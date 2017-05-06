package com.yldbkd.www.seller.android.fragment;

import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.CheckUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.bean.BaseModel;
import com.yldbkd.www.seller.android.utils.http.HttpBack;
import com.yldbkd.www.seller.android.utils.http.ParamUtils;
import com.yldbkd.www.seller.android.utils.http.RetrofitUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * 忘记密码第二步Fragment
 * <p/>
 * Created by linghuxj on 16/6/29.
 */
public class FindStep2Fragment extends BaseFragment {

    private LinearLayout backView;

    private ClearableEditText newView;
    private ClearableEditText confirmView;
    private Button submitBtn;

    private HttpBack<BaseModel> updateHttpBack;

    @Override
    public int setLayoutId() {
        return R.layout.fragment_find_step_2;
    }

    @Override
    public void initView(View view) {
        backView = (LinearLayout) view.findViewById(R.id.ll_back);
        TextView titleView = (TextView) view.findViewById(R.id.tv_title);
        titleView.setText(getText(R.string.title_find));

        newView = (ClearableEditText) view.findViewById(R.id.cet_password_new);
        confirmView = (ClearableEditText) view.findViewById(R.id.cet_password_confirm);
        submitBtn = (Button) view.findViewById(R.id.btn_submit);
    }

    @Override
    public void initHttpBack() {
        updateHttpBack = new HttpBack<BaseModel>() {
            @Override
            public void onSuccess(BaseModel model) {
                getBaseActivity().showFragment(LoginFragment.class.getSimpleName(), null, false);
            }
        };
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getActivity().onBackPressed();
            }
        });
        submitBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String newPassword = newView.getText().toString().trim();
                String confirmPassword = confirmView.getText().toString().trim();
                passwordRequest(newPassword, confirmPassword);
            }
        });
    }

    private void passwordRequest(String newP, String confirm) {
        if (TextUtils.isEmpty(newP)) {
            ToastUtils.show(getActivity(), R.string.password_please_new);
            return;
        }
        if (TextUtils.isEmpty(confirm)) {
            ToastUtils.show(getActivity(), R.string.password_please_confirm);
            return;
        }
        if (!CheckUtils.checkPwd(newP) || !CheckUtils.checkPwd(confirm)) {
            ToastUtils.show(getActivity(), R.string.password_error);
            return;
        }
        if (!newP.equals(confirm)) {
            ToastUtils.show(getActivity(), R.string.password_error_different);
            return;
        }
        Map<String, Object> map = new HashMap<>();
        map.put("password", newP);
        RetrofitUtils.getInstance(true).resetPassword(ParamUtils.getParam(map), updateHttpBack);
    }
}
