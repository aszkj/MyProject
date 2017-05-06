package com.yldbkd.www.seller.android.fragment;

import android.content.Intent;
import android.text.TextUtils;
import android.text.method.HideReturnsTransformationMethod;
import android.text.method.PasswordTransformationMethod;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.CheckUtils;
import com.yldbkd.www.library.android.common.KeyboardUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;
import com.yldbkd.www.library.android.viewCustomer.ImgTxtButton;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.activity.MainActivity;
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
 * 登录页面
 */
public class LoginFragment extends BaseFragment {

    private ImgTxtButton findView;

    private ClearableEditText mobileView;
    private ClearableEditText passwordView;
    private CheckBox eyeView;

    private LinearLayout forgetView;

    private Button loginBtn;

    private HttpBack<StoreBase> storeHttpBack;

    @Override
    public int setLayoutId() {
        return R.layout.fragment_login;
    }

    @Override
    public void initView(View view) {
        LinearLayout backView = (LinearLayout) view.findViewById(R.id.ll_back);
        backView.setVisibility(View.GONE);
        TextView titleView = (TextView) view.findViewById(R.id.tv_title);
        findView = (ImgTxtButton) view.findViewById(R.id.itb_right);
        titleView.setText(getString(R.string.title_login));
        findView.setText(getString(R.string.login_forget_btn));


        mobileView = (ClearableEditText) view.findViewById(R.id.cet_login_mobile);
        passwordView = (ClearableEditText) view.findViewById(R.id.cet_login_pwd);
        eyeView = (CheckBox) view.findViewById(R.id.cb_login_eye);
        String mobile = UserUtils.getLoginName();
        if (!TextUtils.isEmpty(mobile)) {
            mobileView.setText(mobile);
            passwordView.requestFocus();
            KeyboardUtils.openDelay(getContext(), passwordView);
        } else {
            mobileView.requestFocus();
            KeyboardUtils.openDelay(getContext(), mobileView);
        }
        forgetView = (LinearLayout) view.findViewById(R.id.tv_login_forget_notify);

        loginBtn = (Button) view.findViewById(R.id.btn_login);
    }

    @Override
    public void initHttpBack() {
        storeHttpBack = new HttpBack<StoreBase>() {
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

    private void loginRequest(String mobile, String pwd) {
        Map<String, Object> map = new HashMap<>();
        if (!validate(mobile, pwd)) {
            return;
        }
        map.put("mobile", mobile);
        map.put("code", pwd);
        map.put("type", Constants.LoginType.BY_PASSWORD);
        RetrofitUtils.getInstance(true).login(ParamUtils.getParam(map), storeHttpBack);
    }

    private boolean validate(String mobile, String pwd) {
        if (TextUtils.isEmpty(mobile)) {
            ToastUtils.show(getActivity(), R.string.login_please_mobile);
            return false;
        }
        if (TextUtils.isEmpty(pwd)) {
            ToastUtils.show(getActivity(), R.string.login_please_password);
            return false;
        }
        if (!CheckUtils.checkPwd(pwd)) {
            ToastUtils.show(getActivity(), R.string.login_error_password);
            return false;
        }
        if (!CheckUtils.isMobileNO(mobile)) {
            ToastUtils.show(getActivity(), R.string.login_error_mobile);
            return false;
        }
        return true;
    }

    @Override
    public void initListener() {
        findView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getBaseActivity().showFragment(FindStep1Fragment.class.getSimpleName(), null, true);
            }
        });
        forgetView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getBaseActivity().showFragment(LoginCodeFragment.class.getSimpleName(), null, true);
            }
        });
        eyeView.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton compoundButton, boolean isChecked) {
                passwordView.setTransformationMethod(isChecked ? HideReturnsTransformationMethod.getInstance()
                        : PasswordTransformationMethod.getInstance());
                passwordView.requestFocus();
                passwordView.setSelection(passwordView.getText().length());
            }
        });
        loginBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                KeyboardUtils.close(getActivity());
                String mobile = mobileView.getText().toString();
                String pwd = passwordView.getText().toString().trim();
                loginRequest(mobile, pwd);
            }
        });
    }
}
