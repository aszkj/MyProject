package com.yldbkd.www.seller.android.adapter;

import android.support.v7.widget.GridLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.support.v7.widget.StaggeredGridLayoutManager;
import android.view.View;
import android.view.ViewGroup;

/**
 * RecyclerView的基类Adapter
 * <p/>
 * Created by linghuxj on 16/5/31.
 */
public abstract class BaseAdapter<VH extends BaseAdapter.Holder> extends RecyclerView.Adapter<VH> {

    private static final int HEADER_TYPE = 0xfe;
    private static final int NORMAL_TYPE = 0xfd;
    private static final int FOOTER_TYPE = 0xff;

    private View headerView;
    private View footerView;

    private OnItemClickListener itemClickListener;

    public void setOnItemClickListener(OnItemClickListener itemClickListener) {
        this.itemClickListener = itemClickListener;
    }

    public void setHeaderView(View headerView) {
        this.headerView = headerView;
        notifyItemInserted(0);
    }

    public void setFooterView(View footerView) {
        this.footerView = footerView;
        notifyItemInserted(getItemCount() - 1);
    }

    @Override
    public VH onCreateViewHolder(ViewGroup parent, int viewType) {
        if (headerView != null && viewType == HEADER_TYPE) return (VH) new Holder(headerView);
        if (footerView != null && viewType == FOOTER_TYPE) return (VH) new Holder(footerView);
        return onCreateHolder(parent, viewType);
    }

    @Override
    public void onBindViewHolder(VH holder, int position) {
        int viewType = getItemViewType(position);
        if (viewType == HEADER_TYPE || viewType == FOOTER_TYPE) {
            return;
        }
        position = getRealPosition(holder);
        onBindHolder(holder, position);
        if (itemClickListener != null) {
            final VH viewHolder = holder;
            final int index = position;
            holder.itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    itemClickListener.onItemClick(viewHolder.itemView, index);
                }
            });
        }
    }

    @Override
    public int getItemCount() {
        return getCount() + getHeaderCount() + getFooterCount();
    }

    @Override
    public int getItemViewType(int position) {
        if (headerView == null) {
            if (footerView == null) {
                return NORMAL_TYPE;
            } else {
                return position == getItemCount() - 1 ? FOOTER_TYPE : NORMAL_TYPE;
            }
        } else {
            if (footerView == null) {
                return position == 0 ? HEADER_TYPE : NORMAL_TYPE;
            } else {
                return position == 0 ? HEADER_TYPE : position == getItemCount() - 1 ? FOOTER_TYPE : NORMAL_TYPE;
            }
        }
    }

    private int getRealPosition(VH holder) {
        int position = holder.getLayoutPosition();
        return headerView == null ? position : position - 1;
    }

    public int getHeaderCount() {
        return headerView == null ? 0 : 1;
    }

    public int getFooterCount() {
        return footerView == null ? 0 : 1;
    }

    @Override
    public void onAttachedToRecyclerView(RecyclerView recyclerView) {
        super.onAttachedToRecyclerView(recyclerView);
        RecyclerView.LayoutManager manager = recyclerView.getLayoutManager();
        if (manager instanceof GridLayoutManager) {
            final GridLayoutManager gridManager = ((GridLayoutManager) manager);
            gridManager.setSpanSizeLookup(new GridLayoutManager.SpanSizeLookup() {
                @Override
                public int getSpanSize(int position) {
                    return getItemViewType(position) == HEADER_TYPE || getItemViewType(position) ==
                            FOOTER_TYPE ? gridManager.getSpanCount() : 1;
                }
            });
        }
    }

    @Override
    public void onViewAttachedToWindow(VH holder) {
        super.onViewAttachedToWindow(holder);
        ViewGroup.LayoutParams lp = holder.itemView.getLayoutParams();
        if (lp != null && lp instanceof StaggeredGridLayoutManager.LayoutParams
                && holder.getLayoutPosition() == 0) {
            StaggeredGridLayoutManager.LayoutParams p = (StaggeredGridLayoutManager.LayoutParams) lp;
            p.setFullSpan(true);
        }
    }

    class Holder extends RecyclerView.ViewHolder {

        public Holder(View itemView) {
            super(itemView);
        }
    }

    public abstract VH onCreateHolder(ViewGroup parent, int viewType);

    public abstract void onBindHolder(VH holder, int position);

    public abstract int getCount();

    public interface OnItemClickListener {

        void onItemClick(View view, int position);
    }
}
