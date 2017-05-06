package com.yldbkd.www.seller.android.activity;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.view.ViewPager;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.yldbkd.www.library.android.viewCustomer.ImgTxtButton;
import com.yldbkd.www.library.android.viewCustomer.PagerSlidingTabStrip;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.adapter.FragmentAdapter;
import com.yldbkd.www.seller.android.bean.OrderDetail;
import com.yldbkd.www.seller.android.fragment.OrderDetailBackFragment;
import com.yldbkd.www.seller.android.fragment.OrderDetailFragment;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.utils.http.HttpBack;
import com.yldbkd.www.seller.android.utils.http.ParamUtils;
import com.yldbkd.www.seller.android.utils.http.RetrofitUtils;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 订单详情Activity
 * <p/>
 * Created by linghuxj on 16/5/31.
 */
public class OrderDetailActivity extends BaseActivity {

    private String saleOrderNo; // 如果传递参数为订单编号，入口即为订单列表等普通操作
    private OrderDetail orderDetail; // 如果是传递参数为订单详情数据，入口即为填写收货码进行收货操作
    private String receiveNo; // 如果是传递参数为订单详情数据，并传入收货码信息

    private LinearLayout backView;

    private PagerSlidingTabStrip tabStrip;
    private ViewPager viewPager;
    private List<Fragment> fragments;

    private static final int[] VIEW_PAGER_TITLES = {R.string.order_detail, R.string.order_detail_back};

    private HttpBack<OrderDetail> orderDetailHttpBack;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.activity_order_detail);
        saleOrderNo = getIntent().getStringExtra(Constants.BundleName.ORDER_NO);
        orderDetail = (OrderDetail) getIntent().getSerializableExtra(Constants.BundleName.ORDER_DETAIL_INFO);
        receiveNo = getIntent().getStringExtra(Constants.BundleName.RECEIVE_NO);
        initView();
        initListener();
        initHttpBack();
        if (orderDetail == null) {
            initRequest();
        } else {
            initAdapter(orderDetail, true);
        }
    }

    private void initView() {
        backView = (LinearLayout) findViewById(R.id.ll_back);
        TextView titleView = (TextView) findViewById(R.id.tv_title);
        titleView.setText(getString(R.string.title_order_detail));
        ImgTxtButton rightBtn = (ImgTxtButton) findViewById(R.id.itb_right);
        rightBtn.setVisibility(View.GONE);

        tabStrip = (PagerSlidingTabStrip) findViewById(R.id.psts_order_detail);
        viewPager = (ViewPager) findViewById(R.id.vp_order_detail);
        viewPager.setOffscreenPageLimit(VIEW_PAGER_TITLES.length);
    }

    private void initHttpBack() {
        orderDetailHttpBack = new HttpBack<OrderDetail>() {
            @Override
            public void onSuccess(OrderDetail orderDetail) {
                if (orderDetail == null) {
                    return;
                }
                initAdapter(orderDetail, false);
            }
        };
    }

    private void initAdapter(OrderDetail orderDetail, boolean isReceive) {
        List<String> titles = new ArrayList<>();
        fragments = new ArrayList<>();
        viewPager.removeAllViews();
        OrderDetailFragment detailFragment = new OrderDetailFragment();
        Bundle bundle = new Bundle();
        bundle.putSerializable(Constants.BundleName.ORDER_DETAIL_INFO, orderDetail);
        bundle.putString(Constants.BundleName.RECEIVE_NO, receiveNo);
        bundle.putBoolean(Constants.BundleName.ORDER_DETAIL_RECEIVE_FLAG, isReceive);
        detailFragment.setArguments(bundle);
        fragments.add(detailFragment);
        titles.add(getResources().getString(VIEW_PAGER_TITLES[0]));
        OrderDetailBackFragment backFragment = new OrderDetailBackFragment();
        bundle = new Bundle();
        bundle.putSerializable(Constants.BundleName.ORDER_DETAIL_BACK_INFO, (Serializable)
                orderDetail.getSaleOrderItemSettleList());
        backFragment.setArguments(bundle);
        fragments.add(backFragment);
        titles.add(getResources().getString(VIEW_PAGER_TITLES[1]));
        FragmentAdapter adapter = new FragmentAdapter(getSupportFragmentManager(), fragments, titles);
        viewPager.setAdapter(adapter);
        viewPager.setCurrentItem(0);
        tabStrip.setViewPager(viewPager);
        tabStrip.setTextSize((int) getResources().getDimension(R.dimen.text_size_normal));
    }

    public void initRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("saleOrderNo", saleOrderNo);
        RetrofitUtils.getInstance(true).orderDetail(ParamUtils.getParam(map), orderDetailHttpBack);
    }

    private void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onBackPressed();
            }
        });
    }

    @Override
    Fragment newFragmentByTag(String tag) {
        return null;
    }
}
