package com.yldbkd.www.buyer.android.activity;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.view.View;
import android.widget.GridView;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.adapter.AccountAdapter;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.bean.Account;
import com.yldbkd.www.buyer.android.bean.AccountInfo;
import com.yldbkd.www.buyer.android.bean.TicketInfo;
import com.yldbkd.www.buyer.android.fragment.CouponFragment;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.viewCustomer.ImgTxtButton;
import com.yldbkd.www.library.android.viewCustomer.PagerSlidingTabStrip;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @创建者 李贞高
 * @创建时间 2016/10/22 11:27
 * @描述 账户余额相关activity
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class AccountActivity extends BaseActivity {
    private View backView;
    private ImgTxtButton mRightView;
    private TextView mTitleView;

    private int mCouponType;

    private List<Fragment> fragments = new ArrayList<>();
    private PagerSlidingTabStrip pagerIndicator;
    private ViewPager viewPager;
    private int[] EMPTYIMAGE = {R.mipmap.empty_coupon, R.mipmap.empty_voucher, R.mipmap.empty_physical};
    private int[] COLOR = {R.color.colorPrimary, R.color.colorBlue, R.color.colorOrange};
    private int[] TITLE_BG = {R.drawable.selector_coupon_rb_text, R.drawable.selector_voucher_rb_text, R.drawable.selector_physical_rb_text};
    private static final int[] ITEM_BG = {R.drawable.coupon_left, R.drawable.voucher_left, R.drawable.coupon_left};

    private GridView mAccountGridview;
    private AccountAdapter accountAdapter;
    private List<AccountInfo> accountInfoList = new ArrayList<>();
    private List<TicketInfo> ticketInfoList = new ArrayList<>();
    private HttpBack<Account> accountHttpBack;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.account_activity);
        mCouponType = getIntent().getIntExtra(Constants.BundleName.COUPON_TYPE, Constants.TicketType.YOUHUI);

        initView();
        initData();
        initListener();
        initHttpBack();
        initRequest();
    }

    public void initView() {
        backView = findViewById(R.id.back_view);
        mRightView = (ImgTxtButton) findViewById(R.id.right_view);
        mRightView.setVisibility(View.GONE);
        mTitleView = (TextView) findViewById(R.id.title_view);
        mTitleView.setText(getResources().getString(R.string.profile_purse));
        mAccountGridview = (GridView) findViewById(R.id.account_gridview);
        pagerIndicator = (PagerSlidingTabStrip) findViewById(R.id.customer_money_indicator);
        viewPager = (ViewPager) findViewById(R.id.view_pager);
    }

    private void initData() {
    }

    private void initHttpBack() {
        accountHttpBack = new HttpBack<Account>(this) {
            @Override
            public void onSuccess(Account account) {
                accountInfoList = account.getAccountInfoList();
                ticketInfoList = account.getTicketInfoList();
                initAdapter();
            }
        };
    }

    public void initRequest() {
        Map<String, Object> map = new HashMap<>();
        RetrofitUtils.getInstance().accountInfo(ParamUtils.getParam(map), accountHttpBack);
    }

    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                onBackPressed();
            }
        });
    }

    private void initAdapter() {
        accountAdapter = new AccountAdapter(accountInfoList, this);
        mAccountGridview.setAdapter(accountAdapter);

        viewPager.setOffscreenPageLimit(ticketInfoList.size());

        List<String> titles = new ArrayList<>();
        viewPager.removeAllViews();
        fragments.clear();
        for (int i = 0; i < ticketInfoList.size(); i++) {
            CouponFragment fragment = new CouponFragment();
            Bundle bundle = new Bundle();
            String title = String.format(getResources().getString(R.string.indicator_title_coupon), ticketInfoList.get(i).getTicketTypeName(), ticketInfoList.get(i).getTicketCount());
            bundle.putInt(Constants.BundleName.COUPON_TYPE, ticketInfoList.get(i).getTicketType());
            bundle.putString(Constants.BundleName.COUPON_TYPE_NAME, ticketInfoList.get(i).getTicketTypeName());
            bundle.putInt(Constants.BundleName.COUPON_COLOR, COLOR[i % 3]);
            bundle.putInt(Constants.BundleName.COUPON_EMPTY_IMAGE, EMPTYIMAGE[i % 3]);
            bundle.putInt(Constants.BundleName.COUPON_TITLE_COLOR, TITLE_BG[i % 3]);
            bundle.putInt(Constants.BundleName.COUPON_ITEM_BG, ITEM_BG[i % 3]);
            fragment.setArguments(bundle);
            fragments.add(fragment);
            titles.add(title);
        }
        CouponFragmentAdapter adapter = new CouponFragmentAdapter(getSupportFragmentManager(), fragments, titles);
        viewPager.setAdapter(adapter);
        viewPager.setCurrentItem(mCouponType > 0 ? mCouponType - 1 : mCouponType);
        pagerIndicator.setViewPager(viewPager);
        pagerIndicator.setTextSize((int) getResources().getDimension(R.dimen.text_size_normal));
    }

    private static class CouponFragmentAdapter extends FragmentStatePagerAdapter {

        private List<Fragment> fragments;
        private List<String> titles;

        public CouponFragmentAdapter(FragmentManager fm, List<Fragment> fragments, List<String> titles) {
            super(fm);
            this.fragments = fragments;
            this.titles = titles;
            notifyDataSetChanged();
        }

        @Override
        public Fragment getItem(int position) {
            return fragments.get(position);
        }

        @Override
        public int getCount() {
            return fragments.size();
        }

        @Override
        public int getItemPosition(Object object) {
            return PagerAdapter.POSITION_NONE;
        }

        @Override
        public CharSequence getPageTitle(int position) {
            return titles.get(position);
        }
    }

    @Override
    public Fragment newFragmentByTag(String tag) {
        return null;
    }
}
