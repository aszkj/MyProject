package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.Store;

import java.util.List;

/**
 * 搜索页面的地址列表Adapter
 * <p/>
 * Created by linghuxj on 15/10/12.
 */
public class StoreAdapter extends RecyclerView.Adapter<StoreAdapter.ViewHolder> {

    private Context context;
    private List<Store> stores;
    private LayoutInflater inflater;

    public StoreAdapter(List<Store> stores, Context context ) {
        this.stores = stores;
        this.context = context;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.store_item, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
        Store store = stores.get(position);
        holder.storeName.setText(store.getStoreName());
        holder.storeTime.setText(String.format(context.getResources().getString(R.string.product_store_business),
                store.getBusinessHoursBegin(), store.getBusinessHoursEnd()));
        holder.storeAddress.setText(store.getAddressDetail());
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
        return stores == null ? 0 : stores.size();
    }

    static class ViewHolder extends RecyclerView.ViewHolder {

        private TextView storeName;
        private TextView storeTime;
        private TextView storeAddress;

        public ViewHolder(View itemView) {
            super(itemView);
            storeName = (TextView) itemView.findViewById(R.id.store_name_view);
            storeTime = (TextView) itemView.findViewById(R.id.store_time_view);
            storeAddress = (TextView) itemView.findViewById(R.id.address_detail_view);
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
