package com.yldbkd.www.seller.android.fragment;

import android.content.Intent;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.CheckUtils;
import com.yldbkd.www.library.android.common.KeyboardUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.activity.LoginActivity;
import com.yldbkd.www.seller.android.bean.BaseModel;
import com.yldbkd.www.seller.android.utils.UserUtils;
import com.yldbkd.www.seller.android.utils.http.HttpBack;
import com.yldbkd.www.seller.android.utils.http.ParamUtils;
import com.yldbkd.www.seller.android.utils.http.RetrofitUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * 修改密码页面Fragment
 * <p/>
 * Created by linghuxj on 15/10/14.
 */
public class PasswordFragment extends BaseFragment {

    private LinearLayout backView;

    private ClearableEditText originView;
    private ClearableEditText newView;
    private ClearableEditText confirmView;
    private Button submitBtn;
    private HttpBack<BaseModel> updateHttpBack;

    @Override
    public int setLayoutId() {
        return R.layout.fragment_password;
    }

    @Override
    public void initView(View view) {
        backView = (LinearLayout) view.findViewById(R.id.ll_back);
        TextView titleView = (TextView) view.findViewById(R.id.tv_title);
        titleView.setText(getText(R.string.title_modify_password));

        originView = (ClearableEditText) view.findViewById(R.id.cet_password_origin);
        newView = (ClearableEditText) view.findViewById(R.id.cet_password_new);
        confirmView = (ClearableEditText) view.findViewById(R.id.cet_password_confirm);
        submitBtn = (Button) view.findViewById(R.id.btn_submit);
    }

    @Override
    public void initHttpBack() {
        updateHttpBack = new HttpBack<BaseModel>() {
            @Override
            public void onSuccess(BaseModel model) {
                UserUtils.clearLoginInfo();
                Intent intent = new Intent(getActivity(), LoginActivity.class);
                intent.setAction(LoginFragment.class.getSimpleName());
                startActivity(intent);
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
                String originPassword = originView.getText().toString().trim();
                String newPassword = newView.getText().toString().trim();
                String confirmPassword = confirmView.getText().toString().trim();
                if (passwordRequest(originPassword, newPassword, confirmPassword)) {
                    KeyboardUtils.close(getActivity());
                }
            }
        });
    }

    private boolean passwordRequest(String origin, String newP, String confirm) {
        if (TextUtils.isEmpty(origin)) {
            ToastUtils.show(getActivity(), R.string.password_please_origin);
            return false;
        }
        if (TextUtils.isEmpty(newP)) {
            ToastUtils.show(getActivity(), R.string.password_please_new);
            return false;
        }
        if (TextUtils.isEmpty(confirm)) {
            ToastUtils.show(getActivity(), R.string.password_please_confirm);
            return false;
        }
        if (!CheckUtils.checkPwd(origin) || !CheckUtils.checkPwd(newP) || !CheckUtils.checkPwd(confirm)) {
            ToastUtils.show(getActivity(), R.string.password_error);
            return false;
        }
        if (!newP.equals(confirm)) {
            ToastUtils.show(getActivity(), R.string.password_error_different);
            return false;
        }
        Map<String, Object> map = new HashMap<>();
        map.put("oldPassword", origin);
        map.put("password", newP);
        RetrofitUtils.getInstance(true).updatePassword(ParamUtils.getParam(map), updateHttpBack);
        return true;
    }
}
