package com.yldbkd.www.seller.android.fragment;

import android.content.Intent;
import android.support.v4.content.ContextCompat;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.MoneyUtils;
import com.yldbkd.www.library.android.common.TextChangeUtils;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.activity.ClassificationActivity;
import com.yldbkd.www.seller.android.activity.ConnectActivity;
import com.yldbkd.www.seller.android.activity.InviteActivity;
import com.yldbkd.www.seller.android.activity.LoginActivity;
import com.yldbkd.www.seller.android.activity.OrderListActivity;
import com.yldbkd.www.seller.android.activity.StatisticsActivity;
import com.yldbkd.www.seller.android.activity.StoreActivity;
import com.yldbkd.www.seller.android.adapter.BaseAdapter;
import com.yldbkd.www.seller.android.adapter.MainCatalogAdapter;
import com.yldbkd.www.seller.android.bean.StoreBase;
import com.yldbkd.www.seller.android.bean.StoreDataStatistics;
import com.yldbkd.www.seller.android.bean.SummerizeTotal;
import com.yldbkd.www.seller.android.utils.UserUtils;
import com.yldbkd.www.seller.android.utils.http.HttpBack;
import com.yldbkd.www.seller.android.utils.http.ParamUtils;
import com.yldbkd.www.seller.android.utils.http.RetrofitUtils;
import com.yldbkd.www.seller.android.viewCustomer.DefaultItemDecoration;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 合伙人首页页面
 * <p/>
 * Created by linghuxj on 16/5/30.
 */
public class MainFragment extends BaseFragment {

    private static final int[] CATALOG_IMAGE_IDS = {R.mipmap.main_order_manage,
            R.mipmap.main_product_manage, R.mipmap.main_store_manage,
            R.mipmap.main_store_invite, R.mipmap.main_connect};
    private static final int[] CATALOG_NAMES = {R.string.main_catalog_order,
            R.string.main_catalog_product, R.string.main_catalog_store,
            R.string.main_catalog_invite, R.string.main_connect};
    private static final int[] CATALOG_REMARKS = {R.string.main_catalog_order_remark,
            R.string.main_catalog_product_remark, R.string.main_catalog_store_remark,
            R.string.main_catalog_invite_remark, R.string.main_connect_desc};
    private static final Class[] CATALOG_ACTIVITIES = {OrderListActivity.class,
            ClassificationActivity.class, StoreActivity.class,
            InviteActivity.class, ConnectActivity.class};
    private static final String[] CATALOG_FRAGMENTS = {null, ClassificationTabFragment.class.getSimpleName(),
            ProfileFragment.class.getSimpleName(), InviteCodeFragment.class.getSimpleName(),
            null};

    private TextView storeNameView;
    private TextView userNameView;
    private TextView businessView;

    private Button featruesBtn;
    private Button billBtn;
    private ImageView billBtnBg;
    private ImageView featruesBtnBg;

    private RecyclerView catalogView;
    private MainCatalogAdapter adapter;
    private List<MainCatalogAdapter.Catalog> catalogs = new ArrayList<>();

    private View billSettlementContent;
    private RelativeLayout mLlStatistics;

    private HttpBack<StoreDataStatistics> statisticsHttpBack;
    //账单
    private HttpBack<SummerizeTotal> summerizeTotalHttpBack;
    private TextView mOrderTotalCountToday, mOrderTotalAmtToday, mSettledInviteCount, mSettledInviteAmt;
    private TextView mShouldSettleOrderCount, mShouldSettleOrderAmt, mSettleOrderCount, mSettleOrderAmt;
    private TextView mInviteVipCountToday, mInviteVipAmtToday, mShouldSettleInviteCount, mShouldSettleInviteAmt;

    @Override
    public int setLayoutId() {
        return R.layout.fragment_main;
    }

    @Override
    public void initHttpBack() {
        statisticsHttpBack = new HttpBack<StoreDataStatistics>() {
            @Override
            public void onSuccess(StoreDataStatistics storeDataStatistics) {
            }

            @Override
            public void onNoLogin() {
                super.onNoLogin();
                Intent intent = new Intent(getActivity(), LoginActivity.class);
                intent.setAction(LoginFragment.class.getSimpleName());
                startActivity(intent);
            }
        };
        summerizeTotalHttpBack = new HttpBack<SummerizeTotal>() {
            @Override
            public void onSuccess(SummerizeTotal summerizeTotal) {
                List<Integer> priceStyles = new ArrayList<>();
                priceStyles.add(R.style.TextAppearance_Large_Red);
                priceStyles.add(R.style.TextAppearance_Normal);
                List<Integer> countStyles = new ArrayList<>();
                countStyles.add(R.style.TextAppearance_Large);
                countStyles.add(R.style.TextAppearance_Normal);
                TextChangeUtils.setDifferentText(getActivity(), mOrderTotalCountToday, R.string.main_total_sum,
                        countStyles, summerizeTotal.getOrderTotalCountToday(), getResources().getString(R.string.main_count_unit));
                TextChangeUtils.setDifferentText(getActivity(), mOrderTotalAmtToday, R.string.main_total_money,
                        priceStyles, MoneyUtils.toPrice(summerizeTotal.getOrderTotalAmtToday()), getResources().getString(R.string.main_money_unit));
                TextChangeUtils.setDifferentText(getActivity(), mShouldSettleOrderCount, R.string.main_total_sum,
                        countStyles, summerizeTotal.getShouldSettleOrderCount(), getResources().getString(R.string.main_count_unit));
                TextChangeUtils.setDifferentText(getActivity(), mShouldSettleOrderAmt, R.string.main_total_money,
                        countStyles, MoneyUtils.toPrice(summerizeTotal.getShouldSettleOrderAmt()), getResources().getString(R.string.main_money_unit));
                TextChangeUtils.setDifferentText(getActivity(), mSettleOrderCount, R.string.main_total_sum,
                        countStyles, summerizeTotal.getSettledOrderCount(), getResources().getString(R.string.main_count_unit));
                TextChangeUtils.setDifferentText(getActivity(), mSettleOrderAmt, R.string.main_total_money,
                        countStyles, MoneyUtils.toPrice(summerizeTotal.getSettledOrderAmt()), getResources().getString(R.string.main_money_unit));
                TextChangeUtils.setDifferentText(getActivity(), mInviteVipCountToday, R.string.main_total_count,
                        countStyles, summerizeTotal.getInviteVIPCountToday(), getResources().getString(R.string.main_people_unit));
                TextChangeUtils.setDifferentText(getActivity(), mInviteVipAmtToday, R.string.main_total_money,
                        countStyles, MoneyUtils.toPrice(summerizeTotal.getInviteVIPAmtToday()), getResources().getString(R.string.main_money_unit));
                TextChangeUtils.setDifferentText(getActivity(), mShouldSettleInviteCount, R.string.main_total_count,
                        countStyles, summerizeTotal.getSettledInviteCount(), getResources().getString(R.string.main_people_unit));
                TextChangeUtils.setDifferentText(getActivity(), mShouldSettleInviteAmt, R.string.main_total_money,
                        countStyles, MoneyUtils.toPrice(summerizeTotal.getSettledInviteAmt()), getResources().getString(R.string.main_money_unit));
                TextChangeUtils.setDifferentText(getActivity(), mSettledInviteCount, R.string.main_total_count,
                        countStyles, summerizeTotal.getSettledInviteCount(), getResources().getString(R.string.main_people_unit));
                TextChangeUtils.setDifferentText(getActivity(), mSettledInviteAmt, R.string.main_total_money,
                        priceStyles, MoneyUtils.toPrice(summerizeTotal.getSettledInviteAmt()), getResources().getString(R.string.main_money_unit));
            }

            @Override
            public void onFailure(String msg) {
            }

            @Override
            public void onTimeOut() {
            }

            @Override
            public void onNoLogin() {
                super.onNoLogin();
                Intent intent = new Intent(getActivity(), LoginActivity.class);
                intent.setAction(LoginFragment.class.getSimpleName());
                startActivity(intent);
            }
        };
    }

    @Override
    public void initView(View view) {
        storeNameView = (TextView) view.findViewById(R.id.tv_main_store_name);
        userNameView = (TextView) view.findViewById(R.id.tv_user_name);
        businessView = (TextView) view.findViewById(R.id.tv_store_business);

        featruesBtn = (Button) view.findViewById(R.id.choose_featrues);
        featruesBtnBg = (ImageView) view.findViewById(R.id.choose_featrues_bg);
        billBtn = (Button) view.findViewById(R.id.choose_bill);
        billBtnBg = (ImageView) view.findViewById(R.id.choose_bill_bg);

        catalogView = (RecyclerView) view.findViewById(R.id.rv_catalog);
        billSettlementContent = view.findViewById(R.id.bill_settlement_content);
        //账单结算
        mOrderTotalCountToday = (TextView) view.findViewById(R.id.order_total_count_today);
        mOrderTotalAmtToday = (TextView) view.findViewById(R.id.order_total_amt_today);
        mShouldSettleOrderCount = (TextView) view.findViewById(R.id.should_settle_order_count);
        mShouldSettleOrderAmt = (TextView) view.findViewById(R.id.should_settle_order_amt);
        mSettleOrderCount = (TextView) view.findViewById(R.id.settled_order_count);
        mSettleOrderAmt = (TextView) view.findViewById(R.id.settled_order_amt);
        mInviteVipCountToday = (TextView) view.findViewById(R.id.invite_vip_count_today);
        mInviteVipAmtToday = (TextView) view.findViewById(R.id.invite_vip_amt_today);
        mShouldSettleInviteCount = (TextView) view.findViewById(R.id.should_settle_invite_count);
        mShouldSettleInviteAmt = (TextView) view.findViewById(R.id.should_settle_invite_amt);
        mSettledInviteCount = (TextView) view.findViewById(R.id.settled_invite_count);
        mSettledInviteAmt = (TextView) view.findViewById(R.id.settled_invite_amt);

        mLlStatistics = (RelativeLayout) view.findViewById(R.id.ll_statistics);
    }

    @Override
    public void initAdapter() {
        LinearLayoutManager manager = new LinearLayoutManager(getActivity());
        manager.setOrientation(LinearLayoutManager.VERTICAL);
        setupCatalogData();
        adapter = new MainCatalogAdapter(getContext(), catalogs);
        catalogView.setLayoutManager(manager);
        catalogView.setAdapter(adapter);
        catalogView.addItemDecoration(DefaultItemDecoration.getDefault(getActivity()));
    }

    @Override
    public void initData() {
        StoreBase store = UserUtils.getStore();
        userNameView.setText(String.format(getString(R.string.main_user_name), store.getUserName()));
        storeNameView.setText(String.format(getString(R.string.main_store_name), store.getStoreName(),
                store.getAddressDetail()));
        businessView.setText(String.format(getString(R.string.main_business), store.getBeginBusinessHours().substring(0, 5),
                store.getEndBusinessHours().substring(0, 5)));
    }

    @Override
    public void initListener() {
        adapter.setOnItemClickListener(new BaseAdapter.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int position) {
                Intent intent = new Intent(getActivity(), CATALOG_ACTIVITIES[position]);
                intent.setAction(CATALOG_FRAGMENTS[position]);
                startActivity(intent);
            }
        });
        featruesBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                catalogView.setVisibility(View.VISIBLE);
                billSettlementContent.setVisibility(View.GONE);
                featruesBtn.setTextColor(ContextCompat.getColor(getActivity(), R.color.primaryText));
                billBtn.setTextColor(ContextCompat.getColor(getActivity(), R.color.secondaryText));
                featruesBtnBg.setVisibility(View.VISIBLE);
                billBtnBg.setVisibility(View.GONE);
            }
        });
        billBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                catalogView.setVisibility(View.GONE);
                billSettlementContent.setVisibility(View.VISIBLE);
                featruesBtn.setTextColor(ContextCompat.getColor(getActivity(), R.color.secondaryText));
                billBtn.setTextColor(ContextCompat.getColor(getActivity(), R.color.primaryText));
                featruesBtnBg.setVisibility(View.GONE);
                billBtnBg.setVisibility(View.VISIBLE);
            }
        });
        mLlStatistics.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(getActivity(), StatisticsActivity.class);
                intent.setAction(StatisticsFragment.class.getSimpleName());
                startActivity(intent);
            }
        });
    }

    @Override
    public void onResume() {
        super.onResume();
        statisticsRequest();
        summerizeTotalRequest();
    }

    private void statisticsRequest() {
        Map<String, Object> map = new HashMap<>();
        map.put("dataTypeString", "1111");
        RetrofitUtils.getInstance().indexStatistics(ParamUtils.getParam(map), statisticsHttpBack);
    }

    private void summerizeTotalRequest() {
        RetrofitUtils.getInstance().getSummerizeTotal(ParamUtils.getParam(null), summerizeTotalHttpBack);
    }

    private void setupCatalogData() {
        if (catalogs.size() != 0) {
            return;
        }
        for (int i = 0; i < CATALOG_IMAGE_IDS.length; i++) {
            MainCatalogAdapter.Catalog catalog = new MainCatalogAdapter.Catalog();
            catalog.imageResourceId = CATALOG_IMAGE_IDS[i];
            catalog.catalogName = CATALOG_NAMES[i];
            catalog.catalogRemark = CATALOG_REMARKS[i];
            catalog.clazzActivity = CATALOG_ACTIVITIES[i];
            catalog.fragmentSimpleName = CATALOG_FRAGMENTS[i];
            catalogs.add(catalog);
        }
    }
}
