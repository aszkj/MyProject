package com.yldbkd.www.seller.android.adapter;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.seller.android.R;

import java.util.List;

/**
 * 首页分类信息展示Adapter
 * <p>
 * Created by linghuxj on 16/5/30.
 */
public class MainCatalogAdapter extends BaseAdapter<MainCatalogAdapter.ViewHolder> {

    private Context mContext;
    private List<Catalog> catalogList;
    private LayoutInflater mInflater;

    public MainCatalogAdapter(Context mContext, List<Catalog> catalogList) {
        this.mContext = mContext;
        this.catalogList = catalogList;
        this.mInflater = LayoutInflater.from(mContext);
    }

    @Override
    public ViewHolder onCreateHolder(ViewGroup parent, int viewType) {
        View view = mInflater.inflate(R.layout.item_main_catalog, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindHolder(ViewHolder holder, int position) {
        final Catalog catalog = catalogList.get(position);
        holder.imageView.setBackgroundResource(catalog.imageResourceId);
        holder.catalogNameView.setText(mContext.getString(catalog.catalogName));
        holder.catalogRemarkView.setText(mContext.getString(catalog.catalogRemark));
    }

    @Override
    public int getCount() {
        return catalogList == null ? 0 : catalogList.size();
    }

    class ViewHolder extends BaseAdapter.Holder {

        private ImageView imageView;
        private TextView catalogNameView;
        private TextView catalogRemarkView;

        public ViewHolder(View view) {
            super(view);
            this.imageView = (ImageView) view.findViewById(R.id.iv_item_catalog);
            this.catalogNameView = (TextView) view.findViewById(R.id.tv_item_catalog_name);
            this.catalogRemarkView = (TextView) view.findViewById(R.id.tv_item_catalog_remark);
        }
    }

    public static class Catalog {
        public int imageResourceId;
        public int catalogName;
        public int catalogRemark;
        public Class clazzActivity;
        public String fragmentSimpleName;
    }
}
