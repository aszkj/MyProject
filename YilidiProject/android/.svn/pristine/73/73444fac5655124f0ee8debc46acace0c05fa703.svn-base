package com.yldbkd.www.buyer.android.fragment;

import android.content.Intent;
import android.text.TextUtils;
import android.view.View;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.MainActivity;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.User;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;

/**
 * Vip下单成功支付订单完成页面
 * <p/>
 * Created by linghuxj on 15/11/21.
 */
public class PaySuccessVipFragment extends BaseFragment {

    private RelativeLayout backView;
    private TextView vipExpireDate;

    @Override
    public int setLayoutId() {
        return R.layout.pay_success_vip_fragment;
    }

    @Override
    public void initData() {
        setData();
    }

    @Override
    public void initView(View view) {
        backView = (RelativeLayout) view.findViewById(R.id.back_view);
        TextView titleView = (TextView) view.findViewById(R.id.title_view);
        titleView.setText(getResources().getString(R.string.pay_success));
        vipExpireDate = (TextView) view.findViewById(R.id.vip_expire_date);
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(getActivity(), MainActivity.class);
                startActivity(intent);
                getActivity().onBackPressed();
            }
        });
    }

    private void setData() {
        if (UserUtils.isLogin()) {
            RetrofitUtils.getInstance().userInfo(ParamUtils.getParam(null), new HttpBack<User>(getBaseActivity()) {
                @Override
                public void onSuccess(User user) {
                    UserUtils.saveUserInfo(user.getUserName(), user.getMemberType(), user.getVipExpireDate(), user.getUserImageUrl(),
                            user.getNickName(), user.getUserSex(), user.getBirthday(), user.getBindQQInfo(), user.getBindWXInfo());
                    if (TextUtils.isEmpty(user.getVipExpireDate())) {
                        vipExpireDate.setVisibility(View.GONE);
                    } else {
                        vipExpireDate.setText(String.format(getResources().getString(R.string.update_vip_expire), user.getVipExpireDate()));
                    }
                }

                @Override
                public void onFailure(String msg) {
                }

                @Override
                public void onTimeOut() {
                }
            });
        }
    }
}
