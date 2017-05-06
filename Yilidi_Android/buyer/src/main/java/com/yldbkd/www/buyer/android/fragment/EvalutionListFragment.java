package com.yldbkd.www.buyer.android.fragment;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.View;
import android.widget.ListView;
import android.widget.RelativeLayout;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.PreviewImageActivity;
import com.yldbkd.www.buyer.android.adapter.ProductEvalutionAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.Evalution;
import com.yldbkd.www.buyer.android.bean.Page;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.pullRefresh.PullToRefreshBase;
import com.yldbkd.www.library.android.pullRefresh.PullToRefreshListView;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @创建者 李贞高
 * @创建时间 2017/2/14 11:54
 * @描述 评价列表
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class EvalutionListFragment extends BaseFragment {
    private String mSummaryValue;
    private int mSaleProductId;
    private boolean isFirst = true;
    private boolean isVisibleToUser;
    private boolean isViewShown = false;

    private PullToRefreshListView refreshListView;
    private ListView mEvalutionListView;
    private RelativeLayout mNodataRL;
    private ProductEvalutionAdapter mProductEvalutionAdapter;
    private HttpBack<Page<Evalution>> evalutionHttpBack;
    private List<Evalution> mEvalutionLists = new ArrayList<>();
    private int pageNum = 1, totalPages;
    private Handler refreshHandler = new RefreshHandler(this);

    private EvalutionHandler evalutionHandler = new EvalutionHandler(this);

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        mSummaryValue = bundle.getString(Constants.BundleName.EVALUTION_CLASSIFTY);
        mSaleProductId = bundle.getInt(Constants.BundleName.SALE_PRODUCT_ID);
    }

    @Override
    public int setLayoutId() {
        return R.layout.evalution_list_fragment;
    }

    @Override
    public void initView(View view) {
        refreshListView = (PullToRefreshListView) view.findViewById(R.id.evalution_list_view);
        mEvalutionListView = refreshListView.getRefreshableView();
        mNodataRL = (RelativeLayout) view.findViewById(R.id.rl_nodata);
    }

    @Override
    public void initData() {
        initAdapter();
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
        if (isFirst) {
            setUserVisibleHint(isVisibleToUser);
            isFirst = false;
        }
    }

    @Override
    public void initRequest() {
        request(1);
    }

    @Override
    public void initHttpBack() {
        evalutionHttpBack = new HttpBack<Page<Evalution>>(getBaseActivity()) {
            @Override
            public void onSuccess(Page<Evalution> evalutionPage) {
                if (evalutionPage == null) {
                    mNodataRL.setVisibility(View.VISIBLE);
                    refreshListView.setVisibility(View.GONE);
                    return;
                }
                if (evalutionPage.getPageNum() <= 1) {
                    mEvalutionLists.clear();
                }
                if (evalutionPage.getList() != null) {
                    mEvalutionLists.addAll(evalutionPage.getList());
                }
                if (mEvalutionLists.size() == 0) {
                    mNodataRL.setVisibility(View.VISIBLE);
                    refreshListView.setVisibility(View.GONE);
                } else {
                    mNodataRL.setVisibility(View.GONE);
                    refreshListView.setVisibility(View.VISIBLE);
                }
                pageNum = evalutionPage.getPageNum() + 1;
                totalPages = evalutionPage.getTotalPages();
                mProductEvalutionAdapter.notifyDataSetChanged();
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

    private void request(int pageNum) {
        Map<String, Object> map = new HashMap<>();
        map.put("pageNum", pageNum);
        map.put("pageSize", Constants.PAGE_SIZE);
        map.put("saleProductId", mSaleProductId);
        map.put("summaryValue", mSummaryValue);
        RetrofitUtils.getInstance().getEvalution(ParamUtils.getParam(map), evalutionHttpBack);
    }

    private void initAdapter() {
        mProductEvalutionAdapter = new ProductEvalutionAdapter(getActivity(), mEvalutionLists, evalutionHandler);
        mEvalutionListView.setAdapter(mProductEvalutionAdapter);
    }

    @Override
    public void initListener() {
        refreshListView.setOnRefreshListener(new PullToRefreshBase.OnRefreshListener() {
            @Override
            public void onRefreshPullDown() {
                request(1);
            }

            @Override
            public void onRefreshPullUp() {
                if (pageNum > totalPages) {
                    refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_LIST);
                    ToastUtils.show(getActivity(), R.string.pull_up_no_more_data);
                    return;
                }
                request(pageNum);
            }
        });
    }

    static class RefreshHandler extends Handler {
        private WeakReference<EvalutionListFragment> couponWeakReference;

        public RefreshHandler(EvalutionListFragment fragment) {
            this.couponWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(android.os.Message msg) {
            EvalutionListFragment fragment = couponWeakReference.get();
            if (fragment == null) {
                return;
            }
            if (msg.what == Constants.HandlerCode.REFRESH_LIST) {
                fragment.refreshListView.onRefreshComplete();
            }
        }
    }

    private static class EvalutionHandler extends Handler {
        WeakReference<EvalutionListFragment> fragmentWeakReference;

        public EvalutionHandler(EvalutionListFragment fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(final Message msg) {
            final EvalutionListFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            switch (msg.what) {
                case Constants.HandlerCode.EVALUTIONPICTUREITEM:
                    fragment.addEvalutionPicture(msg.arg1, msg.arg2);
                    break;
            }
        }
    }

    private void addEvalutionPicture(int position1, int position2) {
        Intent intent = new Intent(getActivity(), PreviewImageActivity.class);
        intent.putExtra(Constants.BundleName.PRODUCT_EVALUTION, mEvalutionLists.get(position1));
        intent.putExtra(Constants.BundleName.IMAGE_NUMBER, position2);
        startActivity(intent);
    }
}
