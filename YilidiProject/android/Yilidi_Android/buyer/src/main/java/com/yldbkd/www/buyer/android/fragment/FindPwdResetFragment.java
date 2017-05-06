package com.yldbkd.www.buyer.android.fragment;

import android.os.Bundle;
import android.support.v4.content.ContextCompat;
import android.text.Editable;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.BaseModel;
import com.yldbkd.www.buyer.android.utils.Constants;
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
import java.util.Map;

/**
 * Created by HP on 2015/10/23.
 * 找回密码之重置密码
 */
public class FindPwdResetFragment extends BaseFragment {
    private View mBackView;
    private TextView mTitleTV;
    private ImgTxtButton mRightView;
    private HttpBack<BaseModel> mSubmitHttpBack;
    private Button mSubmitBtn;
    private ClearableEditText mPwdEdit;
    private ClearableEditText mConfimPwdEdit;// find_pwd_checkcode
    private String mobile;

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        mobile = bundle.getString(Constants.BundleName.MOBILE);
    }

    @Override
    public int setLayoutId() {
        return R.layout.find_pwd_reset;
    }

    @Override
    public void initView(View view) {
        mBackView = view.findViewById(R.id.back_view);
        mTitleTV = (TextView) view.findViewById(R.id.title_view);
        mRightView = (ImgTxtButton) view.findViewById(R.id.right_view);
        mTitleTV.setText(getText(R.string.login_find_pwd));
        mPwdEdit = (ClearableEditText) view.findViewById(R.id.find_pwd_pwd);
        mConfimPwdEdit = (ClearableEditText) view.findViewById(R.id.find_pwd_confim_pwd);
        mSubmitBtn = (Button) view.findViewById(R.id.find_pwd_submit);
        mConfimPwdEdit.addTextChangedListener(textWatcher);

    }

    @Override
    public void initData() {
        super.initData();
        mPwdEdit.requestFocus();
        KeyboardUtils.openDelay(getActivity(), mPwdEdit);
    }

    @Override
    public void initHttpBack() {
        mSubmitHttpBack = new HttpBack<BaseModel>(getBaseActivity()) {
            @Override
            public void onSuccess(BaseModel model) {
                AppManager.getAppManager().finishActivity();
            }
        };
    }

    @Override
    public void initListener() {
        mSubmitBtn.setOnClickListener(new View.OnClickListener() {

            public void onClick(View v) {
                String pwd = mPwdEdit.getText().toString().trim();
                String confimPwd = mConfimPwdEdit.getText().toString().trim();
                if (TextUtils.isEmpty(pwd)) {
                    ToastUtils.show(getBaseActivity(), getText(R.string.login_please_input_pwd).toString());
                    return;
                }
                if (TextUtils.isEmpty(confimPwd)) {
                    ToastUtils.show(getActivity(), getText(R.string.login_please_again_input_pwd).toString());
                    return;
                }
                if (!pwd.equals(confimPwd)) {
                    ToastUtils.show(getActivity(), getText(R.string.login_pwd_different).toString());
                    return;
                }
                if (!CheckUtils.checkRegiPwd(pwd)) {
                    ToastUtils.show(getActivity(), getText(R.string.login_pwd_rule).toString());
                    return;
                }
                KeyboardUtils.close(getActivity());
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("userId", mobile);// mobile
                map.put("password", pwd);
                RetrofitUtils.getInstance().resetPassword(ParamUtils.getParam(map), mSubmitHttpBack);
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

    private TextWatcher textWatcher = new TextWatcher() {

        public void onTextChanged(CharSequence s, int start, int before,
                                  int count) {
            String pwd = mPwdEdit.getText().toString().trim();
            if (TextUtils.isEmpty(pwd)) {
                mSubmitBtn.setBackgroundResource(R.drawable.button_white_gray_pressed);
                mSubmitBtn.setTextColor(ContextCompat.getColor(getActivity(), R.color.lightText));
                return;
            }
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

}