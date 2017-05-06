package com.yldbkd.www.buyer.android.fragment;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.text.TextUtils;
import android.view.View;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.tencent.mm.sdk.modelmsg.SendAuth;
import com.tencent.mm.sdk.openapi.WXAPIFactory;
import com.tencent.tauth.IUiListener;
import com.tencent.tauth.Tencent;
import com.tencent.tauth.UiError;
import com.yldbkd.www.buyer.android.BuyerApp;
import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.LoginActivity;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.BaseModel;
import com.yldbkd.www.buyer.android.bean.QQData;
import com.yldbkd.www.buyer.android.bean.WXData;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.viewCustomer.CommonDialog;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

/**
 * @创建者 李贞高
 * @创建时间 2017/2/20 18:26
 * @描述 账户安全
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */

public class AccountSafeFragment extends BaseFragment {
    private static final int WXCHAT = 1;
    private static final int QQ = 2;
    private View backView;
    private TextView titleView;
    private RelativeLayout mUpdatePassword;
    private RelativeLayout mBindPhone;
    private TextView mTvPhone;
    private RelativeLayout mBindWChat;
    private TextView mTvWXNickName;
    private RelativeLayout mBindQQ;
    private TextView mTvQQNickName;
    private boolean isBindWX;
    private boolean isBindQQ;

    private CommonDialog bindDialog;
    private HttpBack<BaseModel> unBindQQHttpBack;
    private HttpBack<BaseModel> unBindWXHttpBack;
    private Tencent mTencent;
    private String SCOPE = "all";
    private HttpBack<WXData> mBindWXHttpBack;
    private HttpBack<QQData> mBindQQHttpBack;

    @Override
    public int setLayoutId() {
        return R.layout.account_safe_fragment;
    }

    @Override
    public void initView(View view) {
        backView = view.findViewById(R.id.back_view);
        titleView = (TextView) view.findViewById(R.id.title_view);
        titleView.setText(getResources().getString(R.string.setting_safe));

        mUpdatePassword = (RelativeLayout) view.findViewById(R.id.rl_update_password);
        mBindPhone = (RelativeLayout) view.findViewById(R.id.rl_update_bind_phone);
        mTvPhone = (TextView) view.findViewById(R.id.tv_phone);
        mBindWChat = (RelativeLayout) view.findViewById(R.id.rl_update_bind_wchat);
        mTvWXNickName = (TextView) view.findViewById(R.id.tv_wx_nickname);
        mBindQQ = (RelativeLayout) view.findViewById(R.id.rl_update_bind_qq);
        mTvQQNickName = (TextView) view.findViewById(R.id.tv_qq_nickname);
    }

    @Override
    public void initData() {
        mTvPhone.setText(UserUtils.getUserName().replaceAll("(\\d{3})\\d{4}(\\d{4})", "$1****$2"));
        showThirdAccountInfo();
    }

    private void showThirdAccountInfo() {
        isBindWX = UserUtils.getWXData() != null;
        isBindQQ = UserUtils.getQQData() != null;
        mTvWXNickName.setText(isBindWX ? (UserUtils.getWXData().getNickName() == null ? "" : UserUtils.getWXData().getNickName()) : getResources().getString(R.string.setting_unbind));
        mTvQQNickName.setText(isBindQQ ? (UserUtils.getQQData().getNickName() == null ? "" : UserUtils.getQQData().getNickName()) : getResources().getString(R.string.setting_unbind));
    }

    @Override
    public void onStart() {
        super.onStart();
        IntentFilter bindFilter = new IntentFilter();
        bindFilter.addAction(Constants.Receiver.WXLOGINACTION);
        getActivity().registerReceiver(wxBindreceiver, bindFilter);
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        if (wxBindreceiver != null) {
            getActivity().unregisterReceiver(wxBindreceiver);
            wxBindreceiver = null;
        }
    }

    @Override
    public void initHttpBack() {
        unBindQQHttpBack = new HttpBack<BaseModel>(getBaseActivity()) {
            @Override
            public void onSuccess(BaseModel baseModel) {
                refreshQQData(null);
                ToastUtils.showShort(getActivity(), getResources().getString(R.string.unbind_third_success_toast));
            }
        };
        unBindWXHttpBack = new HttpBack<BaseModel>(getBaseActivity()) {
            @Override
            public void onSuccess(BaseModel baseModel) {
                refreshWXData(null);
                ToastUtils.showShort(getActivity(), getResources().getString(R.string.unbind_third_success_toast));
            }
        };
        mBindWXHttpBack = new HttpBack<WXData>(getBaseActivity()) {
            @Override
            public void onSuccess(WXData wxData) {
                refreshWXData(wxData);
                ToastUtils.showShort(getActivity(), getResources().getString(R.string.bind_third_success_toast));
            }
        };
        mBindQQHttpBack = new HttpBack<QQData>(getBaseActivity()) {
            @Override
            public void onSuccess(QQData qqData) {
                refreshQQData(qqData);
                ToastUtils.showShort(getActivity(), getResources().getString(R.string.bind_third_success_toast));
            }
        };
    }

    private void refreshQQData(QQData qqData) {
        UserUtils.setQQData(qqData);
        showThirdAccountInfo();
    }

    private void refreshWXData(WXData wxData) {
        UserUtils.setWXData(wxData);
        showThirdAccountInfo();
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getActivity().onBackPressed();
            }
        });
        mUpdatePassword.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getActivity(), LoginActivity.class);
                intent.setAction(PasswordFragment.class.getSimpleName());
                startActivity(intent);
            }
        });
        mBindPhone.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
            }
        });
        mBindWChat.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                bindThirdAccount(WXCHAT);
            }
        });
        mBindQQ.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                bindThirdAccount(QQ);
            }
        });
    }

    private void bindThirdAccount(final int type) {
        if (bindDialog != null && bindDialog.isShowing()) {
            return;
        }
        int typeRes;
        final boolean isBind;
        typeRes = type == QQ ? R.string.qq : R.string.wxchat;
        isBind = type == QQ ? isBindQQ : isBindWX;
        bindDialog = new CommonDialog(getActivity(), new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                bindDialog.dismiss();
                if (isBind) {
                    unBindThirdAccount(type);
                } else {
                    if (type == QQ) {
                        getQQAuthorization();
                    } else {
                        getWXAuthorization();
                    }
                }
            }
        });
        bindDialog.setData(isBind ? getResources().getString(R.string.unbind_third_account_dialog)
                        : String.format(getResources().getString(R.string.bind_third_account_dialog), getResources().getString(typeRes)),
                isBind ? getResources().getString(R.string.confirm_button_text) : getResources().getString(R.string.bind_third_account));
        bindDialog.show();
    }

    private void unBindThirdAccount(int type) {
        if (type == QQ) {
            RetrofitUtils.getInstance().unbindQQ(ParamUtils.getParam(null), unBindQQHttpBack);
        } else {
            RetrofitUtils.getInstance().unbindWX(ParamUtils.getParam(null), unBindWXHttpBack);
        }
    }

    public void getWXAuthorization() {
        BuyerApp.iwxapi = WXAPIFactory.createWXAPI(getActivity(), Constants.WX_APP_ID, true);
        if (!checkedIsHasWeiXin()) {
            return;
        }
        BuyerApp.iwxapi.registerApp(Constants.WX_APP_ID);
        SendAuth.Req req = new SendAuth.Req();
        req.scope = Constants.WXParam.WXSCOPE;
        req.state = Constants.WXParam.WXSTATE;
        BuyerApp.iwxapi.sendReq(req);
    }

    private boolean checkedIsHasWeiXin() {//检查是否安装微信
        if (!BuyerApp.iwxapi.isWXAppInstalled()) {
            ToastUtils.show(getActivity(), getResources().getString(R.string.wx_no_checked));
            return false;
        }
        return true;
    }

    private BroadcastReceiver wxBindreceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if (Constants.Receiver.WXLOGINACTION.equals(action)) {
                int wxBindCode = intent.getExtras().getInt(Constants.BundleName.LOGINRESULT);
                String wxBindCodeParams = intent.getExtras().getString(Constants.BundleName.LOGINCODE);
                if (wxBindCode == Constants.ResultCode.SUCCESS) {
                    wxBindRequest(wxBindCodeParams);
                } else {
                    ToastUtils.show(getActivity(), getResources().getString(R.string.wx_login_fail_toast));
                }
            }
        }
    };

    private void wxBindRequest(String code) {
        Map<String, Object> map = new HashMap<>();
        map.put("code", code);
        map.put("tradeType", "APP");
        RetrofitUtils.getInstance(true).bindWX(ParamUtils.getParam(map), mBindWXHttpBack);
    }

    public void getQQAuthorization() {
        if (mTencent == null) {
            mTencent = Tencent.createInstance(Constants.QQ_APP_ID, getActivity());
        }
        if (mTencent.isSessionValid()) {
            mTencent.logout(getActivity());
        }
        mTencent.login(this, SCOPE, qqBindListener);
    }

    IUiListener qqBindListener = new BaseUiListener() {
        @Override
        protected void doComplete(JSONObject values) {
            initOpenidAndToken(values);
        }
    };

    public void initOpenidAndToken(JSONObject jsonObject) {
        try {
            String token = jsonObject.getString(com.tencent.connect.common.Constants.PARAM_ACCESS_TOKEN);
            String expires = jsonObject.getString(com.tencent.connect.common.Constants.PARAM_EXPIRES_IN);
            String openId = jsonObject.getString(com.tencent.connect.common.Constants.PARAM_OPEN_ID);
            if (!TextUtils.isEmpty(token) && !TextUtils.isEmpty(expires)
                    && !TextUtils.isEmpty(openId)) {
                mTencent.setAccessToken(token, expires);
                mTencent.setOpenId(openId);
                qqBindRequest(token, openId);
            }
        } catch (Exception e) {
        }
    }

    private void qqBindRequest(String token, String openId) {
        Map<String, Object> map = new HashMap<>();
        map.put("accessToken", token);
        map.put("openId", openId);
        RetrofitUtils.getInstance(true).bindQQ(ParamUtils.getParam(map), mBindQQHttpBack);
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == com.tencent.connect.common.Constants.REQUEST_LOGIN ||
                requestCode == com.tencent.connect.common.Constants.REQUEST_APPBAR) {
            Tencent.onActivityResultData(requestCode, resultCode, data, qqBindListener);
        }
        super.onActivityResult(requestCode, resultCode, data);
    }

    private class BaseUiListener implements IUiListener {

        @Override
        public void onComplete(Object response) {
            if (null == response) {
                ToastUtils.show(getActivity(), getResources().getString(R.string.qq_authorization_fail_toast));
                return;
            }
            JSONObject jsonResponse = (JSONObject) response;
            if (jsonResponse.length() == 0) {
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
            ToastUtils.show(getActivity(), getResources().getString(R.string.qq_authorization_fail_toast));
        }

        @Override
        public void onCancel() {
            ToastUtils.show(getActivity(), getResources().getString(R.string.qq_authorization_cancel_toast));
        }
    }
}
