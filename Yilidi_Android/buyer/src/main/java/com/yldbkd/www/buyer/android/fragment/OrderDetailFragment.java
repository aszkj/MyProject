package com.yldbkd.www.buyer.android.fragment;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.adapter.OrderDetailProductAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.Community;
import com.yldbkd.www.buyer.android.bean.OrderDetail;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.bean.Store;
import com.yldbkd.www.buyer.android.utils.CommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.library.android.common.MoneyUtils;
import com.yldbkd.www.library.android.common.TextChangeUtils;
import com.yldbkd.www.library.android.viewCustomer.ListInScrollView;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

/**
 * 订单详情页面Fragment
 * <p/>
 * Created by linghuxj on 15/9/28.
 */
public class OrderDetailFragment extends BaseFragment {
    private List<SaleProduct> saleProducts = new ArrayList<SaleProduct>();

    private ListInScrollView productListView;
    private OrderDetailProductAdapter adapter;
    private LinearLayout llAddressShow;
    private TextView orderAmountView;
    private TextView payAmountView;
    private TextView preferentialAmtView;
    private TextView transferFeeView;
    //自提
    private LinearLayout llStoreInfo;
    private TextView storeNameView;
    private TextView storeTimeView;
    private TextView storeAddressView;

    private TextView orderNoView;
    private TextView orderTimeView;
    private TextView orderPayNameView;
    private TextView orderDeliveryView;
    private TextView bestTimeView;
    private TextView noteView;
    private TextView storeLineView;
    private LinearLayout mRlOrderPay, mRlOrderDelivery;

    private TextView addressUserView;
    private TextView addressPhoneView;
    private TextView addressView;

    // 付款时间
    private LinearLayout mOrderPayTimeLlayout;
    private TextView payTimeView;
    // 订单备注
    private LinearLayout mOrderNoteLlayout;

    private OrderDetail mOrderDetail;
    private TextView mReceiverCodeTV;

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
        return R.layout.order_detail_fragment;
    }

    @Override
    public void initView(View view) {
        //自提
        llStoreInfo = (LinearLayout) view.findViewById(R.id.ll_store_info);
        storeNameView = (TextView) view.findViewById(R.id.store_name_view);
        storeTimeView = (TextView) view.findViewById(R.id.store_time_view);
        storeAddressView = (TextView) view.findViewById(R.id.store_address_view);

        llAddressShow = (LinearLayout) view.findViewById(R.id.ll_address_show);
        productListView = (ListInScrollView) view.findViewById(R.id.order_product_list_view);
        orderAmountView = (TextView) view.findViewById(R.id.order_amount_view);
        payAmountView = (TextView) view.findViewById(R.id.order_pay_amount_view);
        preferentialAmtView = (TextView) view.findViewById(R.id.order_preferential_amount_view);
        transferFeeView = (TextView) view.findViewById(R.id.order_transfer_amount_view);
        orderNoView = (TextView) view.findViewById(R.id.order_no_view);
        orderTimeView = (TextView) view.findViewById(R.id.order_time_view);
        orderPayNameView = (TextView) view.findViewById(R.id.order_pay_view);
        orderDeliveryView = (TextView) view.findViewById(R.id.order_delivery_view);
        bestTimeView = (TextView) view.findViewById(R.id.order_best_time_view);

        mRlOrderPay = (LinearLayout) view.findViewById(R.id.rl_order_pay_view);
        mRlOrderDelivery = (LinearLayout) view.findViewById(R.id.rl_order_delivery_view);

        storeLineView = (TextView) view.findViewById(R.id.order_store_line_view);
        addressUserView = (TextView) view.findViewById(R.id.order_address_user_view);
        addressPhoneView = (TextView) view.findViewById(R.id.order_address_mobile_view);
        addressView = (TextView) view.findViewById(R.id.order_address_detail_view);
        mReceiverCodeTV = (TextView) view.findViewById(R.id.tv_receiver_code);

        mOrderPayTimeLlayout = (LinearLayout) view.findViewById(R.id.order_pay_llayout);
        payTimeView = (TextView) view.findViewById(R.id.order_pay_time);
        mOrderNoteLlayout = (LinearLayout) view.findViewById(R.id.order_note_llayout);
        noteView = (TextView) view.findViewById(R.id.order_note_view);
    }

    @Override
    public void initData() {
        initAdapter();
        setData(mOrderDetail);
    }

    @Override
    public void initListener() {

        storeLineView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Community community = mOrderDetail.getConsigneeAddressBean().getCommunity();
                Intent intent = new Intent(Intent.ACTION_CALL, Uri.parse("tel:" + community.getStoreInfo().getHotline()));
                startActivity(intent);
            }
        });

    }

    private void initAdapter() {
        adapter = new OrderDetailProductAdapter(saleProducts, getActivity());
        productListView.setAdapter(adapter);
    }

    private void setData(OrderDetail orderDetail) {
        if (orderDetail == null) {
            return;
        }
        saleProducts.clear();
        saleProducts.addAll(orderDetail.getSaleOrderItemList());
        adapter.notifyDataSetChanged();

        // 商品金额
        orderAmountView.setText(Constants.MONEY_FLAG +
                MoneyUtils.toPrice(orderDetail.getOrderFeeInfo().getTotalAmount()));
        // 配送金额
        transferFeeView.setText(Constants.MONEY_PLUS_FLAG + Constants.MONEY_FLAG +
                MoneyUtils.toPrice(orderDetail.getOrderFeeInfo().getTransferFee()));
        // 优惠金额
        preferentialAmtView.setText(Constants.MONEY_MINUS_FLAG + Constants.MONEY_FLAG +
                MoneyUtils.toPrice(orderDetail.getOrderFeeInfo().getPreferentialAmt()));
        // 应付金额
        List<Integer> countStyles = new ArrayList<>();
        countStyles.add(R.style.TextAppearance_Large_Red);
        TextChangeUtils.setDifferentText(getActivity(), payAmountView, R.string.order_total_price_desc,
                countStyles, MoneyUtils.toPrice(orderDetail.getOrderFeeInfo().getPayableAmount()));

        orderNoView.setText(orderDetail.getOrderBaseInfo().getSaleOrderNo());
        orderTimeView.setText(orderDetail.getOrderBaseInfo().getCreateTime());

        noteView.setText(orderDetail.getOrderBaseInfo().getNote());

        orderPayNameView.setText(orderDetail.getOrderBaseInfo().getPayTypeName());
        SimpleDateFormat format = new SimpleDateFormat(Constants.DAY_TIME_FORMAT, Locale.CHINA);
        String deliveryTime = "";
        orderDeliveryView.setText(orderDetail.getOrderBaseInfo().getDeliveryModeName());

        Store currentStoreInfo = CommunityUtils.getCurrentStore();
        if (currentStoreInfo != null) {
            storeLineView.setText(currentStoreInfo.getHotline());
        }

        if (orderDetail.getOrderBaseInfo().getDeliveryModeCode() == Constants.DeliveryType.PICKUP) {//自提
            llAddressShow.setVisibility(View.GONE);
            llStoreInfo.setVisibility(View.VISIBLE);
            storeNameView.setText(String.format(getResources().getString(R.string.order_store_name_note),
                    String.valueOf(orderDetail.getStoreInfo().getStoreName())));
            storeTimeView.setText(String.format(getResources().getString(R.string.product_store_business),
                    orderDetail.getStoreInfo().getBusinessHoursBegin(), orderDetail.getStoreInfo().getBusinessHoursEnd()));
            storeAddressView.setText(String.format(getResources().getString(R.string.cart_toke_store_address),
                    String.valueOf(orderDetail.getStoreInfo().getAddressDetail())));
        } else {//送货上门
            llAddressShow.setVisibility(View.VISIBLE);
            llStoreInfo.setVisibility(View.GONE);
            addressUserView.setText(orderDetail.getConsigneeAddressBean().getConsigneeName());
            addressPhoneView.setText(orderDetail.getConsigneeAddressBean().getPhoneNo());
            addressView.setText(orderDetail.getConsigneeAddressBean().getAddress());
        }
        mReceiverCodeTV.setText(orderDetail.getReceiveNo());
    }
}
