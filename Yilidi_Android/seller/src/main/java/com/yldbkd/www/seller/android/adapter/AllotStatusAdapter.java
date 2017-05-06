package com.yldbkd.www.seller.android.adapter;

import android.content.Context;
import android.support.v4.content.ContextCompat;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.bean.AllotStatus;

import java.util.List;

/**
 * 调货单状态记录
 * <p/>
 * Created by linghuxj on 16/6/6.
 */
public class AllotStatusAdapter extends BaseAdapter<AllotStatusAdapter.ViewHolder> {

    private Context context;
    private List<AllotStatus> statuses;
    private LayoutInflater inflater;

    public AllotStatusAdapter(Context context, List<AllotStatus> statuses) {
        this.context = context;
        this.statuses = statuses;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public ViewHolder onCreateHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.item_allot_order_record, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindHolder(ViewHolder holder, int position) {
        AllotStatus allotStatus = statuses.get(position);
        boolean isChecked = position == 0;
        holder.dividerView.setVisibility(isChecked ? View.GONE : View.VISIBLE);
        holder.orderStatusView.setText(String.format(context.getString(R.string.allot_order_detail_status)
                , allotStatus.getStatusCodeName()));
        holder.orderStatusView.setTextColor(ContextCompat.getColor(context, isChecked ?
                R.color.colorPrimary : R.color.secondaryText));
        holder.orderTimeView.setText(allotStatus.getStatusTime());
        holder.orderTimeView.setTextColor(ContextCompat.getColor(context, isChecked ? R.color.primaryText :
                R.color.secondaryText));
        holder.orderRemarkView.setText(allotStatus.getStatusNote());
        holder.imageView.setBackgroundResource(getImageResourceId(position));
    }

    @Override
    public int getCount() {
        return statuses == null ? 0 : statuses.size();
    }

    private int getImageResourceId(int position) {
        if (position == 0) {
            return R.drawable.tree_checked;
        } else {
            return R.drawable.tree_unchecked;
        }
    }

    class ViewHolder extends BaseAdapter.Holder {

        View dividerView;
        ImageView imageView;
        TextView orderStatusView;
        TextView orderTimeView;
        TextView orderRemarkView;

        public ViewHolder(View itemView) {
            super(itemView);
            this.dividerView = itemView.findViewById(R.id.v_divider);
            this.imageView = (ImageView) itemView.findViewById(R.id.iv_item_allot_record_image);
            this.orderStatusView = (TextView) itemView.findViewById(R.id.tv_item_allot_record_status);
            this.orderTimeView = (TextView) itemView.findViewById(R.id.tv_item_allot_record_time);
            this.orderRemarkView = (TextView) itemView.findViewById(R.id.tv_item_allot_record_remark);
        }
    }
}
