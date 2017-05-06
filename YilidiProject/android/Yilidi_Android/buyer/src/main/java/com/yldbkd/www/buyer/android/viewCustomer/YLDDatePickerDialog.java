package com.yldbkd.www.buyer.android.viewCustomer;

import android.app.AlertDialog;
import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.DatePicker;

import com.yldbkd.www.buyer.android.R;

public class YLDDatePickerDialog extends AlertDialog implements
        DatePicker.OnDateChangedListener {

    private static final String YEAR = "year";
    private static final String MONTH = "month";
    private static final String DAY = "day";

    private final DatePicker mDatePicker;
    private final OnDateSetListener mDateSetListener;

    private View view;

    /**
     * The callback used to indicate the user is done filling in the date.
     */
    public interface OnDateSetListener {
        void onDateSet(DatePicker view, int year, int monthOfYear, int dayOfMonth);
    }

    public YLDDatePickerDialog(Context context, OnDateSetListener callBack,
                               int year, int monthOfYear, int dayOfMonth) {
        this(context, 0, callBack, year, monthOfYear, dayOfMonth);
    }

    public YLDDatePickerDialog(Context context, int theme,
                               OnDateSetListener listener, int year, int monthOfYear,
                               int dayOfMonth) {
        super(context, theme);
        mDateSetListener = listener;

        Context themeContext = getContext();
        LayoutInflater inflater = LayoutInflater.from(themeContext);
        view = inflater.inflate(R.layout.date_picker_dialog, null);
        mDatePicker = (DatePicker) view.findViewById(R.id.date_picker);
        mDatePicker.init(year, monthOfYear, dayOfMonth, this);
        setButton();
    }

    private void setButton() {
        // 获取自己定义的响应按钮并设置监听，直接调用构造时传进来的CallBack接口
        view.findViewById(R.id.date_picker_ok).setOnClickListener(
                new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        if (mDateSetListener != null) {
                            mDatePicker.clearFocus();
                            mDateSetListener.onDateSet(mDatePicker,
                                    mDatePicker.getYear(),
                                    mDatePicker.getMonth(),
                                    mDatePicker.getDayOfMonth());
                            dismiss();
                        }
                    }
                });
        view.findViewById(R.id.date_picker_cancel).setOnClickListener(
                new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        cancel();
                    }
                });
    }

    public void myShow() {
        // 自己实现show方法，主要是为了把setContentView方法放到show方法后面，否则会报错。
        show();
        setContentView(view);
    }

    @Override
    public void onDateChanged(DatePicker view, int year, int month, int day) {
        mDatePicker.init(year, month, day, this);

    }

    /**
     * Gets the {@link DatePicker} contained in this dialog.
     *
     * @return The calendar view.
     */
    public DatePicker getDatePicker() {
        return mDatePicker;
    }

    public void updateDate(int year, int monthOfYear, int dayOfMonth) {
        mDatePicker.updateDate(year, monthOfYear, dayOfMonth);
    }

    @Override
    public Bundle onSaveInstanceState() {
        final Bundle state = super.onSaveInstanceState();
        state.putInt(YEAR, mDatePicker.getYear());
        state.putInt(MONTH, mDatePicker.getMonth());
        state.putInt(DAY, mDatePicker.getDayOfMonth());
        return state;
    }

    @Override
    public void onRestoreInstanceState(Bundle savedInstanceState) {
        super.onRestoreInstanceState(savedInstanceState);
        final int year = savedInstanceState.getInt(YEAR);
        final int month = savedInstanceState.getInt(MONTH);
        final int day = savedInstanceState.getInt(DAY);
        mDatePicker.init(year, month, day, this);
    }
}