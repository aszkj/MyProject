package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.GiftInfo;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.library.android.common.MoneyUtils;

/**
 * 购物车结算清单Adapter
 * <p/>
 * Created by linghuxj on 15/10/29.
 */
public class CartActDataAdapter extends BaseAdapter {

    private GiftInfo giftInfos;
    private Context context;
    private LayoutInflater inflater;

    public CartActDataAdapter(GiftInfo giftInfos, Context context) {
        this.giftInfos = giftInfos;
        this.context = context;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public int getCount() {
        if (giftInfos == null) {
            return 0;
        }
        return (giftInfos.getGiftProductList() == null ? 0 : giftInfos.getGiftProductList().size()) + (giftInfos.getGiftCouponList() == null ? 0 : giftInfos.getGiftCouponList().size());
    }

    @Override
    public Object getItem(int i) {
        if (getCount() == 0) {
            return null;
        }
        if (getCount() < (giftInfos.getGiftProductList() == null ? 0 : giftInfos.getGiftProductList().size())) {
            return giftInfos.getGiftProductList().get(i);
        } else {
            return giftInfos.getGiftCouponList().get(i - giftInfos.getGiftProductList().size());
        }
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
            view = inflater.inflate(R.layout.gift_item, viewGroup, false);
            initView(holder, view);
            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }
        setData(holder, i);
        return view;
    }

    private void initView(ViewHolder holder, View view) {
        holder.giftNameView = (TextView) view.findViewById(R.id.gift_name_view);
        holder.giftCountView = (TextView) view.findViewById(R.id.gift_count_view);
        holder.giftAmountView = (TextView) view.findViewById(R.id.gift_amount_view);
    }

    private void setData(ViewHolder holder, int i) {
        int giftProductCount = giftInfos.getGiftProductList() == null ? 0 : giftInfos.getGiftCouponList().size();
        if (i < giftProductCount) {
            holder.giftNameView.setText(giftInfos.getGiftProductList().get(i).getSaleProductName());
            holder.giftCountView.setText(String.format(context.getString(R.string.x_number), giftInfos.getGiftProductList().get(i).getCartNum()));
            holder.giftAmountView.setText(String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(giftInfos.getGiftProductList().get(i).getOrderPrice())));
        } else {
            holder.giftNameView.setText(giftInfos.getGiftCouponList().get(i - giftProductCount).getTicketTypeName());
            holder.giftCountView.setText(String.format(context.getString(R.string.x_number), 1));
            holder.giftAmountView.setText(String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(null)));
        }
    }

    private static class ViewHolder {
        TextView giftNameView;
        TextView giftCountView;
        TextView giftAmountView;
    }
}
