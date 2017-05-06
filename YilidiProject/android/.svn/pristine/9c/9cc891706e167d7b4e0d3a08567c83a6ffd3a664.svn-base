package com.yldbkd.www.buyer.android.activity;

import android.os.Bundle;
import android.os.CountDownTimer;
import android.support.v4.app.Fragment;
import android.widget.Button;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.fragment.FindPwdCheckFragment;

/**
 * Created by HP on 2015/10/27.
 */
public class FindPwdActivity extends BaseActivity {
    private Button mCheckCodeBtn;
    private Fragment fragment;


    @Override
    public Fragment newFragmentByTag(String tag) {
        Fragment fragment = null;
        return fragment;
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.common_activity);
        showFragment(getIntent().getAction(), getIntent().getExtras(), false);


        // mCountDownTimer.start();
    }

    private CountDownTimer mCountDownTimer = new CountDownTimer(60000, 1000) {
        @Override
        public void onTick(long time) {
            fragment = getSupportFragmentManager().findFragmentByTag(FindPwdCheckFragment.class.getSimpleName());
            mCheckCodeBtn = (Button) fragment.getView().findViewById(R.id.find_pwd_get_checkcode);
            mCheckCodeBtn.setText("(" + ((time + 15) / 1000 + ")") + getText(R.string.login_again_get_check_code).toString());
        }

        @Override
        public void onFinish() {
            mCheckCodeBtn.setText(getText(R.string.login_again_get_check_code).toString());
        }
    };

}
