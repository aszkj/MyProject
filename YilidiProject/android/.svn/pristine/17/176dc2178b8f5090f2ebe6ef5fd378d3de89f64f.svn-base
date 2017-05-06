package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.Ticket;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.library.android.common.MoneyUtils;

import java.util.List;

/**
 * 抢到红包-优惠券列表结果Adapter
 * <p>
 * Created by linghuxj on 2016/10/19.
 */

public class CouponResultAdapter extends RecyclerBaseAdapter<CouponResultAdapter.ViewHolder> {

    private Context context;
    private List<Ticket> tickets;
    private LayoutInflater inflater;

    public CouponResultAdapter(Context context, List<Ticket> tickets) {
        this.context = context;
        this.tickets = tickets;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public ViewHolder onCreateHolder(ViewGroup parent, int viewType) {
        return new ViewHolder(inflater.inflate(R.layout.item_red_envelop_result_coupon, parent, false));
    }

    @Override
    public void onBindHolder(ViewHolder holder, int position) {
        Ticket ticket = tickets.get(position);
        boolean isDiYong = ticket.getTicketType() == Constants.TicketType.DIYONG;
        holder.couponScopeView.setText(isDiYong ? context.getString(R.string.coupon_item_limited) :
                String.format(context.getString(R.string.coupon_item_scope), ticket.getUseScope()));
        holder.couponDescView.setText(ticket.getTicketDescription());
        holder.couponTimeView.setText(String.format(context.getString(R.string.coupon_item_time),
                ticket.getBeginTime().substring(0, 10), ticket.getEndTime().substring(0, 10)));
        holder.couponAmountView.setText(String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toIntPrice(ticket.getTicketAmount())));
        holder.couponTypeView.setText(ticket.getTicketTypeName());
        holder.couponStatusView.setText(ticket.getTicketStatusName());
    }

    @Override
    public int getCount() {
        return tickets == null ? 0 : tickets.size();
    }

    class ViewHolder extends RecyclerBaseAdapter.Holder {

        TextView couponScopeView;
        TextView couponDescView;
        TextView couponTimeView;
        TextView couponAmountView;
        TextView couponTypeView;
        TextView couponStatusView;

        public ViewHolder(View itemView) {
            super(itemView);
            this.couponScopeView = (TextView) itemView.findViewById(R.id.tv_item_coupon_scope);
            this.couponDescView = (TextView) itemView.findViewById(R.id.tv_item_coupon_desc);
            this.couponTimeView = (TextView) itemView.findViewById(R.id.tv_item_coupon_time);
            this.couponAmountView = (TextView) itemView.findViewById(R.id.tv_item_coupon_amount);
            this.couponTypeView = (TextView) itemView.findViewById(R.id.tv_item_coupon_type);
            this.couponStatusView = (TextView) itemView.findViewById(R.id.tv_item_coupon_status);
        }
    }
}
