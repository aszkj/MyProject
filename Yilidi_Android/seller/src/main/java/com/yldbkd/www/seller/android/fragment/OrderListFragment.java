package com.yldbkd.www.seller.android.fragment;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.text.TextUtils;
import android.view.KeyEvent;
import android.view.View;
import android.view.inputmethod.EditorInfo;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.CheckUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.pullRefresh.RefreshLayout;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;
import com.yldbkd.www.library.android.viewCustomer.ImgTxtButton;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.activity.OrderDetailActivity;
import com.yldbkd.www.seller.android.activity.OrderListActivity;
import com.yldbkd.www.seller.android.adapter.BaseAdapter;
import com.yldbkd.www.seller.android.adapter.OrderAdapter;
import com.yldbkd.www.seller.android.bean.OrderBase;
import com.yldbkd.www.seller.android.bean.Page;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.utils.HistoryUtils;
import com.yldbkd.www.seller.android.utils.PreferenceName;
import com.yldbkd.www.seller.android.utils.http.HttpBack;
import com.yldbkd.www.seller.android.utils.http.ParamUtils;
import com.yldbkd.www.seller.android.utils.http.RetrofitUtils;
import com.yldbkd.www.seller.android.viewCustomer.DefaultItemDecoration;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 订单列表Fragment
 * <p/>
 * Created by linghuxj on 16/5/31.
 */
public class OrderListFragment extends BaseFragment {

    private Integer orderStatus;
    private boolean isNormalType = true;
    private boolean isSearch = false;
    private int pageNum = 0;
    private int totalPages = 1;

    private LinearLayout backView;
    private ClearableEditText editTextView;
    private ImgTxtButton searchBtn;
    private String keyword;

    private RefreshLayout refreshLayout;
    private RecyclerView recyclerView;
    private OrderAdapter orderAdapter;
    private List<OrderBase> orders = new ArrayList<>();
    private LinearLayout emptyLayout;

    private HttpBack<Page<OrderBase>> orderHttpBack;

    private RefreshHandler refreshHandler = new RefreshHandler(this);

    private boolean isVisibleToUser = false;

    @Override
    public int setLayoutId() {
        return R.layout.fragment_order_list;
    }

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        orderStatus = bundle.getInt(Constants.BundleName.ORDER_STATUS, -1);
        isSearch = orderStatus == -1;
        keyword = bundle.getString(Constants.BundleName.SEARCH_KEYWORD);
        isNormalType = bundle.getBoolean(Constants.BundleName.IS_NORMAL_ORDER);
    }

    @Override
    public void initHttpBack() {
        orderHttpBack = new HttpBack<Page<OrderBase>>() {
            @Override
            public void onSuccess(Page<OrderBase> orderBasePage) {
                refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_COMPLETE);
                if (orderBasePage == null || orderBasePage.getTotalRecords() <= 0) {
                    isEmptyView(true);
                    return;
                }
                pageNum = orderBasePage.getPageNum();
                totalPages = orderBasePage.getTotalPages();
                if (pageNum <= 1) {
                    orders.clear();
                }
                orders.addAll(orderBasePage.getList());
                isEmptyView(orders.size() == 0);
                orderAdapter.notifyDataSetChanged();
            }

            @Override
            public void onFailure(String msg) {
                super.onFailure(msg);
                refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_COMPLETE);
            }

            @Override
            public void onTimeOut() {
                super.onTimeOut();
                refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_COMPLETE);
            }
        };
    }

    @Override
    public void initView(View view) {
        LinearLayout searchLayout = (LinearLayout) view.findViewById(R.id.ll_search_layout);
        searchLayout.setVisibility(isSearch ? View.VISIBLE : View.GONE);
        backView = (LinearLayout) view.findViewById(R.id.ll_back_search_bar);
        editTextView = (ClearableEditText) view.findViewById(R.id.cet_search_bar);
        editTextView.setHint(R.string.order_search_hint);
        editTextView.setText(isSearch ? keyword : "");
        searchBtn = (ImgTxtButton) view.findViewById(R.id.itb_right_search_bar);
        searchBtn.setText(getString(R.string.search));

        refreshLayout = (RefreshLayout) view.findViewById(R.id.srl_order_list);
        refreshLayout.init(getActivity());
        recyclerView = (RecyclerView) view.findViewById(R.id.rv_order_list);
        emptyLayout = (LinearLayout) view.findViewById(R.id.ll_order_list_empty);
    }

    @Override
    public void initAdapter() {
        LinearLayoutManager layoutManager = new LinearLayoutManager(getActivity());
        layoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        recyclerView.setLayoutManager(layoutManager);
        orderAdapter = new OrderAdapter(getActivity(), orders);
        recyclerView.setAdapter(orderAdapter);
        recyclerView.addItemDecoration(DefaultItemDecoration.getNormal(getActivity()));
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().onBackPressed();
            }
        });
        searchBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                orderKeywordRequest(editTextView.getText().toString(), 1);
            }
        });
        editTextView.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                if (EditorInfo.IME_ACTION_SEARCH == i) {
                    String keywords = textView.getText().toString().trim();
                    return orderKeywordRequest(keywords, 1);
                }
                return false;
            }
        });
        orderAdapter.setOnItemClickListener(new BaseAdapter.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int position) {
                Intent intent = new Intent(getActivity(), OrderDetailActivity.class);
                intent.setAction(OrderDetailFragment.class.getSimpleName());
                intent.putExtra(Constants.BundleName.ORDER_NO, orders.get(position).getSaleOrderNo());
                startActivity(intent);
            }
        });
        refreshLayout.setRefreshListener(new RefreshLayout.OnDataRefreshListener() {
            @Override
            public void onDataRefresh() {
                request(1);
            }
        });
        refreshLayout.setLoadListener(new RefreshLayout.OnDataLoadListener() {
            @Override
            public void onDataLoad() {
                if (pageNum >= totalPages) {
                    ToastUtils.showShort(getActivity(), R.string.pull_up_no_more_data);
                    refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_COMPLETE);
                    return;
                }
                request(++pageNum);
            }
        });
    }

    @Override
    public void initRequest() {
        if (isSearch) {
            request(1);
        }
    }

    @Override
    public void onResume() {
        super.onResume();
        setUserVisibleHint(isVisibleToUser);
    }

    @Override
    public void setUserVisibleHint(boolean isVisibleToUser) {
        super.setUserVisibleHint(isVisibleToUser);
        this.isVisibleToUser = isVisibleToUser;
        if (isVisibleToUser) {
            request(1);
        }
    }

    private void request(int pageNum) {
        if (isSearch) {
            // 搜索
            orderKeywordRequest(keyword, pageNum);
        } else {
            OrderListActivity activity = (OrderListActivity) getActivity();
            isNormalType = activity.isNormal();
            ordersRequest(pageNum, isNormalType);
        }
    }

    private boolean orderKeywordRequest(String keywords, int pageNum) {
        if (TextUtils.isEmpty(keywords)) {
            ToastUtils.show(getActivity(), R.string.order_search_empty_notify);
            return false;
        }
        if (CheckUtils.isConSpeCharacters(keywords)) {
            ToastUtils.show(getActivity(), R.string.search_error_notify);
            return false;
        }
        HistoryUtils.addHistory(getActivity(), keywords, PreferenceName.Search.SEARCH_ORDER_HISTORY);
        keyword = keywords.trim();
        Map<String, Object> map = new HashMap<>();
        map.put("pageNum", pageNum);
        map.put("pageSize", Constants.PAGE_SIZE);
        map.put("keyword", keyword);
        RetrofitUtils.getInstance(true).orderList(ParamUtils.getParam(map), orderHttpBack);
        return true;
    }

    public void ordersRequest(int pageNum, boolean isNormal) {
        Map<String, Object> map = new HashMap<>();
        map.put("pageNum", pageNum);
        map.put("pageSize", Constants.PAGE_SIZE);
        map.put("statusCode", orderStatus);
        map.put("orderType", isNormal ? 1 : 2);
        RetrofitUtils.getInstance(true).orderList(ParamUtils.getParam(map), orderHttpBack);
    }

    private void isEmptyView(boolean isEmpty) {
        emptyLayout.setVisibility(isEmpty ? View.VISIBLE : View.GONE);
        refreshLayout.setVisibility(isEmpty ? View.GONE : View.VISIBLE);
    }

    private static class RefreshHandler extends Handler {
        private WeakReference<OrderListFragment> productWeakReference;

        public RefreshHandler(OrderListFragment fragment) {
            this.productWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            OrderListFragment fragment = productWeakReference.get();
            if (fragment == null) {
                return;
            }
            if (msg.what == Constants.HandlerCode.REFRESH_COMPLETE) {
                fragment.refreshLayout.setRefreshing(false);
                fragment.refreshLayout.setLoadMore(false);
            }
        }
    }
}
