package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;
import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.library.android.common.MoneyUtils;

import java.util.List;

/**
 * 购物车结算清单Adapter
 * <p/>
 * Created by linghuxj on 15/10/29.
 */
public class CartItemAdapter extends BaseAdapter {

    private List<SaleProduct> products;
    private Context context;
    private LayoutInflater inflater;

    public CartItemAdapter(List<SaleProduct> products, Context context) {
        this.products = products;
        this.context = context;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public int getCount() {
        return products == null ? 0 : products.size();
    }

    @Override
    public Object getItem(int i) {
        return getCount() == 0 ? null : products.get(i);
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
            view = inflater.inflate(R.layout.cart_item_item, viewGroup, false);
            initView(holder, view);
            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }
        setData(holder, products.get(i));
        return view;
    }

    private void initView(ViewHolder holder, View view) {
        holder.proNameView = (TextView) view.findViewById(R.id.item_name_view);
        holder.proCountView = (TextView) view.findViewById(R.id.item_count_view);
        holder.proAmountView = (TextView) view.findViewById(R.id.item_amount_view);
    }

    private void setData(ViewHolder holder, SaleProduct product) {
        holder.proNameView.setText(product.getSaleProductName());
        holder.proCountView.setText(String.format(context.getString(R.string.x_number), product.getCartNum()));
        holder.proAmountView.setText(String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(product.getOrderPrice())));
    }

    private static class ViewHolder {
        TextView proNameView;
        TextView proCountView;
        TextView proAmountView;
    }
}
