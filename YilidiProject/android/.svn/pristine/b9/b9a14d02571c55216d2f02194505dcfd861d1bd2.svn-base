package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;
import com.yldbkd.www.buyer.android.R;

/**
 * 简单的带选择器的adapter
 */
public class SimpleSelectAdapter extends BaseAdapter {
    private LayoutInflater mLayoutInflater;
    private String[] datas;
    private int selectIndex;

    public SimpleSelectAdapter(Context mContext, String[] datas) {
        this.datas = datas;
        this.mLayoutInflater = LayoutInflater.from(mContext);
    }

    @Override
    public int getCount() {
        return datas == null ? 0 : datas.length;
    }

    @Override
    public Object getItem(int position) {
        return getCount() == 0 ? null : datas[position];
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(final int position, View view, ViewGroup parent) {
        ViewHolder viewHolder;
        if (view == null) {
            view = mLayoutInflater.inflate(R.layout.simple_selet_item, parent, false);
            viewHolder = new ViewHolder();
            viewHolder.titleTv = (TextView) view.findViewById(R.id.select_text);
            viewHolder.iconView = (ImageView) view.findViewById(R.id.select_icon);
            view.setTag(viewHolder);
        } else {
            viewHolder = (ViewHolder) view.getTag();
        }
        String seString = datas[position];
        viewHolder.titleTv.setText(seString);
        if (selectIndex == position) {
            viewHolder.iconView.setImageResource(R.mipmap.checkbox_checked);
        } else {
            viewHolder.iconView.setImageResource(R.mipmap.checkbox_unchecked);
        }
        return view;
    }

    public int getSelectIndex() {
        return selectIndex;
    }

    public void setSelectIndex(int selectIndex) {
        this.selectIndex = selectIndex;
    }

    class ViewHolder {
        TextView titleTv;
        ImageView iconView;
    }
}
