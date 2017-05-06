package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;
import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.library.android.common.MoneyUtils;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;

import java.util.List;

/**
 * 评价页面的商品列表Adapter
 * <p/>
 * Created by linghuxj on 15/10/14.
 */
public class OrderDetailProductAdapter extends BaseAdapter {

    private List<SaleProduct> list;
    private LayoutInflater inflater;

    public OrderDetailProductAdapter(List<SaleProduct> list, Context context) {
        this.list = list;
        inflater = LayoutInflater.from(context);

    }

    @Override
    public int getCount() {
        return list == null ? 0 : list.size();
    }

    @Override
    public Object getItem(int i) {
        return list.get(i);
    }

    @Override
    public long getItemId(int i) {
        return i;
    }

    @Override
    public View getView(final int position, View convertView, ViewGroup parent) {
        ViewHolder viewHolder;
        if (convertView == null) {
            viewHolder = new ViewHolder();
            convertView = inflater.inflate(R.layout.order_detail_product_item, parent, false);
            viewHolder.imageView = (ImageView) convertView.findViewById(R.id.product_image);
            viewHolder.productNameView = (TextView) convertView.findViewById(R.id.product_name);
            viewHolder.productCount = (TextView) convertView.findViewById(R.id.product_count);
            viewHolder.productPrice = (TextView) convertView.findViewById(R.id.product_price);
            viewHolder.product_capacity = (TextView) convertView.findViewById(R.id.product_capacity);
            convertView.setTag(viewHolder);
        } else {
            viewHolder = (ViewHolder) convertView.getTag();
        }
        final SaleProduct saleProduct = list.get(position);
        ImageLoaderUtils.load(viewHolder.imageView, saleProduct.getSaleProductImageUrl());
        viewHolder.productNameView.setText(saleProduct.getSaleProductName());
        viewHolder.productCount.setText(Constants.COUNT_FLAG + saleProduct.getCartNum());
        viewHolder.productPrice.setText(Constants.MONEY_FLAG + MoneyUtils.toPrice(saleProduct.getOrderPrice()));
        viewHolder.product_capacity.setText(saleProduct.getSaleProductSpec());
        return convertView;
    }

    private static class ViewHolder {
        ImageView imageView;
        TextView productNameView;
        TextView productCount;
        TextView productPrice;
        TextView product_capacity;
    }
}
