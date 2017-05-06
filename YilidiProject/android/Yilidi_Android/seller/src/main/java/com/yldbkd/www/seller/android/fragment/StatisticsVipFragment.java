package com.yldbkd.www.seller.android.fragment;

import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v4.content.ContextCompat;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.TextChangeUtils;
import com.yldbkd.www.library.android.common.ToastUtils;
import com.yldbkd.www.library.android.pullRefresh.RefreshLayout;
import com.yldbkd.www.library.android.viewCustomer.DatePicker;
import com.yldbkd.www.library.android.viewCustomer.ImgTxtButton;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.activity.StatisticsActivity;
import com.yldbkd.www.seller.android.adapter.BaseAdapter;
import com.yldbkd.www.seller.android.adapter.StatisticsDateAdapter;
import com.yldbkd.www.seller.android.adapter.StatisticsVipAdapter;
import com.yldbkd.www.seller.android.bean.DataStatisticsVip;
import com.yldbkd.www.seller.android.bean.Page;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.utils.http.HttpBack;
import com.yldbkd.www.seller.android.utils.http.ParamUtils;
import com.yldbkd.www.seller.android.utils.http.RetrofitUtils;
import com.yldbkd.www.seller.android.viewCustomer.DefaultItemDecoration;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * VIP会员数统计相关页面
 * <p/>
 * Created by linghuxj on 16/6/16.
 */
public class StatisticsVipFragment extends BaseFragment {

    private StatisticsActivity statisticsActivity;

    private LinearLayout backView;
    private ImgTxtButton dateBtn;
    private PopupWindow window;
    private StatisticsDateAdapter dateAdapter;

    private RefreshLayout refreshLayout;
    private RecyclerView recyclerView;
    private StatisticsVipAdapter vipAdapter;
    private int pageNum = 0, pageSize = 1;
    private RelativeLayout emptyLayout;
    private List<DataStatisticsVip> statisticsVips = new ArrayList<>();

    private HttpBack<Page<DataStatisticsVip>> statisticsHttpBack;

    private RefreshHandler refreshHandler = new RefreshHandler(this);

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        statisticsActivity = (StatisticsActivity) getActivity();
    }

    @Override
    public int setLayoutId() {
        return R.layout.fragment_statistics_detail;
    }

    @Override
    public void initHttpBack() {
        statisticsHttpBack = new HttpBack<Page<DataStatisticsVip>>() {
            @Override
            public void onSuccess(Page<DataStatisticsVip> dataStatisticsVipPage) {
                refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_COMPLETE);
                if (dataStatisticsVipPage == null || dataStatisticsVipPage.getTotalRecords() <= 0) {
                    isEmptyView(true);
                    return;
                }
                isEmptyView(false);
                pageNum = dataStatisticsVipPage.getPageNum();
                pageSize = dataStatisticsVipPage.getPageSize();
                if (pageNum <= 1) {
                    statisticsVips.clear();
                }
                statisticsVips.addAll(dataStatisticsVipPage.getList());
                vipAdapter.notifyDataSetChanged();
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
    }

    @Override
    public void initView(View view) {
        backView = (LinearLayout) view.findViewById(R.id.ll_back);
        TextView titleView = (TextView) view.findViewById(R.id.tv_title);
        titleView.setText(getString(R.string.title_statistics_vip));
        dateBtn = (ImgTxtButton) view.findViewById(R.id.itb_right);
        dateBtn.setBackgroundResource(R.drawable.yellow_bg);

        TextView dateTitleView = (TextView) view.findViewById(R.id.tv_statistics_date);
        dateTitleView.setText(getString(R.string.statistics_detail_date));
        TextView nameTitleView = (TextView) view.findViewById(R.id.tv_statistics_name);
        nameTitleView.setText(getString(R.string.statistics_register_count));
        TextView resultTitleView = (TextView) view.findViewById(R.id.tv_statistics_result);
        resultTitleView.setText(getString(R.string.statistics_vip_count));

        refreshLayout = (RefreshLayout) view.findViewById(R.id.rl_statistics);
        refreshLayout.init(getActivity());
        recyclerView = (RecyclerView) view.findViewById(R.id.rv_statistics);
        emptyLayout = (RelativeLayout) view.findViewById(R.id.rl_statistics_empty);

        initWindow();
    }

    @Override
    public void initAdapter() {
        LinearLayoutManager layoutManager = new LinearLayoutManager(getActivity());
        layoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        recyclerView.setLayoutManager(layoutManager);
        vipAdapter = new StatisticsVipAdapter(getActivity(), statisticsVips);
        recyclerView.setAdapter(vipAdapter);
    }

    @Override
    public void initListener() {
        backView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getActivity().onBackPressed();
            }
        });
        dateBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                window.showAsDropDown(dateBtn);
            }
        });
        dateAdapter.setOnItemClickListener(new BaseAdapter.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int position) {
                window.dismiss();
                if (position == statisticsActivity.DATE_RESIDS.length - 1) {
                    statisticsActivity.index = position;
                    showDatePicker();
                } else {
                    statisticsActivity.calculateTime(position);
                    chooseDate();
                }
            }
        });
        refreshLayout.setRefreshListener(new RefreshLayout.OnDataRefreshListener() {
            @Override
            public void onDataRefresh() {
                statisticsRequest(statisticsActivity.getTimeZero(statisticsActivity.beginTime),
                        statisticsActivity.getTimeZero(statisticsActivity.endTime), 1);
            }
        });
        refreshLayout.setLoadListener(new RefreshLayout.OnDataLoadListener() {
            @Override
            public void onDataLoad() {
                if (pageNum >= pageSize) {
                    ToastUtils.showShort(getActivity(), R.string.pull_up_no_more_data);
                    refreshHandler.sendEmptyMessage(Constants.HandlerCode.REFRESH_COMPLETE);
                    return;
                }
                statisticsRequest(statisticsActivity.getTimeZero(statisticsActivity.beginTime),
                        statisticsActivity.getTimeZero(statisticsActivity.endTime), ++pageNum);
            }
        });
    }

    @Override
    public void initRequest() {
        chooseDate();
    }

    private void isEmptyView(boolean isEmpty) {
        emptyLayout.setVisibility(isEmpty ? View.VISIBLE : View.GONE);
        refreshLayout.setVisibility(isEmpty ? View.GONE : View.VISIBLE);
    }

    private void initWindow() {
        View contentView = View.inflate(getActivity(), R.layout.date_selecter, null);
        window = new PopupWindow(contentView, ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT, true);
        window.setTouchable(true);
        window.setTouchInterceptor(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                return false;
            }
        });
        window.setBackgroundDrawable(ContextCompat.getDrawable(getActivity(), R.mipmap.transparent));

        RecyclerView recyclerView = (RecyclerView) contentView.findViewById(R.id.rv_statistics_date);
        LinearLayoutManager layoutManager = new LinearLayoutManager(getActivity());
        layoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        recyclerView.setLayoutManager(layoutManager);
        dateAdapter = new StatisticsDateAdapter(getActivity(), statisticsActivity.DATE_RESIDS);
        recyclerView.setAdapter(dateAdapter);
        recyclerView.addItemDecoration(DefaultItemDecoration.getDefault(getActivity()));
    }

    private void chooseDate() {
        statisticsRequest(statisticsActivity.getTimeZero(statisticsActivity.beginTime),
                statisticsActivity.getTimeZero(statisticsActivity.endTime), 1);
        setDateContent(getString(statisticsActivity.DATE_RESIDS[statisticsActivity.index]));
    }

    private void setDateContent(String content) {
        TextChangeUtils.setImageText(getActivity(), dateBtn.getTextView(), R.mipmap.down_arrow, content, true);
    }

    private void showDatePicker() {
        PopupWindow picker = DatePicker.getPopupWindow(getActivity(), new DatePicker.SelectListener() {
            @Override
            public void onSelect(Calendar beginTime, Calendar endTime) {
                statisticsActivity.beginTime = beginTime;
                statisticsActivity.endTime = endTime;
                chooseDate();
            }
        });
        picker.showAtLocation(this.getView(), Gravity.CENTER, 0, 0);
    }

    private void statisticsRequest(String beginTime, String endTime, int pageNum) {
        Map<String, Object> map = new HashMap<>();
        map.put("pageNum", pageNum);
        map.put("pageSize", Constants.PAGE_SIZE);
        map.put("beginTime", beginTime);
        map.put("endTime", endTime);
        RetrofitUtils.getInstance(true).statisticsVip(ParamUtils.getParam(map), statisticsHttpBack);
    }

    private static class RefreshHandler extends Handler {
        private WeakReference<StatisticsVipFragment> productWeakReference;

        public RefreshHandler(StatisticsVipFragment fragment) {
            this.productWeakReference = new WeakReference<>(fragment);
        }

        @Override
        public void dispatchMessage(Message msg) {
            StatisticsVipFragment fragment = productWeakReference.get();
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
