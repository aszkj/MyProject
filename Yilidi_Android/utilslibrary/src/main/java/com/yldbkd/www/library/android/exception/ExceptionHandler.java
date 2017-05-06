package com.yldbkd.www.library.android.exception;

import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.os.Build;
import android.os.Looper;
import android.util.Log;
import android.widget.Toast;
import com.yldbkd.www.library.android.common.AppManager;
import com.yldbkd.www.library.android.common.Constants;
import com.yldbkd.www.library.android.network.NetworkUtils;

import java.io.*;
import java.lang.Thread.UncaughtExceptionHandler;
import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * UncaughtExceptionHandler：线程未捕获异常控制器是用来处理未捕获异常的。 如果程序出现了未捕获异常默认情况下则会出现强行关闭对话框
 * 实现该接口并注册为程序中的默认未捕获异常处理 这样当未捕获异常发生时，就可以做些异常处理操作 例如：收集异常信息，发送错误报告 等。
 * <p/>
 * UncaughtException处理类,当程序发生Uncaught异常的时候,由该类来接管程序,并记录发送错误报告.
 */
public class ExceptionHandler implements UncaughtExceptionHandler {
    /**
     * Debug Log Tag
     */
    public static final String TAG = "ExceptionHandler  ";
    /**
     * 是否开启日志输出, 在Debug状态下开启, 在Release状态下关闭以提升程序性能
     */
    public static final boolean DEBUG = false;
    /**
     * CrashHandler实例
     */
    private static ExceptionHandler INSTANCE;
    /**
     * 程序的Context对象
     */
    private Context mContext;
    /**
     * 系统默认的UncaughtException处理类
     */
    private UncaughtExceptionHandler mDefaultHandler;

    /**
     * 使用Properties来保存设备的信息和错误堆栈信息
     */
    private Properties mDeviceCrashInfo = new Properties();
    private static final String VERSION_NAME = "versionName";
    private static final String VERSION_CODE = "versionCode";
    private static final String STACK_TRACE = "STACK_TRACE";
    /**
     * 错误报告文件的扩展名
     */
    private static final String CRASH_REPORTER_EXTENSION = ".directexp";

    /**
     * 保证只有一个CrashHandler实例
     */
    private ExceptionHandler() {
    }

    /**
     * 获取CrashHandler实例 ,单例模式
     */
    public static ExceptionHandler getInstance() {
        if (INSTANCE == null) {
            INSTANCE = new ExceptionHandler();
        }
        return INSTANCE;
    }

    /**
     * 初始化,注册Context对象, 获取系统默认的UncaughtException处理器, 设置该CrashHandler为程序的默认处理器
     *
     * @param ctx
     */
    public void init(Context ctx) {
        mContext = ctx;
        mDefaultHandler = Thread.getDefaultUncaughtExceptionHandler();
        Thread.setDefaultUncaughtExceptionHandler(this);
    }

    /**
     * 当UncaughtException发生时会转入该函数来处理
     */
    @Override
    public void uncaughtException(Thread thread, Throwable ex) {
        if (!handleException(ex) && mDefaultHandler != null) {
            // 如果用户没有处理则让系统默认的异常处理器来处理
            mDefaultHandler.uncaughtException(thread, ex);

        } else {
            // Sleep一会后结束程序
            // 来让线程停止一会是为了显示Toast信息给用户，然后Kill程序
            try {
                Thread.sleep(300);

            } catch (InterruptedException e) {
                Log.e(Constants.TAG, e.toString());
            }
            Intent intent = new Intent(Intent.ACTION_MAIN);
            intent.addCategory(Intent.CATEGORY_HOME);
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            mContext.startActivity(intent);
            AppManager.getAppManager().appExit();
        }
    }

    /**
     * 自定义错误处理,收集错误信息 发送错误报告等操作均在此完成. 开发者可以根据自己的情况来自定义异常处理逻辑
     *
     * @param ex
     * @return true:如果处理了该异常信息;否则返回false
     */
    private boolean handleException(final Throwable ex) {
        if (ex == null) {
            return true;
        }
        Log.d(Constants.TAG, ex.toString());
        // 使用Toast来显示异常信息
        new Thread() {
            @Override
            public void run() {
                Looper.prepare();
                Toast.makeText(mContext, "程序发生异常", Toast.LENGTH_LONG).show();
                Looper.loop();
            }
        }.start();

        new Thread() {
            @Override
            public void run() {
                // TODO Auto-generated method stub
                // 收集设备信息
                Looper.prepare();
                collectCrashDeviceInfo(mContext);
                // 保存错误报告文件
                saveCrashInfoToFile(ex);
                // 发送错误报告到服务器
                if (NetworkUtils.isHasNetwork(mContext)) {
                    sendCrashReportsToServer(mContext);
                }
                Looper.loop();
            }
        }.start();

        return true;
    }

    /**
     * 收集崩溃的设备信息
     *
     * @param ctx 程序上下文
     */
    public void collectCrashDeviceInfo(Context ctx) {
        try {
            // Class for retrieving various kinds of information related to the
            // application packages that are currently installed on the device.
            // You can find this class through getPackageManager().
            PackageManager pm = ctx.getPackageManager();
            // getPackageInfo(String packageName, int flags)
            // Retrieve overall information about an application package that is
            // installed on the system.
            // public static final int GET_ACTIVITIES
            // Since: API Level 1 PackageInfo flag: return information about
            // activities in the package in activities.
            PackageInfo pi = pm.getPackageInfo(ctx.getPackageName(),
                    PackageManager.GET_ACTIVITIES);
            if (pi != null) {
                // public String versionName The version name of this package,
                // as specified by the <manifest> tag's versionName attribute.
                mDeviceCrashInfo.put(VERSION_NAME,
                        pi.versionName == null ? "not set" : pi.versionName);
                // public int versionCode The version number of this package,
                // as specified by the <manifest> tag's versionCode attribute.
                mDeviceCrashInfo.put(VERSION_CODE, pi.versionCode);
                // 加入当时产生问题的时间
                SimpleDateFormat format = new SimpleDateFormat(
                        "yyyy-MM-dd HH:mm:ss");
                mDeviceCrashInfo.put("HAPPEN_TIME",
                        format.format(new Date(System.currentTimeMillis())));
            }
        } catch (NameNotFoundException e) {
            Log.e(Constants.TAG, " Error while collect package info : " + e);
        }
        // 使用反射来收集设备信息.在Build类中包含各种设备信息,
        // 例如: 系统版本号,设备生产商 等帮助调试程序的有用信息
        // 返回 Field 对象的一个数组，这些对象反映此 Class 对象所表示的类或接口所声明的所有字段
        Field[] fields = Build.class.getDeclaredFields();
        for (Field field : fields) {
            try {
                // setAccessible(boolean flag)
                // 将此对象的 accessible 标志设置为指示的布尔值。
                // 通过设置Accessible属性为true,才能对私有变量进行访问，不然会得到一个IllegalAccessException的异常
                field.setAccessible(true);
                mDeviceCrashInfo.put(field.getName(), field.get(null));
                if (DEBUG) {
                    Log.d(Constants.TAG, field.getName() + " : " + field.get(null));
                }
            } catch (Exception e) {
                Log.e(Constants.TAG, "Error while collect crash info " + e);
            }
        }
    }

    /**
     * 保存错误信息到文件中
     *
     * @param ex
     * @return
     */
    private String saveCrashInfoToFile(Throwable ex) {
        Writer info = new StringWriter();
        PrintWriter printWriter = new PrintWriter(info);
        // printStackTrace(PrintWriter s)
        // 将此 throwable 及其追踪输出到指定的 PrintWriter
        ex.printStackTrace(printWriter);

        // getCause() 返回此 throwable 的 cause；如果 cause 不存在或未知，则返回 null。
        Throwable cause = ex.getCause();
        while (cause != null) {
            cause.printStackTrace(printWriter);
            cause = cause.getCause();
        }

        // toString() 以字符串的形式返回该缓冲区的当前值。
        String result = info.toString();
        printWriter.close();

        if (DEBUG) {
            Log.d(TAG, result);
        }

        mDeviceCrashInfo.put(STACK_TRACE, result);

        FileOutputStream trace = null;
        try {
            long time = System.currentTimeMillis();
            String fileName = "yldbkd-" + time
                    + CRASH_REPORTER_EXTENSION;
            // 保存文件
            trace = mContext.openFileOutput(fileName, Context.MODE_PRIVATE);

            // mDeviceCrashInfo.store(trace, null);
            String line = System.getProperty("line.separator");
            // 写到data/data/包名/files中。
            Iterator<Object> iterator = mDeviceCrashInfo.keySet().iterator();
            while (iterator.hasNext()) {
                Object keyObject = iterator.next();
                trace.write((keyObject.toString() + "=" + mDeviceCrashInfo
                        .get(keyObject).toString().replaceAll(line, ""))
                        .getBytes());
                if (iterator.hasNext()) {
                    trace.write(line.getBytes());
                }
            }
            trace.flush();
            return fileName;
        } catch (Exception e) {
            Log.e(Constants.TAG, "an error occured while writing report file... " + e);
        } finally {
            if (null != trace) {
                try {
                    trace.close();
                } catch (IOException e) {
                    Log.e(Constants.TAG, "an error occured while writing report file... " + e);
                }
            }
        }
        return null;
    }

    /**
     * 把错误报告发送给服务器,包含新产生的和以前没发送的.
     *
     * @param ctx
     */
    private String sendCrashReportsToServer(final Context ctx) {
        String fileName = getCrashReportFiles(ctx);
        if (fileName == null || "".equals(fileName)) {
            return null;
        }
        File cr = new File(ctx.getFilesDir(), fileName);
        return postReport(cr);
    }

    /**
     * 获取错误报告文件名
     *
     * @param ctx
     * @return
     */
    private String getCrashReportFiles(Context ctx) {
        File filesDir = ctx.getFilesDir();
        // 实现FilenameFilter接口的类实例可用于过滤器文件名
        FilenameFilter filter = new FilenameFilter() {
            // accept(File dir, String name)
            // 测试指定文件是否应该包含在某一文件列表中。
            public boolean accept(File dir, String name) {
                if (DEBUG) {
                    Log.d(Constants.TAG, "properties file path: " + dir.toString());
                }
                return name.endsWith(CRASH_REPORTER_EXTENSION);
            }
        };
        // list(FilenameFilter filter)
        // 返回一个字符串数组，这些字符串指定此抽象路径名表示的目录中满足指定过滤器的文件和目录
        String[] fileNames = filesDir.list(filter);
        if (fileNames != null) {
            int length = fileNames.length;
            if (length > 0) {
                FileNameComparator comparator = new FileNameComparator();
                TreeSet<String> set = new TreeSet<String>(comparator);
                set.addAll(Arrays.asList(fileNames));
                Object[] files = set.toArray();
                for (int i = 0; i < length - 1; i++) {
                    File file = new File(filesDir, files[i].toString());
                    file.delete();
                }
                return files[length - 1].toString();
            }
        }
        return null;
    }

    /**
     * 发送到服务器，并返回状态码
     *
     * @param file
     * @return
     */
    private String postReport(final File file) {
        if (file == null) {
            return null;
        }

        Properties properties = new Properties();
        StringBuilder exceptionBuffer = new StringBuilder();
        try {
            properties.load(new FileInputStream(file));
        } catch (IOException e) {
            Log.e(Constants.TAG, e.toString());
        }
        for (Map.Entry<Object, Object> entry : properties.entrySet()) {
            exceptionBuffer.append(entry.getKey().toString());
            exceptionBuffer.append("=");
            exceptionBuffer.append(entry.getValue().toString());
            exceptionBuffer.append("\n");
        }
        return exceptionBuffer.toString();
    }

    /**
     * 在程序启动时候, 可以调用该函数来发送以前没有发送的报告
     */
    public String sendPreviousReportsToServer() {
        return sendCrashReportsToServer(mContext);
    }

    private class FileNameComparator implements Comparator<String> {

        @Override
        public int compare(String lhs, String rhs) {
            return lhs.compareToIgnoreCase(rhs);
        }
    }

}