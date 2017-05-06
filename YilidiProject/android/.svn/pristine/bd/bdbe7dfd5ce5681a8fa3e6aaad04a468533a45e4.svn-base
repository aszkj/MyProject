package com.yldbkd.www.buyer.android.fragment;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.adapter.NewOrderStatusAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.OrderDetail;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.library.android.viewCustomer.ListInScrollView;

/**
 * 订单状态页面Fragment
 * <p/>
 * Created by linghuxj on 15/9/28.
 */
public class OrderDetailStatusFragment extends BaseFragment {
    private OrderDetail mOrderDetail;
    private ListInScrollView statusListView;
    private LinearLayout mLlContent;
    private TextView mTelConnectUs;
    private NewOrderStatusAdapter newOrderStatusAdapter;

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        mOrderDetail = (OrderDetail) bundle.getSerializable(Constants.BundleName.ORDER_DETAIL);
    }

    @Override
    public int setLayoutId() {
        return R.layout.order_detail_status_fragment;
    }

    @Override
    public void initView(View view) {
        statusListView = (ListInScrollView) view.findViewById(R.id.status_listview);
        mLlContent = (LinearLayout) view.findViewById(R.id.ll_content);
        mTelConnectUs = (TextView) view.findViewById(R.id.tel_connect_us);
    }

    @Override
    public void initData() {
        initAdapter();
    }

    private void initAdapter() {
        newOrderStatusAdapter = new NewOrderStatusAdapter(mOrderDetail, getActivity());
        statusListView.setAdapter(newOrderStatusAdapter);
    }

    @Override
    public void initListener() {
        mTelConnectUs.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                //用intent启动拨打电话
                Intent intent = new Intent(Intent.ACTION_CALL, Uri.parse("tel:" +
                        getResources().getString(R.string.customer_service_line)));
                startActivity(intent);
            }
        });
    }
}
