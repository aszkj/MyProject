package com.yldbkd.www.seller.android.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.MoneyUtils;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.bean.ProductSettle;
import com.yldbkd.www.seller.android.utils.Constants;

import java.util.List;

/**
 * 订单返款详细列表
 * <p/>
 * Created by linghuxj on 16/6/2.
 */
public class OrderSettleAdapter extends BaseAdapter<OrderSettleAdapter.ViewHolder> {

    private Context context;
    private List<ProductSettle> settles;
    private LayoutInflater inflater;

    public OrderSettleAdapter(Context context, List<ProductSettle> settles) {
        this.context = context;
        this.settles = settles;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public void onBindHolder(OrderSettleAdapter.ViewHolder holder, int position) {
        ProductSettle settle = settles.get(position);
        holder.nameView.setText(settle.getSaleProductName());
        holder.countView.setText(String.valueOf(settle.getSettleCount()));
        holder.amountView.setText(String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(settle.getSettleAmount())));
    }

    @Override
    public OrderSettleAdapter.ViewHolder onCreateHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.item_order_settle, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public int getCount() {
        return settles == null ? 0 : settles.size();
    }

    class ViewHolder extends BaseAdapter.Holder {

        TextView nameView;
        TextView countView;
        TextView amountView;

        public ViewHolder(View itemView) {
            super(itemView);
            this.nameView = (TextView) itemView.findViewById(R.id.tv_item_order_settle_name);
            this.countView = (TextView) itemView.findViewById(R.id.tv_item_order_settle_count);
            this.amountView = (TextView) itemView.findViewById(R.id.tv_item_order_settle_amount);
        }
    }
}
