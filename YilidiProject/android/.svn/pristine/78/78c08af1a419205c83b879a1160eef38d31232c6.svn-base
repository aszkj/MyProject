package com.yldbkd.www.buyer.android.fragment;

import android.app.Activity;
import android.content.Intent;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.NonNull;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.baidu.location.BDLocation;
import com.baidu.location.BDLocationListener;
import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.AddressActivity;
import com.yldbkd.www.buyer.android.activity.LoginActivity;
import com.yldbkd.www.buyer.android.adapter.SearchAddressAdapter;
import com.yldbkd.www.buyer.android.adapter.StoreAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.AddressBase;
import com.yldbkd.www.buyer.android.bean.Store;
import com.yldbkd.www.buyer.android.utils.ChangeCommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.LocationUtils;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.buyer.android.viewCustomer.SectionView;
import com.yldbkd.www.library.android.common.AppManager;
import com.yldbkd.www.library.android.common.KeyboardUtils;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;
import com.yldbkd.www.library.android.viewCustomer.HorizontalDividerItemDecoration;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 定位搜索页面Fragment
 * <p/>
 * Created by linghuxj on 15/10/12.
 */
public class SearchLocationFragment extends BaseFragment implements SectionView.OnItemSelectListener {

    private List<AddressBase> addressBaseList = new ArrayList<>();
    private List<Store> storeInfoList = new ArrayList<>();
    //title
    private RelativeLayout backView;
    private ImageView backImage;
    private RelativeLayout mainToorBar;
    // content
    private LinearLayout locationLayout;
    private RecyclerView addressView;
    private RecyclerView storeInfoLayout;
    private LinearLayout addressBtn;
    private SectionView mSectionView;
    private SearchAddressAdapter addressAdapter;
    private StoreAdapter storeAdapter;

    private HttpBack<List<AddressBase>> addressHttpBack;
    private HttpBack<List<Store>> storeHttpBack;
    private LinearLayout mLlsearch;

    private String[] cityies = {"深圳市"};
    private ClearableEditText mSearchLocationView;

    private ChangeHandler changeHandler = new ChangeHandler(this);
    private LocationUtils location = LocationUtils.getInstance();
    private double mLatitude;
    private double mLongitude;

    @Override
    public void initBundle() {
        //定位
        location.init(getActivity());
        location.registerLocationListener(new LocationListener());
        location.startLoc();
    }

    @Override
    public int setLayoutId() {
        return R.layout.search_location_fragment;
    }

    @Override
    public void initView(View view) {
        backView = (RelativeLayout) view.findViewById(R.id.back_view);
        backImage = (ImageView) view.findViewById(R.id.back_image);
        mainToorBar = (RelativeLayout) view.findViewById(R.id.main_toor_bar);
        TextView titleView = (TextView) view.findViewById(R.id.title_view);
        titleView.setText(getResources().getString(R.string.address_city_detail));

        mainToorBar.setBackgroundColor(getResources().getColor(R.color.shape_order_status_bg_checked));
        backImage.setBackgroundResource(R.mipmap.location_back_image);
        titleView.setTextColor(getResources().getColor(R.color.white));

        mLlsearch = (LinearLayout) view.findViewById(R.id.search_location_layout);
        mSearchLocationView = (ClearableEditText) view.findViewById(R.id.search_location_view);

        locationLayout = (LinearLayout) view.findViewById(R.id.location_current_layout);
        addressView = (RecyclerView) view.findViewById(R.id.address_layout);

        storeInfoLayout = (RecyclerView) view.findViewById(R.id.store_info_layout);
        addressBtn = (LinearLayout) view.findViewById(R.id.ll_manage_address_btn);

        mSectionView = (SectionView) view.findViewById(R.id.sectionview);
    }

    @Override
    public void initData() {
        mLlsearch.setFocusable(true);
        mLlsearch.setFocusableInTouchMode(true);
        KeyboardUtils.close(getActivity());
        initAdapter();
    }

    @Override
    public void onResume() {
        super.onResume();
        initRequest();
    }

    @Override
    public void initHttpBack() {
        addressHttpBack = new HttpBack<List<AddressBase>>(getBaseActivity()) {
            @Override
            public void onSuccess(List<AddressBase> addressBases) {
                addressBaseList.clear();
                if (addressBases != null) {
                    addressBaseList.addAll(addressBases);
                }
                addressAdapter.notifyDataSetChanged();
            }
        };
        storeHttpBack = new HttpBack<List<Store>>(getBaseActivity()) {
            @Override
            public void onSuccess(List<Store> stores) {
                storeInfoList.clear();
                if (stores != null) {
                    storeInfoList.addAll(stores);
                }
                storeAdapter.notifyDataSetChanged();
            }
        };
    }

    @Override
    public void initRequest() {
        RetrofitUtils.getInstance(true).getUserAddressList(ParamUtils.getParam(null), addressHttpBack);
    }

    public void initStoreRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("longitude", mLongitude);
        map.put("latitude", mLatitude);
        RetrofitUtils.getInstance().getStoreList(ParamUtils.getParam(map), storeHttpBack);
    }

    @Override
    public void initListener() {
        mSectionView.setOnItemSelectListener(this);

        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                KeyboardUtils.close(getActivity());
                getActivity().onBackPressed();
            }
        });
        mLlsearch.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getBaseActivity().showFragment(LocationHistoryFragment.class.getSimpleName(), null, true);
            }
        });
        mSearchLocationView.setOnFocusChangeListener(new View.OnFocusChangeListener() {
            @Override
            public void onFocusChange(View v, boolean hasFocus) {
                if (hasFocus) {
                    getBaseActivity().showFragment(LocationHistoryFragment.class.getSimpleName(), null, true);
                }
            }
        });
        addressAdapter.setItemClickListener(new SearchAddressAdapter.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int position) {
                AddressBase address = addressBaseList.get(position);
                ChangeCommunityUtils.changeCommunity(getActivity(), address.getCommunity(), changeHandler);
            }
        });
        storeAdapter.setItemClickListener(new StoreAdapter.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int position) {
                Store store = storeInfoList.get(position);
                ChangeCommunityUtils.changeStore(getActivity(), store, changeHandler);
            }
        });
        locationLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getBaseActivity().showFragment(LocationNearbyFragment.class.getSimpleName(),
                        null, true);
            }
        });
        addressBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent;
                if (UserUtils.isLogin()) {
                    intent = new Intent(getActivity(), AddressActivity.class);
                    intent.setAction(AddressListFragment.class.getSimpleName());
                    startActivity(intent);
                } else {
                    intent = new Intent(getActivity(), LoginActivity.class);
                    intent.setAction(LoginFragment.class.getSimpleName());
                    startActivityForResult(intent, Constants.RequestCode.LOGIN_CODE);
                }
            }
        });
    }

    private void initAdapter() {
        initAddressListAdapter();
        initStoreListAdapter();
    }

    private void initAddressListAdapter() {
        LinearLayoutManager layoutManager = new LinearLayoutManager(getActivity());
        addressView.setLayoutManager(layoutManager);
        addressView.addItemDecoration(new HorizontalDividerItemDecoration.Builder(getActivity())
                .size(1).colorResId(R.color.dividerColor)
                .marginResId(R.dimen.normal_margin_lr, R.dimen.normal_margin_lr).build());
        addressAdapter = new SearchAddressAdapter(addressBaseList, getActivity(), new AddressHandler(this));
        addressView.setAdapter(addressAdapter);
    }

    private void initStoreListAdapter() {
        LinearLayoutManager layoutManager = new LinearLayoutManager(getActivity());
        storeInfoLayout.setLayoutManager(layoutManager);
        storeInfoLayout.addItemDecoration(new HorizontalDividerItemDecoration.Builder(getActivity())
                .size(1).colorResId(R.color.dividerColor)
                .marginResId(R.dimen.normal_margin_lr, R.dimen.normal_margin_lr).build());
        storeAdapter = new StoreAdapter(storeInfoList, getActivity());
        storeInfoLayout.setAdapter(storeAdapter);
    }

    private void onResult(int what) {
        Intent intent = new Intent();
        intent.putExtra(Constants.BundleName.CHANGE_COMMUNITY_CHOICE, what);
        getActivity().setResult(Activity.RESULT_FIRST_USER, intent);
        AppManager.getAppManager().finishActivity(getActivity());
    }

    @Override
    public void onLeftSelect() {
        addressView.setVisibility(View.VISIBLE);
        storeInfoLayout.setVisibility(View.GONE);
    }

    @Override
    public void onRightSelect() {
        addressView.setVisibility(View.GONE);
        storeInfoLayout.setVisibility(View.VISIBLE);
        initStoreRequest();
    }

    private static class ChangeHandler extends Handler {
        WeakReference<SearchLocationFragment> fragmentWeakReference;

        public ChangeHandler(SearchLocationFragment fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(@NonNull Message msg) {
            SearchLocationFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            fragment.onResult(msg.what);
        }
    }

    static class AddressHandler extends Handler {
        private WeakReference<SearchLocationFragment> addressWeakReference;

        public AddressHandler(SearchLocationFragment fragment) {
            this.addressWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            SearchLocationFragment fragment = addressWeakReference.get();
            if (fragment == null) {
                return;
            }
            switch (msg.what) {
                case Constants.HandlerCode.ADDRESS_MODIFY:
                    fragment.modify((int) msg.obj);
                    break;
            }
        }
    }

    private void modify(int position) {
        AddressBase addressBase = addressBaseList.get(position);
        Intent intent = new Intent(getActivity(), AddressActivity.class);
        intent.putExtra(Constants.BundleName.ADDRESS_ID, addressBase.getAddressId());
        intent.setAction(AddressFragment.class.getSimpleName());
        startActivityForResult(intent, Constants.RequestCode.LOCATION_ADDRESS_CODE);
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (Constants.RequestCode.LOCATION_ADDRESS_CODE == requestCode) {
            if (resultCode == Activity.RESULT_OK) {
                initRequest();
            }
        }
    }

    private class LocationListener implements BDLocationListener {
        @Override
        public void onReceiveLocation(BDLocation bdLocation) {
            if (bdLocation.getLocType() == BDLocation.TypeGpsLocation
                    || bdLocation.getLocType() == BDLocation.TypeOffLineLocation
                    || bdLocation.getLocType() == BDLocation.TypeNetWorkLocation) {
                mLatitude = bdLocation.getLatitude();
                mLongitude = bdLocation.getLongitude();
                location.stopLoc();
            }
        }
    }
}
