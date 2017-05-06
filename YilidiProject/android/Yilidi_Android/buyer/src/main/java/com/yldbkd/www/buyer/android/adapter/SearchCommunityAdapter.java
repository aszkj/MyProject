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
 * 搜索页面的地址列表Adapter
 * <p/>
 * Created by linghuxj on 15/10/12.
 */
public class SearchCommunityAdapter extends BaseAdapter {

    private List<Community> communities;
    private LayoutInflater inflater;
    private Context context;
    public SearchCommunityAdapter(List<Community> communities, Context context) {
        this.communities = communities;
        this.inflater = LayoutInflater.from(context);
        this.context = context;
    }

    @Override
    public int getCount() {
        return communities == null ? 0 : communities.size();
    }

    @Override
    public Object getItem(int i) {
        return getCount() == 0 ? null : communities.get(i);
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
        Community locationList = communities.get(i);
        holder.locationName.setText(locationList.getCommunityName());
        holder.locationAddressDetail.setText(String.valueOf(locationList.getAddressDetail()));
        return view;
    }

    private static class ViewHolder {
        TextView locationName;
        TextView locationAddressDetail;
    }
}
