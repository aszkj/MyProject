package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.os.Handler;
import android.support.v4.content.ContextCompat;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.library.android.common.MoneyUtils;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;

import java.util.List;

/**
 * 收藏页面Adapter
 * <p/>
 * Created by linghuxj on 2017/2/21.
 */

public class CollectAdapter extends RecyclerBaseAdapter<CollectAdapter.ViewHolder> {

    private List<SaleProduct> saleProducts;
    private Context context;
    private LayoutInflater inflater;
    private boolean isEdit = false;
    private Handler handler;

    public CollectAdapter(List<SaleProduct> saleProducts, Context context, Handler handler) {
        this.saleProducts = saleProducts;
        this.context = context;
        this.inflater = LayoutInflater.from(context);
        this.handler = handler;
    }

    @Override
    public ViewHolder onCreateHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.collect_item, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindHolder(ViewHolder holder, final int position) {
        final SaleProduct saleProduct = saleProducts.get(position);
        Integer cartNum = saleProduct.getCartNum();
        Integer stockNum = saleProduct.getStockNum();
        final Integer status = saleProduct.getProductStatus();
        final boolean isNormal = status == Constants.ProductStatus.ON_LINE && stockNum > 0;
        holder.checkView.setVisibility(isEdit ? View.VISIBLE : View.GONE);
        holder.productCountView.setVisibility(isEdit ? View.GONE : View.VISIBLE);
        holder.checkView.setBackgroundResource(saleProduct.isCheck() ? R.mipmap.checkbox_checked :
                R.mipmap.checkbox_unchecked);
        holder.checkLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                handler.obtainMessage(Constants.HandlerCode.CART_CHECK_FLASH, 0, position).sendToTarget();
            }
        });

        holder.shadeImageView.setVisibility(isNormal ? View.GONE : View.VISIBLE);
        ImageLoaderUtils.load(holder.productImageView, saleProduct.getSaleProductImageUrl());
        if (!isNormal) {
            holder.shadeImageView.setBackgroundResource(status == Constants.ProductStatus.OFF_LINE ? R.mipmap.cart_shadow :
                    status == Constants.ProductStatus.TIME_OVER ? R.mipmap.cart_time_over : R.mipmap.cart_stock);
        }
        final boolean isNotDetail = !isNormal && (status == Constants.ProductStatus.OFF_LINE || status == Constants.ProductStatus.TIME_OVER);
        holder.productImageView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (isNotDetail)
                    return;
                handler.obtainMessage(Constants.HandlerCode.PRODUCT_DETAIL, 0, position).sendToTarget();
            }
        });

        holder.productNameView.setTextColor(ContextCompat.getColor(context, isNormal ? R.color.primaryText : R.color.secondaryText));
        holder.productNameView.setText(saleProduct.getSaleProductName());

        holder.priceView.setTextColor(ContextCompat.getColor(context, isNormal ? R.color.primaryText : R.color.secondaryText));
        holder.priceView.setText(String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(saleProduct.getPromotionalPrice())));

        boolean isEmpty = cartNum == 0;
        holder.numView.setVisibility(isEmpty || !isNormal ? View.GONE : View.VISIBLE);
        holder.plusView.setVisibility(!isNormal ? View.GONE : View.VISIBLE);
        holder.numView.setVisibility(cartNum > 0 ? View.VISIBLE : View.INVISIBLE);
        holder.numView.setText(String.valueOf(cartNum));
        boolean isEnough = cartNum < stockNum;
        holder.plusView.setBackgroundResource(isEnough ? R.mipmap.plus : R.mipmap.plus_gray);
        holder.plusView.setOnClickListener(isEnough ? new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                int[] startLocation = new int[2];
                v.getLocationInWindow(startLocation);
                handler.obtainMessage(Constants.HandlerCode.PRODUCT_PLUS, 0, position, startLocation).sendToTarget();
            }
        } : null);
        holder.minusView.setVisibility(isEmpty ? View.GONE : View.VISIBLE);
        holder.minusView.setOnClickListener(isEmpty ? null : new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                handler.obtainMessage(Constants.HandlerCode.PRODUCT_MINUS, 0, position).sendToTarget();
            }
        });
    }

    @Override
    public int getCount() {
        return saleProducts == null ? 0 : saleProducts.size();
    }

    public void setEdit(boolean isEdit) {
        this.isEdit = isEdit;
        notifyDataSetChanged();
    }

    class ViewHolder extends RecyclerBaseAdapter.Holder {

        RelativeLayout checkLayout;
        ImageView checkView;
        ImageView productImageView;
        ImageView shadeImageView;
        TextView productNameView;
        TextView priceView;
        ImageView plusView;
        TextView numView;
        ImageView minusView;
        RelativeLayout productCountView;

        public ViewHolder(View itemView) {
            super(itemView);
            this.checkLayout = (RelativeLayout) itemView.findViewById(R.id.rl_collect_check);
            this.checkView = (ImageView) itemView.findViewById(R.id.iv_collect_check);
            this.productImageView = (ImageView) itemView.findViewById(R.id.iv_collect_product_image);
            this.shadeImageView = (ImageView) itemView.findViewById(R.id.iv_collect_product_image_shade);
            this.productNameView = (TextView) itemView.findViewById(R.id.tv_collect_product_name);
            this.priceView = (TextView) itemView.findViewById(R.id.tv_collect_product_price);
            this.plusView = (ImageView) itemView.findViewById(R.id.iv_collect_product_plus);
            this.numView = (TextView) itemView.findViewById(R.id.tv_collect_product_num);
            this.minusView = (ImageView) itemView.findViewById(R.id.iv_collect_product_minus);
            this.productCountView = (RelativeLayout) itemView.findViewById(R.id.rl_product_count_view);
        }
    }
}
