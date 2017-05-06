package com.yldbkd.www.buyer.android.fragment;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.NonNull;
import android.text.TextUtils;
import android.view.KeyEvent;
import android.view.View;
import android.view.inputmethod.EditorInfo;
import android.widget.AdapterView;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.google.gson.Gson;
import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.adapter.SearchCommunityAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.Community;
import com.yldbkd.www.buyer.android.bean.Page;
import com.yldbkd.www.buyer.android.utils.ChangeCommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.HistoryUtils;
import com.yldbkd.www.buyer.android.utils.PreferenceName;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.AppManager;
import com.yldbkd.www.library.android.common.KeyboardUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.pullRefresh.PullToRefreshBase;
import com.yldbkd.www.library.android.pullRefresh.PullToRefreshListView;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;
import com.yldbkd.www.library.android.viewCustomer.CommonDialog;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 查询定位搜索结果页面Fragment
 * <p/>
 * Created by linghuxj on 15/10/13.
 */
public class SearchLocationResultFragment extends BaseFragment {

    private String keywords;
    //title
    private RelativeLayout backView;
    private TextView titleView;
    private RelativeLayout mainToorBar;
    private ImageView backImage;
    // content
    private PullToRefreshListView refreshListView;
    private ListView locationResultListView;
    private RelativeLayout emptyLayout;
    private SearchCommunityAdapter communityAdapter;
    private Integer pageNum = 1;
    private Integer totalPages = 1;
    private HttpBack<Page<Community>> communityHttpBack;
    private List<Community> communities = new ArrayList<>();
    private Handler refreshHandler = new RefreshHandler(this);
    private ClearableEditText mSearchLocationView;
    private CommonDialog locationChangeDialog;
    private boolean isAddressList = false;

    private ChangeHandler changeHandler = new ChangeHandler(this);

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        keywords = bundle.getString(Constants.BundleName.SEARCH_KEYWORD, "");
        //获取来源路径
        isAddressList = bundle.getBoolean(Constants.BundleName.IS_ADDRESS_LIST, false);
    }

    @Override
    public int setLayoutId() {
        return R.layout.search_location_result_fragment;
    }

    @Override
    public void initView(View view) {
        backView = (RelativeLayout) view.findViewById(R.id.back_view);
        titleView = (TextView) view.findViewById(R.id.title_view);
        titleView.setText(getResources().getString(R.string.address_city_detail));
        mainToorBar = (RelativeLayout) view.findViewById(R.id.main_toor_bar);
        backImage = (ImageView) view.findViewById(R.id.back_image);

        mainToorBar.setBackgroundColor(getResources().getColor(R.color.shape_order_status_bg_checked));
        titleView.setTextColor(getResources().getColor(R.color.white));
        backImage.setBackgroundResource(R.mipmap.location_back_image);

        mSearchLocationView = (ClearableEditText) view.findViewById(R.id.search_location_view);
        mSearchLocationView.setImeOptions(EditorInfo.IME_ACTION_SEARCH);

        refreshListView = (PullToRefreshListView) view.findViewById(R.id.search_location_result_refresh_layout);
        locationResultListView = refreshListView.getRefreshableView();
        emptyLayout = (RelativeLayout) view.findViewById(R.id.search_empty_layout);
    }

    @Override
    public void initData() {
        mSearchLocationView.setText(keywords);
        mSearchLocationView.requestFocus();
        KeyboardUtils.openDelay(getContext(), mSearchLocationView);

        initAdapter();
        if (!isAddressList) {//增加地址页面进来的不请求
            initRequest();
        }
    }

    @Override
    public void initHttpBack() {
        communityHttpBack = new HttpBack<Page<Community>>(getBaseActivity()) {
            @Override
            public void onSuccess(Page<Community> locationList) {
                if (locationList == null) {
                    emptyLayout.setVisibility(View.VISIBLE);
                    refreshListView.setVisibility(View.GONE);
                    return;
                }
                if (locationList.getPageNum() <= 1) {
                    communities.clear();
                }
                if (locationList.getList() != null) {
                    communities.addAll(locationList.getList());
                }
                if (communities.size() == 0) {
                    emptyLayout.setVisibility(View.VISIBLE);
                    refreshListView.setVisibility(View.GONE);
                } else {
                    emptyLayout.setVisibility(View.GONE);
                    refreshListView.setVisibility(View.VISIBLE);
                }
                pageNum = locationList.getPageNum() + 1;
                totalPages = locationList.getTotalPages();
                communityAdapter.notifyDataSetChanged();
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
    public void initRequest() {
        request(1);
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

        mSearchLocationView.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView textView, int i, KeyEvent keyEvent) {
                keywords = textView.getText().toString().trim();
                if (TextUtils.isEmpty(keywords)) {
                    ToastUtils.show(getActivity(), R.string.search_location_empty_notify);
                    return false;
                }

                if (EditorInfo.IME_ACTION_SEARCH == i) {
                    request(1);
                    return true;
                }
                return false;
            }
        });
        locationResultListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                final Community locationList = communities.get(position);
                sendAddressDataToHome(locationList);
            }

        });
    }

    private void sendAddressDataToHome(Community locationList) {
        KeyboardUtils.close(getActivity());
        HistoryUtils.addHistory(getActivity(), new Gson().toJson(locationList), PreferenceName.Search.SEARCH_Location_HISTORY);
        if (!isAddressList) {
            ChangeCommunityUtils.changeCommunity(getActivity(), locationList, changeHandler);
        } else {
            Intent intent = new Intent();
            intent.putExtra(Constants.BundleName.LOCATION_INFO, locationList);
            getActivity().setResult(Activity.RESULT_FIRST_USER, intent);
            AppManager.getAppManager().finishActivity(getActivity());
        }
    }

    private void onResult(int what) {
        Intent intent = new Intent();
        intent.putExtra(Constants.BundleName.CHANGE_COMMUNITY_CHOICE, what);
        getActivity().setResult(Activity.RESULT_FIRST_USER, intent);
        AppManager.getAppManager().finishActivity(getActivity());
    }

    private void initAdapter() {
        communityAdapter = new SearchCommunityAdapter(communities, getActivity());
        locationResultListView.setAdapter(communityAdapter);
    }

    private void request(int pageNum) {
        Map<String, Object> map = new HashMap<>();
        map.put("keywords", keywords);
        map.put("pageNum", pageNum);
        map.put("pageSize", Constants.PAGE_SIZE);
        RetrofitUtils.getInstance().communitySearch(ParamUtils.getParam(map), communityHttpBack);
    }

    static class RefreshHandler extends Handler {
        private WeakReference<SearchLocationResultFragment> orderWeakReference;

        public RefreshHandler(SearchLocationResultFragment fragment) {
            this.orderWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(android.os.Message msg) {
            SearchLocationResultFragment fragment = orderWeakReference.get();
            if (fragment == null) {
                return;
            }
            if (msg.what == Constants.HandlerCode.REFRESH_LIST) {
                fragment.refreshListView.onRefreshComplete();
            }
        }
    }

    private static class ChangeHandler extends Handler {
        WeakReference<SearchLocationResultFragment> fragmentWeakReference;

        public ChangeHandler(SearchLocationResultFragment fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(@NonNull Message msg) {
            SearchLocationResultFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            fragment.onResult(msg.what);
        }
    }
}
