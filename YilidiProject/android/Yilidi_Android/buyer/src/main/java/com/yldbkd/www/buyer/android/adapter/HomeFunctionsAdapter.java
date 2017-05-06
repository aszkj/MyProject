package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.FunctionLogo;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;

import java.util.List;

/**
 * @创建者 李贞高
 * @创建时间 2016/5/25 11:45
 * @描述 首页四大功能
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class HomeFunctionsAdapter extends BaseAdapter {

    private List<FunctionLogo> logos;
    private Context context;
    private Integer[] mTitles;
    private Integer[] mIcons;
    private LayoutInflater inflater;

    public HomeFunctionsAdapter(Integer[] titles, Integer[] icons, Context context, List<FunctionLogo> logos) {
        mTitles = titles;
        mIcons = icons;
        this.logos = logos;
        inflater = LayoutInflater.from(context);
        this.context = context;
    }

    @Override
    public int getCount() {
        return mTitles == null ? 0 : mTitles.length;
    }

    @Override
    public Object getItem(int i) {
        return mTitles[i];
    }

    @Override
    public long getItemId(int i) {
        return i;
    }

    @Override
    public View getView(final int position, View convertView, ViewGroup parent) {
        ViewHolder viewHolder;
        if (convertView == null) {
            viewHolder = new ViewHolder();
            convertView = inflater.inflate(R.layout.home_classify_item, parent, false);
            viewHolder.imageView = (ImageView) convertView.findViewById(R.id.classify_image_view);
            viewHolder.textView = (TextView) convertView.findViewById(R.id.classify_name_view);
            convertView.setTag(viewHolder);
        } else {
            viewHolder = (ViewHolder) convertView.getTag();
        }
        if (logos == null || logos.size() < 4) {
            viewHolder.imageView.setImageResource(mIcons[position]);
        } else {
            FunctionLogo functionLogo = logos.get(position);
            ImageLoaderUtils.load(viewHolder.imageView, functionLogo.getImageUrl(), mIcons[position]);
        }
        viewHolder.textView.setText(mTitles[position]);
        return convertView;
    }

    private static class ViewHolder {
        ImageView imageView;
        TextView textView;
    }
}
