package com.yldbkd.www.buyer.android.fragment;

import android.content.Intent;
import android.net.Uri;
import android.view.View;
import android.widget.Button;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.AddressActivity;
import com.yldbkd.www.buyer.android.activity.H5CordovaActivity;
import com.yldbkd.www.buyer.android.activity.LoginActivity;
import com.yldbkd.www.buyer.android.activity.MainActivity;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.BaseModel;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;

/**
 * @创建者 李贞高
 * @创建时间 2017/2/20 18:26
 * @描述 设置
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */

public class SettingFragment extends BaseFragment {
    private View backView;
    private TextView titleView;
    private RelativeLayout mSettingUserInfo;
    private RelativeLayout mSettingSafe;
    private RelativeLayout mSettingAddressmanager;
    private RelativeLayout mSettingFeedback;
    private RelativeLayout mSettingQuestion;
    private RelativeLayout mSettingAboutUs;
    private RelativeLayout mCall;
    private Button mLoginOut;
    private HttpBack<BaseModel> outHttpBack;

    @Override
    public int setLayoutId() {
        return R.layout.setting_fragment;
    }

    @Override
    public void initView(View view) {
        backView = view.findViewById(R.id.back_view);
        titleView = (TextView) view.findViewById(R.id.title_view);
        titleView.setText(getResources().getString(R.string.setting_title));

        mSettingUserInfo = (RelativeLayout) view.findViewById(R.id.rl_setting_userinfo);
        mSettingSafe = (RelativeLayout) view.findViewById(R.id.rl_setting_safe);
        mSettingAddressmanager = (RelativeLayout) view.findViewById(R.id.rl_address_manager);
        mSettingFeedback = (RelativeLayout) view.findViewById(R.id.rl_setting_feedback);
        mSettingQuestion = (RelativeLayout) view.findViewById(R.id.rl_setting_question);
        mSettingAboutUs = (RelativeLayout) view.findViewById(R.id.rl_setting_about_us);
        mCall = (RelativeLayout) view.findViewById(R.id.rl_call);
        mLoginOut = (Button) view.findViewById(R.id.setting_login_out);
    }

    @Override
    public void initHttpBack() {
        outHttpBack = new HttpBack<BaseModel>(getBaseActivity()) {
            @Override
            public void onSuccess(BaseModel baseModel) {
                UserUtils.clearLoginInfo();
                Intent intent = new Intent(getActivity(), MainActivity.class);
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
        //地址管理
        mSettingAddressmanager.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                linkTo(AddressActivity.class, AddressListFragment.class.getSimpleName(),
                        Constants.RequestCode.PROFILE_ADDRESS_LOGIN_CODE, true);
            }
        });
        //账户安全
        mSettingSafe.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getBaseActivity().showFragment(AccountSafeFragment.class.getSimpleName(), null, true);
            }
        });
        mCall.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                //用intent启动拨打电话
                Intent intent = new Intent(Intent.ACTION_CALL, Uri.parse("tel:" +
                        getResources().getString(R.string.customer_service_line)));
                startActivity(intent);
            }
        });
        //常见问题
        mSettingQuestion.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(getActivity(), H5CordovaActivity.class);
                intent.putExtra(Constants.BundleName.TYPE_AGREEMENT, Constants.RuleAgreementType.NORMAL_ASK);
                startActivity(intent);
            }
        });
        //个人资料
        mSettingUserInfo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getBaseActivity().showFragment(UserInfoFragment.class.getSimpleName(), null, true);
            }
        });
        //关于我们
        mSettingAboutUs.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(getActivity(), H5CordovaActivity.class);
                intent.putExtra(Constants.BundleName.TYPE_AGREEMENT, Constants.RuleAgreementType.ABOUT_US);
                startActivity(intent);
            }
        });
        //意见反馈
        mSettingFeedback.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getBaseActivity().showFragment(FeedBackFragment.class.getSimpleName(), null, true);
            }
        });
        mLoginOut.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                loginOutRequest();
            }
        });

    }

    private void linkTo(Class clazz, String fragmentName, int requestCode, boolean isNeedLogin) {
        Intent intent;
        if (isNeedLogin && !UserUtils.isLogin()) {
            intent = new Intent(getActivity(), LoginActivity.class);
            intent.setAction(LoginFragment.class.getSimpleName());
            startActivityForResult(intent, requestCode);
        } else {
            intent = new Intent(getActivity(), clazz);
            intent.setAction(fragmentName);
            startActivity(intent);
        }
    }

    private void loginOutRequest() {
        RetrofitUtils.getInstance(true).logOut(ParamUtils.getParam(null), outHttpBack);
    }
}
