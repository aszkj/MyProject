package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.os.Handler;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.AddressBase;
import com.yldbkd.www.buyer.android.utils.Constants;

import java.util.List;

/**
 * 搜索页面的地址列表Adapter
 * <p/>
 * Created by linghuxj on 15/10/12.
 */
public class SearchAddressAdapter extends RecyclerView.Adapter<SearchAddressAdapter.ViewHolder> {

    private List<AddressBase> addresses;
    private LayoutInflater inflater;
    private Handler handler;

    public SearchAddressAdapter(List<AddressBase> addresses, Context context , Handler handler) {
        this.addresses = addresses;
        this.handler = handler;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.search_address_item, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
        AddressBase address = addresses.get(position);
        holder.userNameView.setText(address.getConsigneeName());
        holder.mobileView.setText(address.getPhoneNo());
        holder.addressView.setText(address.getCommunity().getCommunityName() + address.getAddressDetail());
        if (itemClickListener != null) {
            holder.itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    itemClickListener.onItemClick(holder.itemView, holder.getAdapterPosition());
                }
            });
        }
        holder.addressEdit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                handler.obtainMessage(Constants.HandlerCode.ADDRESS_MODIFY, position).sendToTarget();
            }
        });
    }

    @Override
    public int getItemCount() {
        return addresses == null ? 0 : addresses.size();
    }

    static class ViewHolder extends RecyclerView.ViewHolder {

        private TextView userNameView;
        private TextView mobileView;
        private TextView addressView;
        private LinearLayout addressEdit;

        public ViewHolder(View itemView) {
            super(itemView);
            userNameView = (TextView) itemView.findViewById(R.id.address_user_view);
            mobileView = (TextView) itemView.findViewById(R.id.address_mobile_view);
            addressView = (TextView) itemView.findViewById(R.id.address_detail_view);
            addressEdit = (LinearLayout) itemView.findViewById(R.id.ll_location_address_edit_view);
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
