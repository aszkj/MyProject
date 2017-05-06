package com.yldbkd.www.buyer.android.fragment;

import android.os.Bundle;
import android.os.Handler;
import android.support.annotation.NonNull;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.View;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.adapter.MessageAdapter;
import com.yldbkd.www.buyer.android.base.BaseFragment;
import com.yldbkd.www.buyer.android.bean.MessageDetail;
import com.yldbkd.www.buyer.android.bean.Page;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.JumpUtils;
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
 * @创建时间 2017/3/27 16:01
 * @描述 优惠券、退款信息列表
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class MessageListFragment extends BaseFragment {
    private RelativeLayout backView;

    private RefreshLayout refreshLayout;
    private RecyclerView recycleView;
    private RelativeLayout mNodataRL;
    private List<MessageDetail> mMessageDetails = new ArrayList<>();
    private MessageAdapter messageAdapter;
    private HttpBack<Page<MessageDetail>> messageListHttpBack;
    private Integer pageNum = 1;
    private Integer totalPages = 1;
    private Handler refreshHandler = new RefreshHandler(this);
    private int messageType;

    @Override
    public void initBundle() {
        Bundle bundle = getArguments();
        if (bundle == null) {
            return;
        }
        messageType = bundle.getInt(Constants.BundleName.MESSAGE_TYPE, Constants.MessageType.MESSAGECOUPON);
    }

    @Override
    public int setLayoutId() {
        return R.layout.message_list_fragment;
    }

    @Override
    public void initView(View view) {
        backView = (RelativeLayout) view.findViewById(R.id.back_view);
        TextView titleView = (TextView) view.findViewById(R.id.title_view);
        titleView.setText(getResources().getString(messageType == 1 ? R.string.message_coupon : R.string.message_refund));

        mNodataRL = (RelativeLayout) view.findViewById(R.id.rl_nodata);
        refreshLayout = (RefreshLayout) view.findViewById(R.id.rl_message_list);
        refreshLayout.init(getActivity());
        recycleView = (RecyclerView) view.findViewById(R.id.message_recycle_view);

        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(getActivity());
        linearLayoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        recycleView.setLayoutManager(linearLayoutManager);
        recycleView.getItemAnimator().setSupportsChangeAnimations(false);
    }

    @Override
    public void initHttpBack() {
        messageListHttpBack = new HttpBack<Page<MessageDetail>>(getBaseActivity()) {
            @Override
            public void onSuccess(Page<MessageDetail> data) {
                if (data == null) {
                    mNodataRL.setVisibility(View.VISIBLE);
                    return;
                }
                if (data.getPageNum() <= 1) {
                    mMessageDetails.clear();
                }
                if (data.getList() != null) {
                    mMessageDetails.addAll(data.getList());
                }
                if (mMessageDetails.size() == 0) {
                    mNodataRL.setVisibility(View.VISIBLE);
                } else {
                    mNodataRL.setVisibility(View.GONE);
                }
                pageNum = data.getPageNum();
                totalPages = data.getTotalPages();

                messageAdapter.notifyDataSetChanged();
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
        initRequest();
    }

    @Override
    public void initRequest() {
        messageRequest(1);
    }

    public void messageRequest(int pageNum) {
        Map<String, Object> map = new HashMap<>();
        map.put("typeValue", messageType);
        map.put("pageNum", pageNum);
        map.put("pageSize", Constants.PAGE_SIZE);
        RetrofitUtils.getInstance().checkedMessageByType(ParamUtils.getParam(map), messageListHttpBack);
    }

    private void initAdapter() {
        messageAdapter = new MessageAdapter(mMessageDetails, getActivity(), new MessageJumpHandler(this));
        recycleView.setAdapter(messageAdapter);
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                getActivity().onBackPressed();
            }
        });
        refreshLayout.setRefreshListener(new RefreshLayout.OnDataRefreshListener() {
            @Override
            public void onDataRefresh() {
                messageRequest(1);
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
                messageRequest(++pageNum);
            }
        });
    }

    private static class RefreshHandler extends Handler {
        private WeakReference<MessageListFragment> productWeakReference;

        public RefreshHandler(MessageListFragment fragment) {
            this.productWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(android.os.Message msg) {
            MessageListFragment fragment = productWeakReference.get();
            if (fragment == null) {
                return;
            }
            if (msg.what == Constants.HandlerCode.REFRESH_LIST) {
                fragment.refreshLayout.setRefreshing(false);
                fragment.refreshLayout.setLoadMore(false);
            }
        }
    }

    private static class MessageJumpHandler extends Handler {
        private WeakReference<MessageListFragment> fragmentWeakReference;

        MessageJumpHandler(MessageListFragment fragment) {
            fragmentWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(@NonNull android.os.Message msg) {
            MessageListFragment fragment = fragmentWeakReference.get();
            if (fragment == null) {
                return;
            }
            switch (msg.what) {
                case Constants.HandlerCode.MESSAGEJUMP:
                    fragment.jump(msg.arg1, msg.obj.toString());
                    break;
            }
        }
    }

    private void jump(int directType, String directCode) {
        JumpUtils.messageJump(getActivity(), directType, directCode);
    }
}
