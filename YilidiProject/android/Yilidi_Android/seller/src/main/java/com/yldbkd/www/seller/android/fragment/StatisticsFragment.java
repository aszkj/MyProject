package com.yldbkd.www.seller.android.fragment;

import android.os.Bundle;
import android.support.v4.content.ContextCompat;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.MoneyUtils;
import com.yldbkd.www.library.android.common.TextChangeUtils;
import com.yldbkd.www.library.android.viewCustomer.DatePicker;
import com.yldbkd.www.library.android.viewCustomer.ImgTxtButton;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.activity.StatisticsActivity;
import com.yldbkd.www.seller.android.adapter.BaseAdapter;
import com.yldbkd.www.seller.android.adapter.StatisticsDateAdapter;
import com.yldbkd.www.seller.android.bean.DataStatistics;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.utils.http.HttpBack;
import com.yldbkd.www.seller.android.utils.http.ParamUtils;
import com.yldbkd.www.seller.android.utils.http.RetrofitUtils;
import com.yldbkd.www.seller.android.viewCustomer.DefaultItemDecoration;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

/**
 * 统计首页页面
 * <p/>
 * Created by linghuxj on 16/6/7.
 */
public class StatisticsFragment extends BaseFragment {

    private StatisticsActivity statisticsActivity;

    private LinearLayout backView;
    private ImgTxtButton dateBtn;
    private PopupWindow window;
    private StatisticsDateAdapter dateAdapter;

    private LinearLayout vipLayout;
    private TextView vipView;

    private LinearLayout backLayout;
    private TextView orderBackView;

    private TextView countView;

    private HttpBack<DataStatistics> statisticsHttpBack;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        statisticsActivity = (StatisticsActivity) getActivity();
    }

    @Override
    public int setLayoutId() {
        return R.layout.fragment_statistics;
    }

    @Override
    public void initHttpBack() {
        statisticsHttpBack = new HttpBack<DataStatistics>() {
            @Override
            public void onSuccess(DataStatistics dataStatistics) {
                if (dataStatistics == null) {
                    return;
                }
                vipView.setText(String.valueOf(dataStatistics.getVipUserCount()));
                orderBackView.setText(String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(
                        dataStatistics.getOrderSettleAmount())));
                countView.setText(String.valueOf(dataStatistics.getFinishOrderCount()));
            }
        };
    }

    @Override
    public void initView(View view) {
        backView = (LinearLayout) view.findViewById(R.id.ll_back);
        TextView titleView = (TextView) view.findViewById(R.id.tv_title);
        titleView.setText(getString(R.string.title_statistics));
        dateBtn = (ImgTxtButton) view.findViewById(R.id.itb_right);
        dateBtn.setBackgroundResource(R.drawable.blue_bg);
        dateBtn.setTextColor(ContextCompat.getColor(getActivity(), R.color.white));

        vipLayout = (LinearLayout) view.findViewById(R.id.ll_statistics_vip);
        vipView = (TextView) view.findViewById(R.id.tv_statistics_vip);
        backLayout = (LinearLayout) view.findViewById(R.id.ll_statistics_order_back);
        orderBackView = (TextView) view.findViewById(R.id.tv_statistics_order_back);
        countView = (TextView) view.findViewById(R.id.tv_statistics_order_count);

        initWindow();
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
        vipLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getBaseActivity().showFragment(StatisticsVipFragment.class.getSimpleName(), null, true);
            }
        });
        backLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getBaseActivity().showFragment(StatisticsOrderSettleFragment.class.getSimpleName(), null, true);
            }
        });
    }

    @Override
    public void initRequest() {
        chooseDate();
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
                statisticsActivity.getTimeZero(statisticsActivity.endTime));
        setDateContent(getString(statisticsActivity.DATE_RESIDS[statisticsActivity.index]));
    }

    private void setDateContent(String content) {
        TextChangeUtils.setImageText(getActivity(), dateBtn.getTextView(), R.mipmap.down_arrow_white, content, true);
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

    private void statisticsRequest(String beginTime, String endTime) {
        Map<String, Object> map = new HashMap<>();
        map.put("beginTime", beginTime);
        map.put("endTime", endTime);
        RetrofitUtils.getInstance(true).statisticsSummerize(ParamUtils.getParam(map), statisticsHttpBack);
    }

}
