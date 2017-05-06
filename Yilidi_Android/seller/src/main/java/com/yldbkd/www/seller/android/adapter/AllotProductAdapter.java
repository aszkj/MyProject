package com.yldbkd.www.seller.android.adapter;

import android.content.Context;
import android.os.Handler;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.MoneyUtils;
import com.yldbkd.www.library.android.common.TextChangeUtils;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.bean.ProductAllot;
import com.yldbkd.www.seller.android.utils.Constants;

import java.util.ArrayList;
import java.util.List;

/**
 * 调货单商品列表Adapter
 * <p/>
 * Created by linghuxj on 16/6/3.
 */
public class AllotProductAdapter extends BaseAdapter<AllotProductAdapter.ViewHolder> {

    private Context context;
    private List<ProductAllot> products;
    private LayoutInflater inflater;
    private Handler handler;
    private boolean isShown;

    public AllotProductAdapter(Context context, List<ProductAllot> products, Handler handler) {
        this(context, products, handler, false);
    }

    public AllotProductAdapter(Context context, List<ProductAllot> products, Handler handler, boolean isShown) {
        this.context = context;
        this.products = products;
        this.inflater = LayoutInflater.from(context);
        this.handler = handler;
        this.isShown = isShown;
    }

    @Override
    public void onBindHolder(AllotProductAdapter.ViewHolder holder, final int position) {
        final ProductAllot product = products.get(position);
        int warehouseCount = product.getWarehouseCount();
        int cartNum = product.getCartNum();
        int perAllotCount = product.getPerAllotCount();
        holder.checkView.setVisibility(isShown ? View.VISIBLE : View.GONE);
        holder.checkView.setBackgroundResource(product.isCheck() ? R.mipmap.checkbox_checked :
                R.mipmap.checkbox_unchecked);
        ImageLoaderUtils.load(holder.productImageView, product.getSaleProductImageUrl());
        holder.productNameView.setText(product.getSaleProductName());

        List<Integer> basePriceStyles = new ArrayList<>();
        basePriceStyles.add(R.style.TextAppearance_Small_Red);
        TextChangeUtils.setDifferentText(context, holder.basePriceView, R.string.allot_product_price,
                basePriceStyles, String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(
                        product.getBasePrice())));

        List<Integer> warehouseStyles = new ArrayList<>();
        warehouseStyles.add(R.style.TextAppearance_Small);
        TextChangeUtils.setDifferentText(context, holder.warehouseCountView, R.string.allot_product_warehouse,
                warehouseStyles, String.valueOf(warehouseCount));

        List<Integer> stockStyles = new ArrayList<>();
        stockStyles.add(R.style.TextAppearance_Small_Blue);
        TextChangeUtils.setDifferentText(context, holder.stockNumView, R.string.allot_product_stock,
                stockStyles, String.valueOf(product.getRemainCount()));

        holder.perCountView.setText(String.format(context.getString(R.string.allot_product_per_count),
                perAllotCount));
        boolean isEmpty = cartNum == 0;
        holder.numView.setVisibility(isEmpty ? View.GONE : View.VISIBLE);
        holder.numView.setText(String.valueOf(cartNum));
        boolean isEnough = cartNum <= warehouseCount - perAllotCount && warehouseCount >= perAllotCount;
        holder.plusView.setBackgroundResource(isEnough ? R.mipmap.plus : R.mipmap.plus_gray);
        holder.plusView.setOnClickListener(isEnough ? new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                handler.obtainMessage(Constants.HandlerCode.PRODUCT_PLUS, position).sendToTarget();
            }
        } : null);
        holder.minusView.setVisibility(isEmpty ? View.GONE : View.VISIBLE);
        holder.minusView.setOnClickListener(isEmpty ? null : new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                handler.obtainMessage(Constants.HandlerCode.PRODUCT_MINUS, position).sendToTarget();
            }
        });
    }

    @Override
    public AllotProductAdapter.ViewHolder onCreateHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.item_allot_product, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public int getCount() {
        return products == null ? 0 : products.size();
    }

    class ViewHolder extends BaseAdapter.Holder {

        ImageView checkView;
        ImageView productImageView;
        TextView productNameView;
        TextView basePriceView;
        TextView warehouseCountView;
        TextView stockNumView;
        TextView perCountView;
        ImageView plusView;
        TextView numView;
        ImageView minusView;

        public ViewHolder(View itemView) {
            super(itemView);
            this.checkView = (ImageView) itemView.findViewById(R.id.iv_allot_cart_check);
            this.productImageView = (ImageView) itemView.findViewById(R.id.iv_allot_product_image);
            this.productNameView = (TextView) itemView.findViewById(R.id.tv_allot_product_name);
            this.basePriceView = (TextView) itemView.findViewById(R.id.tv_allot_product_base_price);
            this.perCountView = (TextView) itemView.findViewById(R.id.tv_allot_product_per_count);
            this.warehouseCountView = (TextView) itemView.findViewById(R.id.tv_allot_product_warehouse_count);
            this.stockNumView = (TextView) itemView.findViewById(R.id.tv_allot_product_stock_num);
            this.plusView = (ImageView) itemView.findViewById(R.id.iv_allot_product_plus);
            this.numView = (TextView) itemView.findViewById(R.id.tv_allot_product_num);
            this.minusView = (ImageView) itemView.findViewById(R.id.iv_allot_product_minus);
        }
    }
}
