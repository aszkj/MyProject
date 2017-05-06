package com.yldbkd.www.buyer.android.fragment;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.NonNull;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.baidu.location.BDLocation;
import com.baidu.location.BDLocationListener;
import com.google.gson.Gson;
import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.adapter.LocationListAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.BaseModel;
import com.yldbkd.www.buyer.android.bean.Community;
import com.yldbkd.www.buyer.android.bean.Page;
import com.yldbkd.www.buyer.android.utils.ChangeCommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.HistoryUtils;
import com.yldbkd.www.buyer.android.utils.LocationUtils;
import com.yldbkd.www.buyer.android.utils.PreferenceName;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.library.android.common.AppManager;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.pullRefresh.PullToRefreshBase;
import com.yldbkd.www.library.android.pullRefresh.PullToRefreshListView;

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
public class LocationNearbyFragment extends BaseFragment {


    //title
    private RelativeLayout backView;
    private RelativeLayout mainToorBar;
    private ImageView backImage;
    private TextView titleView;
    // content
    private RelativeLayout emptyLayout;
    private PullToRefreshListView refreshListView;
    private ListView locationListView;

    private HttpBack<Page<Community>> locationListHttpBack;
    private HttpBack<Page<BaseModel>> clearCartHttpBack;
    private Integer pageNum = 1;
    private Integer totalPages;
    public Handler refreshHandler = new RefreshHandler(this);
    private List<Community> mLocationLists = new ArrayList<>();
    private LocationListAdapter locationAdapter;
    private double mLatitude;
    private double mLongitude;
    boolean isAddressList = false;

    private LocationUtils location = LocationUtils.getInstance();

    private ChangeHandler changeHandler = new ChangeHandler(this);

    @Override
    public void initBundle() {
        //定位
        location.init(getActivity());
        location.registerLocationListener(new LocationListener());
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        //获取来源路径
        isAddressList = bundle.getBoolean(Constants.BundleName.IS_ADDRESS_LIST, false);
    }

    @Override
    public int setLayoutId() {
        return R.layout.location_nearby_fragment;
    }

    @Override
    public void initView(View view) {
        backView = (RelativeLayout) view.findViewById(R.id.back_view);
        titleView = (TextView) view.findViewById(R.id.title_view);
        titleView.setText(getResources().getString(R.string.address_current_list));
        mainToorBar = (RelativeLayout) view.findViewById(R.id.main_toor_bar);
        backImage = (ImageView) view.findViewById(R.id.back_image);

        mainToorBar.setBackgroundColor(getResources().getColor(R.color.shape_order_status_bg_checked));
        titleView.setTextColor(getResources().getColor(R.color.white));
        backImage.setBackgroundResource(R.mipmap.location_back_image);

        refreshListView = (PullToRefreshListView) view.findViewById(R.id.location_list_refresh_layout);
        locationListView = refreshListView.getRefreshableView();
        emptyLayout = (RelativeLayout) view.findViewById(R.id.search_empty_layout);
    }

    @Override
    public void initData() {
        initAdapter();
    }

    @Override
    public void onResume() {
        super.onResume();
        location.startLoc();
    }

    @Override
    public void initHttpBack() {
        locationListHttpBack = new HttpBack<Page<Community>>(getBaseActivity()) {
            @Override
            public void onSuccess(Page<Community> locationList) {
                if (locationList == null) {
                    emptyLayout.setVisibility(View.VISIBLE);
                    refreshListView.setVisibility(View.GONE);
                    return;
                }
                if (locationList.getPageNum() <= 1) {
                    mLocationLists.clear();
                }
                if (locationList.getList() != null) {
                    mLocationLists.addAll(locationList.getList());
                }
                if (mLocationLists.size() == 0) {
                    emptyLayout.setVisibility(View.VISIBLE);
                    refreshListView.setVisibility(View.GONE);
                } else {
                    emptyLayout.setVisibility(View.GONE);
                    refreshListView.setVisibility(View.VISIBLE);
                }
                pageNum = locationList.getPageNum() + 1;
                totalPages = locationList.getTotalPages();
                locationAdapter.notifyDataSetChanged();
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
        locationListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                final Community locationList = mLocationLists.get(position);
                sendAddressDataToHome(locationList);
            }
        });
    }

    private void sendAddressDataToHome(Community locationList) {
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
        locationAdapter = new LocationListAdapter(mLocationLists, getActivity());
        locationListView.setAdapter(locationAdapter);
    }

    private void request(int pageNum) {
        Map<String, Object> map = new HashMap<>();
        map.put("pageNum", pageNum);
        map.put("pageSize", Constants.PAGE_SIZE);
        map.put("longitude", mLongitude);
        map.put("latitude", mLatitude);
        RetrofitUtils.getInstance().getLocationList(ParamUtils.getParam(map), locationListHttpBack);
    }

    private class LocationListener implements BDLocationListener {
        @Override
        public void onReceiveLocation(BDLocation bdLocation) {
            if (bdLocation.getLocType() == BDLocation.TypeGpsLocation
                    || bdLocation.getLocType() == BDLocation.TypeOffLineLocation
                    || bdLocation.getLocType() == BDLocation.TypeNetWorkLocation) {
                mLatitude = bdLocation.getLatitude();
                mLongitude = bdLocation.getLongitude();
                request(1);
                location.stopLoc();
            }
        }
    }

    static class RefreshHandler extends Handler {
        private WeakReference<LocationNearbyFragment> orderWeakReference;

        public RefreshHandler(LocationNearbyFragment fragment) {
            this.orderWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(android.os.Message msg) {
            LocationNearbyFragment fragment = orderWeakReference.get();
            if (fragment == null) {
                return;
            }
            if (msg.what == Constants.HandlerCode.REFRESH_LIST) {
                fragment.refreshListView.onRefreshComplete();
            }
        }
    }

    private static class ChangeHandler extends Handler {
        WeakReference<LocationNearbyFragment> fragmentWeakReference;

        public ChangeHandler(LocationNearbyFragment fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(@NonNull Message msg) {
            LocationNearbyFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            fragment.onResult(msg.what);
        }
    }
}
