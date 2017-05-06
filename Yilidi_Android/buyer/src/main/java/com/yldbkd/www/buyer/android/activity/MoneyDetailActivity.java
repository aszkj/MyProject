package com.yldbkd.www.buyer.android.activity;

import android.os.Bundle;
import android.os.Handler;
import android.support.v4.app.Fragment;
import android.view.View;
import android.widget.ListView;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.adapter.AccountListAdapter;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.bean.Community;
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
 * @创建时间 2016/10/22 11:37
 * @描述 余额详情
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class MoneyDetailActivity extends BaseActivity {
    private View mBackView;
    private TextView mTitleTV;
    private TextView mAccountMoneyTv;
    private TextView mAccountContent;
    private TextView mAccountFalg;

    private PullToRefreshListView refreshListView;
    private ListView accountListView;
    private List<Community> mLocationLists = new ArrayList<>();
    private AccountListAdapter accountAdapter;
    public Handler refreshHandler = new RefreshHandler(this);
    private Integer pageNum = 1;
    private Integer totalPages;
    private HttpBack<Page<Community>> accountListHttpBack;
    private int mAccountType;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.account_balance_activity);
        mAccountType = getIntent().getIntExtra(Constants.BundleName.ACCOUNTTYPE, Constants.AccountType.MONEY);

        initView();
        initData();
        initListener();
        initHttpBack();
        initRequest();
    }

    private void initView() {
        mBackView = findViewById(R.id.back_view);
        mTitleTV = (TextView) findViewById(R.id.title_view);

        mAccountMoneyTv = (TextView) findViewById(R.id.account_money_tv);
        mAccountContent = (TextView) findViewById(R.id.account_content);
        mAccountFalg = (TextView) findViewById(R.id.account_falg);
        refreshListView = (PullToRefreshListView) findViewById(R.id.account_list_layout);
        accountListView = refreshListView.getRefreshableView();
    }

    public void initData() {
        boolean isMoney = mAccountType == Constants.AccountType.MONEY;
        mTitleTV.setText(getText(isMoney ? R.string.account_balance_content : R.string.account_lm_content));
        mAccountContent.setText(getText(isMoney ? R.string.money_content : R.string.lm_content));
        mAccountFalg.setText(getText(isMoney ? R.string.account_balance : R.string.account_lm));
        ToastUtils.show(this, isMoney ? "点击余额" : "点击里米");

        //网络请求成功以后显示
        mAccountMoneyTv.setText(String.valueOf("10.00"));

        initAdapter();

        initRequest();
    }

    private void initHttpBack() {
        accountListHttpBack = new HttpBack<Page<Community>>(this) {
            @Override
            public void onSuccess(Page<Community> locationList) {
                if (locationList == null) {
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
                    refreshListView.setVisibility(View.GONE);
                } else {
                    refreshListView.setVisibility(View.VISIBLE);
                }
                pageNum = locationList.getPageNum() + 1;
                totalPages = locationList.getTotalPages();
                accountAdapter.notifyDataSetChanged();
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

    public void initRequest() {
        //TODO 请求优惠券数据 刷新adapter
        //TODO 有数据显示,
    }

    public void initListener() {
        mBackView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                onBackPressed();
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
                    ToastUtils.show(MoneyDetailActivity.this, R.string.pull_up_no_more_data);
                    return;
                }
                request(pageNum);
            }
        });
    }
    private void request(int pageNum) {
        Map<String, Object> map = new HashMap<>();
        map.put("pageNum", pageNum);
        map.put("pageSize", Constants.PAGE_SIZE);
        RetrofitUtils.getInstance().getLocationList(ParamUtils.getParam(map), accountListHttpBack);
    }

    private void initAdapter() {
        accountAdapter = new AccountListAdapter(mLocationLists, this);
        accountListView.setAdapter(accountAdapter);
    }

    static class RefreshHandler extends Handler {
        private WeakReference<MoneyDetailActivity> orderWeakReference;

        public RefreshHandler(MoneyDetailActivity activity) {
            this.orderWeakReference = new WeakReference<>(activity);
        }

        @Override
        public void dispatchMessage(android.os.Message msg) {
            MoneyDetailActivity activity = orderWeakReference.get();
            if (activity == null) {
                return;
            }
            if (msg.what == Constants.HandlerCode.REFRESH_LIST) {
                activity.refreshListView.onRefreshComplete();
            }
        }
    }

    @Override
    public Fragment newFragmentByTag(String tag) {
        return null;
    }

}
