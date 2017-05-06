package com.yldbkd.www.buyer.android.fragment;

import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.adapter.RefundAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.OrderDetail;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * @创建者 李贞高
 * @创建时间 2017/3/27 16:01
 * @描述 消息页面
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class RefundFragment extends BaseFragment {
    private RelativeLayout backView;
    private ListView mRefundListView;
    private View footerView;
    private View headerView;
    private HttpBack<OrderDetail> messageHttpBack;
    private RefundAdapter mRefundAdapter;
    private OrderDetail mOrderDetail;
    private String saleOrderNo;

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        saleOrderNo = bundle.getString(Constants.BundleName.ORDER_CODE);
    }

    @Override
    public int setLayoutId() {
        return R.layout.refund_fragment;
    }

    @Override
    public void initView(View view) {
        backView = (RelativeLayout) view.findViewById(R.id.back_view);
        TextView titleView = (TextView) view.findViewById(R.id.title_view);
        titleView.setText(getResources().getString(R.string.order_refund_detail));

        mRefundListView = (ListView) view.findViewById(R.id.refund_list_view);
        //评价头部
        LayoutInflater inflater = (LayoutInflater) getActivity().getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        headerView = inflater.inflate(R.layout.refund_header_view, mRefundListView, false);
        loadHeader(headerView);
        mRefundListView.addHeaderView(headerView);
        //评价底部
        inflater = (LayoutInflater) getActivity().getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        footerView = inflater.inflate(R.layout.refund_bottom_view, mRefundListView, false);
        loadFooter(footerView);
        mRefundListView.addFooterView(footerView);
    }

    private void loadHeader(View headerView) {

    }

    private void loadFooter(View footerView) {

    }

    @Override
    public void initData() {
        initRequest();
    }

    private void initAdapter() {
        mRefundAdapter = new RefundAdapter(getActivity(), mOrderDetail);
        mRefundListView.setAdapter(mRefundAdapter);
    }

    @Override
    public void initHttpBack() {
        messageHttpBack = new HttpBack<OrderDetail>(getBaseActivity()) {
            @Override
            public void onSuccess(OrderDetail orderDetail) {
                initAdapter();
            }
        };
    }

    @Override
    public void initRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("saleOrderNo", saleOrderNo);
        RetrofitUtils.getInstance(true).getRefundInfo(ParamUtils.getParam(map), messageHttpBack);
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getActivity().onBackPressed();
            }
        });
    }
}
