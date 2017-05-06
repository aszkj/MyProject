package com.yldbkd.www.buyer.android.fragment;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.NonNull;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.CartCouponActivity;
import com.yldbkd.www.buyer.android.activity.OrderDetailActivity;
import com.yldbkd.www.buyer.android.adapter.CartActDataAdapter;
import com.yldbkd.www.buyer.android.adapter.CartCouponTypeAdapter;
import com.yldbkd.www.buyer.android.adapter.CartItemAdapter;
import com.yldbkd.www.buyer.android.adapter.CartPayAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.CartConfirm;
import com.yldbkd.www.buyer.android.bean.OrderBase;
import com.yldbkd.www.buyer.android.bean.OrderCoupon;
import com.yldbkd.www.buyer.android.bean.OrderFee;
import com.yldbkd.www.buyer.android.bean.PayType;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.bean.SerializableMap;
import com.yldbkd.www.buyer.android.bean.Ticket;
import com.yldbkd.www.buyer.android.bean.TicketTypes;
import com.yldbkd.www.buyer.android.utils.CartUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.PayUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.AppManager;
import com.yldbkd.www.library.android.common.CheckUtils;
import com.yldbkd.www.library.android.common.KeyboardUtils;
import com.yldbkd.www.library.android.common.MoneyUtils;
import com.yldbkd.www.library.android.common.TextChangeUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.pay.AliPayUtils;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;
import com.yldbkd.www.library.android.viewCustomer.CommonDialog;
import com.yldbkd.www.library.android.viewCustomer.ListInScrollView;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 确认购物车页面
 * <p/>
 * Created by linghuxj on 15/10/20.
 */
public class ConfirmCartFragment extends BaseFragment {

    private Integer addressId;
    private Integer productCount;
    private CartConfirm cartConfirm;
    private Integer payCode;
    private Integer onlinePayCode; // 在线支付编码

    private RelativeLayout backView;
    private LinearLayout llVipNotice;
    private ListInScrollView payListView;
    private ListInScrollView productListView;
    private ListInScrollView actDataListView;
    private TextView preferentialAmtView;
    private TextView transferAmtView;
    private TextView payAmountView;
    private Button commitBtn;
    private Long payAmount; // 应付金额
    private TextView storeNameCart;
    private TextView totalMoney;
    private TextView productCountText;

    private CartPayAdapter payAdapter;

    private HttpBack<OrderBase> orderHttpBack;
    private HttpBack<OrderCoupon> couponMoneyHttpBack;

    private OrderBase order;
    private List<PayType> payTypes = new ArrayList<>();
    // 提交订单成功状态，因微信支付在某几种情况下没有进行回调，那么我们自己需要做相应的处理
    private boolean createOrderSuccess = false;
    private boolean canSubmit = true;
    private ClearableEditText mCartNote;
    private RelativeLayout mCartNoteLayout;
    private List<SaleProduct> mSaleOrderItemList;
    //优惠券
    private ListInScrollView mCouponListView;
    private CartCouponTypeAdapter couponTypeAdapter;
    private Long couponMoney = 0l;
    private Integer defaultCouponType = -1;//未选择任何优惠券
    private String defaultCouponName;
    private Integer itemNum = -1;
    private static int[] ITEMBG = {R.drawable.cart_coupon_bg, R.drawable.cart_voucher_bg};
    private static int[] ITEMCOLOR = {R.color.colorPrimary, R.color.colorBlue};
    private static int[] CHECKIMAGE = {R.mipmap.checked_red, R.mipmap.checked_blue};

    private Map<Integer, Integer> orderTicketMap;
    private SerializableMap mSerializableMap;
    private CommonDialog chooseDialog;
    private boolean isDefault;
    private OrderFee mOrderFeeInfo;

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        cartConfirm = (CartConfirm) bundle.getSerializable(Constants.BundleName.PURCHASE_INFO);
        mOrderFeeInfo = cartConfirm.getOrderFeeInfo();
        addressId = bundle.getInt(Constants.BundleName.ADDRESS_ID);
        productCount = bundle.getInt(Constants.BundleName.PRODUCT_COUNT);
        mSaleOrderItemList = cartConfirm.getSaleOrderItemList();
    }

    @Override
    public int setLayoutId() {
        return R.layout.confirm_cart_fragment;
    }

    @Override
    public void initView(View view) {
        backView = (RelativeLayout) view.findViewById(R.id.back_view);
        TextView titleView = (TextView) view.findViewById(R.id.title_view);
        titleView.setText(getResources().getString(R.string.confirm_cart_title));
        mCartNote = (ClearableEditText) view.findViewById(R.id.cart_note_view);
        mCartNoteLayout = (RelativeLayout) view.findViewById(R.id.cart_note_layout);
        //优惠券
        mCouponListView = (ListInScrollView) view.findViewById(R.id.cart_coupon_list_view);

        payListView = (ListInScrollView) view.findViewById(R.id.cart_pay_list_view);
        productListView = (ListInScrollView) view.findViewById(R.id.cart_items_list_view);
        actDataListView = (ListInScrollView) view.findViewById(R.id.cart_act_list_view);
        TextView totalAmtView = (TextView) view.findViewById(R.id.cart_order_total_amount_view);
        totalAmtView.setText(String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(mOrderFeeInfo.getTotalAmount())));
        preferentialAmtView = (TextView) view.findViewById(R.id.cart_preferential_amount_view);
        transferAmtView = (TextView) view.findViewById(R.id.cart_transfer_amount_view);
        payAmountView = (TextView) view.findViewById(R.id.cart_order_pay_amount_view);
        commitBtn = (Button) view.findViewById(R.id.cart_commit_btn);
        llVipNotice = (LinearLayout) view.findViewById(R.id.ll_vip_notice);

        storeNameCart = (TextView) view.findViewById(R.id.store_name_cart);
        totalMoney = (TextView) view.findViewById(R.id.total_money);
        productCountText = (TextView) view.findViewById(R.id.product_count_text);

        mCartNoteLayout.setFocusable(true);
        mCartNoteLayout.setFocusableInTouchMode(true);
        KeyboardUtils.close(getActivity());
    }

    @Override
    public void initData() {
        isDefault = true;
        storeNameCart.setText(cartConfirm.getStoreName());
        productCountText.setText(String.format(getResources().getString(R.string.order_product_count), productCount <= 0 ? 0 : productCount));
        mSerializableMap = new SerializableMap();
        orderTicketMap = new HashMap<>();
        if (cartConfirm.getIsTicketSingleSelection() == Constants.TicketSingleType.SINGLE) {
            getBestCoupon(cartConfirm.getTicketTypes());
        } else {//多选 无默认优惠券
            flushViewByCalculate();
        }
        getCheckedCouponMap();
        initAdapter();
    }

    @Override
    public void initHttpBack() {
        orderHttpBack = new HttpBack<OrderBase>(getBaseActivity()) {
            @Override
            public void onSuccess(OrderBase orderBase) {
                order = orderBase;
                CartUtils.removeCartProducts(getCartProductInfo());

                if (onlinePayCode != null && onlinePayCode == Constants.OnlinePayType.WX_PAY) {
                    createOrderSuccess = true;
                }
                if (orderBase.getPaidAmount() <= 0) {//实付金额小于等于0,跳转付款成功
                    paySuccess();
                } else {
                    PayUtils.getInstance(getActivity(), new PayHandler(ConfirmCartFragment.this)).toPay(onlinePayCode,
                            order.getSaleOrderNo());
                }
            }

            @Override
            public void onFailure(String msg) {
                super.onFailure(msg);
                canSubmit = true;
            }

            @Override
            public void onTimeOut() {
                super.onTimeOut();
                canSubmit = true;
            }
        };

        couponMoneyHttpBack = new HttpBack<OrderCoupon>(getBaseActivity()) {
            @Override
            public void onSuccess(OrderCoupon orderCoupon) {
                if (orderCoupon != null && orderCoupon.getOrderFeeInfo() != null) {
                    mOrderFeeInfo = orderCoupon.getOrderFeeInfo();
                    cartConfirm.setOrderFeeInfo(mOrderFeeInfo);
                    flushViewByCalculate();
                }
            }

            @Override
            public void onFailure(String msg) {
                flushViewByCalculate();
            }

            @Override
            public void onTimeOut() {
                flushViewByCalculate();
            }
        };
    }

    private void initAdapter() {
        //TODO 支付类型测试
        PayType aliPay = new PayType(Constants.OnlinePayType.ALI_PAY, String.valueOf("支付宝"));
        PayType weiXinPay = new PayType(Constants.OnlinePayType.WX_PAY, String.valueOf("微信支付"));
        payTypes.add(aliPay);
        payTypes.add(weiXinPay);

        payAdapter = new CartPayAdapter(payTypes, getActivity());
        payListView.setAdapter(payAdapter);

        couponTypeAdapter = new CartCouponTypeAdapter(cartConfirm.getTicketTypes(), getActivity());
        couponTypeAdapter.setDefaultCouponSelection(cartConfirm.getIsTicketSingleSelection());
        couponTypeAdapter.setCouponMoney(couponMoney, itemNum);
        mCouponListView.setAdapter(couponTypeAdapter);

        CartItemAdapter itemAdapter = new CartItemAdapter(cartConfirm.getSaleOrderItemList(), getActivity());
        productListView.setAdapter(itemAdapter);
        //买赠商品数据
        CartActDataAdapter actAdapter = new CartActDataAdapter(cartConfirm.getGiftInfo(), getActivity());
        actDataListView.setAdapter(actAdapter);
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                KeyboardUtils.close(getActivity());
                getActivity().onBackPressed();
            }
        });
        payListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                if (payAmount == 0) {
                    return;
                }
                checkPayType(i);
                payAdapter.notifyDataSetChanged();
            }
        });
        commitBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                commitCart();
            }
        });
        mCouponListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                TicketTypes ticketTypes = cartConfirm.getTicketTypes().get(i);
                if (ticketTypes == null || ticketTypes.getTicketInfoList() == null || ticketTypes.getTicketInfoList().size() == 0)
                    return;
                if (defaultCouponType != -1 && defaultCouponType != ticketTypes.getTicketType().intValue()) {
                    showChooseCouponDialog(i, ticketTypes);
                } else {
                    linkToCouponList(i, ticketTypes);
                }
            }
        });
    }

    private void commitCart() {
        String note = CheckUtils.filterSpecialCharacter(mCartNote.getText().toString().trim());
        if (!validate() || !canSubmit) {
            return;
        }
        canSubmit = false;
        Map<String, Object> map = new HashMap<>();
        map.put("note", note);
        map.put("tickets", CartUtils.getCouponInfo(orderTicketMap));
        RetrofitUtils.getInstance(true).commitOrder(ParamUtils.getParam(map), orderHttpBack);
    }

    private Boolean validate() {
        if (payAmount == 0) {
            //TODO 如果存在这种情况是不是直接生产订单
        } else {
            // 此时需要选择在线支付方式
            if (onlinePayCode == null) {
                ToastUtils.show(getActivity(), R.string.cart_pay_empty_notify);
                return false;
            }
            payCode = Constants.PayTypeCode.ONLINE;
        }
        return true;
    }

    private void checkPayType(int position) {
        PayType payType = payTypes.get(position);
        payType.setIsCheck(!payType.getIsCheck());
        if (payType.getIsCheck()) {
            onlinePayCode = payType.getPayTypeCode();
            int i = 0;
            for (PayType type : payTypes) {
                if (i != position) {
                    type.setIsCheck(false);
                }
                i++;
            }
        } else {
            onlinePayCode = null;
        }
    }

    /**
     * 计算并刷新价格
     */
    private void flushViewByCalculate() {
        Long totalAmt = mOrderFeeInfo.getTotalAmount();
        Long transferFee = mOrderFeeInfo.getTransferFee();
        Long preferential = mOrderFeeInfo.getPreferentialAmt();
        if (transferFee == 0) {
            transferAmtView.setTextColor(getResources().getColor(R.color.secondaryText));
        } else {
            transferAmtView.setTextColor(getResources().getColor(R.color.colorPrimary));
        }
        llVipNotice.setVisibility(cartConfirm.getIsVipOrder() == null || cartConfirm.getIsVipOrder() == 0 ? View.GONE : View.VISIBLE);
        transferAmtView.setText(String.valueOf(Constants.MONEY_PLUS_FLAG + Constants.MONEY_FLAG + MoneyUtils.toPrice(transferFee)));
        preferentialAmtView.setText(String.valueOf(Constants.MONEY_MINUS_FLAG + Constants.MONEY_FLAG + MoneyUtils.toPrice(preferential)));

        payAmount = totalAmt - preferential;
        payAmount = payAmount < 0 ? transferFee : payAmount + transferFee;

        List<Integer> countStyles = new ArrayList<>();
        countStyles.add(R.style.TextAppearance_Large_Red);
        TextChangeUtils.setDifferentText(getActivity(), totalMoney, R.string.order_total_price_desc,
                countStyles, MoneyUtils.toPrice(payAmount));

        payAmountView.setText(String.valueOf(MoneyUtils.toPrice(payAmount)));
        boolean isDisable = false;
        if (payAmount == 0) {
            isDisable = true;
            commitBtn.setText(getResources().getString(R.string.cart_commit_none_payment_btn));
        } else {
            commitBtn.setText(getResources().getString(R.string.cart_commit_btn));
        }
        if (payAdapter == null) {
            return;
        }
        payAdapter.setIsDisable(isDisable);
        payAdapter.notifyDataSetChanged();
    }

    @Override
    public void onResume() {
        super.onResume();
        if (createOrderSuccess) {
            // 该种情况就是因为微信支付没有回调而引起的
            // 那么此时需要跳转到订单详情页面
            payFailure();
        }
    }

    private void paySuccess() {
        Bundle bundle = new Bundle();
        if (cartConfirm.getIsVipOrder() != null && cartConfirm.getIsVipOrder() == 1) {
            getBaseActivity().showFragment(PaySuccessVipFragment.class.getSimpleName(), bundle, false);
        } else {
            bundle.putString(Constants.BundleName.ORDER_CODE, order.getSaleOrderNo());
            getBaseActivity().showFragment(PaySuccessFragment.class.getSimpleName(), bundle, false);
        }
    }

    private void payFailure() {
        Intent intent = new Intent(getActivity(), OrderDetailActivity.class);
        intent.putExtra(Constants.BundleName.ORDER_CODE, order.getSaleOrderNo());
        startActivity(intent);
        AppManager.getAppManager().finishActivity(getActivity());
        AppManager.getAppManager().finishActivity();
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == Constants.RequestCode.COUPON_CHOOSE_CODE) {
            mSerializableMap = (SerializableMap) data.getSerializableExtra(Constants.BundleName.COUPON_CHECKED_DATA);
            orderTicketMap = mSerializableMap.getMap();
            couponMoney = data.getLongExtra(Constants.BundleName.COUPON_MONEY, 0);
            couponTypeAdapter.setCouponMoney(couponMoney, itemNum);
            couponTypeAdapter.notifyDataSetChanged();
            isDefault = false;
            if (orderTicketMap == null || orderTicketMap.size() == 0) {
                defaultCouponType = -1;
            }
            refreshOrderMoney();
        }
    }

    private void refreshOrderMoney() {
        Map<String, Object> map = new HashMap<>();
        map.put("tickets", CartUtils.getCouponInfo(orderTicketMap));
        RetrofitUtils.getInstance(true).settlementOrderTickets(ParamUtils.getParam(map), couponMoneyHttpBack);
    }

    static class PayHandler extends Handler {
        private WeakReference<ConfirmCartFragment> fragmentWeakReference;

        public PayHandler(ConfirmCartFragment fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(@NonNull Message msg) {
            super.dispatchMessage(msg);
            ConfirmCartFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            switch (msg.what) {
                case AliPayUtils.PAY_SUCCESS:
                    ToastUtils.show(fragment.getActivity(), R.string.pay_success);
                    fragment.paySuccess();
                    return;
                case AliPayUtils.PAY_NETWORK_EXCEPTION:
                    ToastUtils.show(fragment.getActivity(), R.string.http_network);
                    break;
                case AliPayUtils.PAY_CANCEL:
                case AliPayUtils.PAY_FAILURE:
                case AliPayUtils.PAY_WAIT_CONFIRM:
                case AliPayUtils.PAY_NO_INSTALL:
                case AliPayUtils.HAS_PAY:
                    ToastUtils.show(fragment.getActivity(), R.string.pay_failure);
                    break;
            }
            fragment.payFailure();
        }
    }

    private void showChooseCouponDialog(final int position, final TicketTypes ticketTypes) {
        if (chooseDialog != null && chooseDialog.isShowing()) {
            return;
        }
        chooseDialog = new CommonDialog(getActivity(), new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                chooseDialog.dismiss();
                couponMoney = 0l;
                orderTicketMap.clear();
                getCheckedCouponMap();
                linkToCouponList(position, ticketTypes);
            }
        });

        chooseDialog.setData(isDefault ? String.format(getResources().getString(R.string.cart_choose_coupon_dialog1), defaultCouponName, defaultCouponName)
                        : String.format(getResources().getString(R.string.cart_choose_coupon_dialog2), defaultCouponName),
                getResources().getString(R.string.confirm_button_text));
        chooseDialog.show();
    }

    private void getBestCoupon(List<TicketTypes> ticketTypes) {
        for (int i = 0; i < ticketTypes.size(); i++) {
            Ticket ticket = listSort(ticketTypes.get(i).getTicketInfoList());
            if (ticket != null && couponMoney < ticket.getTicketAmount()) {
                itemNum = i;
                couponMoney = ticket.getTicketAmount();
                defaultCouponType = ticket.getTicketType();
                defaultCouponName = ticket.getTicketTypeName();
                orderTicketMap.clear();
                orderTicketMap.put(ticket.getTicketId(), ticket.getTicketType());
            }
        }
        if (orderTicketMap == null || orderTicketMap.size() == 0) {//无默认优惠券
            flushViewByCalculate();
            return;
        }
        refreshOrderMoney();
    }

    private Ticket listSort(List<Ticket> ticketInfoList) {
        if (ticketInfoList == null || ticketInfoList.size() == 0) {
            return null;
        }
        Ticket maxTicket = ticketInfoList.get(0);
        for (int i = 0; i < ticketInfoList.size(); i++) {
            if (maxTicket.getTicketAmount() >= ticketInfoList.get(i).getTicketAmount()) {
                continue;
            }
            maxTicket = ticketInfoList.get(i);
        }
        return maxTicket;
    }

    private List<Integer> getCartProductInfo() {
        List<Integer> productIds = new ArrayList<>();
        for (SaleProduct product : mSaleOrderItemList) {
            productIds.add(product.getSaleProductId());
        }
        return productIds;
    }

    public void getCheckedCouponMap() {
        mSerializableMap.setMap(orderTicketMap);
    }

    private void linkToCouponList(int i, TicketTypes ticketType) {
        setDefalutInfoToChooseCoupon(i, ticketType);
        Intent intent = new Intent(getActivity(), CartCouponActivity.class);
        intent.putExtra(Constants.BundleName.COUPON_DATA, ticketType);
        intent.putExtra(Constants.BundleName.COUPON_CHECKED_DATA, mSerializableMap);
        intent.putExtra(Constants.BundleName.TICKET_SINGLE, cartConfirm.getIsTicketSingleSelection());
        intent.putExtra(Constants.BundleName.COUPON_COLOR, ITEMCOLOR[i % 2]);
        intent.putExtra(Constants.BundleName.COUPON_ITEM_BG, ITEMBG[i % 2]);
        intent.putExtra(Constants.BundleName.COUPON_CHECK_IMAGE, CHECKIMAGE[i % 2]);
        intent.putExtra(Constants.BundleName.COUPON_MONEY, couponMoney);
        startActivityForResult(intent, Constants.RequestCode.COUPON_CHOOSE_CODE);
        getActivity().overridePendingTransition(R.anim.down_push_in, 0);
    }

    private void setDefalutInfoToChooseCoupon(int num, TicketTypes ticketType) {
        defaultCouponType = ticketType.getTicketType();
        defaultCouponName = ticketType.getTicketTypeName();
        itemNum = num;
    }
}