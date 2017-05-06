package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.support.v4.content.ContextCompat;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.Ticket;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.DateUtils;
import com.yldbkd.www.library.android.common.MoneyUtils;

import java.util.List;

/**
 * @创建者 李贞高
 * @创建时间 2016/11/16 14:39
 * @描述 优惠券adapter
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class CouponAdapter extends BaseAdapter {

    private int colorResource;
    private int itemBg;
    private List<Ticket> mDatas;
    private LayoutInflater inflater;
    private Context context;
    private int titleColorRes = R.color.primaryText;
    private int descColorRes = R.color.secondaryText;
    private int dateColorRes = R.color.lightText;

    public CouponAdapter(Context context, List<Ticket> datas, int colorResource, int itemBg) {
        mDatas = datas;
        this.inflater = LayoutInflater.from(context);
        this.context = context;
        this.colorResource = colorResource;
        this.itemBg = itemBg;
    }

    @Override
    public int getCount() {
        return mDatas == null ? 0 : mDatas.size();
    }

    @Override
    public Object getItem(int i) {
        return getCount() == 0 ? null : mDatas.get(i);
    }

    @Override
    public long getItemId(int i) {
        return i;
    }

    @Override
    public View getView(int i, View view, ViewGroup viewGroup) {
        ViewHolder holder;
        if (view == null) {
            holder = new ViewHolder();
            view = inflater.inflate(R.layout.coupon_item, viewGroup, false);
            holder.couponItemLayout = (LinearLayout) view.findViewById(R.id.coupon_item_layout);
            holder.couponName = (TextView) view.findViewById(R.id.coupon_name);
            holder.couponMoney = (TextView) view.findViewById(R.id.coupon_money_tv);
            holder.moneyFalg = (TextView) view.findViewById(R.id.money_falg_tv);
            holder.couponScope = (TextView) view.findViewById(R.id.coupon_scope);
            holder.couponRule = (TextView) view.findViewById(R.id.coupon_rule);
            holder.couponExpireDate = (TextView) view.findViewById(R.id.coupon_expire_date);
            holder.couponStatus = (TextView) view.findViewById(R.id.coupon_status);
            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }
        Ticket ticket = mDatas.get(i);
        holder.couponName.setText(ticket.getTicketTypeName());
        holder.couponMoney.setText(String.valueOf(MoneyUtils.toIntPrice(ticket.getTicketAmount())));
        holder.couponScope.setText(ticket.getTicketType() == Constants.TicketType.YOUHUI
                ? String.format(context.getResources().getString(R.string.coupon_scope), ticket.getUseScope()) : ticket.getUseScope());
        holder.couponRule.setText(ticket.getTicketDescription());
        holder.couponExpireDate.setText(String.format(context.getResources().getString(R.string.coupon_time), DateUtils.parseDateChange(ticket.getBeginTime(), DateUtils.DAY_TIME_FORMAT_SHORT),
                DateUtils.parseDateChange(ticket.getEndTime(), DateUtils.DAY_TIME_FORMAT_SHORT)));
        holder.couponStatus.setText(ticket.getTicketStatusName());

        holder.couponItemLayout.setBackgroundResource(itemBg);
        holder.couponName.setTextColor(ContextCompat.getColor(context, colorResource));
        holder.couponMoney.setTextColor(ContextCompat.getColor(context, colorResource));
        holder.moneyFalg.setTextColor(ContextCompat.getColor(context, colorResource));

        holder.couponScope.setTextColor(ContextCompat.getColor(context, titleColorRes));
        holder.couponRule.setTextColor(ContextCompat.getColor(context, descColorRes));
        holder.couponExpireDate.setTextColor(ContextCompat.getColor(context, dateColorRes));
        return view;
    }

    public void setColorResource(int colorResource) {
        this.colorResource = colorResource;
    }

    public void setBgResource(int bgResource) {
        this.itemBg = bgResource;
    }

    public void setContentTextColor(int titleColorRes, int descColorRes, int dateColorRes) {
        this.titleColorRes = titleColorRes;
        this.descColorRes = descColorRes;
        this.dateColorRes = dateColorRes;
    }

    private static class ViewHolder {
        LinearLayout couponItemLayout;
        TextView couponName;
        TextView couponMoney;
        TextView moneyFalg;
        TextView couponScope;
        TextView couponRule;
        TextView couponExpireDate;
        TextView couponStatus;
    }
}
