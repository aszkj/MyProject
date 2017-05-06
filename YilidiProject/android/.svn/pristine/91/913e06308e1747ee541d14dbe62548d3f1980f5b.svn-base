package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.os.Handler;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * 购物车换购商品列表Adapter
 * <p/>
 * Created by op on 2015/12/17.
 */
public class HorizontalAdapter extends RecyclerView.Adapter<HorizontalAdapter.ViewHolder> {

    private Context mContext;
    private LayoutInflater mInflater;
    private List<SaleProduct> mDatas;
    private Integer parentPosition;
    private Handler handler;
    private List<SaleProduct> exProducts = new ArrayList<>();

    public HorizontalAdapter(Context context, List<SaleProduct> datats, Integer parentPosition, Handler handler) {
        mContext = context;
        mInflater = LayoutInflater.from(context);
        mDatas = datats;
        this.parentPosition = parentPosition;
        this.handler = handler;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = mInflater.inflate(R.layout.cart_exchange_item, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
        final SaleProduct item = exProducts.get(position);
        ImageLoaderUtils.load(holder.ivExchangeImg, item.getSaleProductImageUrl());
        holder.tvExchangeName.setText(item.getSaleProductName());
        holder.tvExchangeStandard.setText(item.getSaleProductSpec());
        holder.tvExchangePrice.setText(Constants.MONEY_FLAG + item.getPromotionalPrice());
        holder.ivExchangeSubmit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                handler.obtainMessage(Constants.HandlerCode.CART_EXCHANGE_PRODUCT_CART, parentPosition, position)
                        .sendToTarget();
            }
        });
    }

    @Override
    public int getItemCount() {
        if (mDatas == null || mDatas.size() == 0) {
            return 0;
        }
        exProducts.clear();
        for (SaleProduct saleProduct : mDatas) {
            if (saleProduct.getProductStatus() != Constants.ProductStatus.HAD_CART) {
                exProducts.add(saleProduct);
            }
        }
        return exProducts.size();
    }

    public void removeItem(Integer position) {
        exProducts.remove(exProducts.get(position));
        notifyItemRemoved(position);
    }

    class ViewHolder extends RecyclerView.ViewHolder {

        ImageView ivExchangeImg;
        TextView tvExchangeName;
        TextView tvExchangeStandard;
        TextView tvExchangePrice;
        ImageView ivExchangeSubmit;

        public ViewHolder(View view) {
            super(view);
            this.ivExchangeImg = (ImageView) view.findViewById(R.id.cart_exchange_item_img);
            this.tvExchangeName = (TextView) view.findViewById(R.id.cart_exchange_item_name);
            this.tvExchangeStandard = (TextView) view.findViewById(R.id.cart_exchange_item_standard);
            this.tvExchangePrice = (TextView) view.findViewById(R.id.cart_exchange_item_price);
            this.ivExchangeSubmit = (ImageView) view.findViewById(R.id.cart_exchange_item_submit);
        }
    }
}
