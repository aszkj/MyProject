package com.yldbkd.www.seller.android.fragment;

import android.os.Handler;
import android.os.Message;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.TextChangeUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.pullRefresh.RefreshLayout;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.adapter.InviteRecordAdapter;
import com.yldbkd.www.seller.android.bean.InvitationUser;
import com.yldbkd.www.seller.android.bean.Page;
import com.yldbkd.www.seller.android.bean.StoreDataStatistics;
import com.yldbkd.www.seller.android.utils.Constants;
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
 * 邀请用户信息列表页面
 * <p/>
 * Created by linghuxj on 16/5/30.
 */
public class InviteListFragment extends BaseFragment {

    private LinearLayout backView;

    private TextView totalView;

    private RefreshLayout refreshLayout;
    private RecyclerView inviteView;
    private InviteRecordAdapter inviteAdapter;
    private List<InvitationUser> invitationUsers = new ArrayList<>();
    private HttpBack<Page<InvitationUser>> inviteHttpBack;
    private HttpBack<StoreDataStatistics> countHttpBack;

    private int pageNum = 0;
    private int totalPages = 1;

    private RefreshHandler refreshHandler = new RefreshHandler(this);

    @Override
    public int setLayoutId() {
        return R.layout.fragment_invite_list;
    }

    @Override
    public void initHttpBack() {
        inviteHttpBack = new HttpBack<Page<InvitationUser>>() {
            @Override
            public void onSuccess(Page<InvitationUser> invitationUserPage) {
                refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_COMPLETE);
                if (invitationUserPage == null || invitationUserPage.getTotalRecords() <= 0) {
                    return;
                }
                pageNum = invitationUserPage.getPageNum();
                totalPages = invitationUserPage.getTotalPages();
                if (pageNum <= 1) {
                    invitationUsers.clear();
                }
                invitationUsers.addAll(invitationUserPage.getList());
                inviteAdapter.notifyDataSetChanged();
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

        countHttpBack = new HttpBack<StoreDataStatistics>() {
            @Override
            public void onSuccess(StoreDataStatistics storeDataStatistics) {
                setData(storeDataStatistics.getInviteCount(), storeDataStatistics.getVipUserCount());
            }
        };
    }

    @Override
    public void initView(View view) {
        backView = (LinearLayout) view.findViewById(R.id.ll_back);
        TextView titleView = (TextView) view.findViewById(R.id.tv_title);
        titleView.setText(getString(R.string.title_invite_list));

        totalView = (TextView) view.findViewById(R.id.tv_invite_list_statistics);

        refreshLayout = (RefreshLayout) view.findViewById(R.id.srl_invite);
        refreshLayout.init(getActivity());
        inviteView = (RecyclerView) view.findViewById(R.id.rv_invite);
    }

    @Override
    public void initAdapter() {
        LinearLayoutManager layoutManager = new LinearLayoutManager(getActivity());
        layoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        inviteView.setLayoutManager(layoutManager);
        inviteAdapter = new InviteRecordAdapter(getActivity(), invitationUsers);
        inviteView.setAdapter(inviteAdapter);
        inviteView.addItemDecoration(DefaultItemDecoration.getDefault(getActivity()));
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().onBackPressed();
            }
        });
        refreshLayout.setRefreshListener(new RefreshLayout.OnDataRefreshListener() {
            @Override
            public void onDataRefresh() {
                inviteRequest(1);
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
                inviteRequest(++pageNum);
            }
        });
    }

    public void setData(Integer inviteCount, Integer vipUserCount) {
        List<Integer> styleResIds = new ArrayList<>();
        styleResIds.add(R.style.TextAppearance_Large);
        styleResIds.add(R.style.TextAppearance_Invite);
        TextChangeUtils.setDifferentText(getActivity(), totalView, R.string.invite_total, styleResIds,
                inviteCount, vipUserCount);
    }

    @Override
    public void initRequest() {
        inviteRequest(1);
        countRequest();
    }

    private void inviteRequest(int num) {
        Map<String, Object> map = new HashMap<>();
        map.put("pageNum", num);
        map.put("pageSize", Constants.PAGE_SIZE);
        RetrofitUtils.getInstance().inviteUsers(ParamUtils.getParam(map), inviteHttpBack);
    }

    private void countRequest() {
        RetrofitUtils.getInstance().inviteCount(ParamUtils.getParam(null), countHttpBack);
    }

    private static class RefreshHandler extends Handler {
        private WeakReference<InviteListFragment> productWeakReference;

        public RefreshHandler(InviteListFragment fragment) {
            this.productWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            InviteListFragment fragment = productWeakReference.get();
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
