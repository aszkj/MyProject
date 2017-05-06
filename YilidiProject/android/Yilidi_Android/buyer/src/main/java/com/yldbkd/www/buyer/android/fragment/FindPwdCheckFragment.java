package com.yldbkd.www.buyer.android.fragment;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.content.ContextCompat;
import android.text.Editable;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.LoginActivity;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.CaptchaTime;
import com.yldbkd.www.buyer.android.bean.User;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.CheckUtils;
import com.yldbkd.www.library.android.common.KeyboardUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;
import com.yldbkd.www.library.android.viewCustomer.ImgTxtButton;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by HP on 2015/10/23.
 * 找回密码之验证身份
 */
public class FindPwdCheckFragment extends BaseFragment {
    private View mBackView;
    private TextView mTitleTV;
    private TextView mTvCallPhone;
    private ImgTxtButton mRightView;
    private Button mSubmitBtn;
    private Button mGetCheckCodeBtn;// find_pwd_get_checkcode
    private ClearableEditText mMobileEdit;
    private ClearableEditText mCheckCodeEdit;// find_pwd_checkcode
    private int remainTimes = 0;
    private HttpBack<CaptchaTime> mGetCodeHttpBack;
    private HttpBack<User> mSubmitHttpBack;
    private LoginActivity.CountDownListener countDownListener;

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
    public int setLayoutId() {
        return R.layout.find_pwd_check;
    }

    @Override
    public void initView(View view) {
        mBackView = view.findViewById(R.id.back_view);
        mTitleTV = (TextView) view.findViewById(R.id.title_view);
        mRightView = (ImgTxtButton) view.findViewById(R.id.right_view);
        mTitleTV.setText(getText(R.string.login_find_pwd));
        mMobileEdit = (ClearableEditText) view.findViewById(R.id.find_pwd_moble);
        mMobileEdit.addTextChangedListener(mMobileEtWatcher);
        mCheckCodeEdit = (ClearableEditText) view.findViewById(R.id.find_pwd_checkcode);
        mCheckCodeEdit.addTextChangedListener(mCheckEtWatcher);
        mGetCheckCodeBtn = (Button) view.findViewById(R.id.find_pwd_get_checkcode);
        mSubmitBtn = (Button) view.findViewById(R.id.find_pwd_submit);
        mMobileEdit.requestFocus();
        KeyboardUtils.openDelay(getContext(), mMobileEdit);
        mTvCallPhone = (TextView) view.findViewById(R.id.mlogin_btn2);
    }

    @Override
    public void initListener() {
        mGetCheckCodeBtn.setOnClickListener(new View.OnClickListener() {

            public void onClick(View v) {
                String mobile = mMobileEdit.getText().toString().trim();
                getCheckedCode(mobile);
            }
        });

        mSubmitBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String mobile = mMobileEdit.getText().toString().trim();
                String chekCode = mCheckCodeEdit.getText().toString().trim();
                if (TextUtils.isEmpty(chekCode)) {
                    ToastUtils.show(getActivity(), getText(R.string.login_please_input_checkcode).toString());
                    return;
                }
                KeyboardUtils.close(getActivity());
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("mobile", mobile);
                map.put("code", chekCode);
                map.put("type", Constants.CheckCodeType.FIND_PWD);
                RetrofitUtils.getInstance().checkMobileCode(ParamUtils.getParam(map), mSubmitHttpBack);
            }
        });

        mBackView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                KeyboardUtils.close(getActivity());
                getActivity().onBackPressed();
            }
        });

        mTvCallPhone.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String number = getResources().getString(R.string.call_phone_number);
                //用intent启动拨打电话
                Intent intent = new Intent(Intent.ACTION_CALL, Uri.parse("tel:" + number));
                startActivity(intent);
            }
        });
    }

    private void getCheckedCode(String mobile) {
        if (TextUtils.isEmpty(mobile)) {
            ToastUtils.show(getActivity(), getText(R.string.login_please_input_mobile).toString());
            return;
        }
        if (!CheckUtils.isMobileNO(mobile)) {
            ToastUtils.show(getActivity(), getText(R.string.login_mobile_format_error).toString());
            return;
        }
        mGetCheckCodeBtn.setClickable(false);

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("mobile", mobile);
        map.put("type", Constants.CheckCodeType.FIND_PWD);
        RetrofitUtils.getInstance().sendIdCode(ParamUtils.getParam(map), mGetCodeHttpBack);
    }

    @Override
    public void initHttpBack() {
        mGetCodeHttpBack = new HttpBack<CaptchaTime>(getBaseActivity()) {
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
                mCheckCodeEdit.requestFocus();
            }

            @Override
            public void onFailure(String msg) {
                mGetCheckCodeBtn.setClickable(true);
            }

            @Override
            public void onTimeOut() {
                mGetCheckCodeBtn.setClickable(true);
            }
        };

        mSubmitHttpBack = new HttpBack<User>(getBaseActivity()) {
            @Override
            public void onSuccess(User user) {
                Bundle bundle = new Bundle();
                bundle.putString(Constants.BundleName.MOBILE, mMobileEdit.getText().toString().trim());
                getBaseActivity().showFragment(FindPwdResetFragment.class.getSimpleName(), bundle, true);
            }

        };
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


    private TextWatcher mCheckEtWatcher = new TextWatcher() {

        public void onTextChanged(CharSequence s, int start, int before,
                                  int count) {
            if (s.toString().length() > 0) {
                mSubmitBtn.setEnabled(true);
                mSubmitBtn.setBackgroundResource(R.drawable.button_yellow_selector);
                mSubmitBtn.setTextColor(ContextCompat.getColor(getActivity(), R.color.white));
            } else {
                mSubmitBtn.setEnabled(false);
                mSubmitBtn.setBackgroundResource(R.drawable.button_white_gray_pressed);
                mSubmitBtn.setTextColor(ContextCompat.getColor(getActivity(), R.color.lightText));
            }
        }

        public void afterTextChanged(Editable s) {

        }

        public void beforeTextChanged(CharSequence s, int start, int count,
                                      int after) {

        }

    };

    private TextWatcher mMobileEtWatcher = new TextWatcher() {

        public void onTextChanged(CharSequence s, int start, int before,
                                  int count) {
            if (remainTimes > 0) {
                return;
            }
            if (s.toString().length() == 11) {
                mGetCheckCodeBtn.setEnabled(true);
            } else {
                mGetCheckCodeBtn.setEnabled(false);
                mGetCheckCodeBtn.setText(getResources().getString(R.string.login_get_checkcode));
            }
        }

        public void afterTextChanged(Editable s) {

        }

        public void beforeTextChanged(CharSequence s, int start, int count,
                                      int after) {

        }
    };

    private void checkCodeCountDownTimer(long millisUntilFinished) {
        remainTimes = Math.round(millisUntilFinished / 1000);
        if (mGetCheckCodeBtn == null) {
            return;
        }
        mGetCheckCodeBtn.setText(String.format(getString(R.string.login_code_wait), remainTimes));
        mGetCheckCodeBtn.setTextColor(ContextCompat.getColor(getActivity(), R.color.secondaryText));
        mGetCheckCodeBtn.setOnClickListener(null);
    }

    private void checkCodeCountDownFinish() {
        if (mGetCheckCodeBtn == null) {
            return;
        }
        mGetCheckCodeBtn.setText(getString(R.string.login_get_checkcode));
        mGetCheckCodeBtn.setEnabled(true);
        mGetCheckCodeBtn.setTextColor(ContextCompat.getColor(getActivity(), R.color.colorYellow));
        mGetCheckCodeBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getCheckedCode(mMobileEdit.getText().toString().trim());
            }
        });
    }
}