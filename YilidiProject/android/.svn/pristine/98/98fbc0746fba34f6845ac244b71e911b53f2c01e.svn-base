package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;

import java.util.List;


/**
 * Created by Liuxd on 2016/5/27.
 */
public abstract class SmallSortGridViewAdapter<T> extends BaseAdapter {
    private Context mContext;
    private LayoutInflater mLayoutInflater;
    private List<T> mSmallSortList;
    private int mSelectPosition = 0;

    public int getmSelectPosition() {
        return mSelectPosition;
    }

    public void setmSelectPosition(int mSelectPosition) {
        this.mSelectPosition = mSelectPosition;
    }

    public SmallSortGridViewAdapter(Context context, List<T> smallSortList) {
        this.mContext = context;
        mLayoutInflater = LayoutInflater.from(context);
        this.mSmallSortList = smallSortList;
    }

    @Override
    public int getCount() {
        return mSmallSortList.size();
    }

    @Override
    public T getItem(int position) {
        return mSmallSortList.get(position);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        ViewHolder viewHolder;
        if (convertView == null) {
            convertView = mLayoutInflater.inflate(R.layout.popwindow_samllsort_item, parent, false);
            viewHolder = new ViewHolder();
            convertView.setTag(viewHolder);
        } else {
            viewHolder = (ViewHolder) convertView.getTag();
        }
        handle2(viewHolder, getItem(position));
//        viewHolder.tv_samllSort.setText(mSmallSortList.get(position).categoryName);
        if (getmSelectPosition() == position) {
            viewHolder.tvGoodsSmallSort.setSelected(true);
        } else {
            viewHolder.tvGoodsSmallSort.setSelected(false);
        }
        return convertView;
    }

    public static class ViewHolder {
        public TextView tvGoodsSmallSort;
    }

    //处理数据
    public abstract void handle2(ViewHolder holder, T t);
}
