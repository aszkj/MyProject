package com.yldbkd.www.library.android.pay;

import android.app.Activity;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.text.TextUtils;
import android.util.Log;
import android.widget.Toast;
import com.alipay.sdk.app.PayTask;

/**
 * 支付宝支付工具类
 * <p/>
 * Created by linghuxj on 15/9/22.
 */
public class AliPayUtils {

    public static final int PAY_SUCCESS = 1;
    public static final int PAY_CANCEL = 2;
    public static final int PAY_NETWORK_EXCEPTION = 3;
    public static final int PAY_FAILURE = 4;
    public static final int PAY_NO_INSTALL = 5;
    public static final int PAY_WAIT_CONFIRM = 6;
    public static final int HAS_PAY = 7;

    private Activity activity;
    private Handler returnHandler;

    public AliPayUtils(Activity act, Handler handler) {
        activity = act;
        returnHandler = handler;
    }

    private Handler mHandler = new PayHandler();

    public void toPay(final String payInfo) {
        Runnable payRunnable = new Runnable() {

            @Override
            public void run() {
                Looper.prepare();
                // 构造PayTask 对象
                PayTask aliPay = new PayTask(activity);
                // 调用支付接口，获取支付结果
                String result = aliPay.pay(payInfo);
                Message msg = new Message();
                msg.what = SDK_PAY_FLAG;
                msg.obj = result;
                mHandler.sendMessage(msg);
                Looper.loop();
            }
        };

        // 必须异步调用
        Thread payThread = new Thread(payRunnable);
        payThread.start();
    }

    private static final int SDK_PAY_FLAG = 1;

    private static final int SDK_CHECK_FLAG = 2;

    class PayHandler extends Handler {
        public void handleMessage(Message msg) {
            if (activity == null) {
                return;
            }
            switch (msg.what) {
                case SDK_PAY_FLAG: {
                    PayResult payResult = new PayResult((String) msg.obj);

                    // 支付宝返回此次支付结果及加签，建议对支付宝签名信息拿签约时支付宝提供的公钥做验签
                    String resultInfo = payResult.getResult();

                    String resultStatus = payResult.getResultStatus();

                    // 判断resultStatus 为“9000”则代表支付成功，具体状态码代表含义可参考接口文档
                    if (TextUtils.equals(resultStatus, "9000")) {
                        returnHandler.obtainMessage(PAY_SUCCESS).sendToTarget();
                    } else if (TextUtils.equals(resultStatus, "8000")) {
                        // 判断resultStatus 为非“9000”则代表可能支付失败
                        // “8000”代表支付结果因为支付渠道原因或者系统原因还在等待支付结果确认，最终交易是否成功以服务端异步通知为准（小概率状态）
                        returnHandler.obtainMessage(PAY_WAIT_CONFIRM).sendToTarget();
                    } else if (TextUtils.equals(resultStatus, "6001")) {
                        returnHandler.obtainMessage(PAY_CANCEL).sendToTarget();
                    } else if (TextUtils.equals(resultStatus, "6002")) {
                        returnHandler.obtainMessage(PAY_NETWORK_EXCEPTION).sendToTarget();
                    } else {
                        // 其他值就可以判断为支付失败
                        returnHandler.obtainMessage(PAY_FAILURE).sendToTarget();
                    }
                    break;
                }
                case SDK_CHECK_FLAG: {
                    if ((boolean) msg.obj) {
                        // 如果存在支付宝，则进行支付操作
                        returnHandler.obtainMessage(HAS_PAY).sendToTarget();
                    } else {
                        Toast.makeText(activity, "未安装支付宝客户端，无法进行支付。", Toast.LENGTH_SHORT).show();
                        returnHandler.obtainMessage(PAY_NO_INSTALL).sendToTarget();
                    }
                    break;
                }
                default:
                    break;
            }
        }
    }

    /**
     * check whether the device has authentication alipay account.
     * 查询终端设备是否存在支付宝认证账户
     */
    public void check() {
        // getSDKVersion();
        Runnable checkRunnable = new Runnable() {
            @Override
            public void run() {
                Looper.prepare();
                // 构造PayTask 对象
                PayTask payTask = new PayTask(activity);
                // 调用查询接口，获取查询结果
                boolean isExist = payTask.checkAccountIfExist();

                Message msg = new Message();
                msg.what = SDK_CHECK_FLAG;
                msg.obj = isExist;
                mHandler.sendMessage(msg);
                Looper.loop();
            }
        };

        Thread checkThread = new Thread(checkRunnable);
        checkThread.start();
    }

    /**
     * get the sdk version. 获取SDK版本号
     */
    public void getSDKVersion() {
        PayTask payTask = new PayTask(activity);
        String version = payTask.getVersion();
        Log.d("AliPayUtils", "获取到的当前版本：" + version);
    }
}
