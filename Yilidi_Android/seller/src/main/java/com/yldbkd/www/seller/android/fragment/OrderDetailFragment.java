package com.yldbkd.www.seller.android.fragment;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.DistanceUtils;
import com.yldbkd.www.library.android.common.MoneyUtils;
import com.yldbkd.www.library.android.common.TextChangeUtils;
import com.yldbkd.www.library.android.viewCustomer.CommonDialog;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.activity.LocationMapActivity;
import com.yldbkd.www.seller.android.activity.OrderDetailActivity;
import com.yldbkd.www.seller.android.adapter.OrderProductAdapter;
import com.yldbkd.www.seller.android.bean.BaseModel;
import com.yldbkd.www.seller.android.bean.OrderDetail;
import com.yldbkd.www.seller.android.bean.ProductOrderItem;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.utils.OrderStatusUtils;
import com.yldbkd.www.seller.android.utils.TimeUtils;
import com.yldbkd.www.seller.android.utils.http.HttpBack;
import com.yldbkd.www.seller.android.utils.http.ParamUtils;
import com.yldbkd.www.seller.android.utils.http.RetrofitUtils;
import com.yldbkd.www.seller.android.viewCustomer.DefaultItemDecoration;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 订单详细Fragment
 * <p/>
 * Created by linghuxj on 16/5/31.
 */
public class OrderDetailFragment extends BaseFragment {

    private OrderDetail orderDetail;
    private boolean isReceive; // 是否是收货码进入的详情页面
    private String receiveNo;

    private TextView orderStatusView;
    private View dividerView;
    private TextView orderStatusDesc;
    private LinearLayout consigneeLayout;
    private LinearLayout pickUpLayout;
    private TextView consigneeNameView;
    private TextView consigneeMobileView;
    private TextView buyerMobileView;
    private LinearLayout addressLayout;
    private TextView consigneeAddressView;
    private RelativeLayout callTelView;
    private LinearLayout distanceLayout;
    private TextView distanceView;
    private TextView deliveryView;

    private RecyclerView productsView;
    private OrderProductAdapter productAdapter;
    private List<ProductOrderItem> products = new ArrayList<>();

    private TextView totalAmtView;
    private TextView productAmtLabelView;
    private TextView productAmtView;
    private TextView preferentialAmtView;
    private TextView deliveryAmtView;

    private TextView orderNoView;
    private TextView orderTimeView;
    private TextView orderDeliveryTypeView;
    private LinearLayout orderDeliveryTimeLayout;
    private TextView orderDeliveryTimeView;
    private TextView orderPayTypeView;
    private TextView orderPayTimeView;
    private LinearLayout orderReceiveTimeLayout;
    private TextView orderReceiveTimeView;
    private LinearLayout orderSendTimeLayout;
    private TextView orderSendTimeView;
    private LinearLayout orderFinishTimeLayout;
    private TextView orderFinishTimeView;
    private LinearLayout orderCancelTimeLayout;
    private TextView orderCancelTimeView;
    private TextView orderRemarkView;


    private RelativeLayout submitLayout;
    private Button submitBtn;

    private HttpBack<BaseModel> acceptHttpBack;
    private HttpBack<BaseModel> sendHttpBack;
    private HttpBack<BaseModel> cancelHttpBack;
    private HttpBack<BaseModel> finishHttpBack;

    private CommonDialog dialog;

    @Override
    public int setLayoutId() {
        return R.layout.fragment_order_detail;
    }

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        orderDetail = (OrderDetail) bundle.getSerializable(Constants.BundleName.ORDER_DETAIL_INFO);
        isReceive = bundle.getBoolean(Constants.BundleName.ORDER_DETAIL_RECEIVE_FLAG);
        receiveNo = bundle.getString(Constants.BundleName.RECEIVE_NO);
    }

    @Override
    public void initHttpBack() {
        acceptHttpBack = new HttpBack<BaseModel>() {
            @Override
            public void onSuccess(BaseModel baseModel) {
                OrderDetailActivity activity = (OrderDetailActivity) getActivity();
                activity.initRequest();
            }
        };
        sendHttpBack = new HttpBack<BaseModel>() {
            @Override
            public void onSuccess(BaseModel baseModel) {
                OrderDetailActivity activity = (OrderDetailActivity) getActivity();
                activity.initRequest();
            }
        };
        cancelHttpBack = new HttpBack<BaseModel>() {
            @Override
            public void onSuccess(BaseModel baseModel) {
                OrderDetailActivity activity = (OrderDetailActivity) getActivity();
                activity.initRequest();
            }
        };
        finishHttpBack = new HttpBack<BaseModel>() {
            @Override
            public void onSuccess(BaseModel baseModel) {
                OrderDetailActivity activity = (OrderDetailActivity) getActivity();
                activity.initRequest();
            }
        };
    }

    @Override
    public void initView(View view) {
        productsView = (RecyclerView) view.findViewById(R.id.rv_order_detail_products);

        submitLayout = (RelativeLayout) view.findViewById(R.id.rl_order_detail_submit);
        submitBtn = (Button) view.findViewById(R.id.btn_order_detail_submit);
    }

    @Override
    public void initAdapter() {
        LinearLayoutManager layoutManager = new LinearLayoutManager(getActivity());
        layoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        productsView.setLayoutManager(layoutManager);
        productAdapter = new OrderProductAdapter(getActivity(), products);
        productsView.setAdapter(productAdapter);
        productsView.addItemDecoration(DefaultItemDecoration.getDefault(getActivity()));

        View headerView = View.inflate(getActivity(), R.layout.fragment_order_detail_header, null);
        productAdapter.setHeaderView(headerView);
        initHeaderView(headerView);

        View footerView = View.inflate(getActivity(), R.layout.fragment_order_detail_footer, null);
        productAdapter.setFooterView(footerView);
        initFooterView(footerView);
    }

    private void initHeaderView(View view) {
        orderStatusView = (TextView) view.findViewById(R.id.tv_order_detail_status);
        dividerView = view.findViewById(R.id.v_divider);
        orderStatusDesc = (TextView) view.findViewById(R.id.tv_order_detail_status_desc);
        consigneeLayout = (LinearLayout) view.findViewById(R.id.ll_order_detail_consignee);
        pickUpLayout = (LinearLayout) view.findViewById(R.id.ll_order_detail_pick_up);
        consigneeNameView = (TextView) view.findViewById(R.id.tv_order_detail_consignee);
        consigneeMobileView = (TextView) view.findViewById(R.id.tv_order_detail_mobile);
        buyerMobileView = (TextView) view.findViewById(R.id.tv_order_detail_buyer_mobile);
        addressLayout = (LinearLayout) view.findViewById(R.id.ll_order_detail_address);
        consigneeAddressView = (TextView) view.findViewById(R.id.tv_order_detail_address);
        callTelView = (RelativeLayout) view.findViewById(R.id.rl_order_detail_tel);
        distanceLayout = (LinearLayout) view.findViewById(R.id.ll_order_detail_distance);
        distanceView = (TextView) view.findViewById(R.id.tv_order_detail_distance);
        deliveryView = (TextView) view.findViewById(R.id.tv_order_detail_delivery_time);
    }

    private void initFooterView(View view) {
        totalAmtView = (TextView) view.findViewById(R.id.tv_order_detail_total_amount);
        productAmtLabelView = (TextView) view.findViewById(R.id.tv_order_detail_product_amount_label);
        productAmtView = (TextView) view.findViewById(R.id.tv_order_detail_product_amount);
        preferentialAmtView = (TextView) view.findViewById(R.id.tv_order_detail_preferential_amount);
        deliveryAmtView = (TextView) view.findViewById(R.id.tv_order_detail_delivery_amount);

        orderNoView = (TextView) view.findViewById(R.id.tv_order_detail_info_no);
        orderTimeView = (TextView) view.findViewById(R.id.tv_order_detail_info_time);
        orderDeliveryTypeView = (TextView) view.findViewById(R.id.tv_order_detail_info_delivery_type);
        orderDeliveryTimeLayout = (LinearLayout) view.findViewById(R.id.ll_order_detail_info_delivery_time);
        orderDeliveryTimeView = (TextView) view.findViewById(R.id.tv_order_detail_info_delivery_time);
        orderPayTypeView = (TextView) view.findViewById(R.id.tv_order_detail_info_pay_type);
        orderPayTimeView = (TextView) view.findViewById(R.id.tv_order_detail_info_pay_time);
        orderReceiveTimeLayout = (LinearLayout) view.findViewById(R.id.ll_order_detail_info_receive_time);
        orderReceiveTimeView = (TextView) view.findViewById(R.id.tv_order_detail_info_receive_time);
        orderSendTimeLayout = (LinearLayout) view.findViewById(R.id.ll_order_detail_info_send_time);
        orderSendTimeView = (TextView) view.findViewById(R.id.tv_order_detail_info_send_time);
        orderFinishTimeLayout = (LinearLayout) view.findViewById(R.id.ll_order_detail_info_finish_time);
        orderFinishTimeView = (TextView) view.findViewById(R.id.tv_order_detail_info_finish_time);
        orderCancelTimeLayout = (LinearLayout) view.findViewById(R.id.ll_order_detail_info_cancel_time);
        orderCancelTimeView = (TextView) view.findViewById(R.id.tv_order_detail_info_cancel_time);
        orderRemarkView = (TextView) view.findViewById(R.id.tv_order_detail_info_remark);
    }

    @Override
    public void initData() {
        if (orderDetail == null) {
            return;
        }
        setData(orderDetail);
    }

    @Override
    public void initListener() {
        distanceLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getActivity(), LocationMapActivity.class);
                intent.setAction(LocationMapFragment.class.getSimpleName());
                intent.putExtra(Constants.BundleName.ORDER_DETAIL_CONSIGNEE_INFO, orderDetail.getConsigneeAddress());
                startActivity(intent);
            }
        });
        submitBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                submitRequest();
            }
        });
    }

    public void setData(OrderDetail orderDetail) {
        List<Integer> statusStyles = new ArrayList<>();
        statusStyles.add(R.style.TextAppearance_Normal_Orange);
        //        TextChangeUtils.setDifferentText(getActivity(), orderStatusView, R.string.order_detail_status,
        //                statusStyles, orderDetail.getStatusCodeName());
        orderStatusView.setText(orderDetail.getStatusCodeName());
        if (TextUtils.isEmpty(orderDetail.getStatusDesc())) {
            orderStatusDesc.setVisibility(View.GONE);
            dividerView.setVisibility(View.GONE);
        } else {
            orderStatusDesc.setVisibility(View.VISIBLE);
            dividerView.setVisibility(View.VISIBLE);
            orderStatusDesc.setText(orderDetail.getStatusDesc());
        }
        boolean isDelivery = orderDetail.getDeliveryModeCode() == Constants.DeliveryMode.DELIVER_GOODS;
        consigneeLayout.setVisibility(isDelivery ? View.VISIBLE : View.GONE);
        pickUpLayout.setVisibility(isDelivery ? View.GONE : View.VISIBLE);
        addressLayout.setVisibility(isDelivery ? View.VISIBLE : View.GONE);
        final String mobile = isDelivery ? orderDetail.getConsigneeAddress().getConsMobile() : orderDetail.getBuyerMobile();
        consigneeMobileView.setText(mobile);
        buyerMobileView.setText(mobile);
        callTelView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(Intent.ACTION_CALL, Uri.parse("tel:" + mobile));
                startActivity(intent);
            }
        });
        if (isDelivery) {
            consigneeNameView.setText(orderDetail.getConsigneeAddress().getConsignee());
            consigneeAddressView.setText(orderDetail.getConsigneeAddress().getConsAddress());
            distanceView.setText(DistanceUtils.getDistance(orderDetail.getConsigneeAddress().getDistance()));
        }

        String time = TimeUtils.deliveryTime(orderDetail.getPayTime());
        if (isDelivery && TextUtils.isEmpty(time)) {
            deliveryView.setText("");
        } else if (isDelivery) {
            deliveryView.setText(String.format(getString(R.string.order_delivery_time), time));
        } else {
            deliveryView.setText(getString(R.string.order_detail_pick_up_time));
        }

        products.clear();
        products.addAll(orderDetail.getSaleOrderItemList());
        productAdapter.notifyDataSetChanged();

        totalAmtView.setText(String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(orderDetail
                .getPayableAmount())));
        productAmtLabelView.setText(String.format(getString(R.string.order_detail_product_count),
                getProductCount(orderDetail.getSaleOrderItemList())));
        productAmtView.setText(String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(
                getProductTotalAmt(orderDetail.getSaleOrderItemList()))));
        preferentialAmtView.setText(String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(orderDetail
                .getPreferentialAmt())));
        deliveryAmtView.setText(String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(orderDetail
                .getTransferFee())));

        orderNoView.setText(orderDetail.getSaleOrderNo());
        orderTimeView.setText(orderDetail.getCreateTime());
        List<Integer> typeStyles = new ArrayList<>();
        typeStyles.add(R.style.TextAppearance_Normal);
        TextChangeUtils.setDifferentText(getActivity(), orderDeliveryTypeView, R.string.order_detail_info_delivery_type_value,
                typeStyles, orderDetail.getDeliveryModeName());

        boolean isBest = !TextUtils.isEmpty(orderDetail.getBestTime());
        orderDeliveryTimeLayout.setVisibility(isBest ? View.VISIBLE : View.GONE);
        orderDeliveryTimeView.setText(orderDetail.getBestTime());

        orderPayTypeView.setText(orderDetail.getPayTypeName());
        orderPayTimeView.setText(orderDetail.getPayTime());

        boolean isWaitReceive = orderDetail.getStatusCode() == OrderStatusUtils.WAIT_RECEIVE_CODE;
        boolean isNotSend = orderDetail.getStatusCode() == OrderStatusUtils.NOT_SEND_CODE;
        orderReceiveTimeLayout.setVisibility(isNotSend ? View.VISIBLE : View.GONE);
        orderReceiveTimeView.setText(orderDetail.getAcceptTime());
        boolean isSending = orderDetail.getStatusCode() == OrderStatusUtils.NOT_SEND_CODE;
        orderSendTimeLayout.setVisibility(isSending ? View.VISIBLE : View.GONE);
        orderSendTimeView.setText(orderDetail.getBestTime());
        boolean isFinished = orderDetail.getStatusCode() == OrderStatusUtils.FINISHED_CODE ||
                orderDetail.getStatusCode() == OrderStatusUtils.EVALUATED_CODE;
        orderFinishTimeLayout.setVisibility(isFinished ? View.VISIBLE : View.GONE);
        orderFinishTimeView.setText(orderDetail.getFinishTime());
        boolean isCanceled = orderDetail.getStatusCode() == OrderStatusUtils.CANCELED_CODE ||
                orderDetail.getStatusCode() == OrderStatusUtils.REFUNDED_CODE ||
                orderDetail.getStatusCode() == OrderStatusUtils.REFUNDING_CODE;
        orderCancelTimeLayout.setVisibility(isCanceled ? View.VISIBLE : View.GONE);
        orderCancelTimeView.setText(orderDetail.getCancelTime());
        boolean hasRemark = !TextUtils.isEmpty(orderDetail.getNote());
        orderRemarkView.setText(hasRemark ? orderDetail.getNote() : getString(R.string.order_detail_info_remark_empty));

        submitLayout.setVisibility(isReceive || isWaitReceive || isNotSend ? View.VISIBLE : View.GONE);
        submitBtn.setText(isReceive ? (isDelivery ? getString(R.string.order_detail_submit_finish)
                : getString(R.string.order_detail_submit_pickup)) : isWaitReceive ? getString(R.string.order_detail_submit_receive) :
                isNotSend ? getString(R.string.order_detail_submit_send) : "");
    }

    private void submitRequest() {
        if (isReceive) {
            finishRequest(receiveNo);
        } else if (orderDetail.getStatusCode() == OrderStatusUtils.WAIT_RECEIVE_CODE) {
            dialog = new CommonDialog(getActivity(), new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    receiveRequest();
                    dialog.dismiss();
                }
            }, new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    cancelRequest();
                    dialog.dismiss();
                }
            });
            dialog.setData(getString(R.string.order_detail_submit_notify_content),
                    getString(R.string.order_detail_submit_notify_confirm), getString(R.string.order_detail_submit_notify_cancel));
            dialog.show();
        } else if (orderDetail.getStatusCode() == OrderStatusUtils.NOT_SEND_CODE) {
            sendRequest();
        }
    }

    private void receiveRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("saleOrderNo", orderDetail.getSaleOrderNo());
        RetrofitUtils.getInstance(true).acceptOrder(ParamUtils.getParam(map), acceptHttpBack);
    }

    private void sendRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("saleOrderNo", orderDetail.getSaleOrderNo());
        RetrofitUtils.getInstance(true).deliveryOrder(ParamUtils.getParam(map), sendHttpBack);
    }

    private void cancelRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("saleOrderNo", orderDetail.getSaleOrderNo());
        RetrofitUtils.getInstance(true).cancelOrder(ParamUtils.getParam(map), cancelHttpBack);
    }

    private void finishRequest(String receiveNo) {
        Map<String, Object> map = new HashMap<>();
        map.put("saleOrderNo", orderDetail.getSaleOrderNo());
        map.put("receiveNo", receiveNo);
        RetrofitUtils.getInstance(true).finishOrder(ParamUtils.getParam(map), finishHttpBack);
    }

    private int getProductCount(List<ProductOrderItem> products) {
        int count = 0;
        for (ProductOrderItem product : products) {
            count += product.getCartNum();
        }
        return count;
    }

    private Long getProductTotalAmt(List<ProductOrderItem> products) {
        Long total = 0L;
        for (ProductOrderItem product : products) {
            total += product.getCartNum() * product.getCurrentPrice();
        }
        return total;
    }
}
