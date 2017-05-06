package com.yldbkd.www.buyer.android.fragment;

import android.app.Activity;
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
import com.yldbkd.www.library.android.viewCustomer.ImgTxtButton;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by HP on 2015/10/22.
 */
public class CheckCodeLoginFragment extends BaseFragment {
    private View mBackView;
    private TextView mTitleTV;
    private ImgTxtButton mRightView;
    private Button mSubmitBtn;
    private Button mGetCheckCodeBtn;
    private ClearableEditText mCheckCodeEdit;
    private ClearableEditText mMobileEdit;

    private HttpBack<User> mSubmitHttpBack;
    private HttpBack<CaptchaTime> mGetCodeHttpBack;
    private HttpBack<List<SaleProduct>> cartHttpBack;
    private LoginActivity.CountDownListener countDownListener;
    private int remainTimes = 0;

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
        return R.layout.checkcode_login_fragment;
    }

    @Override
    public void initView(View view) {
        mBackView = view.findViewById(R.id.back_view);
        mTitleTV = (TextView) view.findViewById(R.id.title_view);
        mRightView = (ImgTxtButton) view.findViewById(R.id.right_view);
        mTitleTV.setText(getText(R.string.login_login));
        mCheckCodeEdit = (ClearableEditText) view.findViewById(R.id.checkcode_code);
        mSubmitBtn = (Button) view.findViewById(R.id.checcode_submit);
        mGetCheckCodeBtn = (Button) view.findViewById(R.id.checkcode_get_code);
        mMobileEdit = (ClearableEditText) view.findViewById(R.id.checkcode_mobile);
    }

    @Override
    public void initData() {
        mMobileEdit.requestFocus();
        KeyboardUtils.openDelay(getContext(), mMobileEdit);
    }

    @Override
    public void initListener() {
        mCheckCodeEdit.addTextChangedListener(mCheckEtWatcher);
        mMobileEdit.addTextChangedListener(mMobileEtWatcher);
        mGetCheckCodeBtn.setOnClickListener(new View.OnClickListener() {

            public void onClick(View v) {
                String mobile = mMobileEdit.getText().toString();
                getLoginCode(mobile);
            }
        });

        mSubmitBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String mobile = mMobileEdit.getText().toString().trim();
                String chekCode = mCheckCodeEdit.getText().toString().trim();
                if (TextUtils.isEmpty(chekCode)) {
                    // 设置提示
                    ToastUtils.show(getActivity(), getText(R.string.login_please_input_checkcode).toString());
                    return;
                }
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("mobile", mobile);
                map.put("code", chekCode);
                map.put("type", Constants.LoginPasswordType.CHECKWORD);
                RetrofitUtils.getInstance(true).login(ParamUtils.getParam(map), mSubmitHttpBack);
            }
        });

        mBackView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                KeyboardUtils.close(getActivity());
                getActivity().onBackPressed();
            }
        });
    }

    private void getLoginCode(String mobile) {
        if (TextUtils.isEmpty(mobile)) {
            // 设置提示
            ToastUtils.show(getActivity(), getString(R.string.login_please_input_mobile));
            return;
        }
        if (!CheckUtils.isMobileNO(mobile)) {
            // 设置提示
            ToastUtils.show(getActivity(), getString(R.string.login_mobile_format_error));
            return;
        }
        mGetCheckCodeBtn.setClickable(false);

        // 发送手机号，得到验证码
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("mobile", mobile);
        map.put("type", Constants.CheckCodeType.LOGIN);
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
                // 登入成功，跳转到对应的界面
                String mobile = mMobileEdit.getEditableText().toString().trim();
                int memberType = user.getMemberType();
                String vipExpireDate = user.getVipExpireDate();
                String userImage = user.getUserImageUrl();
                UserUtils.saveUserInfo(mobile, memberType, vipExpireDate, userImage,
                        user.getNickName(), user.getUserSex(), user.getBirthday(), user.getBindQQInfo(), user.getBindWXInfo());
                if (CommunityUtils.getCurrentStoreId() == null) {//判断是否同步购物车
                    getBaseActivity().setResult(Activity.RESULT_OK);
                    AppManager.getAppManager().finishActivity();
                    return;
                }
                requestCart(); // 同步购物车
                KeyboardUtils.close(getActivity());
            }
        };

        cartHttpBack = new HttpBack<List<SaleProduct>>(getBaseActivity()) {
            @Override
            public void onSuccess(List<SaleProduct> cartInfos) {
                CartUtils.setCartInfo(cartInfos);
                getBaseActivity().setResult(Activity.RESULT_OK);
                AppManager.getAppManager().finishActivity();
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

        public void beforeTextChanged(CharSequence s, int start, int count, int after) {
        }

    };

    private TextWatcher mMobileEtWatcher = new TextWatcher() {

        public void onTextChanged(CharSequence s, int start, int before,
                                  int count) {
            if (remainTimes > 0) {//正在倒计时
                return;
            }
            if (s.toString().length() == 11) {
                mGetCheckCodeBtn.setEnabled(true);
            } else {
                mGetCheckCodeBtn.setEnabled(false);
            }
        }

        public void afterTextChanged(Editable s) {

        }

        public void beforeTextChanged(CharSequence s, int start, int count,
                                      int after) {

        }

    };

    private void requestCart() {
        Map<String, Object> map = new HashMap<>();
        map.put("cartInfo", CartUtils.getCartInfo());
        map.put("storeId", CommunityUtils.getCurrentStoreId());
        RetrofitUtils.getInstance(true).synchronizeCart(ParamUtils.getParam(map), cartHttpBack);
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

    private void checkCodeCountDownTimer(long millisUntilFinished) {
        remainTimes = Math.round(millisUntilFinished / 1000);
        if (mGetCheckCodeBtn == null) {
            return;
        }
        mGetCheckCodeBtn.setText(String.format(getString(R.string.login_code_wait), remainTimes));
        mGetCheckCodeBtn.setTextColor(ContextCompat.getColor(getActivity(), R.color.lightText));
        mGetCheckCodeBtn.setOnClickListener(null);
    }

    private void checkCodeCountDownFinish() {
        if (mGetCheckCodeBtn == null) {
            return;
        }
        mGetCheckCodeBtn.setText(getString(R.string.login_get_checkcode));
        mGetCheckCodeBtn.setTextColor(ContextCompat.getColor(getActivity(), R.color.colorPrimary));
        mGetCheckCodeBtn.setEnabled(true);
        mGetCheckCodeBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getLoginCode(mMobileEdit.getText().toString().trim());
            }
        });
    }
}
