package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.Classification;

import java.util.List;

/**
 * 分类列表Adapter
 * <p/>
 * Created by linghuxj on 15/9/29.
 */
public class StoreClassifyAdapter extends BaseAdapter {

    private List<Classification> list;
    private LayoutInflater inflater;

    public StoreClassifyAdapter(List<Classification> list, Context context) {
        this.list = list;
        inflater = LayoutInflater.from(context);
    }

    @Override
    public int getCount() {
        return list == null ? 0 : list.size();
    }

    @Override
    public Object getItem(int i) {
        return list.get(i);
    }

    @Override
    public long getItemId(int i) {
        return i;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        ViewHolder viewHolder;
        if (convertView == null) {
            viewHolder = new ViewHolder();
            convertView = inflater.inflate(R.layout.store_classify_item, parent, false);
//            viewHolder.imageView = (ImageView) convertView.findViewById(R.id.classify_image_view);
            viewHolder.textView = (TextView) convertView.findViewById(R.id.classify_name_view);
            convertView.setTag(viewHolder);
        } else {
            viewHolder = (ViewHolder) convertView.getTag();
        }
        Classification classification = list.get(position);
//        ImageLoaderUtils.load(viewHolder.imageView, classification.getClassImageUrl());
        viewHolder.textView.setText(classification.getClassName());
        return convertView;
    }

    private static class ViewHolder {
//        ImageView imageView;
        TextView textView;
    }
}
