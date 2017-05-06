package com.yldbkd.www.seller.android.fragment;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.LinearLayout;

import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.pullRefresh.RefreshLayout;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.activity.AllotOrderDetailActivity;
import com.yldbkd.www.seller.android.adapter.AllotOrderAdapter;
import com.yldbkd.www.seller.android.adapter.BaseAdapter;
import com.yldbkd.www.seller.android.bean.AllotOrderBase;
import com.yldbkd.www.seller.android.bean.Page;
import com.yldbkd.www.seller.android.utils.Constants;
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
 * 调货单列表页面
 * <p/>
 * Created by linghuxj on 16/6/6.
 */
public class AllotOrderListFragment extends BaseFragment {

    private Integer whetherComplete;

    private List<AllotOrderBase> allotOrders = new ArrayList<>();
    private RefreshLayout refreshLayout;
    private RecyclerView recyclerView;
    private AllotOrderAdapter orderAdapter;
    private int pageNum = 0, totalPage = 1;
    private LinearLayout emptyLayout;

    private HttpBack<Page<AllotOrderBase>> allotOrderHttpBack;

    private RefreshHandler refreshHandler = new RefreshHandler(this);

    @Override
    public int setLayoutId() {
        return R.layout.fragment_allot_list;
    }

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        whetherComplete = bundle.getInt(Constants.BundleName.ALLOT_ORDER_STATUS_TYPE);
    }

    @Override
    public void initHttpBack() {
        allotOrderHttpBack = new HttpBack<Page<AllotOrderBase>>() {
            @Override
            public void onSuccess(Page<AllotOrderBase> allotOrderBasePage) {
                refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_COMPLETE);
                if (allotOrderBasePage == null || allotOrderBasePage.getTotalRecords() <= 0) {
                    isEmptyView(true);
                    return;
                }
                isEmptyView(false);
                pageNum = allotOrderBasePage.getPageNum();
                totalPage = allotOrderBasePage.getTotalPages();
                if (pageNum <= 1) {
                    allotOrders.clear();
                }
                allotOrders.addAll(allotOrderBasePage.getList());
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
        refreshLayout = (RefreshLayout) view.findViewById(R.id.rl_allot_order);
        refreshLayout.init(getActivity());
        recyclerView = (RecyclerView) view.findViewById(R.id.rv_allot_order);
        emptyLayout = (LinearLayout) view.findViewById(R.id.ll_allot_order_empty);
    }

    @Override
    public void initAdapter() {
        LinearLayoutManager layoutManager = new LinearLayoutManager(getActivity());
        layoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        recyclerView.setLayoutManager(layoutManager);
        orderAdapter = new AllotOrderAdapter(getActivity(), allotOrders, whetherComplete);
        recyclerView.setAdapter(orderAdapter);
        recyclerView.addItemDecoration(DefaultItemDecoration.getNormal(getActivity()));
    }

    @Override
    public void initListener() {
        refreshLayout.setRefreshListener(new RefreshLayout.OnDataRefreshListener() {
            @Override
            public void onDataRefresh() {
                allotOrderRequest(1);
            }
        });
        refreshLayout.setLoadListener(new RefreshLayout.OnDataLoadListener() {
            @Override
            public void onDataLoad() {
                if (pageNum >= totalPage) {
                    ToastUtils.showShort(getActivity(), R.string.pull_up_no_more_data);
                    refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_COMPLETE);
                    return;
                }
                allotOrderRequest(++pageNum);
            }
        });
        orderAdapter.setOnItemClickListener(new BaseAdapter.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int position) {
                Intent intent = new Intent(getActivity(), AllotOrderDetailActivity.class);
                intent.putExtra(Constants.BundleName.ALLOT_ORDER_NO, allotOrders.get(position).getAllotOrderNo());
                startActivityForResult(intent, Constants.RequestCode.ALLOT_ORDER_DETAIL_CODE);
            }
        });
    }

    @Override
    public void setUserVisibleHint(boolean isVisibleToUser) {
        super.setUserVisibleHint(isVisibleToUser);
        if (isVisibleToUser) {
            allotOrderRequest(1);
        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
    }

    private void isEmptyView(boolean isEmpty) {
        emptyLayout.setVisibility(isEmpty ? View.VISIBLE : View.GONE);
        refreshLayout.setVisibility(isEmpty ? View.GONE : View.VISIBLE);
    }

    private void allotOrderRequest(int pageNum) {
        Map<String, Object> map = new HashMap<>();
        map.put("pageNum", pageNum);
        map.put("pageSize", Constants.PAGE_SIZE);
        map.put("whetherComplete", whetherComplete);
        RetrofitUtils.getInstance(true).allotOrderList(ParamUtils.getParam(map), allotOrderHttpBack);
    }

    private static class RefreshHandler extends Handler {
        private WeakReference<AllotOrderListFragment> productWeakReference;

        public RefreshHandler(AllotOrderListFragment fragment) {
            this.productWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            AllotOrderListFragment fragment = productWeakReference.get();
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
