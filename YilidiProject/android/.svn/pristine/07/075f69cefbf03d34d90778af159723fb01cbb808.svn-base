package com.yldbkd.www.buyer.android.fragment;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.MainActivity;
import com.yldbkd.www.buyer.android.activity.OrderDetailActivity;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.PaySuccessBean;
import com.yldbkd.www.buyer.android.bean.Store;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.AppManager;
import com.yldbkd.www.library.android.common.MoneyUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * 下单成功支付订单完成页面
 * <p/>
 * Created by linghuxj on 15/11/21.
 */
public class PaySuccessFragment extends BaseFragment {

    private RelativeLayout backView;
    private TextView orderNoView;
    private TextView payTypeView;
    private TextView deliveryView;
    private TextView sendTime;
    private TextView couponMoneyView;
    private TextView amountView;
    private Button orderBtn;
    private Button shopBtn;
    private TextView telephoneView;

    private LinearLayout llStoreInfo;
    private TextView storeName;
    private TextView storeHotLine;
    private TextView storeTime;
    private TextView storeAddress;
    private TextView paysuccessNote;
    private TextView paysuccessOrderNote;
    private HttpBack<PaySuccessBean> paySuccessHttpBack;

    private String orderNo;
    private String recevierCode;
    private Long orderMoney;
    private Long couponMoney;
    private boolean isOrderDetail = false;
    private Integer deliverydType;
    private String deliverydTypeName;
    private String deliverydTimeNote;
    public PaySuccessBean mPaySuccess;

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        orderNo = bundle.getString(Constants.BundleName.ORDER_CODE);
        isOrderDetail = bundle.getBoolean(Constants.BundleName.IS_ORDER_DETAIL, false);
    }

    @Override
    public int setLayoutId() {
        return R.layout.pay_success_fragment;
    }

    @Override
    public void initView(View view) {
        backView = (RelativeLayout) view.findViewById(R.id.back_view);
        TextView titleView = (TextView) view.findViewById(R.id.title_view);
        titleView.setText(getResources().getString(R.string.pay_success));
        orderNoView = (TextView) view.findViewById(R.id.pay_order_no_view);
        payTypeView = (TextView) view.findViewById(R.id.pay_type_view);
        deliveryView = (TextView) view.findViewById(R.id.pay_delivery_view);
        sendTime = (TextView) view.findViewById(R.id.pay_send_time_view);
        couponMoneyView = (TextView) view.findViewById(R.id.pay_coupon_money_view);
        amountView = (TextView) view.findViewById(R.id.pay_amount_view);
        orderBtn = (Button) view.findViewById(R.id.pay_button_order);
        shopBtn = (Button) view.findViewById(R.id.pay_button_shopping);
        telephoneView = (TextView) view.findViewById(R.id.pay_telephone_view);

        llStoreInfo = (LinearLayout) view.findViewById(R.id.ll_store_info);
        storeName = (TextView) view.findViewById(R.id.store_name);
        storeHotLine = (TextView) view.findViewById(R.id.store_hot_line);
        storeTime = (TextView) view.findViewById(R.id.store_time);
        storeAddress = (TextView) view.findViewById(R.id.store_address);
        paysuccessNote = (TextView) view.findViewById(R.id.paysuccess_note);
        paysuccessOrderNote = (TextView) view.findViewById(R.id.paysuccess_order_note);

    }

    @Override
    public void initData() {
        initRequest();
    }

    @Override
    public void initHttpBack() {
        paySuccessHttpBack = new HttpBack<PaySuccessBean>(getBaseActivity()) {

            @Override
            public void onSuccess(PaySuccessBean paySuccessInfo) {
                mPaySuccess = paySuccessInfo;
                if (mPaySuccess == null) {
                    return;
                }
                orderNo = mPaySuccess.getSaleOrderNo();
                orderMoney = mPaySuccess.getPaidAmount();
                deliverydTypeName = mPaySuccess.getDeliveryModeName();
                deliverydType = mPaySuccess.getDeliveryModeCode();
                deliverydTimeNote = mPaySuccess.getDeliveryTimeNote();
                recevierCode = mPaySuccess.getReceiveCode();
                couponMoney = mPaySuccess.getPreferentialAmt();
                setData(mPaySuccess.getStoreInfo());
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
        orderBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (isOrderDetail) {
                    getActivity().onBackPressed();
                } else {
                    Intent intent = new Intent(getActivity(), OrderDetailActivity.class);
                    intent.putExtra(Constants.BundleName.ORDER_CODE, orderNo);
                    startActivity(intent);
                    AppManager.getAppManager().finishActivity(getActivity());
                }
            }
        });
        shopBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(getActivity(), MainActivity.class);
                startActivity(intent);
            }
        });
        telephoneView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                //用intent启动拨打电话
                Intent intent = new Intent(Intent.ACTION_CALL, Uri.parse("tel:" +
                        getResources().getString(R.string.customer_service_line)));
                startActivity(intent);
            }
        });
    }

    @Override
    public void initRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("saleOrderNo", orderNo);
        RetrofitUtils.getInstance(true).paySuccessOrderInfo(ParamUtils.getParam(map), paySuccessHttpBack);
    }

    private void setData(Store storeInfo) {
        if (deliverydType == Constants.DeliveryType.PICKUP) {
            if (storeInfo == null) {
                paysuccessNote.setVisibility(View.GONE);
                llStoreInfo.setVisibility(View.GONE);
            } else {
                paysuccessNote.setVisibility(View.VISIBLE);
                llStoreInfo.setVisibility(View.VISIBLE);
                paysuccessOrderNote.setText(getResources().getString(R.string.pay_success_content5));
                storeName.setText(String.format(getResources().getString(R.string.cart_toke_store_name),
                        String.valueOf(storeInfo.getStoreName())));
                storeHotLine.setText(String.format(getResources().getString(R.string.cart_toke_hotline_name),
                        String.valueOf(storeInfo.getHotline())));
                storeTime.setText(String.format(getResources().getString(R.string.product_store_business),
                        storeInfo.getBusinessHoursBegin(), storeInfo.getBusinessHoursEnd()));
                storeAddress.setText(String.format(getResources().getString(R.string.cart_toke_store_address),
                        String.valueOf(storeInfo.getAddressDetail())));

                orderNoView.setText(String.format(getResources().getString(R.string.pay_toke_no), recevierCode));
                payTypeView.setText(String.format(getResources().getString(R.string.pay_type_name),
                        getResources().getString(R.string.pay_type)));
                deliveryView.setText(String.format(getResources().getString(R.string.pay_delivery_name),
                        deliverydTypeName));
                sendTime.setText(String.format(getResources().getString(R.string.pay_delivery_toke_time), deliverydTimeNote));
            }
        } else {
            llStoreInfo.setVisibility(View.GONE);
            paysuccessNote.setVisibility(View.GONE);
            paysuccessOrderNote.setText(getResources().getString(R.string.pay_success_content2));
            orderNoView.setText(String.format(getResources().getString(R.string.pay_order_no), orderNo));
            payTypeView.setText(String.format(getResources().getString(R.string.pay_type_name),
                    getResources().getString(R.string.pay_type)));
            deliveryView.setText(String.format(getResources().getString(R.string.pay_delivery_name),
                    deliverydTypeName));
            sendTime.setText(String.format(getResources().getString(R.string.pay_delivery_time), deliverydTimeNote));
        }
        couponMoneyView.setText(String.format(getResources().getString(R.string.pay_coupon_money_text), Constants.MONEY_FLAG + MoneyUtils.toPrice(couponMoney)));
        amountView.setText(String.valueOf(MoneyUtils.toPrice(orderMoney)));
    }
}
