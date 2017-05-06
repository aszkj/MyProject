package com.yldbkd.www.seller.android.adapter;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.yldbkd.www.library.android.image.ImageLoaderUtils;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.bean.Brand;

import java.util.List;

/**
 * @创建者 李贞高
 * @创建时间 2016/12/12 11:14
 * @描述 品牌adapter
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class BrandAdapter extends RecyclerView.Adapter<BrandAdapter.ViewHolder> {

    private Context context;
    private List<Brand> brands;
    private LayoutInflater inflater;

    public BrandAdapter(Context context, List<Brand> brands) {
        this.brands = brands;
        this.context = context;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.brand_item, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
        Brand brand = brands.get(position);
        holder.brandName.setText(brand.getBrandName());
        ImageLoaderUtils.load(holder.brandImage, brand.getBrandLogoImageUrl());
        if (itemClickListener != null) {
            holder.itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    itemClickListener.onItemClick(holder.itemView, holder.getAdapterPosition());
                }
            });
        }
    }

    @Override
    public int getItemCount() {
        return brands == null ? 0 : brands.size();
    }

    static class ViewHolder extends RecyclerView.ViewHolder {

        private TextView brandName;
        private ImageView brandImage;

        public ViewHolder(View itemView) {
            super(itemView);
            brandName = (TextView) itemView.findViewById(R.id.brand_name_text);
            brandImage = (ImageView) itemView.findViewById(R.id.brand_image);
        }
    }

    public interface OnItemClickListener {
        void onItemClick(View view, int position);
    }

    private OnItemClickListener itemClickListener;

    public void setItemClickListener(OnItemClickListener itemClickListener) {
        this.itemClickListener = itemClickListener;
    }
}
