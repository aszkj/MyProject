package com.yldbkd.www.buyer.android.fragment;

import android.app.Activity;
import android.support.v4.content.ContextCompat;
import android.text.Editable;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.text.method.HideReturnsTransformationMethod;
import android.text.method.PasswordTransformationMethod;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.LoginActivity;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.CaptchaTime;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.bean.User;
import com.yldbkd.www.buyer.android.utils.CartUtils;
import com.yldbkd.www.buyer.android.utils.CommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.AppManager;
import com.yldbkd.www.library.android.common.CheckUtils;
import com.yldbkd.www.library.android.common.KeyboardUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @创建者 李贞高
 * @创建时间 2016/10/10 10:07
 * @描述 关联手机号
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class RelatedPhoneNumFragment extends BaseFragment {
    private View mBackView;
    private TextView mTitleTV;
    private Button mSubmitBtn;
    private Button mGetCheckCodeBtn;
    private ClearableEditText mMobileEdit;
    private ClearableEditText mCheckCodeEdit;
    private int remainTimes = 0;
    private HttpBack<CaptchaTime> mGetCodeHttpBack;
    private HttpBack<User> mSubmitHttpBack;
    private LoginActivity.CountDownListener countDownListener;
    private ClearableEditText mThirdLoginPwd;
    private CheckBox mRelatedPwdEye;
    private HttpBack<List<SaleProduct>> cartHttpBack;

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
        return R.layout.related_phone_num_fragment;
    }

    @Override
    public void initView(View view) {
        mBackView = view.findViewById(R.id.back_view);
        mTitleTV = (TextView) view.findViewById(R.id.title_view);
        mTitleTV.setText(getText(R.string.related_phone_title));

        mMobileEdit = (ClearableEditText) view.findViewById(R.id.related_phone_moble);
        mMobileEdit.addTextChangedListener(mMobileEtWatcher);
        mCheckCodeEdit = (ClearableEditText) view.findViewById(R.id.related_phone_checkcode);
        mGetCheckCodeBtn = (Button) view.findViewById(R.id.related_phone_get_checkcode);
        mSubmitBtn = (Button) view.findViewById(R.id.related_phone_submit);
        mMobileEdit.requestFocus();

        mThirdLoginPwd = (ClearableEditText) view.findViewById(R.id.third_login_pwd);
        mRelatedPwdEye = (CheckBox) view.findViewById(R.id.related_eye);
        mThirdLoginPwd.addTextChangedListener(mPasswordEtWatcher);

        KeyboardUtils.openDelay(getContext(), mMobileEdit);
    }

    @Override
    public void initListener() {
        mGetCheckCodeBtn.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                String mobile = mMobileEdit.getText().toString();
                getCheckedCode(mobile);
            }
        });

        mSubmitBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String mobile = mMobileEdit.getText().toString();
                String chekCode = mCheckCodeEdit.getText().toString();
                String password = mThirdLoginPwd.getText().toString();
                if (!CheckUtils.isMobileNO(mobile)) {
                    ToastUtils.show(getActivity(), getText(R.string.login_mobile_format_error).toString());
                    return;
                }
                if (TextUtils.isEmpty(chekCode)) {
                    ToastUtils.show(getActivity(), getText(R.string.login_please_input_checkcode).toString());
                    return;
                }
                if (!CheckUtils.checkRegiPwd(password)) {
                    ToastUtils.show(getActivity(), getText(R.string.register_error_password).toString());
                    return;
                }
                KeyboardUtils.close(getActivity());
                Map<String, Object> map = new HashMap<>();
                map.put("mobile", mobile);
                map.put("code", chekCode);
                map.put("password", password);
                RetrofitUtils.getInstance().bindMobile(ParamUtils.getParam(map), mSubmitHttpBack);
            }
        });

        mBackView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                KeyboardUtils.close(getActivity());
                getActivity().onBackPressed();
            }
        });

        mRelatedPwdEye.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton compoundButton, boolean isChecked) {
                if (isChecked) {// 如果选中，显示密码
                    mThirdLoginPwd.setTransformationMethod(HideReturnsTransformationMethod
                            .getInstance());
                } else {// 否则隐藏密码
                    mThirdLoginPwd.setTransformationMethod(PasswordTransformationMethod
                            .getInstance());
                }
                mThirdLoginPwd.setSelection(mThirdLoginPwd.getText().toString().length());
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

        Map<String, Object> map = new HashMap<>();
        map.put("mobile", mobile);
        map.put("type", Constants.CheckCodeType.RELARED_MOBILE);
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
        cartHttpBack = new HttpBack<List<SaleProduct>>(getBaseActivity()) {
            @Override
            public void onSuccess(List<SaleProduct> cartInfos) {
                CartUtils.setCartInfo(cartInfos);
                getBaseActivity().setResult(Activity.RESULT_OK);
                AppManager.getAppManager().finishActivity();
                CartUtils.synchronizeCartFlag(true);
            }

            @Override
            public void onFailure(String msg) {
                super.onFailure(msg);
                if (UserUtils.isLogin()) {
                    getBaseActivity().setResult(Activity.RESULT_OK);
                    AppManager.getAppManager().finishActivity();
                }
            }

            @Override
            public void onTimeOut() {
                super.onTimeOut();
                if (UserUtils.isLogin()) {
                    getBaseActivity().setResult(Activity.RESULT_OK);
                    AppManager.getAppManager().finishActivity();
                }
            }
        };

        mSubmitHttpBack = new HttpBack<User>(getBaseActivity()) {
            @Override
            public void onSuccess(User user) {
                loginSuccessMethod(user);
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

    private void loginSuccessMethod(User user) {
        // 登入成功，跳转到对应的界面
        String mobile = user.getUserName();
        int memberType = user.getMemberType();
        UserUtils.saveUserInfo(mobile, memberType, user.getVipExpireDate(), user.getUserImageUrl(),
                user.getNickName(), user.getUserSex(), user.getBirthday(), user.getBindQQInfo(), user.getBindWXInfo());
        if (CommunityUtils.getCurrentStoreId() == null) {//判断是否同步购物车
            getBaseActivity().setResult(Activity.RESULT_OK);
            AppManager.getAppManager().finishActivity();
            return;
        }
        requestCart(); // 同步购物车
    }

    public void requestCart() {
        Map<String, Object> map = new HashMap<>();
        map.put("cartInfo", CartUtils.getCartInfo());
        map.put("storeId", CommunityUtils.getCurrentStoreId());
        RetrofitUtils.getInstance(true).synchronizeCart(ParamUtils.getParam(map), cartHttpBack);
    }

    private TextWatcher mPasswordEtWatcher = new TextWatcher() {

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