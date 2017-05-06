package com.yldbkd.www.seller.android.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.MoneyUtils;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.bean.ProductOrderItem;
import com.yldbkd.www.seller.android.utils.Constants;

import java.util.List;

/**
 * 订单商品列表也Adapter
 * <p/>
 * Created by linghuxj on 16/6/1.
 */
public class OrderProductAdapter extends BaseAdapter<OrderProductAdapter.ViewHolder> {

    private Context context;
    private List<ProductOrderItem> products;
    private LayoutInflater inflater;

    public OrderProductAdapter(Context context, List<ProductOrderItem> products) {
        this.context = context;
        this.products = products;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public void onBindHolder(ViewHolder holder, int position) {
        final ProductOrderItem product = products.get(position);
        ImageLoaderUtils.load(holder.productImageView, product.getSaleProductImageUrl());
        holder.productNameView.setText(product.getSaleProductName());
        holder.productSpecView.setText(product.getSaleProductSpec());
        holder.productCountView.setText(String.format(context.getString(R.string.order_detail_item_count),
                product.getCartNum()));
        holder.productPriceView.setText(String.valueOf(Constants.MONEY_FLAG + MoneyUtils
                .toPrice(product.getCurrentPrice())));
    }

    @Override
    public ViewHolder onCreateHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.item_order_product, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public int getCount() {
        return products == null ? 0 : products.size();
    }

    class ViewHolder extends BaseAdapter.Holder {

        ImageView productImageView;
        TextView productNameView;
        TextView productSpecView;
        TextView productCountView;
        TextView productPriceView;

        public ViewHolder(View itemView) {
            super(itemView);
            productImageView = (ImageView) itemView.findViewById(R.id.iv_order_detail_product_image);
            productNameView = (TextView) itemView.findViewById(R.id.iv_order_detail_product_name);
            productSpecView = (TextView) itemView.findViewById(R.id.iv_order_detail_product_capacity);
            productCountView = (TextView) itemView.findViewById(R.id.iv_order_detail_product_count);
            productPriceView = (TextView) itemView.findViewById(R.id.iv_order_detail_product_price);
        }
    }
}
