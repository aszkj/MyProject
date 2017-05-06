package com.yldbkd.www.seller.android.fragment;

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
import com.yldbkd.www.library.android.common.KeyboardUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.pullRefresh.RefreshLayout;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;
import com.yldbkd.www.library.android.viewCustomer.CommonDialog;
import com.yldbkd.www.library.android.viewCustomer.ImgTxtButton;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.adapter.SearchProductAdapter;
import com.yldbkd.www.seller.android.bean.BaseModel;
import com.yldbkd.www.seller.android.bean.Page;
import com.yldbkd.www.seller.android.bean.ProductDetail;
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
 * 商品搜索结果页
 * <p/>
 * Created by linghuxj on 16/6/3.
 */
public class ProductSearchResultFragment extends BaseFragment {

    private String keyword;

    private LinearLayout backView;
    private ClearableEditText searchTextView;
    private ImgTxtButton searchBtn;

    private List<ProductDetail> products = new ArrayList<>();
    private RefreshLayout refreshLayout;
    private RecyclerView recyclerView;
    private SearchProductAdapter productAdapter;
    private RelativeLayout emptyLayout;

    private int pageNum = 0;
    private int totalPages = 1;
    private int operationIndex = 0;

    private HttpBack<Page<ProductDetail>> productHttpBack;
    private HttpBack<BaseModel> confirmHttpBack;

    private RefreshHandler refreshHandler = new RefreshHandler(this);
    private StatusHandler statusHandler = new StatusHandler(this);

    private CommonDialog dialog;

    @Override
    public int setLayoutId() {
        return R.layout.fragment_product_search_result;
    }

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        keyword = bundle.getString(Constants.BundleName.SEARCH_KEYWORD);
    }

    @Override
    public void initHttpBack() {
        productHttpBack = new HttpBack<Page<ProductDetail>>() {
            @Override
            public void onSuccess(Page<ProductDetail> productBasePage) {
                refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_COMPLETE);
                if (productBasePage == null || productBasePage.getTotalRecords() <= 0) {
                    isEmptyView(true);
                    return;
                }
                pageNum = productBasePage.getPageNum();
                totalPages = productBasePage.getTotalPages();
                if (pageNum <= 1) {
                    products.clear();
                }
                products.addAll(productBasePage.getList());
                isEmptyView(products.size() == 0);
                productAdapter.notifyDataSetChanged();
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
        confirmHttpBack = new HttpBack<BaseModel>() {
            @Override
            public void onSuccess(BaseModel baseModel) {
                ProductDetail product = products.get(operationIndex);
                product.setProductStatus(Constants.PRODUCT_STATUS.ONLINE == product.getProductStatus() ?
                        Constants.PRODUCT_STATUS.OFFLINE : Constants.PRODUCT_STATUS.ONLINE);
                productAdapter.notifyItemChanged(operationIndex, product);
            }
        };
    }

    @Override
    public void initView(View view) {
        backView = (LinearLayout) view.findViewById(R.id.ll_back_search_bar);
        backView.setVisibility(View.GONE);
        searchTextView = (ClearableEditText) view.findViewById(R.id.cet_search_bar);
        searchBtn = (ImgTxtButton) view.findViewById(R.id.itb_right_search_bar);
        searchBtn.setText(getString(R.string.cancle));
        refreshLayout = (RefreshLayout) view.findViewById(R.id.rl_search_product);
        refreshLayout.init(getActivity());
        recyclerView = (RecyclerView) view.findViewById(R.id.rv_search_product);
        emptyLayout = (RelativeLayout) view.findViewById(R.id.rl_search_product_empty);
    }

    @Override
    public void initAdapter() {
        LinearLayoutManager layoutManager = new LinearLayoutManager(getActivity());
        layoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        recyclerView.setLayoutManager(layoutManager);
        productAdapter = new SearchProductAdapter(getActivity(), products, statusHandler);
        recyclerView.setAdapter(productAdapter);
        recyclerView.addItemDecoration(DefaultItemDecoration.getNormal(getActivity()));
    }

    @Override
    public void initListener() {
        searchBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().onBackPressed();
            }
        });
        searchTextView.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                if (EditorInfo.IME_ACTION_SEARCH == i) {
                    String keywords = searchTextView.getText().toString().trim();
                    return search(keywords);
                }
                return false;
            }
        });
        refreshLayout.setRefreshListener(new RefreshLayout.OnDataRefreshListener() {
            @Override
            public void onDataRefresh() {
                productRequest(1);
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
                productRequest(++pageNum);
            }
        });
    }

    @Override
    public void initData() {
        searchTextView.setText(keyword);
        searchTextView.setSelection(keyword.length());
        searchTextView.requestFocus();
    }

    @Override
    public void initRequest() {
        productRequest(1);
    }

    @Override
    public void onPause() {
        super.onPause();
        KeyboardUtils.close(getActivity(), searchTextView);
    }

    private void isEmptyView(boolean isEmpty) {
        emptyLayout.setVisibility(isEmpty ? View.VISIBLE : View.GONE);
        refreshLayout.setVisibility(isEmpty ? View.GONE : View.VISIBLE);
    }

    private boolean search(String keywords) {
        if (TextUtils.isEmpty(keywords)) {
            ToastUtils.show(getActivity(), R.string.search_location_empty_notify);
            return false;
        }
        if (CheckUtils.isConSpeCharacters(keywords)) {
            ToastUtils.show(getActivity(), R.string.search_error_notify);
            return false;
        }
        HistoryUtils.addHistory(getActivity(), keywords, PreferenceName.Search.SEARCH_PRODUCT_HISTORY);
        keyword = keywords;
        productRequest(1);
        return true;
    }

    private void productRequest(int pageNum) {
        Map<String, Object> map = new HashMap<>();
        map.put("pageNum", pageNum);
        map.put("pageSize", Constants.PAGE_SIZE);
        map.put("keyword", keyword);
        RetrofitUtils.getInstance(true).searchProducts(ParamUtils.getParam(map), productHttpBack);
    }

    private void confirm(final int status, final int position) {
        boolean isOnline = Constants.HandlerCode.PRODUCT_ONLINE != status;
        dialog = new CommonDialog(getActivity(), new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                changeFlag(status, position);
                dialog.dismiss();
            }
        });
        dialog.setData(getString(isOnline ? R.string.class_product_choice_off_confirm :
                R.string.class_product_choice_on_confirm), getString(isOnline ? R.string.class_product_offline
                : R.string.class_product_online));
        dialog.show();
    }

    private void changeFlag(int status, int position) {
        operationIndex = position;
        ProductDetail product = products.get(operationIndex);
        Map<String, Object> map = new HashMap<>();
        map.put("saleProductIds", product.getSaleProductId());
        map.put("enabledFlag", Constants.HandlerCode.PRODUCT_ONLINE == status ? 1 : 2);
        RetrofitUtils.getInstance(true).changeProductStatus(ParamUtils.getParam(map), confirmHttpBack);
    }

    private static class StatusHandler extends Handler {
        WeakReference<ProductSearchResultFragment> fragmentWeakReference;

        public StatusHandler(ProductSearchResultFragment fragment) {
            this.fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            ProductSearchResultFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            fragment.confirm(msg.what, (Integer) msg.obj);
        }
    }

    private static class RefreshHandler extends Handler {
        private WeakReference<ProductSearchResultFragment> productWeakReference;

        public RefreshHandler(ProductSearchResultFragment fragment) {
            this.productWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            ProductSearchResultFragment fragment = productWeakReference.get();
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
