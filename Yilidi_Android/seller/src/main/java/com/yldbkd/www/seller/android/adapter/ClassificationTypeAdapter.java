package com.yldbkd.www.seller.android.adapter;

import android.content.Context;
import android.support.v4.content.ContextCompat;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.bean.ClassBean;

import java.util.List;

/**
 * @创建者 李贞高
 * @创建时间 2016/12/12 11:14
 * @描述  一级分类Adapter
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class ClassificationTypeAdapter extends RecyclerView.Adapter<ClassificationTypeAdapter.ViewHolder> {

    private Context context;
    private List<ClassBean> classTypes;
    private LayoutInflater inflater;
    private int clickPosition = -1;

    public ClassificationTypeAdapter(List<ClassBean> classTypes, Context context) {
        this.classTypes = classTypes;
        this.context = context;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.classification_left_item, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
        ClassBean classification = classTypes.get(position);
        holder.classifyFirstName.setText(classification.getClassName());
        if (position == clickPosition) {
            holder.classifyFirstName.setTextColor(ContextCompat.getColor(context, R.color.colorPrimary));
            holder.checkedLine.setVisibility(View.VISIBLE);
        } else {
            holder.classifyFirstName.setTextColor(ContextCompat.getColor(context, R.color.secondaryText));
            holder.checkedLine.setVisibility(View.GONE);
        }
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
        return classTypes == null ? 0 : classTypes.size();
    }

    static class ViewHolder extends RecyclerView.ViewHolder {

        private TextView classifyFirstName;
        private ImageView checkedLine;

        public ViewHolder(View itemView) {
            super(itemView);
            classifyFirstName = (TextView) itemView.findViewById(R.id.classify_first_name_view);
            checkedLine = (ImageView) itemView.findViewById(R.id.checked_bottom_line);
        }
    }

    public void setSelectItem(int clickPosition) {
        this.clickPosition = clickPosition;
    }

    public interface OnItemClickListener {
        void onItemClick(View view, int position);
    }

    private OnItemClickListener itemClickListener;

    public void setItemClickListener(OnItemClickListener itemClickListener) {
        this.itemClickListener = itemClickListener;
    }
}
