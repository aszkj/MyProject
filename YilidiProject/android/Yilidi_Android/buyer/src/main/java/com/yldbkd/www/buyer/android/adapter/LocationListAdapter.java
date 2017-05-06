package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.Community;

import java.util.List;

/**
 * @创建者     lizg
 * @创建时间   2016/6/1 22:59
 * @描述	      定位附近地址列表adapter
 *
 * @更新者     $Author$
 * @更新时间   $Date$
 * @更新描述
 */
public class LocationListAdapter extends BaseAdapter {

    private List<Community> mDatas;
    private LayoutInflater inflater;
    private Context context;

    public LocationListAdapter(List<Community> datas, Context context) {
        mDatas = datas;
        this.inflater = LayoutInflater.from(context);
        this.context = context;
    }

    @Override
    public int getCount() {
        return mDatas == null ? 0 : mDatas.size();
    }

    @Override
    public Object getItem(int i) {
        return getCount() == 0 ? null : mDatas.get(i);
    }

    @Override
    public long getItemId(int i) {
        return i;
    }

    @Override
    public View getView(int i, View view, ViewGroup viewGroup) {
        ViewHolder holder;
        if (view == null) {
            holder = new ViewHolder();
            view = inflater.inflate(R.layout.location_item, viewGroup, false);
            holder.locationName = (TextView) view.findViewById(R.id.location_name);
            holder.locationAddressDetail = (TextView) view.findViewById(R.id.location_address_detail);
            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }
        Community locationList = mDatas.get(i);
        holder.locationName.setText(locationList.getCommunityName());
        holder.locationAddressDetail.setText(String.valueOf(locationList.getAddressDetail()));
        return view;
    }

    private static class ViewHolder {
        TextView locationName;
        TextView locationAddressDetail;
    }
}
