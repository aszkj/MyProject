package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.support.v4.content.ContextCompat;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.TicketTypes;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.library.android.common.MoneyUtils;

import java.util.List;

/**
 * @创建者 李贞高
 * @创建时间 2016/11/22 17:27
 * @描述 订单结算优惠券类型
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class CartCouponTypeAdapter extends BaseAdapter {

    private Context context;
    private List<TicketTypes> ticketTypes;
    private LayoutInflater inflater;
    private long couponMoney = 0;
    private Integer position = 0;
    private Integer isTicketSingleSelection;

    public CartCouponTypeAdapter(List<TicketTypes> ticketTypes, Context context) {
        this.context = context;
        this.ticketTypes = ticketTypes;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public int getCount() {
        return ticketTypes == null ? 0 : ticketTypes.size();
    }

    @Override
    public Object getItem(int i) {
        return getCount() == 0 ? null : ticketTypes.get(i);
    }

    @Override
    public long getItemId(int i) {
        return i;
    }

    @Override
    public View getView(int i, View view, ViewGroup viewGroup) {
        ViewHolder holder;
        if (view == null) {
            view = inflater.inflate(R.layout.cart_coupon_type_item, viewGroup, false);
            holder = new ViewHolder();
            initView(holder, view);
            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }
        setData(holder, ticketTypes.get(i), i);
        return view;
    }

    private void initView(ViewHolder holder, View view) {
        holder.couponName = (TextView) view.findViewById(R.id.coupon_content_text);
        holder.couponNote = (TextView) view.findViewById(R.id.coupon_note_textview);
    }

    private void setData(ViewHolder holder, TicketTypes ticketType, int i) {
        holder.couponName.setText(ticketType.getTicketTypeName());
        boolean isTicket = ticketType.getTicketInfoList() == null || ticketType.getTicketInfoList().size() == 0;
        boolean isSingle = isTicketSingleSelection == Constants.TicketSingleType.SINGLE;
        int textColorRes;
        int textContentRes;
        String textContentData;
        if (i == position) {//单选且指定item,显示优惠金额
            textContentData = couponMoney > 0 ? String.format(context.getResources().getString(R.string.cart_coupon_money), MoneyUtils.toIntPrice(couponMoney))
                    : (isSingle ? String.format(context.getResources().getString(R.string.cart_confirm_coupon_empty), ticketType.getTicketTypeName())
                    : String.format(context.getResources().getString(R.string.cart_confirm_coupon_count), isTicket ? 0 : ticketType.getTicketInfoList().size()));
            textColorRes = isTicket || (couponMoney <= 0 && isSingle) ? R.color.secondaryText : R.color.colorPrimary;
        } else {
            if (isSingle) {
                textColorRes = R.color.secondaryText;
                textContentRes = R.string.cart_confirm_coupon_empty;
                textContentData = String.format(context.getResources().getString(textContentRes), ticketType.getTicketTypeName());
            } else {
                textColorRes = isTicket ? R.color.secondaryText : R.color.colorPrimary;
                textContentRes = R.string.cart_confirm_coupon_count;
                textContentData = String.format(context.getResources().getString(textContentRes), isTicket ? 0 : ticketType.getTicketInfoList().size());
            }
        }
        holder.couponNote.setText(isTicket ? context.getResources().getString(R.string.cart_coupon_empty) : textContentData);
        holder.couponNote.setTextColor(ContextCompat.getColor(context, textColorRes));
    }

    public void setDefaultCouponSelection(Integer isTicketSingleSelection) {
        this.isTicketSingleSelection = isTicketSingleSelection;
    }

    public void setCouponMoney(Long couponMoney, Integer position) {
        this.couponMoney = couponMoney;
        this.position = position;
    }

    private static class ViewHolder {
        TextView couponName;
        TextView couponNote;
    }
}
