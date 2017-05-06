package com.yldbkd.www.library.android.common;

import android.os.CountDownTimer;
import android.os.Handler;

/**
 * 倒计时工具类
 * <p/>
 * Created by linghuxj on 16/6/13.
 */
public class CountDown extends CountDownTimer {

    public static final int COUNT_DOWN_FINISH = 0xcf;
    public static final int COUNT_DOWN_TIMER = 0xce;

    private Handler handler;

    public CountDown(long millisInFuture, long countDownInterval) {
        super(millisInFuture, countDownInterval);
    }

    public CountDown(long millisInFuture, long countDownInterval, Handler handler) {
        this(millisInFuture, countDownInterval);
        this.handler = handler;
    }

    @Override
    public void onTick(long millisUntilFinished) {
        handler.obtainMessage(COUNT_DOWN_TIMER, millisUntilFinished).sendToTarget();
    }

    @Override
    public void onFinish() {
        handler.sendEmptyMessage(COUNT_DOWN_FINISH);
    }
}
