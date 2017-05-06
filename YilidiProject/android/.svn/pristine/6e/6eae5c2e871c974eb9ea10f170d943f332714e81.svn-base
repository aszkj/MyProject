package com.yldbkd.www.buyer.android.fragment;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.RelativeLayout;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.ClassActivity;
import com.yldbkd.www.buyer.android.adapter.BrandAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.Brand;
import com.yldbkd.www.buyer.android.bean.Page;
import com.yldbkd.www.buyer.android.utils.CommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.pullRefresh.RefreshLayout;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @创建者 李贞高
 * @创建时间 2017/1/17 15:46
 * @描述 搜索品牌
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class SearchBrandFragment extends BaseFragment {
    private String keywords;

    private RefreshLayout refreshLayout;
    private RecyclerView recycleView;
    private RelativeLayout mNodataRL;
    private List<Brand> brands = new ArrayList<>();
    private BrandAdapter brandAdapter;
    private HttpBack<Page<Brand>> searchBrandHttpBack;
    private Integer pageNum = 1;
    private Integer totalPages = 1;
    private Handler refreshHandler = new RefreshHandler(this);

    private boolean isViewShown = false;
    private boolean isVisibleToUser;
    private boolean isChange = true;

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        keywords = bundle.getString(Constants.BundleName.SEARCH_KEYWORD);
    }

    @Override
    public int setLayoutId() {
        return R.layout.search_brand_fragment;
    }

    @Override
    public void initView(View view) {
        mNodataRL = (RelativeLayout) view.findViewById(R.id.rl_nodata);

        refreshLayout = (RefreshLayout) view.findViewById(R.id.rl_brand_product);
        refreshLayout.init(getActivity());
        recycleView = (RecyclerView) view.findViewById(R.id.search_brand_recycle_view);
        GridLayoutManager gridLayoutManager = new GridLayoutManager(getActivity(), 4);
        gridLayoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        recycleView.setLayoutManager(gridLayoutManager);
        recycleView.getItemAnimator().setSupportsChangeAnimations(false);
    }

    @Override
    public void setUserVisibleHint(boolean isVisibleToUser) {
        super.setUserVisibleHint(isVisibleToUser);
        isViewShown = getView() != null;
        this.isVisibleToUser = isVisibleToUser;
        if (isVisibleToUser && isViewShown) {
            if (isChange) {
                brandInitRequest(1);
                isChange = false;
            }
        }
    }

    @Override
    public void onResume() {
        super.onResume();
        setUserVisibleHint(isVisibleToUser);
    }

    @Override
    public void initHttpBack() {
        searchBrandHttpBack = new HttpBack<Page<Brand>>(getBaseActivity()) {
            @Override
            public void onSuccess(Page<Brand> data) {
                if (data == null) {
                    mNodataRL.setVisibility(View.VISIBLE);
                    return;
                }
                if (data.getPageNum() <= 1) {
                    brands.clear();
                }
                if (data.getList() != null) {
                    brands.addAll(data.getList());
                }
                if (brands.size() == 0) {
                    mNodataRL.setVisibility(View.VISIBLE);
                } else {
                    mNodataRL.setVisibility(View.GONE);
                }
                pageNum = data.getPageNum();
                totalPages = data.getTotalPages();

                brandAdapter.notifyDataSetChanged();
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
    }

    @Override
    public void initData() {
        initAdapter();
    }

    public void setKeyWords(String key, boolean isChange) {
        this.keywords = key;
        this.isChange = isChange;
    }

    public void searchRequest() {
        brandInitRequest(1);
        isChange = false;
    }

    public void brandInitRequest(int pageNum) {
        Map<String, Object> map = new HashMap<>();
        map.put("keywords", keywords);
        map.put("storeId", CommunityUtils.getCurrentStoreId());
        map.put("pageNum", pageNum);
        map.put("pageSize", Constants.PAGE_SIZE * 2);
        RetrofitUtils.getInstance().searchBrandByKeywords(ParamUtils.getParam(map), searchBrandHttpBack);
    }

    private void initAdapter() {
        brandAdapter = new BrandAdapter(brands, getActivity());
        recycleView.setAdapter(brandAdapter);
    }

    @Override
    public void initListener() {
        brandAdapter.setItemClickListener(new BrandAdapter.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int position) {
                Brand brand = brands.get(position);
                if (brand == null) {
                    return;
                }
                Intent intent = new Intent(getActivity(), ClassActivity.class);
                intent.setAction(BrandProductFragment.class.getSimpleName());
                intent.putExtra(Constants.BundleName.BRAND_NAME, brand.getBrandName());
                intent.putExtra(Constants.BundleName.BRAND_CODE, brand.getBrandCode());
                startActivity(intent);
            }
        });
        refreshLayout.setRefreshListener(new RefreshLayout.OnDataRefreshListener() {
            @Override
            public void onDataRefresh() {
                brandInitRequest(1);
            }
        });
        refreshLayout.setLoadListener(new RefreshLayout.OnDataLoadListener() {
            @Override
            public void onDataLoad() {
                if (pageNum >= totalPages) {
                    ToastUtils.showShort(getActivity(), R.string.pull_up_no_more_data);
                    refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_LIST);
                    return;
                }
                brandInitRequest(++pageNum);
            }
        });
    }

    private static class RefreshHandler extends Handler {
        private WeakReference<SearchBrandFragment> productWeakReference;

        public RefreshHandler(SearchBrandFragment fragment) {
            this.productWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            SearchBrandFragment fragment = productWeakReference.get();
            if (fragment == null) {
                return;
            }
            if (msg.what == Constants.HandlerCode.REFRESH_LIST) {
                fragment.refreshLayout.setRefreshing(false);
                fragment.refreshLayout.setLoadMore(false);
            }
        }
    }
}
