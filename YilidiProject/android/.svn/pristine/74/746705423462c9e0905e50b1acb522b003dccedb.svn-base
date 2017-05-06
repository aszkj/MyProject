package com.yldbkd.www.seller.android.adapter;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.DistanceUtils;
import com.yldbkd.www.library.android.common.MoneyUtils;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.bean.OrderBase;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.utils.TimeUtils;

import java.util.List;

/**
 * 订单列表Item
 * <p/>
 * Created by linghuxj on 16/5/31.
 */
public class OrderAdapter extends BaseAdapter<OrderAdapter.ViewHolder> {

    private Context context;
    private List<OrderBase> orders;
    private LayoutInflater inflater;

    public OrderAdapter(Context context, List<OrderBase> orders) {
        this.context = context;
        this.orders = orders;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public void onBindHolder(ViewHolder holder, int position) {
        final OrderBase order = orders.get(position);
        final boolean isDeliver = Constants.DeliveryMode.DELIVER_GOODS == order.getDeliveryModeCode();
        holder.timeView.setText(order.getCreateTime());
        holder.consigneeLayout.setVisibility(isDeliver ? View.VISIBLE : View.GONE);
        holder.pickUpLayout.setVisibility(isDeliver ? View.GONE : View.VISIBLE);
        if (isDeliver) {
            holder.distanceView.setVisibility(View.VISIBLE);
            holder.distanceView.setText(DistanceUtils.getDistance(order.getConsigneeAddress().getDistance()));
            holder.consigneeNameView.setText(order.getConsigneeAddress().getConsignee());
            holder.consigneeTelView.setText(order.getConsigneeAddress().getConsMobile());
            holder.consigneeAddressView.setText(order.getConsigneeAddress().getConsAddress());
        }else{
            holder.distanceView.setVisibility(View.GONE);
        }
        String time = TimeUtils.deliveryTime(order.getPayTime());
        if (isDeliver && TextUtils.isEmpty(time)) {
            holder.deliveryView.setText("");
        } else if (isDeliver) {
            holder.deliveryView.setText(String.format(context.getString(R.string.order_delivery_time), time));
        } else {
            holder.deliveryView.setText(context.getString(R.string.order_list_pick_up_time));
        }
        holder.amountView.setText(String.format(context.getString(R.string.order_total_amount),
                String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(order.getPayableAmount()))));
        holder.telView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                context.startActivity(new Intent(Intent.ACTION_CALL, Uri.parse("tel:" +
                        (isDeliver ? order.getConsigneeAddress().getConsMobile() : order.getBuyerMobile()))));
            }
        });
    }

    @Override
    public ViewHolder onCreateHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.item_order, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public int getCount() {
        return orders == null ? 0 : orders.size();
    }

    class ViewHolder extends BaseAdapter.Holder {

        TextView timeView;
        TextView distanceView;
        RelativeLayout telView;
        LinearLayout consigneeLayout;
        TextView consigneeNameView;
        TextView consigneeTelView;
        TextView consigneeAddressView;
        LinearLayout pickUpLayout;
        TextView deliveryView;
        TextView amountView;

        public ViewHolder(View itemView) {
            super(itemView);
            this.timeView = (TextView) itemView.findViewById(R.id.tv_item_order_time);
            this.distanceView = (TextView) itemView.findViewById(R.id.tv_item_order_distance);
            this.telView = (RelativeLayout) itemView.findViewById(R.id.rl_item_order_tel);
            this.consigneeLayout = (LinearLayout) itemView.findViewById(R.id.ll_order_list_consignee);
            this.consigneeNameView = (TextView) itemView.findViewById(R.id.tv_item_order_consignee_name);
            this.consigneeTelView = (TextView) itemView.findViewById(R.id.tv_item_order_consignee_mobile);
            this.consigneeAddressView = (TextView) itemView.findViewById(R.id.tv_item_order_consignee_address);
            this.pickUpLayout = (LinearLayout) itemView.findViewById(R.id.ll_order_list_pick_up);
            this.deliveryView = (TextView) itemView.findViewById(R.id.tv_item_order_delivery);
            this.amountView = (TextView) itemView.findViewById(R.id.tv_item_order_amount);
        }
    }
}
