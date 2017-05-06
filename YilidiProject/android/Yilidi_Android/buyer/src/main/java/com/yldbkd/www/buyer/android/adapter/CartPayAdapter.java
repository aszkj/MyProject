package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;
import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.PayType;
import com.yldbkd.www.buyer.android.utils.Constants;

import java.util.List;

/**
 * 购物车结算支付方式Adapter
 * <p/>
 * Created by linghuxj on 15/10/29.
 */
public class CartPayAdapter extends BaseAdapter {

    private List<PayType> payTypes;
    private LayoutInflater inflater;
    private boolean isDisable = false;

    public CartPayAdapter(List<PayType> payTypes, Context context) {
        this.payTypes = payTypes;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public int getCount() {
        return payTypes == null ? 0 : payTypes.size();
    }

    @Override
    public Object getItem(int i) {
        return getCount() == 0 ? null : payTypes.get(i);
    }

    @Override
    public long getItemId(int i) {
        return i;
    }

    @Override
    public View getView(int i, View view, ViewGroup viewGroup) {
        ViewHolder holder;
        if (view == null) {
            view = inflater.inflate(R.layout.cart_pay_item, viewGroup, false);
            holder = new ViewHolder();
            initView(holder, view);
            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }
        setData(holder, payTypes.get(i));
        return view;
    }

    private void initView(ViewHolder holder, View view) {
        holder.imageView = (ImageView) view.findViewById(R.id.cart_pay_image_view);
        holder.nameView = (TextView) view.findViewById(R.id.cart_pay_name_view);
        holder.checkView = (ImageView) view.findViewById(R.id.cart_pay_checkbox);
    }

    private void setData(ViewHolder holder, PayType payType) {
        if (payType.getPayTypeCode() == Constants.OnlinePayType.ALI_PAY) {
            holder.imageView.setImageResource(R.mipmap.ali_pay_logo);
        } else if (payType.getPayTypeCode() == Constants.OnlinePayType.WX_PAY) {
            holder.imageView.setImageResource(R.mipmap.weixin_pay_logo);
        }
        holder.nameView.setText(payType.getPayTypeName());
        holder.checkView.setVisibility(isDisable ? View.GONE : View.VISIBLE);
        holder.checkView.setBackgroundResource(payType.getIsCheck() ? R.mipmap.checkbox_checked : R.mipmap.checkbox_unchecked);
    }

    public void setIsDisable(boolean isDisable) {
        this.isDisable = isDisable;
    }

    private static class ViewHolder {
        ImageView imageView;
        TextView nameView;
        ImageView checkView;
    }
}
