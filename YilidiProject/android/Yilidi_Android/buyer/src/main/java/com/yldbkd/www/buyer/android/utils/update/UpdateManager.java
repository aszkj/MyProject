package com.yldbkd.www.buyer.android.utils.update;

import android.app.AlertDialog.Builder;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.DialogInterface.OnCancelListener;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager.NameNotFoundException;
import android.net.Uri;
import android.os.Environment;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.util.Xml;
import android.view.View;
import android.widget.ProgressBar;
import android.widget.TextView;
import com.yldbkd.www.buyer.android.BuyerApp;
import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.library.android.common.AppManager;
import com.yldbkd.www.library.android.network.NetworkUtils;
import org.xmlpull.v1.XmlPullParser;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.ref.WeakReference;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.SocketTimeoutException;
import java.net.URL;
import java.text.DecimalFormat;

/**
 * 应用程序更新工具包
 */
public class UpdateManager {

    public static final int NO_NETWORK = 110;
    public static final int CHECK_VERSION_FINISH = 111;
    public static final int NO_VERSION_UPDATE = 112;


    private static final int DOWN_NOSDCARD = 0;
    private static final int DOWN_UPDATE = 1;
    private static final int DOWN_OVER = 2;

    private static final int DIALOG_TYPE_LATEST = 0;
    private static final int DIALOG_TYPE_FAIL = 1;

    private static UpdateManager updateManager;

    private Context mContext;
    // 通知对话框
    private UpdateDialog noticeDialog;
    // 下载对话框
    private DownloadDialog downloadDialog;
    // '已经是最新' 或者 '无法获取最新版本' 的对话框
    private Dialog latestOrFailDialog;
    // 进度条
    private ProgressBar mProgress;
    // 显示下载数值
    private TextView mProgressText;
    // 终止标记
    private boolean interceptFlag;
    // 提示语
    private String updateMsg = "";
    // 返回的安装包url
    private String apkUrl = "";
    // 下载包保存路径
    private String savePath = "";
    // apk保存完整路径
    private String apkFilePath = "";
    // 临时下载文件路径
    private String tmpFilePath = "";

    private String curVersionName = "";
    private int curVersionCode;
    private UpdateInfoBean mUpdate;
    private static final int SHOW_UPDATE = 1;

    private Handler mHandler;

    public static UpdateManager getUpdateManager() {
        if (updateManager == null) {
            updateManager = new UpdateManager();
        }
        updateManager.interceptFlag = false;
        return updateManager;
    }

    /**
     * 检查App更新
     *
     * @param context
     */
    public void checkAppUpdate(final Context context, Handler jumpHandler) {
        this.mContext = context;
        mHandler = new DownloadHandler(mContext);
        getCurrentVersion(context);
        final Handler checkHandler = new CheckHandler(jumpHandler, context);
        Thread checkUpdateThread = new Thread() {
            public void run() {
                Message msg = new Message();
                msg.what = SHOW_UPDATE;
                msg.obj = checkVersionFromServer(context);
                checkHandler.sendMessage(msg);
            }
        };
        ThreadPoolManager.getInstance().addTask(checkUpdateThread);
    }

    private static class CheckHandler extends Handler {
        WeakReference<Handler> handlerWeakReference;
        WeakReference<Context> contextWeakReference;

        public CheckHandler(Handler handler, Context context) {
            handlerWeakReference = new WeakReference<>(handler);
            contextWeakReference = new WeakReference<>(context);
        }

        @Override
        public void handleMessage(Message msg) {
            Handler jumpHandler = handlerWeakReference.get();
            Context context = contextWeakReference.get();
            if (context == null || msg.obj == null) {
                jumpHandler.obtainMessage(UpdateManager.CHECK_VERSION_FINISH).sendToTarget();
                return;
            }
            // 显示检测结果
            UpdateInfoBean mUpdate = (UpdateInfoBean) msg.obj;
            UpdateManager.getUpdateManager().setmUpdate(mUpdate);
            if (msg.what != SHOW_UPDATE || mUpdate.getUrl() == null || "".equals(mUpdate.getUrl())) {
                if (jumpHandler != null) {
                    jumpHandler.obtainMessage(UpdateManager.CHECK_VERSION_FINISH).sendToTarget();
                }
                return;
            }
            UpdateManager manager = UpdateManager.getUpdateManager();
            if (manager.getCurrentVersionCode(context) < mUpdate.getVersionCode()) {
                manager.setApkUrl(mUpdate.getUrl());
                manager.setUpdateMsg(mUpdate.getDesc());
                manager.showNoticeDialog(mUpdate, mUpdate.isForce(), jumpHandler);
            } else {
                if (jumpHandler != null) {
                    jumpHandler.obtainMessage(NO_VERSION_UPDATE).sendToTarget();
                }
            }
        }
    }

    public void setApkUrl(String apkUrl) {
        this.apkUrl = apkUrl;
    }

    public void setUpdateMsg(String updateMsg) {
        this.updateMsg = updateMsg;
    }

    /**
     * 显示'已经是最新'或者'无法获取版本信息'对话框
     */
    private void showLatestOrFailDialog(int dialogType) {
        if (latestOrFailDialog != null) {
            // 关闭并释放之前的对话框
            latestOrFailDialog.dismiss();
            latestOrFailDialog = null;
        }
        Builder builder = new Builder(mContext);
        builder.setTitle("系统提示");
        if (dialogType == DIALOG_TYPE_LATEST) {
            builder.setMessage("您当前已经是最新版本");
        } else if (dialogType == DIALOG_TYPE_FAIL) {
            builder.setMessage("无法获取版本更新信息");
        }
        builder.setPositiveButton("确定", null);
        latestOrFailDialog = builder.create();
        latestOrFailDialog.show();
    }

    /**
     * 获取当前客户端版本信息
     */
    private void getCurrentVersion(Context context) {
        try {
            PackageInfo info = context.getPackageManager().getPackageInfo(
                    context.getPackageName(), 0);
            curVersionName = info.versionName;
            curVersionCode = info.versionCode;
        } catch (NameNotFoundException e) {
            e.printStackTrace(System.err);
        }
    }

    public String getCurrentVersionName(Context context) {
        if (curVersionName == null || "".equals(curVersionName)) {
            getCurrentVersion(context);
        }
        return curVersionName;
    }

    public int getCurrentVersionCode(Context context) {
        if (curVersionCode <= 0) {
            getCurrentVersion(context);
        }
        return curVersionCode;
    }

    /**
     * 显示版本更新通知对话框
     */
    private void showNoticeDialog(UpdateInfoBean bean, boolean ifForce, final Handler handler) {
        noticeDialog = new UpdateDialog(mContext, bean, ifForce, handler);
        noticeDialog.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                noticeDialog.dismiss();
                showDownloadDialog(handler);
            }
        });
        noticeDialog.show();
    }

    /**
     * 显示下载对话框
     */
    private void showDownloadDialog(final Handler handler) {
        downloadDialog = new DownloadDialog(mContext);
        mProgress = downloadDialog.getProgress();
        mProgressText = downloadDialog.getPercent();
        downloadDialog.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mUpdate.isForce()) {
                    AppManager.getAppManager().appExit();
                } else {
                    if (handler != null) {
                        handler.obtainMessage(UpdateManager.CHECK_VERSION_FINISH).sendToTarget();
                    }
                }
                interceptFlag = true;
            }
        });

        downloadDialog.setOnCancelListener(new OnCancelListener() {
            @Override
            public void onCancel(DialogInterface dialog) {
                dialog.dismiss();
                interceptFlag = true;
            }
        });
        downloadDialog.show();

        downloadApk();
    }

    private Runnable mdownApkRunnable = new Runnable() {
        @Override
        public void run() {
            FileOutputStream fos = null;
            InputStream is = null;
            try {
                String apkName = "yldbkd_" + mUpdate.getVersionName() + ".apk";
                String tmpApk = "yldbkd_" + mUpdate.getVersionName() + ".tmp";
                // 判断是否挂载了SD卡
                String storageState = Environment.getExternalStorageState();
                if (storageState.equals(Environment.MEDIA_MOUNTED)) {
                    savePath = Environment.getExternalStorageDirectory()
                            .getAbsolutePath() + "/yldbkd/Update/";
                    File file = new File(savePath);
                    if (!file.exists()) {
                        file.mkdirs();
                    }
                    apkFilePath = savePath + apkName;
                    File apkFile = new File(apkFilePath);
                    if (apkFile.exists()) {
                        apkFile.delete();
                    }
                    tmpFilePath = savePath + tmpApk;
                }

                // 没有挂载SD卡，无法下载文件
                if (apkFilePath == null || "".equals(apkFilePath)) {
                    mHandler.sendEmptyMessage(DOWN_NOSDCARD);
                    return;
                }

                File ApkFile = new File(apkFilePath);
                // 是否已下载更新文件
                if (ApkFile.exists()) {
                    downloadDialog.dismiss();
                    installApk();
                    return;
                }

                // 输出临时下载文件
                File tmpFile = new File(tmpFilePath);
                fos = new FileOutputStream(tmpFile);

                URL url = new URL(apkUrl);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestProperty("Accept-Encoding", "identity");
                conn.connect();
                int length = conn.getContentLength();
                is = conn.getInputStream();

                // 显示文件大小格式：2个小数点显示
                DecimalFormat df = new DecimalFormat("0.00");
                // 进度条下面显示的总文件大小
                String apkFileSize = df.format((float) length / 1024 / 1024) + "MB";
                int count = 0;
                byte buf[] = new byte[1024];

                do {
                    int numread = is.read(buf);
                    count += numread;
                    // 进度条下面显示的当前下载文件大小
                    String tmpFileSize = df.format((float) count / 1024 / 1024) + "MB";
                    // 当前进度值
                    int progress = count * 100 / length;
                    // 更新进度
                    mHandler.obtainMessage(DOWN_UPDATE, progress).sendToTarget();
                    if (numread <= 0) {
                        // 下载完成 - 将临时下载文件转成APK文件
                        if (tmpFile.renameTo(ApkFile)) {
                            // 通知安装
                            mHandler.sendEmptyMessage(DOWN_OVER);
                        }
                        break;
                    }
                    fos.write(buf, 0, numread);
                } while (!interceptFlag);// 点击取消就停止下载
            } catch (Exception e) {
                Log.e("UPDATE_MANAGER", e.toString());
            } finally {
                if (fos != null) {
                    try {
                        fos.close();
                    } catch (IOException e) {
                        Log.e("UPDATE_MANAGER", e.toString());
                    }
                }
                if (is != null) {
                    try {
                        is.close();
                    } catch (IOException e) {
                        Log.e("UPDATE_MANAGER", e.toString());
                    }
                }
            }
        }
    };

    /**
     * 下载apk
     */
    private void downloadApk() {
        new Thread(mdownApkRunnable).start();
    }

    /**
     * 安装apk
     */
    private void installApk() {
        File apkfile = new File(apkFilePath);
        if (!apkfile.exists()) {
            return;
        }
        Intent i = new Intent(Intent.ACTION_VIEW);
        i.setDataAndType(Uri.parse("file://" + apkfile.toString()),
                "application/vnd.android.package-archive");
        mContext.startActivity(i);
        AppManager.getAppManager().appExit();
    }

    public UpdateInfoBean checkVersionFromServer(Context context) {
        UpdateInfoBean bean = null;
        if (!NetworkUtils.isHasNetwork(context)) {
            mHandler.sendEmptyMessage(NO_NETWORK);
            return null;
        }
        String path = context.getString(R.string.update_url);
        HttpURLConnection conn = null;
        try {
            URL url = new URL(path);
            conn = (HttpURLConnection) url.openConnection();
            conn.setConnectTimeout(2000);
            InputStream is = conn.getInputStream();
            bean = getUpdateInfo(is);
        } catch (SocketTimeoutException e) {
            Log.e("UPDATE_MANAGER", e.toString());
            return null;
        } catch (MalformedURLException e) {
            Log.e("UPDATE_MANAGER", e.toString());
            return null;
        } catch (IOException e) {
            Log.e("UPDATE_MANAGER", e.toString());
            return null;
        } catch (Exception e) {
            Log.e("UPDATE_MANAGER", e.toString());
            return null;
        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }
        return bean;
    }

    /**
     * 解析升级xml文件
     */
    private UpdateInfoBean getUpdateInfo(InputStream is) throws Exception {
        UpdateInfoBean updateInfo = new UpdateInfoBean();
        XmlPullParser parser = Xml.newPullParser();
        parser.setInput(is, "UTF-8");
        int type = parser.getEventType();
        while (type != XmlPullParser.END_DOCUMENT) {
            switch (type) {
                case XmlPullParser.START_TAG:
                    if ("versionName".equals(parser.getName())) {
                        String version = parser.nextText().trim();
                        updateInfo.setVersionName(version);
                    } else if ("versionCode".equals(parser.getName())) {
                        int versionCode = Integer.parseInt(parser.nextText().trim());
                        updateInfo.setVersionCode(versionCode);
                    } else if ("url".equals(parser.getName())) {
                        String url = parser.nextText().trim();
                        updateInfo.setUrl(url);
                    } else if ("force".equals(parser.getName())) {
                        boolean force = Boolean.valueOf(parser.nextText().trim());
                        updateInfo.setForce(force);
                    } else if ("size".equals(parser.getName())) {
                        String size = parser.nextText().trim();
                        updateInfo.setSize(size);
                    } else if ("desc".equals(parser.getName())) {
                        String desc = parser.nextText().trim();
                        updateInfo.setDesc(desc);
                    } else if ("key".equals(parser.getName())) {
                        String key = parser.nextText().trim();
                        updateInfo.setKey(key);
                        BuyerApp.getInstance().setJsonKey(key);
                    }
                    break;
            }
            type = parser.next();
        }
        return updateInfo;
    }

    protected void download(int progress) {
        mProgress.setProgress(progress);
        mProgressText.setText(progress + "%");
    }

    protected void downloadDismiss() {
        if (downloadDialog != null && downloadDialog.isShowing()) {
            downloadDialog.dismiss();
        }
    }

    protected void setmUpdate(UpdateInfoBean bean) {
        mUpdate = bean;
    }

    private static class DownloadHandler extends Handler {
        WeakReference<Context> contextWeakReference;

        public DownloadHandler(Context context) {
            contextWeakReference = new WeakReference<>(context);
        }

        @Override
        public void handleMessage(Message msg) {
            Context context = contextWeakReference.get();
            switch (msg.what) {
                case DOWN_UPDATE:
                    int progress = (int) msg.obj;
                    UpdateManager.getUpdateManager().download(progress);
                    break;
                case DOWN_OVER:
                    UpdateManager.getUpdateManager().downloadDismiss();
                    UpdateManager.getUpdateManager().installApk();
                    break;
                case DOWN_NOSDCARD:
                    UpdateManager.getUpdateManager().downloadDismiss();
                    if (context == null) {
                        return;
                    }
                    break;
                case NO_NETWORK:
                    UpdateManager.getUpdateManager().downloadDismiss();
                    if (context == null) {
                        return;
                    }
                    break;
            }
        }
    }
}
