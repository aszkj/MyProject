package com.yldbkd.www.buyer.android.fragment;

import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.BaseModel;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.CheckUtils;
import com.yldbkd.www.library.android.common.KeyboardUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;

import java.util.HashMap;
import java.util.Map;

/**
 * 修改密码页面Fragment
 * <p/>
 * Created by linghuxj on 15/10/14.
 */
public class PasswordFragment extends BaseFragment {
    private ClearableEditText mPrimaryPwd;// et_primary_pwd
    private ClearableEditText mNewPwd;// et_new_pwd
    private ClearableEditText mSurePwd; // et_sure_pwd
    private Button mSubmitBtn;
    private View mBackView;
    private TextView mTitleTV;
    private HttpBack<BaseModel> mUpdatePwdHttpBack;

    @Override
    public int setLayoutId() {
        return R.layout.password_fragment;
    }

    @Override
    public void initView(View view) {
        mBackView = view.findViewById(R.id.back_view);
        mTitleTV = (TextView) view.findViewById(R.id.title_view);
        mTitleTV.setText(getText(R.string.login_update_pwd));
        mSubmitBtn = (Button) view.findViewById(R.id.btn_submit);
        mPrimaryPwd = (ClearableEditText) view.findViewById(R.id.et_primary_pwd);
        mNewPwd = (ClearableEditText) view.findViewById(R.id.et_new_pwd);
        mSurePwd = (ClearableEditText) view.findViewById(R.id.et_sure_pwd);

    }

    @Override
    public void initHttpBack() {
        mUpdatePwdHttpBack = new HttpBack<BaseModel>(getBaseActivity()) {
            @Override
            public void onSuccess(BaseModel model) {
                UserUtils.clearLoginInfo();
                getBaseActivity().showFragment(LoginFragment.class.getSimpleName(), null, false);
            }
        };
    }

    @Override
    public void initListener() {
        mBackView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getBaseActivity().onBackPressed();
            }
        });

        mSubmitBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String primaryPwd = mPrimaryPwd.getText().toString().trim();
                String newPwd = mNewPwd.getText().toString().trim();
                String surePwd = mSurePwd.getText().toString().trim();
                if (TextUtils.isEmpty(primaryPwd)) {
                    // 设置提示
                    ToastUtils.show(getActivity(), R.string.login_please_input_primary_pwd);
                    return;
                }
                if (TextUtils.isEmpty(newPwd)) {
                    // 设置提示
                    ToastUtils.show(getActivity(), R.string.login_please_input_new_pwd);
                    return;
                }
                if (TextUtils.isEmpty(surePwd)) {
                    // 设置提示
                    ToastUtils.show(getActivity(), R.string.login_please_again_input_pwd);
                    return;
                }
                if (!CheckUtils.checkRegiPwd(newPwd) ||
                        !CheckUtils.checkRegiPwd(surePwd)) {
                    ToastUtils.show(getActivity(), R.string.login_pwd_under_6);
                    return;
                }
                if (!newPwd.equals(surePwd)) {
                    ToastUtils.show(getActivity(), R.string.login_pwd_not_same);
                    return;
                }
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("oldPassword", primaryPwd);
                map.put("password", newPwd);
                RetrofitUtils.getInstance(true).modifyPassword(ParamUtils.getParam(map), mUpdatePwdHttpBack);
                KeyboardUtils.close(getActivity());
            }
        });
    }
}
