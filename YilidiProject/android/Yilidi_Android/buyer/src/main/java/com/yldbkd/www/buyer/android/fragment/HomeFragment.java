package com.yldbkd.www.buyer.android.fragment;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.NonNull;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.baidu.location.BDLocation;
import com.baidu.location.BDLocationListener;
import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.H5CordovaActivity;
import com.yldbkd.www.buyer.android.activity.LoginActivity;
import com.yldbkd.www.buyer.android.activity.MainActivity;
import com.yldbkd.www.buyer.android.activity.MessageActivity;
import com.yldbkd.www.buyer.android.activity.ProductActivity;
import com.yldbkd.www.buyer.android.activity.RedEnvelopActivity;
import com.yldbkd.www.buyer.android.activity.ScanActivity;
import com.yldbkd.www.buyer.android.activity.SearchActivity;
import com.yldbkd.www.buyer.android.activity.SecKillActivity;
import com.yldbkd.www.buyer.android.activity.ZoneActivity;
import com.yldbkd.www.buyer.android.adapter.AdvertZoneAdapter;
import com.yldbkd.www.buyer.android.adapter.HomeClassProductAdapter;
import com.yldbkd.www.buyer.android.adapter.HomeFunctionsAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.ActSecKill;
import com.yldbkd.www.buyer.android.bean.Advertisement;
import com.yldbkd.www.buyer.android.bean.Community;
import com.yldbkd.www.buyer.android.bean.FunctionLogo;
import com.yldbkd.www.buyer.android.bean.HomeFloorInfo;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.bean.Store;
import com.yldbkd.www.buyer.android.utils.CartUtils;
import com.yldbkd.www.buyer.android.utils.ChangeCommunityUtils;
import com.yldbkd.www.buyer.android.utils.CommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.DateUtils;
import com.yldbkd.www.buyer.android.utils.JumpUtils;
import com.yldbkd.www.buyer.android.utils.LocationUtils;
import com.yldbkd.www.buyer.android.utils.Logger;
import com.yldbkd.www.buyer.android.utils.UserUtils;
import com.yldbkd.www.buyer.android.utils.ZoneUtils;
import com.yldbkd.www.buyer.android.utils.http.HttpBack;
import com.yldbkd.www.buyer.android.utils.http.ParamUtils;
import com.yldbkd.www.buyer.android.utils.http.RetrofitUtils;
import com.yldbkd.www.buyer.android.viewCustomer.DefaultItemDecoration;
import com.yldbkd.www.library.android.banner.BannerView;
import com.yldbkd.www.library.android.banner.BannerViewAdapter;
import com.yldbkd.www.library.android.common.CountDown;
import com.yldbkd.www.library.android.common.DisplayUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;
import com.yldbkd.www.library.android.pullRefresh.RefreshHeaderHandler;
import com.yldbkd.www.library.android.viewCustomer.ClearableEditText;
import com.yldbkd.www.library.android.viewCustomer.ExpandableHeightGridView;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import in.srain.cube.views.ptr.PtrClassicFrameLayout;
import in.srain.cube.views.ptr.PtrDefaultHandler;
import in.srain.cube.views.ptr.PtrFrameLayout;

/**
 * 首页页面
 * <p/>
 * Created by linghuxj on 15/9/28.
 */
public class HomeFragment extends BaseFragment {

    // toolbar
    private RelativeLayout toolBarLayout;
    private LinearLayout locationLayout;
    private TextView locationNameView;
    private LinearLayout scanView;
    private LinearLayout searchView;
    private LinearLayout homeSearchView;
    private ClearableEditText mHomeSearchTextView;
    private View homeSearchToolBarView;

    //有小区页面
    private PtrClassicFrameLayout refreshLayout;
    private ListView contentListView;
    private HomeClassProductAdapter classProductAdapter;
    //轮播广告
    private LinearLayout emptyLayout;
    private BannerView bannerView;
    private BannerView bannerEmptyView;
    private ImageView festivalactView;
    private List<Advertisement> advertList = new ArrayList<>();
    //四大功能
    private ExpandableHeightGridView functionsGridView;
    private HomeFunctionsAdapter functionsAdapter;
    private List<FunctionLogo> mFunctionLogos = new ArrayList<>();

    //广告
    private LinearLayout zoneLayout;
    private TextView hourView, minuteView, secondView;
    private ImageView secKillImageView;
    private LinearLayout llHomeSeckillView;

    private ImageView zoneFirstView;
    private ImageView zoneSecondView;
    private RecyclerView zoneListView;
    private AdvertZoneAdapter advertZoneAdapter;
    private List<Advertisement> advertZoneList = new ArrayList<>();
    //店铺信息列表--listView底部
    private View footerView;
    //首页专区
    private HttpBack<Community> communityHttpBack;
    private List<HomeFloorInfo> homeFloorInfos = new ArrayList<>();

    private HttpBack<List<HomeFloorInfo>> homeFloorHttpBack;
    private HttpBack<List<SaleProduct>> cartHttpBack;
    private HttpBack<List<FunctionLogo>> functionLogoHttpBack;
    private HttpBack<List<Advertisement>> advertHttpBack;
    private HttpBack<ActSecKill> secKillHttpBack;
    private ActSecKill actSecKill; // 当前正在活动的秒杀活动信息
    private long timeLocalBetweenServer = 0;
    private HttpBack<List<Advertisement>> secKillAdvertHttpBack;
    private List<Advertisement> secKillAdvertisements;
    private HttpBack<List<Advertisement>> seminarAdvertHttpBack;
    private HttpBack<List<Advertisement>> festivalactHttpBack;
    private List<Advertisement> festivalactAdvertisement;

    private LocationUtils location = LocationUtils.getInstance();

    private boolean isViewShown = false;

    private static final float BANNER_HEIGHT_SCALE = 0.4445f;
    private int bannerHeight = 0;
    private boolean isVisibleToUser;
    private Integer[] functionsTitles = {R.string.home_function_member, R.string.home_function_group_buying, R.string.home_function_shark, R.string.home_function_lm};
    private Integer[] functionsIcon = {R.mipmap.home_member_icon, R.mipmap.home_group_buying_icon, R.mipmap.home_shark_icon, R.mipmap.home_lm_icon};
    private final int FUNCTION_MEMBER = 0;
    private final int FUNCTION_GROUP_BUY = 1;
    private final int FUNCTION_SPECIAL = 2;
    private final int FUNCTION_CLASSIFY = 3;

    private boolean isFirstLoad = true;

    private HomeHandler homeHandler = new HomeHandler(this);
    private Handler cartHandler;
    private ChangeHandler changeHandler = new ChangeHandler(this);

    private CountDown secKillCountDown;
    private static final long SECOND = 1000L;
    private static final long IMAGE_CHANGE_INTERVAL = 6 * 1000L;
    private long timeCount = 0L;
    private CountDownHandler countDownHandler = new CountDownHandler(this);

    //测量itemView不同高度的listView的滑动距离
    private int oldItem = -1;
    private int totalHeight = 0;
    private int beforeItemHeight = 0;
    private boolean changeBgFalg = false;

    private HttpBack<Store> storeInfotHttpBack;
    private boolean isNotification = false;

    @Override
    public void initBundle() {
        super.initBundle();
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        isNotification = bundle.getBoolean(Constants.BundleName.IS_NOTIFICATION, false);
    }

    @Override
    public int setLayoutId() {
        return R.layout.home_fragment;
    }

    @Override
    public void initData() {
        DisplayUtils.getPixelDisplayMetricsII(getActivity());
        bannerHeight = (int) (DisplayUtils.screenWidth * BANNER_HEIGHT_SCALE);
        initAdapter();
        initRequest();
        if (!isViewShown) {
            location.startLoc();
            bannerView.startPlay();
        }
    }

    @Override
    public void initView(View view) {
        toolBarLayout = (RelativeLayout) view.findViewById(R.id.home_toll_bar_layout);
        locationLayout = (LinearLayout) view.findViewById(R.id.location_view);
        locationNameView = (TextView) view.findViewById(R.id.location_text_view);
        scanView = (LinearLayout) view.findViewById(R.id.ll_scan_view);
        searchView = (LinearLayout) view.findViewById(R.id.ll_search_view);
        homeSearchView = (LinearLayout) view.findViewById(R.id.ll_home_search_layout);
        mHomeSearchTextView = (ClearableEditText) view.findViewById(R.id.home_search_text_view);
        homeSearchToolBarView = view.findViewById(R.id.home_search_tool_bar_layout);
        homeSearchToolBarView.setVisibility(View.GONE);
        homeSearchView.setFocusable(true);
        homeSearchView.setFocusableInTouchMode(true);

        refreshLayout = (PtrClassicFrameLayout) view.findViewById(R.id.refresh_layout);
        RefreshHeaderHandler headerHandler = new RefreshHeaderHandler(getActivity()) {
            @Override
            public void onUIReset(PtrFrameLayout frame) {
                super.onUIReset(frame);
                toolBarLayout.setVisibility(VISIBLE);
            }

            @Override
            public void onUIRefreshPrepare(PtrFrameLayout ptrFrameLayout) {
                super.onUIRefreshPrepare(ptrFrameLayout);
                toolBarLayout.setVisibility(GONE);
            }
        };
        refreshLayout.setHeaderView(headerHandler);
        refreshLayout.addPtrUIHandler(headerHandler);
        contentListView = (ListView) view.findViewById(R.id.home_refresh_list_view);

        emptyLayout = (LinearLayout) view.findViewById(R.id.home_empty_layout);
        bannerEmptyView = (BannerView) view.findViewById(R.id.home_empty_banner_view);
        bannerEmptyView.setBannerHeightScale(BANNER_HEIGHT_SCALE);
    }

    private void initAdapter() {
        LayoutInflater inflater = (LayoutInflater) getActivity().getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        View headerView = inflater.inflate(R.layout.home_fragment_header, contentListView, false);
        loadHeader(headerView);

        contentListView.addHeaderView(headerView);
        classProductAdapter = new HomeClassProductAdapter(homeFloorInfos, getContext(), homeHandler);
        contentListView.setAdapter(classProductAdapter);
        footerView = inflater.inflate(R.layout.scroll_bottom_view, contentListView, false);
        contentListView.addFooterView(footerView);
    }

    private void loadHeader(View headerView) {
        bannerView = (BannerView) headerView.findViewById(R.id.home_banner_view);
        bannerView.setBannerHeightScale(BANNER_HEIGHT_SCALE);
        festivalactView = (ImageView) headerView.findViewById(R.id.festivalact_view);
        functionsGridView = (ExpandableHeightGridView) headerView.findViewById(R.id.home_functions);

        zoneLayout = (LinearLayout) headerView.findViewById(R.id.home_advert_zone_layout);
        hourView = (TextView) headerView.findViewById(R.id.home_seckill_hour_view);
        minuteView = (TextView) headerView.findViewById(R.id.home_seckill_minute_view);
        secondView = (TextView) headerView.findViewById(R.id.home_seckill_second_view);
        secKillImageView = (ImageView) headerView.findViewById(R.id.home_seckill_image_view);
        llHomeSeckillView = (LinearLayout) headerView.findViewById(R.id.ll_home_seckill_view);
        zoneFirstView = (ImageView) headerView.findViewById(R.id.home_advert_zone_first_view);
        zoneSecondView = (ImageView) headerView.findViewById(R.id.home_advert_zone_second_view);
        zoneListView = (RecyclerView) headerView.findViewById(R.id.home_advert_zone_list_view);
        initHeaderAdapter();
    }

    private void initHeaderAdapter() {
        functionsAdapter = new HomeFunctionsAdapter(functionsTitles, functionsIcon, getActivity(), mFunctionLogos);
        functionsGridView.setAdapter(functionsAdapter);
        advertZoneAdapter = new AdvertZoneAdapter(advertZoneList, getActivity());
        LinearLayoutManager layoutManager = new LinearLayoutManager(getActivity());
        layoutManager.setOrientation(LinearLayoutManager.HORIZONTAL);
        zoneListView.addItemDecoration(DefaultItemDecoration.getDefaultVertical(getActivity()));
        zoneListView.setLayoutManager(layoutManager);
        zoneListView.setAdapter(advertZoneAdapter);
    }

    @Override
    public void initListener() {
        locationLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(getActivity(), SearchActivity.class);
                intent.setAction(SearchLocationFragment.class.getSimpleName());
                startActivityForResult(intent, Constants.RequestCode.SEARCH_LOCATION_CODE);
            }
        });
        scanView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(getActivity(), ScanActivity.class);
                intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                startActivity(intent);
            }
        });
        searchView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(getActivity(), SearchActivity.class);
                intent.setAction(SearchFragment.class.getSimpleName());
                startActivity(intent);
            }
        });
        homeSearchView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(getActivity(), SearchActivity.class);
                intent.setAction(SearchFragment.class.getSimpleName());
                startActivity(intent);
            }
        });
        mHomeSearchTextView.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                if (event.getAction() == MotionEvent.ACTION_DOWN) {
                    Intent intent = new Intent(getActivity(), SearchActivity.class);
                    intent.setAction(SearchFragment.class.getSimpleName());
                    startActivity(intent);
                    return true;
                }
                return false;
            }
        });
        refreshLayout.setPtrHandler(new PtrDefaultHandler() {
            @Override
            public boolean checkCanDoRefresh(PtrFrameLayout ptrFrameLayout, View view, View view1) {
                return PtrDefaultHandler.checkContentCanBePulledDown(ptrFrameLayout, view, view1);
            }

            @Override
            public void onRefreshBegin(PtrFrameLayout ptrFrameLayout) {
                initRequest();
            }
        });
        contentListView.setOnScrollListener(new AbsListView.OnScrollListener() {
            @Override
            public void onScrollStateChanged(AbsListView absListView, int i) {
            }

            @Override
            public void onScroll(AbsListView absListView, int i, int i1, int i2) {
                if (i == 0) {
                    contentListView.getParent().requestDisallowInterceptTouchEvent(false);
                }
                if (getScrollY() >= bannerHeight || getScrollY() == -1) {
                    if (changeBgFalg)
                        return;
                    changeBgFalg = true;
                    homeSearchToolBarView.setVisibility(View.VISIBLE);
                    toolBarLayout.setVisibility(View.GONE);
                } else {
                    if (!changeBgFalg)
                        return;
                    changeBgFalg = false;
                    homeSearchToolBarView.setVisibility(View.GONE);
                    toolBarLayout.setVisibility(View.VISIBLE);
                }
            }
        });
        functionsGridView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                Intent intent;
                switch (i) {
                    case FUNCTION_MEMBER:
                        intent = new Intent(getActivity(), H5CordovaActivity.class);
                        intent.putExtra(Constants.BundleName.TYPE_AGREEMENT, Constants.RuleAgreementType.VIP_ZONE);
                        intent.setAction(ZoneFragment.class.getSimpleName());
                        startActivity(intent);
                        break;
                    case FUNCTION_GROUP_BUY:
                        if (UserUtils.isLogin()) {
                            intent = new Intent(getActivity(), RedEnvelopActivity.class);
                            intent.setAction(RedEnvelopEntranceFragment.class.getSimpleName());
                            startActivity(intent);
                        } else {
                            intent = new Intent(getActivity(), LoginActivity.class);
                            intent.setAction(LoginFragment.class.getSimpleName());
                            startActivityForResult(intent, Constants.RequestCode.ENVELOPE_LOGIN_CODE);
                        }
                        break;
                    case FUNCTION_SPECIAL:
                        intent = new Intent(getActivity(), ZoneActivity.class);
                        intent.setAction(WeeklyProductFragment.class.getSimpleName());
                        startActivity(intent);
                        break;
                    case FUNCTION_CLASSIFY:
                        ToastUtils.showShort(getActivity(), getResources().getString(R.string.no_finish));
                        break;
                }
            }
        });
        llHomeSeckillView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent;
                intent = new Intent(getActivity(), SecKillActivity.class);
                startActivity(intent);
            }
        });
    }

    @Override
    public void initHttpBack() {
        advertHttpBack = new HttpBack<List<Advertisement>>(getBaseActivity()) {
            @Override
            public void onSuccess(List<Advertisement> advertisements) {
                advertList.clear();
                advertList.addAll(advertisements);
                fillBanner(advertList);
            }
        };
        communityHttpBack = new HttpBack<Community>(getBaseActivity()) {
            @Override
            public void onSuccess(final Community community) {
                location.stopLoc();
                if (community != null) {
                    ChangeCommunityUtils.setAutoLocation(true);
                }
                // 该方法为定位得到的操作
                // 分为2种情况，第一种为启动APP第一次触发定位成功请求成功的情况，该标志可以通过手动选择小区取消或者自动定位成功以后取消
                // 该情况不用判断切换，直接清除之前的店铺购物车或者显示效果等等
                if (isFirstLoad) {
                    isFirstLoad = false;
                    if (!ChangeCommunityUtils.isSameStore(community)) {
                        CartUtils.clearCart();
                        ((MainActivity) getActivity()).flushCart();
                    }
                    CommunityUtils.setCurrentCommunity(community);
                    if (community == null || community.getStoreInfo() == null) {
                        showContent(false);
                    } else {
                        showContent(true);
                        getHomeFloorInfos();
                    }
                    if (community != null) {
                        locationNameView.setText(community.getCommunityName());
                        ZoneUtils.getZoneProducts();
                    }
                    //通知处理
                    if (isNotification) {
                        Intent intent = new Intent(getActivity(), MessageActivity.class);
                        intent.setAction(MessageFragment.class.getSimpleName());
                        startActivity(intent);
                    }
                    //判断店铺营业情况
                    ChangeCommunityUtils.notifyStoreBusiness(getActivity(), CommunityUtils.getCurrentStore());
                    getStoreScoreRequest();
                } else {// 第二种为触发过定位请求以后，中途超过一定时间后的自动定位
                    if (community == null) {
                        return;
                    }
                    ChangeCommunityUtils.changeCommunity(getActivity(), community, changeHandler);
                }
            }
        };
        homeFloorHttpBack = new HttpBack<List<HomeFloorInfo>>(getBaseActivity()) {
            @Override
            public void onSuccess(List<HomeFloorInfo> floorInfos) {
                functionsGridView.setVisibility(View.VISIBLE);
                zoneLayout.setVisibility(View.VISIBLE);
                homeFloorInfos.clear();
                refreshLayout.refreshComplete();
                if (floorInfos == null || floorInfos.size() == 0) {
                    showContent(false);
                    return;
                }
                homeFloorInfos.addAll(floorInfos);
                showContent(true);

                for (HomeFloorInfo homeFloorInfo : floorInfos) {//显示本地保存的购物车数据
                    if (homeFloorInfo.getFloorInfo() == null) {
                        continue;
                    }
                    CartUtils.calculateProductNum(homeFloorInfo.getFloorInfo().getFloorProductList());
                }
                classProductAdapter.notifyDataSetChanged();

                // 同时刷新广告信息数据
                secKillAdvertRequest();
                seminarAdvertRequest();
                secKillInfoRequest();

                //同步购物车
                if (UserUtils.isLogin() && !CartUtils.getSynchronizeCartFlag()) {
                    requestCart();
                }
            }

            @Override
            public void onFailure(String msg) {
                super.onFailure(msg);
                refreshLayout.refreshComplete();
            }

            @Override
            public void onTimeOut() {
                super.onTimeOut();
                refreshLayout.refreshComplete();
            }
        };
        cartHttpBack = new HttpBack<List<SaleProduct>>(getBaseActivity()) {
            @Override
            public void onSuccess(List<SaleProduct> cartInfos) {
                CartUtils.setCartInfo(cartInfos);
                CartUtils.synchronizeCartFlag(true);
            }
        };
        functionLogoHttpBack = new HttpBack<List<FunctionLogo>>(getBaseActivity()) {
            @Override
            public void onSuccess(List<FunctionLogo> logoLists) {
                mFunctionLogos.clear();
                if (logoLists == null || logoLists.size() == 0) {
                    return;
                }
                mFunctionLogos.addAll(logoLists);
                functionsAdapter.notifyDataSetChanged();
            }
        };
        secKillHttpBack = new HttpBack<ActSecKill>() {
            @Override
            public void onSuccess(ActSecKill seckill) {
                actSecKill = seckill;
                if (actSecKill != null) {
                    timeLocalBetweenServer = DateUtils.secondsBetweenNow(actSecKill.getSystemTime());
                }
                calculateSecKillInfo();
            }
        };
        secKillAdvertHttpBack = new HttpBack<List<Advertisement>>() {
            @Override
            public void onSuccess(List<Advertisement> advertisements) {
                secKillAdvertisements = advertisements;
                if (secKillAdvertisements != null && secKillAdvertisements.size() > 0) {
                    ImageLoaderUtils.loadNoneBG(secKillImageView, secKillAdvertisements.get(0).getImageUrl());
                }
            }
        };
        seminarAdvertHttpBack = new HttpBack<List<Advertisement>>() {
            @Override
            public void onSuccess(List<Advertisement> advertisements) {
                advertZoneList.clear();
                if (advertisements != null && advertisements.size() > 0) {
                    zoneListView.setVisibility(advertisements.size() <= 2 ? View.GONE : View.VISIBLE);
                    final Advertisement firstAdvert = advertisements.remove(0);
                    ImageLoaderUtils.load(zoneFirstView, firstAdvert.getImageUrl());
                    zoneFirstView.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            JumpUtils.jump(getActivity(), firstAdvert.getLinkType(), firstAdvert.getLinkData());
                        }
                    });
                    if (advertisements.size() == 0) {
                        return;
                    }
                    final Advertisement secondAdvert = advertisements.remove(0);
                    ImageLoaderUtils.load(zoneSecondView, secondAdvert.getImageUrl());
                    zoneSecondView.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            JumpUtils.jump(getActivity(), secondAdvert.getLinkType(), secondAdvert.getLinkData());
                        }
                    });
                    advertZoneList.addAll(advertisements);
                    advertZoneAdapter.notifyDataSetChanged();
                } else {
                    zoneListView.setVisibility(View.GONE);
                }
            }
        };
        festivalactHttpBack = new HttpBack<List<Advertisement>>() {
            @Override
            public void onSuccess(List<Advertisement> advertisements) {
                festivalactAdvertisement = advertisements;
                if (festivalactAdvertisement != null && festivalactAdvertisement.size() == 1) {
                    final Advertisement advertisement = festivalactAdvertisement.get(0);
                    ImageLoaderUtils.load(festivalactView, advertisement.getImageUrl(), com.yldbkd.www.library.android.R.drawable.no_picture_rect);
                    festivalactView.setVisibility(View.VISIBLE);

                    festivalactView.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            JumpUtils.jump(getActivity(), advertisement.getLinkType(), advertisement.getLinkData());
                        }
                    });
                } else {
                    festivalactView.setVisibility(View.GONE);
                }
            }

            @Override
            public void onFailure(String msg) {
                festivalactView.setVisibility(View.GONE);
            }

            @Override
            public void onTimeOut() {
                festivalactView.setVisibility(View.GONE);
            }
        };
        storeInfotHttpBack = new HttpBack<Store>(getBaseActivity()) {
            @Override
            public void onSuccess(Store store) {
                CommunityUtils.setCurrentStore(store);
            }
        };
    }

    @Override
    public void initRequest() {
        if (advertList.size() == 0) {
            advertRequest();
            functionLogoRequest();
        }
        getLocationAddress();
    }

    private void getLocationAddress() {
        //定位
        if (CommunityUtils.getCurrentStoreId() == null) {
            location.init(getActivity(), 20 * 1000);
            location.registerLocationListener(new LocationListener());
        } else {
            getHomeFloorInfos();
        }
        getFestivalactAdvertising();
    }

    public void requestCart() {
        Map<String, Object> map = new HashMap<>();
        map.put("cartInfo", CartUtils.getCartInfo());
        map.put("storeId", CommunityUtils.getCurrentStoreId());
        RetrofitUtils.getInstance(true).synchronizeCart(ParamUtils.getParam(map), cartHttpBack);
    }

    private void getStoreScoreRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("storeId", CommunityUtils.getCurrentStoreId());
        RetrofitUtils.getInstance().getStoreInformation(ParamUtils.getParam(map), storeInfotHttpBack);
    }

    private class LocationListener implements BDLocationListener {

        @Override
        public void onReceiveLocation(BDLocation bdLocation) {
            Logger.d("定位结束：" + bdLocation.getLocType());
            if (bdLocation.getLocType() == BDLocation.TypeGpsLocation
                    || bdLocation.getLocType() == BDLocation.TypeOffLineLocation
                    || bdLocation.getLocType() == BDLocation.TypeNetWorkLocation) {
                Logger.d("定位成功：" + bdLocation.getLatitude() + " - " + bdLocation.getLongitude() + " ，精度：" +
                        bdLocation.getRadius());
                CommunityUtils.setLongitude(bdLocation.getLongitude());
                CommunityUtils.setLatitude(bdLocation.getLatitude());
                locationRequest(bdLocation.getLatitude(), bdLocation.getLongitude());
                if (advertList.size() == 0) {
                    advertRequest();
                    functionLogoRequest();
                }
            } else {
                refreshLayout.refreshComplete();
            }
        }
    }

    /**
     * 定位请求
     */
    private void locationRequest(double latitude, double longitude) {
        Map<String, Object> map = new HashMap<>();
        map.put("latitude", latitude);
        map.put("longitude", longitude);
        RetrofitUtils.getInstance(isFirstLoad).getLocation(ParamUtils.getParam(map), communityHttpBack);
    }

    /**
     * 楼层信息请求
     */
    private void getHomeFloorInfos() {
        Map<String, Object> map = new HashMap<>();
        map.put("storeId", CommunityUtils.getCurrentStoreId());
        RetrofitUtils.getInstance(true).homeFloors(ParamUtils.getParam(map), homeFloorHttpBack);
    }

    /**
     * 首页广告Banner请求
     */
    private void advertRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("type", Constants.BannerType.HOME_BANNER);
        RetrofitUtils.getInstance().getAdverts(ParamUtils.getParam(map), advertHttpBack);
    }

    /**
     * 首页节日活动广告请求
     */
    private void getFestivalactAdvertising() {
        Map<String, Object> map = new HashMap<>();
        map.put("type", Constants.BannerType.HOME_FESTIVALACT);
        RetrofitUtils.getInstance().getAdverts(ParamUtils.getParam(map), festivalactHttpBack);
    }

    /**
     * 首页秒杀广告请求
     */
    private void secKillAdvertRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("type", Constants.BannerType.HOME_SECKILL);
        RetrofitUtils.getInstance().getAdverts(ParamUtils.getParam(map), secKillAdvertHttpBack);
    }

    /**
     * 首页专题广告请求
     */
    private void seminarAdvertRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("type", Constants.BannerType.HOME_SEMINAR);
        RetrofitUtils.getInstance().getAdverts(ParamUtils.getParam(map), seminarAdvertHttpBack);
    }

    /**
     * 查询当前的秒杀活动信息
     */
    private void secKillInfoRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("storeId", CommunityUtils.getCurrentStoreId());
        RetrofitUtils.getInstance().seckillInfo(ParamUtils.getParam(map), secKillHttpBack);
    }

    /**
     * 查询首页4大功能图标
     */
    private void functionLogoRequest() {
        RetrofitUtils.getInstance().getFunctionLogo(ParamUtils.getParam(null), functionLogoHttpBack);
    }

    private void showContent(boolean isContent) {
        if (isContent) {
            emptyLayout.setVisibility(View.GONE);
            bannerEmptyView.setVisibility(View.GONE);
            refreshLayout.setVisibility(View.VISIBLE);
            contentListView.setVisibility(View.VISIBLE);
            footerView.setVisibility(View.VISIBLE);
        } else {
            emptyLayout.setVisibility(View.VISIBLE);
            bannerEmptyView.setVisibility(View.VISIBLE);
            refreshLayout.setVisibility(View.GONE);
            contentListView.setVisibility(View.GONE);
            footerView.setVisibility(View.GONE);
        }
        start();
    }

    private void fillBanner(final List<Advertisement> advertList) {
        BannerViewAdapter adapter = new BannerViewAdapter<Advertisement>(
                bannerView.getContext(), advertList) {
            @Override
            public void jumpTo(int position) {
                Advertisement ad = advertList.get(position % advertList.size());
                advertJump(ad);
            }
        };
        bannerView.setAdapter(adapter, advertList);
        bannerView.startPlay();
        BannerViewAdapter emptyAdapter = new BannerViewAdapter<Advertisement>(
                bannerEmptyView.getContext(), advertList) {
            @Override
            public void jumpTo(int position) {
                Advertisement ad = advertList.get(position % advertList.size());
                advertJump(ad);
            }
        };
        bannerEmptyView.setAdapter(emptyAdapter, advertList);
        bannerEmptyView.startPlay();
    }

    private void advertJump(Advertisement ad) {
        JumpUtils.jump(getActivity(), ad.getLinkType(), ad.getLinkData());
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (Constants.RequestCode.SEARCH_LOCATION_CODE == requestCode) {
            if (resultCode == Activity.RESULT_OK) {
                Double latitude = data.getDoubleExtra(Constants.BundleName.LOCATION_LATITUDE, 0);
                Double longitude = data.getDoubleExtra(Constants.BundleName.LOCATION_LONGITUDE, 0);
                locationRequest(latitude, longitude);
            }
            if (resultCode == Activity.RESULT_FIRST_USER) {
                int what = data.getIntExtra(Constants.BundleName.CHANGE_COMMUNITY_CHOICE, Constants.HandlerCode.CHANGE_COMMUNITY_NORMAL);
                changeHandler.obtainMessage(what).sendToTarget();
                ChangeCommunityUtils.setAutoLocation(false);
            }
        }
        if (Constants.RequestCode.ENVELOPE_LOGIN_CODE == requestCode && resultCode == Activity.RESULT_OK) {
            Intent intent = new Intent(getActivity(), RedEnvelopActivity.class);
            intent.setAction(RedEnvelopEntranceFragment.class.getSimpleName());
            startActivity(intent);
        }
    }

    private static class HomeHandler extends Handler {
        WeakReference<HomeFragment> fragmentWeakReference;

        public HomeHandler(HomeFragment fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(@NonNull Message msg) {
            HomeFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            switch (msg.what) {
                case Constants.HandlerCode.PRODUCT_PLUS:
                    HomeFloorInfo homeFloorInfo = fragment.homeFloorInfos.get(msg.arg1);
                    SaleProduct product = homeFloorInfo.getFloorInfo().getFloorProductList().get(msg.arg2);
                    CartUtils.validateOperationCart(fragment.getActivity(), product, this, msg.obj);
                    break;
                case Constants.HandlerCode.CART_SUCCESS:
                    if (fragment.cartHandler != null) {
                        fragment.cartHandler.obtainMessage(Constants.HandlerCode.PRODUCT_PLUS, msg.obj).sendToTarget();
                    }
                    for (HomeFloorInfo homeFloorInfo1 : fragment.homeFloorInfos) {
                        if (homeFloorInfo1.getFloorInfo() == null) {
                            continue;
                        }
                        CartUtils.calculateProductNum(homeFloorInfo1.getFloorInfo().getFloorProductList());
                    }
                    fragment.classProductAdapter.notifyDataSetChanged();
                    break;
                case Constants.HandlerCode.PRODUCT_MINUS:
                    homeFloorInfo = fragment.homeFloorInfos.get(msg.arg1);
                    product = homeFloorInfo.getFloorInfo().getFloorProductList().get(msg.arg2);
                    product.setCartNum(product.getCartNum() - 1);
                    CartUtils.removeCart(product);
                    CartUtils.calculateProductNum(product);
                    if (fragment.cartHandler != null) {
                        fragment.cartHandler.obtainMessage(Constants.HandlerCode.PRODUCT_MINUS).sendToTarget();
                    }
                    fragment.classProductAdapter.notifyDataSetChanged();
                    break;
                case Constants.HandlerCode.PRODUCT_DETAIL:
                    homeFloorInfo = fragment.homeFloorInfos.get(msg.arg1);
                    product = homeFloorInfo.getFloorInfo().getFloorProductList().get(msg.arg2);
                    Intent intent = new Intent(fragment.getActivity(), ProductActivity.class);
                    intent.putExtra(Constants.BundleName.SALE_PRODUCT_ID, product.getSaleProductId());
                    fragment.startActivity(intent);
                    break;
            }
        }
    }

    private static class ChangeHandler extends Handler {
        WeakReference<HomeFragment> fragmentWeakReference;

        public ChangeHandler(HomeFragment fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(@NonNull Message msg) {
            HomeFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            fragment.locationNameView.setText(CommunityUtils.getIsTokeByMyself()
                    ? String.format(fragment.getResources().getString(R.string.home_store_name), CommunityUtils.getCurrentStore().getStoreName())
                    : CommunityUtils.getCurrentCommunityName());
            ChangeCommunityUtils.notifyStoreBusiness(fragment.getActivity(), CommunityUtils.getCurrentStore());
            switch (msg.what) {
                case Constants.HandlerCode.CHANGE_COMMUNITY_EMPTY:
                    fragment.showContent(false);
                    ZoneUtils.getZoneProducts();
                    break;
                case Constants.HandlerCode.CHANGE_COMMUNITY_STORE_DIFF:
                    fragment.showContent(true);
                    fragment.getHomeFloorInfos();
                    ZoneUtils.getZoneProducts();
                    //手动切换店铺
                    fragment.getStoreScoreRequest();
                    break;
            }
        }
    }

    private void calculateSecKillInfo() {
        if (actSecKill == null) {
            return;
        }
        String notTime = DateUtils.parseDate(System.currentTimeMillis() + timeLocalBetweenServer);
        long duration = DateUtils.secondsBetween(notTime, actSecKill.getEndTime());
        if (duration > 0) {
            if (secKillCountDown != null) {
                secKillCountDown.cancel();
            }
            secKillCountDown = new CountDown(duration, SECOND, countDownHandler);
            secKillCountDown.start();
        } else {
            secKillInfoRequest();
        }
    }

    private static class CountDownHandler extends Handler {
        WeakReference<HomeFragment> fragmentWeakReference;

        public CountDownHandler(HomeFragment fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(@NonNull Message msg) {
            HomeFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            switch (msg.what) {
                case CountDown.COUNT_DOWN_TIMER:
                    long millisUntilFinished = (long) msg.obj;
                    fragment.hourView.setText(DateUtils.getHour(millisUntilFinished));
                    fragment.minuteView.setText(DateUtils.getMinute(millisUntilFinished));
                    fragment.secondView.setText(DateUtils.getSecond(millisUntilFinished));
                    if (fragment.secKillAdvertisements != null) {
                        int size = fragment.secKillAdvertisements.size();
                        if (size > 1) {
                            long count = millisUntilFinished / IMAGE_CHANGE_INTERVAL;
                            if (fragment.timeCount != count) {
                                fragment.timeCount = count;
                                int index = (int) (count % size);
                                ImageLoaderUtils.loadNoneBG(fragment.secKillImageView,
                                        fragment.secKillAdvertisements.get(index).getImageUrl());
                            }
                        }
                    }
                    break;
                case CountDown.COUNT_DOWN_FINISH:
                    fragment.secKillInfoRequest();
                    break;
            }
        }
    }

    public void setCartHandler(Handler cartHandler) {
        this.cartHandler = cartHandler;
    }

    @Override
    public void setUserVisibleHint(boolean isVisibleToUser) {
        super.setUserVisibleHint(isVisibleToUser);
        isViewShown = getView() != null;
        this.isVisibleToUser = isVisibleToUser;
        if (isVisibleToUser && isViewShown) {
            flushProductInfo();
            start();
            if (ChangeCommunityUtils.isTimeToChange()) {
                if (CommunityUtils.isInitLocation() && CommunityUtils.getLatitude() != null
                        && CommunityUtils.getLongitude() != null) {
                    CommunityUtils.setInitLocation(false);
                    locationRequest(CommunityUtils.getLatitude(), CommunityUtils.getLongitude());
                } else {
                    location.startLoc();
                }
            }
            if (!ZoneUtils.isSuccess()) {
                ZoneUtils.getZoneProducts();
            }
            calculateSecKillInfo();
        } else {
            stop();
        }
    }

    public int getScrollY() {
        View c = contentListView.getChildAt(0);
        if (c == null) {
            return 0;
        }
        int firstVisiblePosition = contentListView.getFirstVisiblePosition();
        int top = c.getTop();
        return firstVisiblePosition > 0 ? -1 : -top;//仅判断第一个item是否改变title_bar
    }

    public int getListViewScrollY() {
        View c = contentListView.getChildAt(0);
        if (c == null) {
            return 0;
        }
        int firstVisiblePosition = contentListView.getFirstVisiblePosition();
        int top = c.getTop();
        int height = c.getHeight();
        if (firstVisiblePosition == 0) {//刚刚进入页面得到的第一个item高度不准确
            totalHeight = 0;
            beforeItemHeight = height;
        } else {
            if (oldItem < firstVisiblePosition) {
                totalHeight += beforeItemHeight;
                beforeItemHeight = height;
            } else if (oldItem > firstVisiblePosition) {
                beforeItemHeight = height;
                totalHeight -= beforeItemHeight;
            }
        }
        oldItem = firstVisiblePosition;
        return -top + totalHeight;
    }

    private void flushProductInfo() {
        if (classProductAdapter == null) {
            return;
        }
        for (HomeFloorInfo homeFloorInfo : homeFloorInfos) {
            if (homeFloorInfo.getFloorInfo() == null) {
                continue;
            }
            CartUtils.calculateProductNum(homeFloorInfo.getFloorInfo().getFloorProductList());
        }
        classProductAdapter.notifyDataSetChanged();
    }

    @Override
    public void onResume() {
        super.onResume();
        setUserVisibleHint(isVisibleToUser);
    }

    @Override
    public void onPause() {
        super.onPause();
        stop();
    }

    private void start() {
        if (contentListView.getVisibility() == View.VISIBLE) {
            bannerView.startPlay();
        }
        if (emptyLayout.getVisibility() == View.VISIBLE) {
            bannerEmptyView.startPlay();
        }
    }

    private void stop() {
        if (bannerView != null) {
            bannerView.stopPlay();
        }
        if (bannerEmptyView != null) {
            bannerEmptyView.stopPlay();
        }
        if (location != null) {
            location.stopLoc();
        }
        if (secKillCountDown != null) {
            secKillCountDown.cancel();
        }
    }
}
