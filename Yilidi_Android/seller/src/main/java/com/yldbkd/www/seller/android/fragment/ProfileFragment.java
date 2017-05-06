package com.yldbkd.www.seller.android.fragment;

import android.content.Intent;
import android.net.Uri;
import android.os.Handler;
import android.os.Message;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.MoneyUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.SellerApp;
import com.yldbkd.www.seller.android.activity.AllotOrderListActivity;
import com.yldbkd.www.seller.android.activity.H5CordovaActivity;
import com.yldbkd.www.seller.android.activity.LoginActivity;
import com.yldbkd.www.seller.android.bean.BaseModel;
import com.yldbkd.www.seller.android.bean.StoreDataStatistics;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.utils.UserUtils;
import com.yldbkd.www.seller.android.utils.http.HttpBack;
import com.yldbkd.www.seller.android.utils.http.ParamUtils;
import com.yldbkd.www.seller.android.utils.http.RetrofitUtils;
import com.yldbkd.www.seller.android.utils.update.UpdateManager;

import java.lang.ref.WeakReference;

/**
 * 店铺中心首页页面
 * <p/>
 * Created by linghuxj on 16/6/7.
 */
public class ProfileFragment extends BaseFragment {

    private LinearLayout backView;

    private ImageView ivEditStore;
    private ImageView storeImageView;
    private TextView storeNameView;
    private TextView storeMobileView;

    private TextView thisWeekView;
    private TextView lastWeekView;
    private TextView complainView;

    private RelativeLayout allotOrderLayout;
    private RelativeLayout passwordLayout;
    private RelativeLayout suggestLayout;
    private RelativeLayout helpCenterLayout;
    private RelativeLayout aboutUsLayout;
    private RelativeLayout updateLayout;
    private RelativeLayout phoneLayout;

    private Button loginOutBtn;

    private HttpBack<StoreDataStatistics> statisticsHttpBack;
    private HttpBack<BaseModel> loginOutHttpBack;

    private CheckHandler handler = new CheckHandler(this);

    @Override
    public int setLayoutId() {
        return R.layout.fragment_profile;
    }

    @Override
    public void initHttpBack() {
        statisticsHttpBack = new HttpBack<StoreDataStatistics>() {
            @Override
            public void onSuccess(StoreDataStatistics storeDataStatistics) {
                thisWeekView.setText(String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(
                        storeDataStatistics.getCurrentWeekAmount())));
                lastWeekView.setText(String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(
                        storeDataStatistics.getLastWeekAmount())));
            }
        };
        loginOutHttpBack = new HttpBack<BaseModel>() {
            @Override
            public void onSuccess(BaseModel baseModel) {
                UserUtils.clearLoginInfo();
                Intent intent = new Intent(getActivity(), LoginActivity.class);
                intent.setAction(LoginFragment.class.getSimpleName());
                startActivity(intent);
            }
        };
    }

    @Override
    public void initView(View view) {
        backView = (LinearLayout) view.findViewById(R.id.ll_back);
        TextView titleView = (TextView) view.findViewById(R.id.tv_title);
        titleView.setText(getString(R.string.title_profile));

        ivEditStore = (ImageView) view.findViewById(R.id.iv_edit_store);
        storeImageView = (ImageView) view.findViewById(R.id.iv_profile_store);
        storeNameView = (TextView) view.findViewById(R.id.tv_profile_store_name);
        storeMobileView = (TextView) view.findViewById(R.id.tv_profile_store_mobile);

        thisWeekView = (TextView) view.findViewById(R.id.tv_profile_store_this_week);
        lastWeekView = (TextView) view.findViewById(R.id.tv_profile_store_last_week);
        complainView = (TextView) view.findViewById(R.id.tv_profile_store_complain);

        allotOrderLayout = (RelativeLayout) view.findViewById(R.id.rl_profile_allot_order_manage);
        passwordLayout = (RelativeLayout) view.findViewById(R.id.rl_profile_modify_password);
        suggestLayout = (RelativeLayout) view.findViewById(R.id.rl_profile_suggest);
        helpCenterLayout = (RelativeLayout) view.findViewById(R.id.rl_profile_help_center);
        aboutUsLayout = (RelativeLayout) view.findViewById(R.id.rl_profile_about_us);
        updateLayout = (RelativeLayout) view.findViewById(R.id.rl_profile_update_check);
        phoneLayout = (RelativeLayout) view.findViewById(R.id.rl_profile_phone_customer);

        loginOutBtn = (Button) view.findViewById(R.id.btn_profile_login_out);
    }

    @Override
    public void initData() {
        SellerApp app = SellerApp.getInstance();
        storeNameView.setText(app.getStore().getStoreName());
        storeMobileView.setText(app.getStore().getHotline());

        complainView.setText(getString(R.string.profile_has_not));
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().onBackPressed();
            }
        });
        ivEditStore.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getBaseActivity().showFragment(StoreManageFragment.class.getSimpleName(), null, true);
            }
        });
        allotOrderLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(getActivity(), AllotOrderListActivity.class));
            }
        });
        passwordLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getBaseActivity().showFragment(PasswordFragment.class.getSimpleName(), null, true);
            }
        });
        suggestLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getBaseActivity().showFragment(SuggestFragment.class.getSimpleName(), null, true);
            }
        });
        helpCenterLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getActivity(), H5CordovaActivity.class);
                intent.putExtra(Constants.BundleName.WEB_URL, Constants.URL_TYPE.FAQ);
                startActivity(intent);
            }
        });
        aboutUsLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getActivity(), H5CordovaActivity.class);
                intent.putExtra(Constants.BundleName.WEB_URL, Constants.URL_TYPE.ABOUT_US);
                startActivity(intent);
            }
        });
        updateLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                UpdateManager.getUpdateManager().checkAppUpdate(getActivity(), handler);
            }
        });
        loginOutBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                loginOutRequest();
            }
        });
        phoneLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //用intent启动拨打电话
                Intent intent = new Intent(Intent.ACTION_CALL, Uri.parse("tel:" +
                        getResources().getString(R.string.customer_service_line)));
                startActivity(intent);
            }
        });
    }

    @Override
    public void initRequest() {
        statisticsRequest();
    }

    private void statisticsRequest() {
        RetrofitUtils.getInstance().storeSettle(ParamUtils.getParam(null), statisticsHttpBack);
    }

    private void loginOutRequest() {
        RetrofitUtils.getInstance(true).loginOut(ParamUtils.getParam(null), loginOutHttpBack);
    }

    static class CheckHandler extends Handler {
        WeakReference<ProfileFragment> mFragmentReference;

        CheckHandler(ProfileFragment fragment) {
            mFragmentReference = new WeakReference<>(fragment);
        }

        @Override
        public void handleMessage(Message msg) {
            final ProfileFragment fragment = mFragmentReference.get();
            if (fragment == null) {
                return;
            }
            if (msg.what == UpdateManager.NO_VERSION_UPDATE
                    || msg.what == UpdateManager.CHECK_VERSION_FINISH) {
                ToastUtils.show(fragment.getActivity(), R.string.profile_already_lasted_version);
            }
        }
    }
}
