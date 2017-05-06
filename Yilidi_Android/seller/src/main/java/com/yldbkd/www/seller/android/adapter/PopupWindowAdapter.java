package com.yldbkd.www.seller.android.adapter;

import android.content.Context;
import android.support.v4.content.ContextCompat;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.bean.ClassBean;

import java.util.List;

/**
 * 分类、排序弹框adapter
 * <p/>
 * Created by lizhg on 17/1/11.
 */
public class PopupWindowAdapter extends RecyclerView.Adapter<PopupWindowAdapter.ViewHolder> {

    private int classPosition;//选中的分类
    private int sortPositon;//选中的排序
    private int[] sorts;
    private boolean isClass;
    private Context context;
    private List<ClassBean> classList;
    private LayoutInflater inflater;

    public PopupWindowAdapter(Context context, List<ClassBean> classList, int[] sort, boolean isClass, int classPosition, int sortPositon) {
        this.context = context;
        this.classList = classList;
        this.sorts = sort;
        this.isClass = isClass;
        this.classPosition = classPosition;
        this.sortPositon = sortPositon;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.popupwindow_item, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
        String textContent;
        int choosePosition;
        if (isClass) {
            ClassBean classBean = classList.get(position);
            textContent = classBean.getClassName();
            choosePosition = classPosition;
        } else {
            textContent = context.getResources().getString(sorts[position]);
            choosePosition = sortPositon;
        }
        if (position == choosePosition) {
            holder.rlItemContent.setBackgroundResource(R.drawable.class_choose);
            holder.popupwindowText.setTextColor(ContextCompat.getColor(context, R.color.white));
        } else {
            holder.rlItemContent.setBackgroundResource(R.drawable.class_unchoose);
            holder.popupwindowText.setTextColor(ContextCompat.getColor(context, R.color.secondaryText));
        }
        holder.popupwindowText.setText(textContent);
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
        if (isClass) {
            return classList == null ? 0 : classList.size();
        }
        return sorts == null ? 0 : sorts.length;
    }

    public void setType(boolean isClass) {
        this.isClass = isClass;
    }

    public void setChoosePosition(int classChoosePosition, int sortChoosePosition) {
        this.classPosition = classChoosePosition;
        this.sortPositon = sortChoosePosition;
    }

    static class ViewHolder extends RecyclerView.ViewHolder {

        private TextView popupwindowText;
        private RelativeLayout rlItemContent;

        public ViewHolder(View itemView) {
            super(itemView);
            popupwindowText = (TextView) itemView.findViewById(R.id.popupwindow_item_text);
            rlItemContent = (RelativeLayout) itemView.findViewById(R.id.rl_item_content);
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
