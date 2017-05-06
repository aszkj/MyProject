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
import com.yldbkd.www.seller.android.bean.ClassBean;

import java.util.List;

/**
 * @创建者 李贞高
 * @创建时间 2016/12/12 11:14
 * @描述  子分类adapter
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述 ${TODO}$
 */
public class ClassificationChildAdapter extends RecyclerView.Adapter<ClassificationChildAdapter.ViewHolder> {

    private Context context;
    private List<ClassBean> types;
    private LayoutInflater inflater;

    public ClassificationChildAdapter(List<ClassBean> types, Context context) {
        this.types = types;
        this.context = context;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.classification_child_item, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
        ClassBean classBean = types.get(position);
        holder.secondName.setText(classBean.getClassName());
        ImageLoaderUtils.load(holder.secondImage, classBean.getClassImageUrl());

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
        return types == null ? 0 : (types.size() > 9 ? 9 : types.size());
    }

    static class ViewHolder extends RecyclerView.ViewHolder {

        private TextView secondName;
        private ImageView secondImage;

        public ViewHolder(View itemView) {
            super(itemView);
            secondName = (TextView) itemView.findViewById(R.id.second_name_text);
            secondImage = (ImageView) itemView.findViewById(R.id.second_image);
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
