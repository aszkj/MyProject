package com.yldbkd.www.library.android.viewCustomer;

import android.content.Context;
import android.graphics.Typeface;
import android.support.v4.content.ContextCompat;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.PopupWindow;
import android.widget.TextView;

import com.squareup.timessquare.CalendarPickerView;
import com.yldbkd.www.library.android.R;
import com.yldbkd.www.library.android.common.ToastUtils;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * 时间选择器弹框
 * <p/>
 * Created by linghuxj on 16/6/15.
 */
public class DatePicker {

    private static CalendarPickerView pickerView;
    private static TextView cancelView;
    private static TextView confirmView;

    private static PopupWindow pickerWindow;

    public static PopupWindow getPopupWindow(Context context, SelectListener selectListener) {
        View view = View.inflate(context, R.layout.date_picker, null);
        pickerWindow = new PopupWindow(view, ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT, true);
        pickerWindow.setTouchable(true);
        pickerWindow.setTouchInterceptor(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                return false;
            }
        });
        pickerWindow.setBackgroundDrawable(ContextCompat.getDrawable(context, R.color.transparent));

        initView(view);
        initListener(context, selectListener);
        return pickerWindow;
    }

    private static void initView(View view) {
        pickerView = (CalendarPickerView) view.findViewById(R.id.cpv_statistics);
        cancelView = (TextView) view.findViewById(R.id.tv_picker_cancel);
        confirmView = (TextView) view.findViewById(R.id.tv_picker_confirm);
        initPicker();
    }

    private static void initListener(final Context context, final SelectListener selectListener) {
        cancelView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (pickerWindow == null) {
                    return;
                }
                pickerWindow.dismiss();
            }
        });
        confirmView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (pickerWindow == null || selectListener == null) {
                    return;
                }
                List<Date> list = pickerView.getSelectedDates();
                if (list.size() < 2) {
                    ToastUtils.show(context, R.string.picker_error_empty_notify);
                    return;
                }
                Calendar beginTime = Calendar.getInstance();
                beginTime.setTime(list.get(0));
                beginTime.add(Calendar.DAY_OF_MONTH, -1);
                Calendar endTime = Calendar.getInstance();
                endTime.setTime(list.get(list.size() - 1));
                Calendar beginTimeAfterMonth = Calendar.getInstance();
                beginTimeAfterMonth.setTime(beginTime.getTime());
                beginTimeAfterMonth.add(Calendar.MONTH, 1);
                if (beginTimeAfterMonth.before(endTime)) {
                    ToastUtils.show(context, R.string.picker_error_enough_notify);
                    return;
                }
                selectListener.onSelect(beginTime, endTime);
                pickerWindow.dismiss();
            }
        });
    }

    private static void initPicker() {
        Calendar minDate = Calendar.getInstance();
        minDate.add(Calendar.YEAR, -1);
        Calendar maxDate = Calendar.getInstance();
        maxDate.add(Calendar.DAY_OF_MONTH, 1);
        pickerView.init(minDate.getTime(), maxDate.getTime()).inMode(CalendarPickerView.SelectionMode.RANGE);
        pickerView.setTypeface(Typeface.DEFAULT);
        pickerView.setOnInvalidDateSelectedListener(null);
        pickerView.scrollToDate(maxDate.getTime());
    }

    public interface SelectListener {
        void onSelect(Calendar beginTime, Calendar endTime);
    }
}
