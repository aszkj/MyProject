package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.os.Handler;
import android.support.v4.content.ContextCompat;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.Ticket;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.library.android.common.MoneyUtils;

import java.util.List;
import java.util.Map;

/**
 * @创建者 李贞高
 * @创建时间 2016/11/16 14:39
 * @描述 结算优惠券列表adapter
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class CartCouponAdapter extends BaseAdapter {

    private List<Ticket> mDatas;
    private LayoutInflater inflater;
    private Context context;
    private android.os.Handler handler;
    private int couponItemBg;
    private int couponColor;
    private int couponCheckImage;
    private Map<Integer, Integer> checkedMap;

    public CartCouponAdapter(Context context, List<Ticket> datas, Map<Integer, Integer> map, Handler handler) {
        mDatas = datas;
        this.inflater = LayoutInflater.from(context);
        this.context = context;
        this.checkedMap = map;
        this.handler = handler;
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
    public View getView(final int i, View view, ViewGroup viewGroup) {
        ViewHolder holder;
        if (view == null) {
            holder = new ViewHolder();
            view = inflater.inflate(R.layout.cart_coupon_item, viewGroup, false);
            holder.checkCouponLayout = (LinearLayout) view.findViewById(R.id.check_coupon_layout);
            holder.couponMoneyFalg = (TextView) view.findViewById(R.id.cart_coupon_money_falg);
            holder.couponMoney = (TextView) view.findViewById(R.id.cart_coupon_money);
            holder.couponScope = (TextView) view.findViewById(R.id.coupon_scope);
            holder.couponRule = (TextView) view.findViewById(R.id.coupon_rule);
            holder.checkBox = (ImageView) view.findViewById(R.id.coupon_checkbox);
            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }
        Ticket ticket = mDatas.get(i);
        holder.couponMoney.setText(String.valueOf(MoneyUtils.toIntPrice(ticket.getTicketAmount())));
        holder.couponRule.setText(ticket.getTicketDescription());
        holder.couponScope.setText(ticket.getTicketType() == Constants.TicketType.YOUHUI
                ? String.format(context.getResources().getString(R.string.coupon_scope), ticket.getUseScope()) : ticket.getUseScope());
        holder.checkCouponLayout.setBackgroundResource(couponItemBg);
        holder.couponMoney.setTextColor(ContextCompat.getColor(context, couponColor));
        holder.couponMoneyFalg.setTextColor(ContextCompat.getColor(context, couponColor));
        showDefaultStatus(holder, ticket);

        holder.checkCouponLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                handler.obtainMessage(Constants.HandlerCode.CHECK_COUPON, i).sendToTarget();
            }
        });
        return view;
    }

    private void showDefaultStatus(ViewHolder holder, Ticket ticket) {
        if (checkedMap.get(ticket.getTicketId()) != null) {
            ticket.setCheck(true);
        }
        holder.checkBox.setBackgroundResource(ticket.isCheck() ? couponCheckImage : R.mipmap.checkbox_unchecked);
    }

    public void changeProductCheck(View view, int position) {
        ViewHolder holder = (ViewHolder) view.getTag();
        Ticket ticket = mDatas.get(position);
        holder.checkBox.setBackgroundResource(ticket.isCheck() ? couponCheckImage :
                R.mipmap.checkbox_unchecked);
    }

    public void setCouponColorResources(int couponItemBg, int couponColor, int couponCheckImage) {
        this.couponItemBg = couponItemBg;
        this.couponColor = couponColor;
        this.couponCheckImage = couponCheckImage;
    }

    private static class ViewHolder {
        LinearLayout checkCouponLayout;
        TextView couponMoneyFalg;
        TextView couponMoney;
        TextView couponScope;
        TextView couponRule;
        ImageView checkBox;
    }
}
