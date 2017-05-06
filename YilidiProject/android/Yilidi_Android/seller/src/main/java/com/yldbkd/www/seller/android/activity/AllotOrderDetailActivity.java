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
import com.yldbkd.www.seller.android.bean.AllotOrderDetail;
import com.yldbkd.www.seller.android.bean.BaseModel;
import com.yldbkd.www.seller.android.fragment.AllotOrderDetailFragment;
import com.yldbkd.www.seller.android.fragment.AllotOrderDetailRecordFragment;
import com.yldbkd.www.seller.android.utils.AllotOrderStatusUtils;
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
 * 调货单详情Activity
 * <p/>
 * Created by linghuxj on 16/5/31.
 */
public class AllotOrderDetailActivity extends BaseActivity {

    private String allotOrderNo;

    private LinearLayout backView;
    private ImgTxtButton rightBtn;

    private PagerSlidingTabStrip tabStrip;
    private ViewPager viewPager;
    private List<Fragment> fragments;

    private static final int[] VIEW_PAGER_TITLES = {R.string.allot_order_detail_record, R.string.allot_order_detail};

    private HttpBack<AllotOrderDetail> orderDetailHttpBack;
    private HttpBack<BaseModel> checkHttpBack;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.activity_allot_order_detail);
        allotOrderNo = getIntent().getStringExtra(Constants.BundleName.ALLOT_ORDER_NO);
        initView();
        initHttpBack();
        initListener();
        initRequest();
    }

    private void initView() {
        backView = (LinearLayout) findViewById(R.id.ll_back);
        TextView titleView = (TextView) findViewById(R.id.tv_title);
        titleView.setText(getString(R.string.title_allot_order_detail));
        rightBtn = (ImgTxtButton) findViewById(R.id.itb_right);
        rightBtn.setText(getString(R.string.allot_order_detail_check));

        tabStrip = (PagerSlidingTabStrip) findViewById(R.id.psts_allot_order_detail);
        viewPager = (ViewPager) findViewById(R.id.vp_allot_order_detail);
        viewPager.setOffscreenPageLimit(VIEW_PAGER_TITLES.length);
    }

    private void initHttpBack() {
        orderDetailHttpBack = new HttpBack<AllotOrderDetail>() {
            @Override
            public void onSuccess(AllotOrderDetail orderDetail) {
                if (orderDetail == null) {
                    return;
                }
                initAdapter(orderDetail);
            }
        };
        checkHttpBack = new HttpBack<BaseModel>() {
            @Override
            public void onSuccess(BaseModel baseModel) {
                initRequest();
            }
        };
    }

    private void initAdapter(AllotOrderDetail orderDetail) {
        List<String> titles = new ArrayList<>();
        fragments = new ArrayList<>();
        viewPager.removeAllViews();
        AllotOrderDetailRecordFragment recordFragment = new AllotOrderDetailRecordFragment();
        Bundle bundle = new Bundle();
        bundle.putSerializable(Constants.BundleName.ALLOT_ORDER_DETAIL_RECORD_INFO, (Serializable)
                orderDetail.getAllotStatusList());
        recordFragment.setArguments(bundle);
        fragments.add(recordFragment);
        titles.add(getResources().getString(VIEW_PAGER_TITLES[0]));
        AllotOrderDetailFragment detailFragment = new AllotOrderDetailFragment();
        bundle = new Bundle();
        bundle.putSerializable(Constants.BundleName.ALLOT_ORDER_DETAIL_INFO, orderDetail);
        detailFragment.setArguments(bundle);
        fragments.add(detailFragment);
        titles.add(getResources().getString(VIEW_PAGER_TITLES[1]));
        FragmentAdapter adapter = new FragmentAdapter(getSupportFragmentManager(), fragments, titles);
        viewPager.setAdapter(adapter);
        viewPager.setCurrentItem(VIEW_PAGER_TITLES.length - 1);
        tabStrip.setViewPager(viewPager);
        tabStrip.setTextSize((int) getResources().getDimension(R.dimen.text_size_normal));

        rightBtn.setVisibility(orderDetail.getStatusCode() == AllotOrderStatusUtils.SEND_CODE ?
                View.VISIBLE : View.GONE);
    }

    private void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onBackPressed();
            }
        });
        rightBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                checkRequest();
            }
        });
    }

    public void initRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("allotOrderNo", allotOrderNo);
        RetrofitUtils.getInstance(true).allotOrderDetail(ParamUtils.getParam(map), orderDetailHttpBack);
    }

    private void checkRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("allotOrderNo", allotOrderNo);
        RetrofitUtils.getInstance(true).checkAllotOrder(ParamUtils.getParam(map), checkHttpBack);
    }

    @Override
    Fragment newFragmentByTag(String tag) {
        return null;
    }
}
