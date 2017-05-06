package com.yldbkd.www.buyer.android.fragment;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.NonNull;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.CalcCenterActivity;
import com.yldbkd.www.buyer.android.activity.EvalutionActivity;
import com.yldbkd.www.buyer.android.activity.OrderDetailActivity;
import com.yldbkd.www.buyer.android.adapter.OrderListAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.BaseModel;
import com.yldbkd.www.buyer.android.bean.OrderDetail;
import com.yldbkd.www.buyer.android.bean.OrderList;
import com.yldbkd.www.buyer.android.bean.Page;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.PayUtils;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.buyer.android.viewCustomer.ThreeSelectorDialog;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.pay.AliPayUtils;
import com.yldbkd.www.library.android.pullRefresh.PullToRefreshBase;
import com.yldbkd.www.library.android.pullRefresh.PullToRefreshListView;
import com.yldbkd.www.library.android.viewCustomer.CommonDialog;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 订单列表页面Fragment
 * <p/>
 * Created by linghuxj on 15/10/15.
 */
public class OrderListFragment extends BaseFragment {
    private PullToRefreshListView refreshListView;
    private ListView orderListView;
    private OrderListAdapter orderAdapter;
    private List<OrderList> orders = new ArrayList<>();
    private Integer mPageNum;
    private Integer totalPages;
    private Integer position;
    private Integer statusCode = 4;

    private HttpBack<Page<OrderList>> orderHttpBack;
    private HttpBack<BaseModel> cancelHttpBack;
    private HttpBack<BaseModel> receiveHttpBack;
    private RelativeLayout mNodataRL;
    private RelativeLayout backView;
    private TextView titleView;
    private View progressContainer;
    private View mOrderListTitle;
    private CommonDialog mCancelOrderDialog;
    private boolean isRefundOrder = false;
    private boolean isViewShown = false;

    private Handler refreshHandler = new RefreshHandler(this);

    private ThreeSelectorDialog payDialog;
    private Handler payHandler = new PayHandler(this);
    private boolean isVisibleToUser;
    //评价
    private HttpBack<OrderDetail> orderDetailHttpBack;

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        statusCode = bundle.getInt(Constants.BundleName.ORDER_STATUS_TYPE);
    }

    @Override
    public int setLayoutId() {
        return R.layout.order_list_fragment;
    }

    @Override
    public void initView(View view) {
        refreshListView = (PullToRefreshListView) view.findViewById(R.id.order_list_layout);
        orderListView = refreshListView.getRefreshableView();
        mNodataRL = (RelativeLayout) view.findViewById(R.id.rl_nodata);
        mOrderListTitle = view.findViewById(R.id.order_list_title);
        backView = (RelativeLayout) view.findViewById(R.id.back_view);
        titleView = (TextView) view.findViewById(R.id.title_view);
        titleView.setText(getResources().getString(R.string.order_refund));
        progressContainer = view.findViewById(R.id.progress_container);
    }

    @Override
    public void initData() {
        isRefundOrder = statusCode == 4;
        mOrderListTitle.setVisibility(isRefundOrder ? View.VISIBLE : View.GONE);
        initAdapter();
        if (isRefundOrder) {
            initRequest();
        }
        progressContainer.setVisibility(View.VISIBLE);
    }

    @Override
    public void setUserVisibleHint(boolean isVisibleToUser) {
        super.setUserVisibleHint(isVisibleToUser);
        isViewShown = getView() != null;
        this.isVisibleToUser = isVisibleToUser;
        if (isVisibleToUser && isViewShown) {
            initRequest();
        }
    }

    @Override
    public void onResume() {
        super.onResume();
        setUserVisibleHint(isVisibleToUser);
    }

    @Override
    public void initHttpBack() {
        orderHttpBack = new HttpBack<Page<OrderList>>(getBaseActivity()) {
            @Override
            public void onSuccess(Page<OrderList> data) {
                progressContainer.setVisibility(View.GONE);
                if (data == null || data.getTotalRecords() == 0) {
                    mNodataRL.setVisibility(View.VISIBLE);
                    refreshListView.setVisibility(View.GONE);
                    return;
                } else {
                    mNodataRL.setVisibility(View.GONE);
                    refreshListView.setVisibility(View.VISIBLE);
                }
                if (data.getPageNum() == 1) {
                    orders.clear();
                }
                mPageNum = data.getPageNum() + 1;
                totalPages = data.getTotalPages();
                orders.addAll(data.getList());
                orderAdapter.notifyDataSetChanged();
                refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_LIST);
            }

            @Override
            public void onFailure(String msg) {
                super.onFailure(msg);
                refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_LIST);
            }

            @Override
            public void onTimeOut() {
                super.onTimeOut();
                refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_LIST);
            }
        };
        cancelHttpBack = new HttpBack<BaseModel>(getBaseActivity()) {
            @Override
            public void onSuccess(BaseModel baseModel) {
                initRequest();
            }
        };
        receiveHttpBack = new HttpBack<BaseModel>(getBaseActivity()) {
            @Override
            public void onSuccess(BaseModel baseModel) {
                initRequest();
            }
        };
        orderDetailHttpBack = new HttpBack<OrderDetail>(getBaseActivity()) {
            @Override
            public void onSuccess(OrderDetail orderDetail) {
                if (orderDetail == null) {
                    return;
                }
                Intent intent = new Intent(getActivity(), EvalutionActivity.class);
                intent.putExtra(Constants.BundleName.ORDER_DETAIL, orderDetail);
                startActivity(intent);
            }
        };
    }

    @Override
    public void initRequest() {
        if (UserUtils.isLogin()) {
            request(1);// 获取第一页数据
        }
    }

    private void request(int pageNum) {
        Map<String, Object> map = new HashMap<>();
        map.put("pageNum", pageNum);
        map.put("pageSize", Constants.PAGE_SIZE);
        map.put("statusCode", String.valueOf(statusCode));
        RetrofitUtils.getInstance().getOrderesList(ParamUtils.getParam(map), orderHttpBack);
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().onBackPressed();
            }
        });
        orderListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                Intent intent = new Intent(getActivity(), OrderDetailActivity.class);
                intent.putExtra(Constants.BundleName.ORDER_CODE, orders.get(i).getSaleOrderNo());
                startActivityForResult(intent, Constants.RequestCode.ORDER_DETAIL_OPERATOR);
            }
        });
        refreshListView.setOnRefreshListener(new PullToRefreshBase.OnRefreshListener() {
            @Override
            public void onRefreshPullDown() {// 下拉
                request(1);
            }

            @Override
            public void onRefreshPullUp() {
                if (mPageNum > totalPages) {
                    refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_LIST);
                    ToastUtils.showShort(getActivity(), R.string.pull_up_no_more_data);
                    return;
                }
                request(mPageNum);
            }
        });
    }

    private void initAdapter() {
        orderAdapter = new OrderListAdapter(orders, getContext(), new OrderHandler(this));
        orderListView.setAdapter(orderAdapter);
    }

    private void toPay(int position) {
        this.position = position;
        final OrderList order = orders.get(position);
        payDialog = new ThreeSelectorDialog(getActivity(), new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                PayUtils.getInstance(getActivity(), payHandler).toPay(Constants.OnlinePayType.ALI_PAY,
                        order.getSaleOrderNo());
                payDialog.dismiss();
            }
        }, new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                PayUtils.getInstance(getActivity(), payHandler).toPay(Constants.OnlinePayType.WX_PAY,
                        order.getSaleOrderNo());
                payDialog.dismiss();
            }
        });
        payDialog.setData(R.string.order_select_ali_pay, R.string.order_select_wx_pay);
        payDialog.show();
    }

    private void toReceive(int position) {
        this.position = position;
        OrderList order = orders.get(position);
        Map<String, Object> map = new HashMap<>();
        map.put("saleOrderNo", order.getSaleOrderNo());
        RetrofitUtils.getInstance(true).receiveOrder(ParamUtils.getParam(map), receiveHttpBack);
    }

    private void toCancel(final int position) {
        this.position = position;
        if (mCancelOrderDialog != null && mCancelOrderDialog.isShowing()) {
            return;
        }
        mCancelOrderDialog = new CommonDialog(getActivity(), new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                OrderList order = orders.get(position);
                Map<String, Object> map = new HashMap<>();
                map.put("saleOrderNo", order.getSaleOrderNo());
                RetrofitUtils.getInstance(true).cancelOrder(ParamUtils.getParam(map), cancelHttpBack);
                mCancelOrderDialog.dismiss();
            }
        });
        mCancelOrderDialog.setData(getText(R.string.order_dialog_cancel).toString(), getText(R.string.dialog_confirm).toString());
        mCancelOrderDialog.show();
    }

    private void toEvalution(final int position) {//评价
        this.position = position;
        Map<String, Object> map = new HashMap<>();
        map.put("saleOrderNo", orders.get(position).getSaleOrderNo());
        RetrofitUtils.getInstance(true).getOrderesDetail(ParamUtils.getParam(map), orderDetailHttpBack);
    }

    private void paySuccess() {
        if (position == null) {
            return;
        }
        Intent intent = new Intent(getActivity(), CalcCenterActivity.class);
        intent.setAction(PaySuccessFragment.class.getSimpleName());
        intent.putExtra(Constants.BundleName.ORDER_CODE, orders.get(position).getSaleOrderNo());
        startActivity(intent);
        position = null;
    }

    public void setData(OrderDetail orderDetail) {
        if (orderDetail == null) {
            return;
        }
        for (OrderList orderBase : orders) {
            if (orderBase.getSaleOrderNo().equals(orderDetail.getOrderBaseInfo().getSaleOrderNo())) {
                orderBase.setStatusCode(orderDetail.getOrderBaseInfo().getStatusCode());
            }
        }
        orderAdapter.notifyDataSetChanged();
    }

    static class OrderHandler extends Handler {
        private WeakReference<OrderListFragment> orderWeakReference;

        public OrderHandler(OrderListFragment fragment) {
            this.orderWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(@NonNull Message msg) {
            OrderListFragment fragment = orderWeakReference.get();
            if (fragment == null) {
                return;
            }
            int position = (int) msg.obj;
            switch (msg.what) {
                case Constants.HandlerCode.ORDER_PAY:
                    fragment.toPay(position);
                    break;
                case Constants.HandlerCode.ORDER_RECEIVE:
                    fragment.toReceive(position);
                    break;
                case Constants.HandlerCode.ORDER_CANCEL:
                    fragment.toCancel(position);
                    break;
                case Constants.HandlerCode.ORDER_EVALUATION:
                    fragment.toEvalution(position);
                    break;
            }
        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (Constants.RequestCode.ORDER_DETAIL_OPERATOR == requestCode) {
            initRequest();
        }
    }

    static class RefreshHandler extends Handler {
        private WeakReference<OrderListFragment> orderWeakReference;

        public RefreshHandler(OrderListFragment fragment) {
            this.orderWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(@NonNull Message msg) {
            OrderListFragment fragment = orderWeakReference.get();
            if (fragment == null) {
                return;
            }
            if (msg.what == Constants.HandlerCode.REFRESH_LIST) {
                fragment.refreshListView.onRefreshComplete();
            }
        }
    }

    static class PayHandler extends Handler {
        private WeakReference<OrderListFragment> fragmentWeakReference;

        public PayHandler(OrderListFragment fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(@NonNull Message msg) {
            super.dispatchMessage(msg);
            OrderListFragment fragment = fragmentWeakReference.get();
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
        }
    }
}
