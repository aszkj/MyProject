package com.yldbkd.www.buyer.android.activity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.view.View;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.bean.OrderDetail;
import com.yldbkd.www.buyer.android.fragment.OrderListFragment;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.DisplayUtils;
import com.yldbkd.www.library.android.viewCustomer.ImgTxtButton;
import com.yldbkd.www.library.android.viewCustomer.PagerSlidingTabStrip;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 订单Fragment
 * <p/>
 * Created by linghuxj on 15/10/14.
 */
public class OrderListTabActivity extends BaseActivity {
    private int currentPager;
    private View backView;
    private PagerSlidingTabStrip pagerIndicator;
    private ViewPager viewPager;

    private static final int VIEW_PAGER_COUNT = 4;
    private static final int[] VIEW_PAGER_TITLES = {R.string.order_all, R.string.order_waitPay,
            R.string.order_waitReceive, R.string.order_evalution, R.string.order_refund};
    private static final int ALL = 0, WAIT_PAY = 1, WAIT_RECEIVE = 2, FINISH = 3;
    private static final int[] STATUS_TYPES = {ALL, WAIT_PAY, WAIT_RECEIVE, FINISH};

    private List<Fragment> fragments = new ArrayList<>();
    private HttpBack<OrderDetail> orderDetailHttpBack;
    private String operatorOrderNo;
    private ImgTxtButton mRightView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.order_list_tab_activity);
        currentPager = getIntent().getIntExtra(Constants.BundleName.ORDER_STATUS, 0);
        initHttpBack();
        initView();
        initData();
        initListener();
    }

    public void initView() {
        backView = findViewById(R.id.back_view);
        mRightView = (ImgTxtButton) findViewById(R.id.right_view);
        mRightView.setText(getResources().getString(R.string.order_refund));

        TextView titleView = (TextView) findViewById(R.id.title_view);
        titleView.setText(getResources().getString(R.string.order_mine));

        pagerIndicator = (PagerSlidingTabStrip) findViewById(R.id.page_indicator);
        pagerIndicator.setIndicatorWidth(50 * DisplayUtils.density);

        viewPager = (ViewPager) findViewById(R.id.view_pager);
        viewPager.setOffscreenPageLimit(VIEW_PAGER_COUNT);
    }

    private void initData() {
        initAdapter();
    }

    private void initHttpBack() {
        orderDetailHttpBack = new HttpBack<OrderDetail>(this) {
            @Override
            public void onSuccess(OrderDetail orderDetail) {
                OrderListFragment fragment = (OrderListFragment) fragments.get(viewPager.getCurrentItem());
                fragment.setData(orderDetail);
            }
        };
    }

    private void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                onBackPressed();
            }
        });
        mRightView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(OrderListTabActivity.this, OrderActivity.class);
                intent.setAction(OrderListFragment.class.getSimpleName());
                startActivity(intent);
            }
        });
    }

    private void initAdapter() {
        List<String> titles = new ArrayList<>();
        viewPager.removeAllViews();
        fragments.clear();
        for (int i = 0; i < VIEW_PAGER_COUNT; i++) {
            OrderListFragment fragment = new OrderListFragment();
            Bundle bundle = new Bundle();
            bundle.putInt(Constants.BundleName.ORDER_STATUS_TYPE, STATUS_TYPES[i]);
            fragment.setArguments(bundle);
            fragments.add(fragment);
            titles.add(getResources().getString(VIEW_PAGER_TITLES[i]));
        }
        OrderFragmentAdapter adapter = new OrderFragmentAdapter(getSupportFragmentManager(), fragments, titles);
        viewPager.setAdapter(adapter);
        viewPager.setCurrentItem(currentPager);
        pagerIndicator.setViewPager(viewPager);
        pagerIndicator.setTextSize((int) getResources().getDimension(R.dimen.text_size_normal));
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (Constants.RequestCode.ORDER_LIST_OPERATOR == requestCode && resultCode == Activity.RESULT_OK) {
            Map<String, Object> map = new HashMap<>();
            map.put("saleOrderNo", operatorOrderNo);
            RetrofitUtils.getInstance(true).getOrderesDetail(ParamUtils.getParam(map), orderDetailHttpBack);
        }
    }

    private static class OrderFragmentAdapter extends FragmentStatePagerAdapter {

        private List<Fragment> fragments;
        private List<String> titles;

        public OrderFragmentAdapter(FragmentManager fm, List<Fragment> fragments, List<String> titles) {
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
