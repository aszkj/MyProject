package com.yldbkd.www.seller.android.activity;

import android.os.Bundle;
import android.support.v4.app.Fragment;

import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.fragment.StatisticsFragment;
import com.yldbkd.www.seller.android.fragment.StatisticsOrderSettleFragment;
import com.yldbkd.www.seller.android.fragment.StatisticsVipFragment;
import com.yldbkd.www.seller.android.utils.Constants;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;

/**
 * 统计Activity
 * <p/>
 * Created by linghuxj on 16/6/7.
 */
public class StatisticsActivity extends BaseActivity {

    public Calendar endTime = Calendar.getInstance();
    public Calendar beginTime = Calendar.getInstance();
    public final int[] DATE_DAY = {1, 3, 7};
    public final int[] DATE_RESIDS = {R.string.statistics_date_lasted_1, R.string.statistics_date_lasted_3,
            R.string.statistics_date_lasted_7, R.string.statistics_date_custom};
    public int index = 2; // 默认7天

    @Override
    Fragment newFragmentByTag(String tag) {
        Fragment fragment = null;
        if (StatisticsFragment.class.getSimpleName().equals(tag)) {
            fragment = new StatisticsFragment();
        }
        if (StatisticsVipFragment.class.getSimpleName().equals(tag)) {
            fragment = new StatisticsVipFragment();
        }
        if (StatisticsOrderSettleFragment.class.getSimpleName().equals(tag)) {
            fragment = new StatisticsOrderSettleFragment();
        }
        return fragment;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setCustomContentView(R.layout.activity_common);
        calculateTime(index); // 初始化数据信息
        showFragment(getIntent().getAction(), getIntent().getExtras(), false);
    }

    public void calculateTime(int position) {
        index = position;
        if (index >= 3) {
            // 自定义
        } else {
            endTime = Calendar.getInstance();
            beginTime = Calendar.getInstance();
            beginTime.add(Calendar.DAY_OF_MONTH, 0 - DATE_DAY[index]);
        }
    }

    public String getTimeZero(Calendar calendar) {
        Calendar calendarZone = Calendar.getInstance();
        calendarZone.setTime(calendar.getTime());
        calendarZone.add(Calendar.DAY_OF_MONTH, 1);
        calendarZone.set(Calendar.HOUR_OF_DAY, 0);
        calendarZone.set(Calendar.MINUTE, 0);
        calendarZone.set(Calendar.SECOND, 0);
        return new SimpleDateFormat(Constants.TIME_FORMAT, Locale.CHINA).format(calendarZone.getTime());
    }
}
