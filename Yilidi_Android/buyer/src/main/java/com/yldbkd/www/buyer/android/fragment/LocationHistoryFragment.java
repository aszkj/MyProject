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
import android.widget.Button;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.google.gson.Gson;
import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.adapter.LocationListAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.Community;
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
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;
import com.yldbkd.www.library.android.viewCustomer.ListInScrollView;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 搜索历史Fragment
 * <p/>
 * Created by linghuxj on 15/10/13.
 */
public class LocationHistoryFragment extends BaseFragment {
    //title
    private RelativeLayout backView;
    private ImageView backImage;
    private RelativeLayout mainToorBar;
    private TextView titleView;
    private ClearableEditText mSearchLocationView;
    private List<String> mList;
    private List<Community> mLocationLists = new ArrayList<>();
    private ListInScrollView historyListview;
    private LocationListAdapter locationAdapter;
    private Button mBtnCleanHistory;

    private ChangeHandler changeHandler = new ChangeHandler(this);

    private HttpBack<Community> communityHttpBack;

    @Override
    public int setLayoutId() {
        return R.layout.location_history_fragment;
    }

    @Override
    public void initHttpBack() {
        communityHttpBack = new HttpBack<Community>(getBaseActivity()) {
            @Override
            public void onSuccess(Community community) {
                ChangeCommunityUtils.changeCommunity(getActivity(), community, changeHandler);
            }
        };
    }

    @Override
    public void initView(View view) {
        backView = (RelativeLayout) view.findViewById(R.id.back_view);
        titleView = (TextView) view.findViewById(R.id.title_view);
        backImage = (ImageView) view.findViewById(R.id.back_image);
        titleView.setText(getResources().getString(R.string.address_city_detail));
        mainToorBar = (RelativeLayout) view.findViewById(R.id.main_toor_bar);

        mainToorBar.setBackgroundColor(getResources().getColor(R.color.shape_order_status_bg_checked));
        titleView.setTextColor(getResources().getColor(R.color.white));
        backImage.setBackgroundResource(R.mipmap.location_back_image);


        mSearchLocationView = (ClearableEditText) view.findViewById(R.id.search_location_view);
        historyListview = (ListInScrollView) view.findViewById(R.id.history_listview);
        mBtnCleanHistory = (Button) view.findViewById(R.id.btn_clean_history);
    }

    @Override
    public void initData() {
        mSearchLocationView.requestFocus();
        KeyboardUtils.openDelay(getContext(), mSearchLocationView);

        initAdapter();
        historyRequest();
    }

    private void historyRequest() {
        mList = HistoryUtils.getHistory(getActivity(), PreferenceName.Search.SEARCH_Location_HISTORY);
        if (mList == null) {
            mBtnCleanHistory.setVisibility(View.GONE);
            return;
        }
        mLocationLists.clear();
        new Thread() {
            @Override
            public void run() {
                super.run();
                Gson gson = new Gson();
                for (int i = 0; i < mList.size(); i++) {
                    Community locationList = gson.fromJson(mList.get(i), Community.class);
                    mLocationLists.add(locationList);
                }
                getActivity().runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        locationAdapter.notifyDataSetChanged();
                    }
                });
            }
        }.start();
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
        mSearchLocationView.setOnEditorActionListener(new TextView.OnEditorActionListener() {
            @Override
            public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
                String keywords = mSearchLocationView.getText().toString().trim();
                if (TextUtils.isEmpty(keywords)) {
                    ToastUtils.show(getActivity(), R.string.search_location_empty_notify);
                    return false;
                }

                if (EditorInfo.IME_ACTION_SEARCH == actionId) {
                    KeyboardUtils.close(getActivity());

                    Bundle bundle = new Bundle();
                    bundle.putSerializable(Constants.BundleName.SEARCH_KEYWORD, keywords);
                    getBaseActivity().showFragment(SearchLocationResultFragment.class.getSimpleName(),
                            bundle, true);
                    return true;
                }
                return false;
            }
        });
        historyListview.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                final Community locationList = mLocationLists.get(position);
                communityRequest(locationList.getCommunityId());
            }
        });
        mBtnCleanHistory.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                HistoryUtils.clearHistory(getActivity(), PreferenceName.Search.SEARCH_Location_HISTORY);
                mLocationLists.clear();
                locationAdapter.notifyDataSetChanged();
                mBtnCleanHistory.setVisibility(View.GONE);
            }
        });
    }

    private void initAdapter() {
        locationAdapter = new LocationListAdapter(mLocationLists, getActivity());
        historyListview.setAdapter(locationAdapter);
    }

    private void onResult(int what) {
        Intent intent = new Intent();
        intent.putExtra(Constants.BundleName.CHANGE_COMMUNITY_CHOICE, what);
        getActivity().setResult(Activity.RESULT_FIRST_USER, intent);
        AppManager.getAppManager().finishActivity(getActivity());
    }

    private void communityRequest(Integer communityId) {
        Map<String, Object> map = new HashMap<>();
        map.put("communityId", communityId);
        RetrofitUtils.getInstance(true).communityById(ParamUtils.getParam(map), communityHttpBack);
    }

    private static class ChangeHandler extends Handler {
        WeakReference<LocationHistoryFragment> fragmentWeakReference;

        public ChangeHandler(LocationHistoryFragment fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(@NonNull Message msg) {
            LocationHistoryFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            fragment.onResult(msg.what);
        }
    }
}
