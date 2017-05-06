package com.yldbkd.www.seller.android.fragment;

import android.content.Intent;
import android.support.v4.content.ContextCompat;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.CheckUtils;
import com.yldbkd.www.library.android.common.KeyboardUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;
import com.yldbkd.www.library.android.viewCustomer.ImgTxtButton;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.activity.LoginActivity;
import com.yldbkd.www.seller.android.activity.MainActivity;
import com.yldbkd.www.seller.android.bean.CaptchaTime;
import com.yldbkd.www.seller.android.bean.StoreBase;
import com.yldbkd.www.seller.android.receiver.ReceiverUtils;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.utils.UserUtils;
import com.yldbkd.www.seller.android.utils.http.HttpBack;
import com.yldbkd.www.seller.android.utils.http.ParamUtils;
import com.yldbkd.www.seller.android.utils.http.RetrofitUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * 验证码登录页面
 * <p/>
 * Created by linghuxj on 16/6/10.
 */
public class LoginCodeFragment extends BaseFragment {

    private LinearLayout backView;
    private ImgTxtButton findView;

    private Button sendCodeBtn;
    private ClearableEditText mobileView;
    private ClearableEditText checkCodeView;

    private Button loginBtn;

    private HttpBack<CaptchaTime> sendCodeHttpBack;
    private HttpBack<StoreBase> loginHttpBack;

    private LoginActivity.CountDownListener countDownListener;

    @Override
    public int setLayoutId() {
        return R.layout.fragment_login_code;
    }

    @Override
    public void initBundle() {
        countDownListener = new LoginActivity.CountDownListener() {
            @Override
            public void countTimer(long millisUntilFinished) {
                checkCodeCountDownTimer(millisUntilFinished);
            }

            @Override
            public void countFinish() {
                checkCodeCountDownFinish();
            }
        };
    }

    @Override
    public void initHttpBack() {
        sendCodeHttpBack = new HttpBack<CaptchaTime>() {
            @Override
            public void onSuccess(CaptchaTime time) {
                Long remainTime;
                if (time == null || time.getRemainClock() == null) {
                    remainTime = LoginActivity.MILLIS_IN_FUTURE;
                } else {
                    remainTime = time.getRemainClock() * 1000L;
                }
                LoginActivity activity = (LoginActivity) getActivity();
                activity.startCountDown(remainTime);
            }
        };
        loginHttpBack = new HttpBack<StoreBase>() {
            @Override
            public void onSuccess(StoreBase store) {
                // 登入成功，跳转到对应的界面
                String mobile = mobileView.getEditableText().toString();
                UserUtils.saveUserInfo(mobile, store);
                ReceiverUtils.synchronizedClientId();
                Intent intent = new Intent(getActivity(), MainActivity.class);
                intent.setAction(MainFragment.class.getSimpleName());
                startActivity(intent);
            }
        };
    }

    @Override
    public void initView(View view) {
        backView = (LinearLayout) view.findViewById(R.id.ll_back);
        TextView titleView = (TextView) view.findViewById(R.id.tv_title);
        titleView.setText(getString(R.string.title_login));
        findView = (ImgTxtButton) view.findViewById(R.id.itb_right);
        findView.setText(getString(R.string.login_forget_btn));

        mobileView = (ClearableEditText) view.findViewById(R.id.cet_login_mobile);
        sendCodeBtn = (Button) view.findViewById(R.id.btn_login_check_code);
        checkCodeView = (ClearableEditText) view.findViewById(R.id.cet_login_check_code);
        String mobile = UserUtils.getLoginName();
        if (!TextUtils.isEmpty(mobile)) {
            mobileView.setText(mobile);
            checkCodeView.requestFocus();
            KeyboardUtils.openDelay(getContext(), checkCodeView);
        } else {
            mobileView.requestFocus();
            KeyboardUtils.openDelay(getContext(), mobileView);
        }

        loginBtn = (Button) view.findViewById(R.id.btn_login);
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getActivity().onBackPressed();
            }
        });
        findView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getBaseActivity().showFragment(FindStep1Fragment.class.getSimpleName(), null, true);
            }
        });
        sendCodeBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                loginCodeRequest(mobileView.getText().toString());
            }
        });
        loginBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                loginRequest(mobileView.getText().toString(), checkCodeView.getText().toString());
            }
        });
    }

    @Override
    public void onResume() {
        super.onResume();
        LoginActivity activity = (LoginActivity) getActivity();
        activity.setCountDownListener(countDownListener);
    }

    @Override
    public void onPause() {
        super.onPause();
        LoginActivity activity = (LoginActivity) getActivity();
        activity.setCountDownListener(null);
    }

    private void loginRequest(String mobile, String checkCode) {
        if (!validateMobile(mobile) || !validate(checkCode)) {
            return;
        }
        Map<String, Object> map = new HashMap<>();
        map.put("mobile", mobile);
        map.put("code", checkCode);
        map.put("type", Constants.LoginType.BY_CHECK_CODE);
        RetrofitUtils.getInstance(true).login(ParamUtils.getParam(map), loginHttpBack);
    }

    private void loginCodeRequest(String mobile) {
        if (!validateMobile(mobile)) {
            return;
        }
        Map<String, Object> map = new HashMap<>();
        map.put("mobile", mobile);
        map.put("type", Constants.SendCheckCodeType.LOGIN_TYPE);
        RetrofitUtils.getInstance(true).sendCaptcha(ParamUtils.getParam(map), sendCodeHttpBack);
    }

    private boolean validateMobile(String mobile) {
        if (TextUtils.isEmpty(mobile)) {
            ToastUtils.show(getActivity(), R.string.login_please_mobile);
            return false;
        }
        if (!CheckUtils.isMobileNO(mobile)) {
            ToastUtils.show(getActivity(), R.string.login_error_mobile);
            return false;
        }
        return true;
    }

    private boolean validate(String checkCode) {
        if (TextUtils.isEmpty(checkCode)) {
            ToastUtils.show(getActivity(), R.string.login_please_check_code);
            return false;
        }
        return true;
    }

    private void checkCodeCountDownTimer(long millisUntilFinished) {
        int remainTime = Math.round(millisUntilFinished / 1000);
        if (sendCodeBtn == null) {
            return;
        }
        sendCodeBtn.setText(String.format(getString(R.string.login_code_wait), remainTime));
        sendCodeBtn.setBackgroundResource(R.drawable.button_white_gray_pressed);
        sendCodeBtn.setTextColor(ContextCompat.getColor(getActivity(), R.color.secondaryText));
        sendCodeBtn.setOnClickListener(null);
    }

    private void checkCodeCountDownFinish() {
        if (sendCodeBtn == null) {
            return;
        }
        sendCodeBtn.setText(getString(R.string.login_send_code));
        sendCodeBtn.setBackgroundResource(R.drawable.button_white_selector);
        sendCodeBtn.setTextColor(ContextCompat.getColor(getActivity(), R.color.black));
        sendCodeBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                loginCodeRequest(mobileView.getText().toString());
            }
        });
    }
}
