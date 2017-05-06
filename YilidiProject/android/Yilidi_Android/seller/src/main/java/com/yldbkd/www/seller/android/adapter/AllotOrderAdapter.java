package com.yldbkd.www.seller.android.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.MoneyUtils;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.bean.AllotOrderBase;
import com.yldbkd.www.seller.android.utils.AllotOrderStatusUtils;
import com.yldbkd.www.seller.android.utils.Constants;

import java.util.List;

/**
 * 调货单列表adapter
 * <p/>
 * Created by linghuxj on 16/6/6.
 */
public class AllotOrderAdapter extends BaseAdapter<AllotOrderAdapter.ViewHolder> {

    private Context context;
    private List<AllotOrderBase> allotOrders;
    private LayoutInflater inflater;

    private boolean isComplete;

    public AllotOrderAdapter(Context context, List<AllotOrderBase> allotOrders,
                             Integer whetherComplete) {
        this.context = context;
        this.allotOrders = allotOrders;
        this.inflater = LayoutInflater.from(context);
        this.isComplete = whetherComplete != null && whetherComplete == 1;
    }

    @Override
    public ViewHolder onCreateHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.item_allot_order, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindHolder(ViewHolder holder, int position) {
        AllotOrderBase allotOrder = allotOrders.get(position);
        holder.orderNoView.setText(allotOrder.getAllotOrderNo());
        holder.orderStatusView.setText(AllotOrderStatusUtils.getName(allotOrder.getStatusCode()));
        holder.orderAddressView.setText(allotOrder.getConsAddress());
        holder.orderTimeView.setText(allotOrder.getCreateTime());
        holder.orderAmtView.setText(String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(
                isComplete ? allotOrder.getRealAllotTotalAmount() : allotOrder.getAllotTotalAmount())));
        holder.orderCountView.setText(String.format(context.getString(R.string.allot_order_count),
                isComplete ? allotOrder.getRealAllotTotalCount() : allotOrder.getAllotTotalCount()));
    }

    @Override
    public int getCount() {
        return allotOrders == null ? 0 : allotOrders.size();
    }

    class ViewHolder extends BaseAdapter.Holder {

        TextView orderNoView;
        TextView orderStatusView;
        ImageView orderTypeView;
        TextView orderAddressView;
        TextView orderTimeView;
        TextView orderAmtView;
        TextView orderCountView;

        public ViewHolder(View itemView) {
            super(itemView);
            this.orderNoView = (TextView) itemView.findViewById(R.id.tv_item_allot_order_no);
            this.orderStatusView = (TextView) itemView.findViewById(R.id.tv_item_allot_order_status);
            this.orderTypeView = (ImageView) itemView.findViewById(R.id.iv_item_allot_order_image_type);
            this.orderAddressView = (TextView) itemView.findViewById(R.id.tv_item_allot_order_address);
            this.orderTimeView = (TextView) itemView.findViewById(R.id.tv_item_allot_order_time);
            this.orderAmtView = (TextView) itemView.findViewById(R.id.tv_item_allot_order_amount);
            this.orderCountView = (TextView) itemView.findViewById(R.id.tv_item_allot_order_count);
        }
    }
}
