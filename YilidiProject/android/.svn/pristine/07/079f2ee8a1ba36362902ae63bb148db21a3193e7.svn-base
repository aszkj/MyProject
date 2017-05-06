package com.yldbkd.www.buyer.android.fragment;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.NonNull;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.CalcCenterActivity;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.BaseModel;
import com.yldbkd.www.buyer.android.bean.OrderDetail;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.PayUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.buyer.android.viewCustomer.ThreeSelectorDialog;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.pay.AliPayUtils;
import com.yldbkd.www.library.android.viewCustomer.CommonDialog;
import com.yldbkd.www.library.android.viewCustomer.ImgTxtButton;
import com.yldbkd.www.library.android.viewCustomer.PagerSlidingTabStrip;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 订单Fragment
 * <p/>
 * Created by linghuxj on 15/10/14.
 */
public class NewOrderDetailFragment extends BaseFragment {

    private View backView;
    private PagerSlidingTabStrip pagerIndicator;
    private ViewPager viewPager;

    private static final int VIEW_PAGER_COUNT = 2;
    private static final int[] VIEW_PAGER_TITLES = {R.string.order_status_text, R.string.order_details};
    private static final int STATUS = 1, DETAIL = 2;
    private static final int[] STATUS_TYPES = {STATUS, DETAIL};

    private List<Fragment> fragments = new ArrayList<>();
    private HttpBack<OrderDetail> orderDetailHttpBack;
    private String operatorOrderNo;
    private ImgTxtButton mRightView;
    private String mSaleOrderNo;
    private String orderNo;
    private HttpBack<OrderDetail> orderHttpBack;
    private OrderDetail mOrderDetail;

    private LinearLayout mBottomLL;//ll_bottom
    private Button mCancelBtn;
    private Button mConfirmBtn;

    private ThreeSelectorDialog payDialog;
    private Handler payHandler = new PayHandler(this);
    private CommonDialog mCancelOrderDialog;
    private HttpBack<BaseModel> mReceiveOHttpBack;
    private HttpBack<BaseModel> mCancelHttpBack;
    private TextView mTitleView;

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        orderNo = bundle.getString(Constants.BundleName.ORDER_CODE);
    }

    @Override
    public int setLayoutId() {
        return R.layout.new_order_detail_fragment;
    }

    @Override
    public void initView(View view) {
        backView = view.findViewById(R.id.back_view);
        mRightView = (ImgTxtButton) view.findViewById(R.id.right_view);
        mRightView.setVisibility(View.GONE);
        mTitleView = (TextView) view.findViewById(R.id.title_view);
        // mTitleView.setText(getResources().getString(R.string.order_details));

        mBottomLL = (LinearLayout) view.findViewById(R.id.ll_bottom);
        mConfirmBtn = (Button) view.findViewById(R.id.btn_confirm);
        mCancelBtn = (Button) view.findViewById(R.id.btn_cancel);

        pagerIndicator = (PagerSlidingTabStrip) view.findViewById(R.id.detail_page_indicator);

        mTitleView.setVisibility(View.GONE);
        pagerIndicator.setVisibility(View.GONE);

        viewPager = (ViewPager) view.findViewById(R.id.view_pager);
        viewPager.setOffscreenPageLimit(VIEW_PAGER_COUNT);

    }

    @Override
    public void onResume() {
        super.onResume();
        initRequest();
    }

    @Override
    public void initHttpBack() {
        orderHttpBack = new HttpBack<OrderDetail>(getBaseActivity()) {
            @Override
            public void onSuccess(OrderDetail orderDetail) {
                mOrderDetail = orderDetail;
                mTitleView.setVisibility(View.VISIBLE);
                pagerIndicator.setVisibility(View.VISIBLE);

                mTitleView.setText(mOrderDetail.getOrderBaseInfo().getStoreName());

                initAdapter();
                chageBtnStatus(mOrderDetail);
            }

            @Override
            public void onFailure(String msg) {
                mTitleView.setText(getResources().getString(R.string.order_details));
            }
        };

        orderDetailHttpBack = new HttpBack<OrderDetail>(getBaseActivity()) {
            @Override
            public void onSuccess(OrderDetail orderDetail) {
                OrderListFragment fragment = (OrderListFragment) fragments.get(viewPager.getCurrentItem());
                fragment.setData(orderDetail);
            }
        };
        mReceiveOHttpBack = new HttpBack<BaseModel>(getBaseActivity()) {
            @Override
            public void onSuccess(BaseModel model) {
                initRequest();
            }
        };
        mCancelHttpBack = new HttpBack<BaseModel>(getBaseActivity()) {
            @Override
            public void onSuccess(BaseModel model) {
                initRequest();
            }
        };
    }

    private void chageBtnStatus(OrderDetail orderDetail) {
        String statusCode = orderDetail.getOrderBaseInfo().getStatusCode();
        if (Constants.OrderStatus.BUILD_CODE.equals(statusCode)) {// 去支付，蓝色背景，白色字体
            mConfirmBtn.setText(getBaseActivity().getResources().getString(R.string.order_to_pay));
            mConfirmBtn.setBackgroundResource(R.drawable.button_yellow_selector);
            mConfirmBtn.setTextColor(getResources().getColor(R.color.white));
            mCancelBtn.setVisibility(View.VISIBLE);
            mConfirmBtn.setVisibility(View.VISIBLE);
            mBottomLL.setVisibility(View.VISIBLE);
        } else if (Constants.OrderStatus.PAY_CODE.equals(statusCode)) {// 取消订单  白色背景，黑色字体，默认边框
            mConfirmBtn.setText(getBaseActivity().getResources().getString(R.string.order_to_cancel));
            mConfirmBtn.setBackgroundResource(R.drawable.button_white_gray_selector);
            mConfirmBtn.setTextColor(getResources().getColor(R.color.black));
            mCancelBtn.setVisibility(View.GONE);
            mConfirmBtn.setVisibility(View.VISIBLE);
            mBottomLL.setVisibility(View.VISIBLE);
        } else if (Constants.OrderStatus.WAIT_RECEIPT_CODE.equals(statusCode)) {// 确定收货  白色背景，红色边框，红色字体
            mConfirmBtn.setText(orderDetail.getOrderBaseInfo().getDeliveryModeCode().intValue() == Constants.DeliveryType.PICKUP
                    ? getBaseActivity().getResources().getString(R.string.order_to_receive_toke)
                    : getBaseActivity().getResources().getString(R.string.order_to_receive));
            mConfirmBtn.setBackgroundResource(R.drawable.button_yellow_selector);
            mConfirmBtn.setTextColor(getResources().getColor(R.color.white));
            mCancelBtn.setVisibility(View.GONE);
            mConfirmBtn.setVisibility(View.VISIBLE);
            mBottomLL.setVisibility(View.VISIBLE);
        } else {
            // 订单取消后下面按钮不可见
            mBottomLL.setVisibility(View.GONE);
            mCancelBtn.setVisibility(View.GONE);
            mConfirmBtn.setVisibility(View.GONE);
        }
    }


    @Override
    public void initRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("saleOrderNo", orderNo);
        RetrofitUtils.getInstance(true).getOrderesDetail(ParamUtils.getParam(map), orderHttpBack);
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getActivity().onBackPressed();
            }
        });
        // 确定支付
        mConfirmBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (mOrderDetail == null) {
                    return;
                }
                String statusCode = mOrderDetail.getOrderBaseInfo().getStatusCode();
                if (Constants.OrderStatus.BUILD_CODE.equals(statusCode)) {// 已下单，去支付
                    toPay();
                } else if (Constants.OrderStatus.PAY_CODE.equals(statusCode)) {// 已支付，取消订单
                    cancelOrder();
                } else if (Constants.OrderStatus.WAIT_RECEIPT_CODE.equals(statusCode)) {// 配送中，确定收货
                    Map<String, Object> map = new HashMap<>();
                    map.put("saleOrderNo", orderNo);
                    RetrofitUtils.getInstance().receiveOrder(ParamUtils.getParam(map), mReceiveOHttpBack);
                }
            }
        });

        // 取消订单
        mCancelBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (mOrderDetail == null) {
                    return;
                }
                cancelOrder();
            }
        });
    }

    private void toPay() {
        payDialog = new ThreeSelectorDialog(getActivity(), new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                PayUtils.getInstance(getActivity(), payHandler).toPay(Constants.OnlinePayType.ALI_PAY,
                        mOrderDetail.getOrderBaseInfo().getSaleOrderNo());
                payDialog.dismiss();
            }
        }, new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                PayUtils.getInstance(getActivity(), payHandler).toPay(Constants.OnlinePayType.WX_PAY,
                        mOrderDetail.getOrderBaseInfo().getSaleOrderNo());
                payDialog.dismiss();
            }
        });
        payDialog.setData(R.string.order_select_ali_pay, R.string.order_select_wx_pay);
        //        payDialog.setVisiableItem(Integer.parseInt(mOrderDetail.getOrderBaseInfo().getPayTypeCode()));
        payDialog.show();
    }

    /**
     * 取消订单
     */
    private void cancelOrder() {
        if(mCancelOrderDialog != null && mCancelOrderDialog.isShowing()){
            return;
        }
        mCancelOrderDialog = new CommonDialog(getActivity(), new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Map<String, Object> map = new HashMap<>();
                map.put("saleOrderNo", orderNo);
                RetrofitUtils.getInstance(true).cancelOrder(ParamUtils.getParam(map), mCancelHttpBack);
                mCancelOrderDialog.dismiss();
            }
        });
        mCancelOrderDialog.setData(getText(R.string.order_dialog_cancel).toString(), getText(R.string.dialog_confirm).toString());
        mCancelOrderDialog.show();
    }


    private void initAdapter() {
        List<String> titles = new ArrayList<>();
        viewPager.removeAllViews();
        fragments.clear();
        OrderDetailStatusFragment statusFragment = new OrderDetailStatusFragment();
        OrderDetailFragment detailFragment = new OrderDetailFragment();
        Bundle bundle = new Bundle();
        bundle.putSerializable(Constants.BundleName.ORDER_DETAIL, mOrderDetail);
        statusFragment.setArguments(bundle);
        detailFragment.setArguments(bundle);

        fragments.add(statusFragment);
        fragments.add(detailFragment);
        for (int i = 0; i < VIEW_PAGER_COUNT; i++) {
            titles.add(getResources().getString(VIEW_PAGER_TITLES[i]));
        }
        OrderDetailFragmentAdapter adapter = new OrderDetailFragmentAdapter(getFragmentManager(), fragments, titles);
        viewPager.setAdapter(adapter);
        viewPager.setCurrentItem(1);
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

    private static class OrderDetailFragmentAdapter extends FragmentStatePagerAdapter {

        private List<Fragment> fragments;
        private List<String> titles;

        public OrderDetailFragmentAdapter(FragmentManager fm, List<Fragment> fragments, List<String> titles) {
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

    static class PayHandler extends Handler {
        private WeakReference<NewOrderDetailFragment> fragmentWeakReference;

        public PayHandler(NewOrderDetailFragment fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(@NonNull Message msg) {
            super.dispatchMessage(msg);
            NewOrderDetailFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            switch (msg.what) {
                case AliPayUtils.PAY_SUCCESS:
                    ToastUtils.show(fragment.getActivity(), R.string.pay_success);
                    fragment.paySuccess();
                    break;
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
            fragment.initRequest();
        }
    }
    private void paySuccess() {
        Intent intent = new Intent(getActivity(), CalcCenterActivity.class);
        intent.setAction(PaySuccessFragment.class.getSimpleName());
        intent.putExtra(Constants.BundleName.ORDER_CODE, orderNo);
        intent.putExtra(Constants.BundleName.IS_ORDER_DETAIL, true);
        startActivity(intent);
    }
}
