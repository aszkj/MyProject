package com.yldbkd.www.buyer.android.fragment;

import android.app.Activity;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
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
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.tencent.connect.UserInfo;
import com.tencent.mm.sdk.modelmsg.SendAuth;
import com.tencent.mm.sdk.openapi.WXAPIFactory;
import com.tencent.tauth.IUiListener;
import com.tencent.tauth.Tencent;
import com.tencent.tauth.UiError;
import com.yldbkd.www.buyer.android.BuyerApp;
import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.LoginActivity;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.Advertisement;
import com.yldbkd.www.buyer.android.bean.BaseModel;
import com.yldbkd.www.buyer.android.bean.CaptchaTime;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.bean.User;
import com.yldbkd.www.buyer.android.utils.CartUtils;
import com.yldbkd.www.buyer.android.utils.CommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.JumpUtils;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.AppManager;
import com.yldbkd.www.library.android.common.CheckUtils;
import com.yldbkd.www.library.android.common.KeyboardUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @创建者 李贞高
 * @创建时间 2016/10/13 15:56
 * @描述 登录页面
 * @更新者 李贞高
 * @更新时间 2016/10/13 15:56
 * @更新描述 登录注册页面整合
 */
public class LoginFragment extends BaseFragment {
    //登录
    private ImageView mCloseLoginView;
    private ImageView mLoginBannerView;
    private Button mCheckCodeLoginBtn;
    private Button mLoginForgetPwdBtn;
    private CheckBox mEyeCB;
    private CheckBox mRegisterEyeCB;
    private ClearableEditText mPwdEdit;
    private Button mLoginBtn;
    private ClearableEditText mMobileEdit;
    private HttpBack<User> mLoginHttpBack;
    private HttpBack<List<SaleProduct>> cartHttpBack;
    //注册
    private Button mGetCheckCodeBtn, mRegisterLoginBtn;
    private ClearableEditText mRegisterMobileEdit, mCheckCodeEdit;
    private ClearableEditText mPasswordEdit, mInvitationCodeEdit;
    private CheckBox mInviteCb;
    private TextView mInviteTV;
    private LinearLayout mLlInviteContent;
    private LinearLayout mLlShowInviteContent;
    private int remainTimes = 0;
    private boolean isShowInvite = false;
    private LoginActivity.CountDownListener countDownListener;
    private HttpBack<CaptchaTime> mGetCodeHttpBack;
    private HttpBack<BaseModel> mRegisterHttpBack;
    //第三方登录
    private ImageButton mWeixinLogin;
    private ImageButton mQqLogin;
    private Tencent mTencent;
    private String SCOPE = "all";
    private UserInfo mInfo;
    private Button mChooseRegister;
    private Button mChooseLogin;
    private LinearLayout mLlLoginContent;
    private View mRegisterContent, mRegisterBg, mLoginBg;
    //登录信息请求
    private HttpBack<User> mWXLoginHttpBack;
    private HttpBack<User> mQqLoginHttpBack;
    //广告
    private HttpBack<List<Advertisement>> advertHttpBack;

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
        return R.layout.login_fragment;
    }

    @Override
    public void initView(View view) {
        mCloseLoginView = (ImageView) view.findViewById(R.id.close_login_view);
        mLoginBannerView = (ImageView) view.findViewById(R.id.login_banner_image_view);
        //选择注册还是登录
        mChooseRegister = (Button) view.findViewById(R.id.choose_register);
        mChooseLogin = (Button) view.findViewById(R.id.choose_login);
        mLlLoginContent = (LinearLayout) view.findViewById(R.id.login_content_ll);
        mRegisterContent = view.findViewById(R.id.register_content);
        mLoginBg = view.findViewById(R.id.choose_login_bg);
        mRegisterBg = view.findViewById(R.id.choose_register_bg);

        mLlLoginContent.setVisibility(View.VISIBLE);
        mRegisterContent.setVisibility(View.GONE);
        showContentForLoginOrRegister();
        //登录页面
        mCheckCodeLoginBtn = (Button) view.findViewById(R.id.login_checkcode_login);
        mLoginForgetPwdBtn = (Button) view.findViewById(R.id.login_forget_pwd);
        mEyeCB = (CheckBox) view.findViewById(R.id.login_eye);
        mRegisterEyeCB = (CheckBox) view.findViewById(R.id.register_eye);
        mMobileEdit = (ClearableEditText) view.findViewById(R.id.login_mobile);
        mPwdEdit = (ClearableEditText) view.findViewById(R.id.login_pwd);
        mLoginBtn = (Button) view.findViewById(R.id.login_login);
        String mobile = UserUtils.getLoginName();

        showDefaultLoginaName(mobile);
        //注册页面
        //获取验证码
        mGetCheckCodeBtn = (Button) view.findViewById(R.id.send_register_checkcode);
        //注册信息
        mRegisterMobileEdit = (ClearableEditText) view.findViewById(R.id.register_mobile);
        mCheckCodeEdit = (ClearableEditText) view.findViewById(R.id.register_checkcode);
        mPasswordEdit = (ClearableEditText) view.findViewById(R.id.register_password);
        mInvitationCodeEdit = (ClearableEditText) view.findViewById(R.id.register_recommend);
        //邀请码
        mLlInviteContent = (LinearLayout) view.findViewById(R.id.ll_invite_content);
        mLlShowInviteContent = (LinearLayout) view.findViewById(R.id.ll_show_invite_content);
        mInviteTV = (TextView) view.findViewById(R.id.register_invite);
        mInviteCb = (CheckBox) view.findViewById(R.id.cb_invite);

        mRegisterLoginBtn = (Button) view.findViewById(R.id.register_login);
        mRegisterMobileEdit.addTextChangedListener(mobileWatcher);

        //第三方登录
        mWeixinLogin = (ImageButton) view.findViewById(R.id.weixin_login);
        mQqLogin = (ImageButton) view.findViewById(R.id.qq_login);

        KeyboardUtils.close(getActivity());
    }

    @Override
    public void initData() {
        advertRequest();
    }

    /**
     * 登录页面广告图请求
     */
    private void advertRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("type", Constants.BannerType.LOGIN_ADVERTISING);
        RetrofitUtils.getInstance().getAdverts(ParamUtils.getParam(map), advertHttpBack);
    }

    private void showDefaultLoginaName(String mobile) {
        if (mobile != null) {
            mMobileEdit.setText(mobile);
            mMobileEdit.setSelection(mMobileEdit.getText().toString().trim().length());
            mPwdEdit.requestFocus();
        } else {
            mMobileEdit.requestFocus();
        }
    }

    private void showContentForLoginOrRegister() {
        mChooseLogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mLlLoginContent.setVisibility(View.VISIBLE);
                mRegisterContent.setVisibility(View.GONE);
                mLoginBg.setVisibility(View.VISIBLE);
                mRegisterBg.setVisibility(View.GONE);
                mChooseLogin.setTextColor(ContextCompat.getColor(getActivity(), R.color.white));
                mChooseRegister.setTextColor(ContextCompat.getColor(getActivity(), R.color.login_no_choose_color));
                showDefaultLoginaName(mMobileEdit.getText().toString().trim());
            }
        });

        mChooseRegister.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mLlLoginContent.setVisibility(View.GONE);
                mRegisterContent.setVisibility(View.VISIBLE);
                mLoginBg.setVisibility(View.GONE);
                mRegisterBg.setVisibility(View.VISIBLE);
                mChooseLogin.setTextColor(ContextCompat.getColor(getActivity(), R.color.login_no_choose_color));
                mChooseRegister.setTextColor(ContextCompat.getColor(getActivity(), R.color.white));
                mRegisterMobileEdit.requestFocus();
            }
        });

    }

    public void requestCart() {
        Map<String, Object> map = new HashMap<>();
        map.put("cartInfo", CartUtils.getCartInfo());
        map.put("storeId", CommunityUtils.getCurrentStoreId());
        RetrofitUtils.getInstance(true).synchronizeCart(ParamUtils.getParam(map), cartHttpBack);
    }

    @Override
    public void onStart() {
        super.onStart();
        IntentFilter filter = new IntentFilter();
        filter.addAction(Constants.Receiver.REGISTER);
        getActivity().registerReceiver(receiver, filter);
        IntentFilter loginFilter = new IntentFilter();
        loginFilter.addAction(Constants.Receiver.WXLOGINACTION);
        getActivity().registerReceiver(wxLoginreceiver, loginFilter);
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

    @Override
    public void initHttpBack() {
        mLoginHttpBack = new HttpBack<User>(getBaseActivity()) {
            @Override
            public void onSuccess(User user) {
                loginSuccessMethod(user);
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

        mRegisterHttpBack = new HttpBack<BaseModel>(getBaseActivity()) {
            @Override
            public void onSuccess(BaseModel model) {
                // 注册成功，进行登录
                String mobile = mRegisterMobileEdit.getEditableText().toString();
                String password = mPasswordEdit.getEditableText().toString();
                requestForLogin(mobile, password);
            }
        };

        mWXLoginHttpBack = new HttpBack<User>(getBaseActivity()) {
            @Override
            public void onSuccess(User user) {
                thirdLoginSuccess(user);
            }
        };

        mQqLoginHttpBack = new HttpBack<User>(getBaseActivity()) {
            @Override
            public void onSuccess(User user) {
                thirdLoginSuccess(user);
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

        advertHttpBack = new HttpBack<List<Advertisement>>() {
            @Override
            public void onSuccess(List<Advertisement> advertisements) {
                if (advertisements != null && advertisements.size() == 1) {
                    final Advertisement advertisement = advertisements.get(0);
                    ImageLoaderUtils.load(mLoginBannerView, advertisement.getImageUrl(), R.mipmap.login_banner);

                    mLoginBannerView.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            JumpUtils.jump(getActivity(), advertisement.getLinkType(), advertisement.getLinkData());
                        }
                    });
                } else {
                    mLoginBannerView.setImageResource(R.mipmap.login_banner);
                }
            }

            @Override
            public void onFailure(String msg) {
                mLoginBannerView.setImageResource(R.mipmap.login_banner);
            }

            @Override
            public void onTimeOut() {
                mLoginBannerView.setImageResource(R.mipmap.login_banner);
            }
        };
    }

    private void thirdLoginSuccess(User user) {
        if (user != null && user.getBinding() != null && user.getBinding() == 1) {
            loginSuccessMethod(user);
        } else {
            getBaseActivity().showFragment(RelatedPhoneNumFragment.class.getSimpleName(), null, true);
        }
    }

    private void loginSuccessMethod(User user) {
        // 登入成功，跳转到对应的界面
        String mobile = user.getUserName();
        int memberType = user.getMemberType();
        String userImageUrl = user.getUserImageUrl();
        UserUtils.saveUserInfo(mobile, memberType, user.getVipExpireDate(), userImageUrl,
                user.getNickName(), user.getUserSex(), user.getBirthday(), user.getBindQQInfo(), user.getBindWXInfo());
        if (CommunityUtils.getCurrentStoreId() == null) {//判断是否同步购物车
            getBaseActivity().setResult(Activity.RESULT_OK);
            AppManager.getAppManager().finishActivity();
            return;
        }
        requestCart(); // 同步购物车
    }

    private void requestForLogin(String mobile, String pwd) {
        Map<String, Object> map = new HashMap<>();
        map.put("mobile", mobile);
        map.put("code", pwd);
        map.put("type", Constants.LoginPasswordType.PASSWORD);
        RetrofitUtils.getInstance(true).login(ParamUtils.getParam(map), mLoginHttpBack);
    }

    @Override
    public void initListener() {
        mMobileEdit.addTextChangedListener(new TextWatcher() {
            private CharSequence temp;//监听前的文本
            private int editStart;//光标开始位置
            private int editEnd;//光标结束位置
            private final int charMaxNum = 11;

            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
                temp = s;
            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
            }

            @Override
            public void afterTextChanged(Editable s) {
                /** 得到光标开始和结束位置 ,超过最大数后记录刚超出的数字索引进行控制 */
                editStart = mMobileEdit.getSelectionStart();
                editEnd = mMobileEdit.getSelectionEnd();
                if (temp.length() > charMaxNum) {
                    s.delete(editStart - 1, editEnd);
                    int tempSelection = editStart;
                    mMobileEdit.setText(s);
                    mMobileEdit.setSelection(tempSelection);
                }
            }
        });
        mPwdEdit.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                if (s.toString().length() > 0) {
                    mLoginBtn.setEnabled(true);
                    mLoginBtn.setBackgroundResource(R.drawable.button_yellow_selector);
                    mLoginBtn.setTextColor(ContextCompat.getColor(getActivity(), R.color.white));
                } else {
                    mLoginBtn.setEnabled(false);
                    mLoginBtn.setBackgroundResource(R.drawable.button_white_gray_pressed);
                    mLoginBtn.setTextColor(ContextCompat.getColor(getActivity(), R.color.lightText));
                }

            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });
        mPasswordEdit.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                if (s.toString().length() > 0) {
                    mRegisterLoginBtn.setEnabled(true);
                    mRegisterLoginBtn.setBackgroundResource(R.drawable.button_yellow_selector);
                    mRegisterLoginBtn.setTextColor(ContextCompat.getColor(getActivity(), R.color.white));
                } else {
                    mRegisterLoginBtn.setEnabled(false);
                    mRegisterLoginBtn.setBackgroundResource(R.drawable.button_white_gray_pressed);
                    mRegisterLoginBtn.setTextColor(ContextCompat.getColor(getActivity(), R.color.secondaryText));
                }
            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });
        mCheckCodeLoginBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                KeyboardUtils.close(getActivity());
                getBaseActivity().showFragment(CheckCodeLoginFragment.class.getSimpleName(), null, true);
            }
        });

        mLoginForgetPwdBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                KeyboardUtils.close(getActivity());
                getBaseActivity().showFragment(FindPwdCheckFragment.class.getSimpleName(), null, true);
            }
        });
        mEyeCB.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton compoundButton, boolean isChecked) {
                if (isChecked) {
                    mPwdEdit.setTransformationMethod(HideReturnsTransformationMethod
                            .getInstance());
                    // 如果选中，显示密码
                } else {
                    mPwdEdit.setTransformationMethod(PasswordTransformationMethod
                            .getInstance());
                    // 否则隐藏密码
                }
                mPwdEdit.setSelection(mPwdEdit.getText().toString().length());
            }
        });
        mRegisterEyeCB.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton compoundButton, boolean isChecked) {
                if (isChecked) {
                    mPasswordEdit.setTransformationMethod(HideReturnsTransformationMethod
                            .getInstance());
                    // 如果选中，显示密码
                } else {
                    mPasswordEdit.setTransformationMethod(PasswordTransformationMethod
                            .getInstance());
                    // 否则隐藏密码
                }
                mPasswordEdit.setSelection(mPasswordEdit.getText().toString().length());
            }
        });
        mLoginBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                KeyboardUtils.close(getActivity());
                String mobile = mMobileEdit.getText().toString().trim();
                String pwd = mPwdEdit.getText().toString().trim();
                if (TextUtils.isEmpty(mobile)) {
                    ToastUtils.show(getActivity(), R.string.login_please_input_mobile);
                    return;
                }
                if (TextUtils.isEmpty(pwd)) {
                    ToastUtils.show(getActivity(), R.string.login_please_input_pwd);
                    return;
                }
                if (!CheckUtils.checkPwd(pwd)) {
                    ToastUtils.show(getActivity(), R.string.login_pwd_under_6);
                    return;
                }
                if (!CheckUtils.isMobileNO(mobile)) {
                    ToastUtils.show(getActivity(), R.string.login_mobile_format_error);
                    return;
                }
                requestForLogin(mobile, pwd);
            }
        });
        mGetCheckCodeBtn.setOnClickListener(new View.OnClickListener() {

            public void onClick(View v) {
                String mobile = mRegisterMobileEdit.getText().toString().trim();
                getRegiCode(mobile);
            }
        });

        mRegisterLoginBtn.setOnClickListener(new View.OnClickListener() {

            public void onClick(View v) {
                String mobile = mRegisterMobileEdit.getText().toString().trim();
                String checkCode = mCheckCodeEdit.getText().toString().trim();
                String password = mPasswordEdit.getText().toString().trim();
                String invitationCode = mInvitationCodeEdit.getText().toString().trim();

                if (!CheckUtils.isMobileNO(mobile)) {
                    ToastUtils.show(getActivity(), getText(R.string.login_mobile_format_error).toString());
                    return;
                }

                if (TextUtils.isEmpty(checkCode)) {
                    ToastUtils.show(getActivity(), getText(R.string.register_error_checkcode).toString());
                    return;
                }
                if (!CheckUtils.checkRegiPwd(password)) {
                    ToastUtils.show(getActivity(), getText(R.string.register_error_password).toString());
                    return;
                }
                if (isShowInvite && TextUtils.isEmpty(invitationCode)) {//邀请码的判断
                    ToastUtils.show(getActivity(), getText(R.string.register_invite_code_empty).toString());
                    return;
                }

                KeyboardUtils.close(getActivity());
                Map<String, Object> map = new HashMap<>();
                map.put("mobile", mobile);
                map.put("code", checkCode);
                map.put("password", password);
                if (isShowInvite) {
                    map.put("invitationCode", invitationCode);
                }
                map.put("type", Constants.CheckCodeType.REHGISTER);
                RetrofitUtils.getInstance().register(ParamUtils.getParam(map), mRegisterHttpBack);
            }
        });
        mInviteCb.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                showInviteContent(isChecked);
            }
        });
        mLlShowInviteContent.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                showInviteContent(!isShowInvite);
                mInviteCb.setChecked(isShowInvite);
            }
        });
        mCloseLoginView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                KeyboardUtils.close(getActivity());
                getBaseActivity().setResult(Activity.RESULT_CANCELED);
                AppManager.getAppManager().finishActivity();
            }
        });
        mWeixinLogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                BuyerApp.iwxapi = WXAPIFactory.createWXAPI(getActivity(), Constants.WX_APP_ID, true);
                if (!checkedIsHasWeiXin()) {
                    return;
                }
                mWeixinLogin.setEnabled(false);//防止多次点击
                BuyerApp.iwxapi.registerApp(Constants.WX_APP_ID);
                SendAuth.Req req = new SendAuth.Req();
                req.scope = Constants.WXParam.WXSCOPE;
                req.state = Constants.WXParam.WXSTATE;
                BuyerApp.iwxapi.sendReq(req);
            }
        });

        mQqLogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mQqLogin.setEnabled(false);//防止多次点击
                if (mTencent == null) {
                    mTencent = Tencent.createInstance(Constants.QQ_APP_ID, getActivity());
                }
                onClickThirdLogin();
            }
        });
    }

    private void showInviteContent(boolean isChecked) {
        if (isChecked) {
            mInviteTV.setTextColor(ContextCompat.getColor(getActivity(), R.color.primaryText));
            mLlInviteContent.setVisibility(View.VISIBLE);
            isShowInvite = true;
        } else {
            mInviteTV.setTextColor(ContextCompat.getColor(getActivity(), R.color.secondaryText));
            mLlInviteContent.setVisibility(View.GONE);
            isShowInvite = false;
        }
    }

    private void onClickThirdLogin() {
        if (mTencent.isSessionValid()) {
            mTencent.logout(getActivity());
        }
        mTencent.login(this, SCOPE, qqLoginListener);
    }

    IUiListener qqLoginListener = new BaseUiListener() {
        @Override
        protected void doComplete(JSONObject values) {
            initOpenidAndToken(values);
        }
    };

    @Override
    public void onDestroy() {
        super.onDestroy();
        if (receiver != null) {
            getActivity().unregisterReceiver(receiver);
            receiver = null;
        }
        if (wxLoginreceiver != null) {
            getActivity().unregisterReceiver(wxLoginreceiver);
            wxLoginreceiver = null;
        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == com.tencent.connect.common.Constants.REQUEST_LOGIN ||
                requestCode == com.tencent.connect.common.Constants.REQUEST_APPBAR) {
            Tencent.onActivityResultData(requestCode, resultCode, data, qqLoginListener);
        }
        super.onActivityResult(requestCode, resultCode, data);
    }

    private TextWatcher mobileWatcher = new TextWatcher() {

        public void onTextChanged(CharSequence s, int start, int before,
                                  int count) {
            if (remainTimes > 0) {
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

    private BroadcastReceiver receiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if (Constants.Receiver.REGISTER.equals(action)) {
                AppManager.getAppManager().finishActivity();
            }
        }
    };

    private BroadcastReceiver wxLoginreceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            mWeixinLogin.setEnabled(true);
            String action = intent.getAction();
            if (Constants.Receiver.WXLOGINACTION.equals(action)) {
                int wxLoginCode = intent.getExtras().getInt(Constants.BundleName.LOGINRESULT);
                String wxLoginCodeParams = intent.getExtras().getString(Constants.BundleName.LOGINCODE);
                if (wxLoginCode == Constants.ResultCode.SUCCESS) {
                    wxLoginRequest(wxLoginCodeParams);
                } else {
                    ToastUtils.show(getActivity(), getResources().getString(R.string.wx_login_fail_toast));
                }
            }
        }
    };

    private boolean checkedIsHasWeiXin() {//检查是否安装微信
        if (!BuyerApp.iwxapi.isWXAppInstalled()) {
            ToastUtils.show(getActivity(), getResources().getString(R.string.wx_no_checked));
            return false;
        }
        return true;
    }

    private void wxLoginRequest(String code) {
        Map<String, Object> map = new HashMap<>();
        map.put("code", code);
        RetrofitUtils.getInstance(true).wxLogin(ParamUtils.getParam(map), mWXLoginHttpBack);
    }

    private void qqLoginRequest(String token, String openId) {
        Map<String, Object> map = new HashMap<>();
        map.put("accessToken", token);
        map.put("openId", openId);
        RetrofitUtils.getInstance(true).qqLogin(ParamUtils.getParam(map), mQqLoginHttpBack);
    }

    public void initOpenidAndToken(JSONObject jsonObject) {
        try {
            String token = jsonObject.getString(com.tencent.connect.common.Constants.PARAM_ACCESS_TOKEN);
            String expires = jsonObject.getString(com.tencent.connect.common.Constants.PARAM_EXPIRES_IN);
            String openId = jsonObject.getString(com.tencent.connect.common.Constants.PARAM_OPEN_ID);
            if (!TextUtils.isEmpty(token) && !TextUtils.isEmpty(expires)
                    && !TextUtils.isEmpty(openId)) {
                mTencent.setAccessToken(token, expires);
                mTencent.setOpenId(openId);
                qqLoginRequest(token, openId);
            }
        } catch (Exception e) {
        }
    }

    private void getRegiCode(String mobile) {
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
        map.put("type", Constants.CheckCodeType.REHGISTER);
        RetrofitUtils.getInstance().sendIdCode(ParamUtils.getParam(map), mGetCodeHttpBack);
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
        mGetCheckCodeBtn.setEnabled(true);
        mGetCheckCodeBtn.setTextColor(ContextCompat.getColor(getActivity(), R.color.colorYellow));
        mGetCheckCodeBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getRegiCode(mRegisterMobileEdit.getText().toString().trim());
            }
        });
    }

    private class BaseUiListener implements IUiListener {

        @Override
        public void onComplete(Object response) {
            mQqLogin.setEnabled(true);
            if (null == response) {
                ToastUtils.show(getActivity(), getResources().getString(R.string.qq_authorization_fail_toast));
                return;
            }
            JSONObject jsonResponse = (JSONObject) response;
            if (null != jsonResponse && jsonResponse.length() == 0) {
                ToastUtils.show(getActivity(), getResources().getString(R.string.qq_authorization_fail_toast));
                return;
            }
            doComplete((JSONObject) response);
        }

        //授权成功以后处理方法
        protected void doComplete(JSONObject values) {
        }

        @Override
        public void onError(UiError e) {
            mQqLogin.setEnabled(true);
            ToastUtils.show(getActivity(), getResources().getString(R.string.qq_authorization_fail_toast));
        }

        @Override
        public void onCancel() {
            mQqLogin.setEnabled(true);
        }
    }
}
