package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.os.Handler;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.utils.Constants;

import java.util.List;

/**
 * 商品列表Adapter
 * <p/>
 * Created by linghuxj on 15/9/29.
 */
public class SearchProductAdapter extends BaseAdapter {

    private List<SaleProduct> list;
    private boolean hasMore = false;
    private LayoutInflater inflater;
    private Context context;
    private Handler handler;
    private Integer parentPosition;

    public SearchProductAdapter(List<SaleProduct> list, Context context, Integer parentPosition, Handler handler) {
        this.list = list;
        inflater = LayoutInflater.from(context);
        this.context = context;
        this.parentPosition = parentPosition;
        this.handler = handler;
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
    public View getView(final int position, View convertView, final ViewGroup parent) {
        ViewHolder viewHolder;
        if (convertView == null) {
            viewHolder = new ViewHolder();
            convertView = inflater.inflate(R.layout.product_item, parent, false);
            viewHolder.iconView = (ImageView) convertView.findViewById(R.id.product_icon_view);
            viewHolder.imageView = (ImageView) convertView.findViewById(R.id.product_image_view);
            viewHolder.productNameView = (TextView) convertView.findViewById(R.id.product_name_view);
            viewHolder.productDescView = (TextView) convertView.findViewById(R.id.product_desc_view);
            viewHolder.plusView = (ImageView) convertView.findViewById(R.id.product_num_plus_view);
            viewHolder.minusView = (ImageView) convertView.findViewById(R.id.product_num_minus_view);
            viewHolder.productPriceLayout = (LinearLayout) convertView.findViewById(R.id.product_price_layout);
            viewHolder.productOriginPriceLayout = (LinearLayout) convertView.findViewById(R.id.product_origin_price_layout);
            viewHolder.originPriceView = (TextView) convertView.findViewById(R.id.product_origin_price_view);
            // viewHolder.originPriceView.getPaint().setFlags(Paint.STRIKE_THRU_TEXT_FLAG | Paint.ANTI_ALIAS_FLAG);
            viewHolder.priceView = (TextView) convertView.findViewById(R.id.product_price_view);
            viewHolder.numView = (TextView) convertView.findViewById(R.id.product_num_view);
            convertView.setTag(viewHolder);
        } else {
            viewHolder = (ViewHolder) convertView.getTag();
        }

        viewHolder.productOriginPriceLayout.setVisibility(View.VISIBLE);
        viewHolder.minusView.setVisibility(View.VISIBLE);
        viewHolder.numView.setVisibility(View.VISIBLE);
        viewHolder.plusView.setBackgroundResource(R.mipmap.plus_gray);
        viewHolder.plusView.setOnClickListener(null);
        viewHolder.plusView.setBackgroundResource(R.mipmap.plus);
        viewHolder.plusView.setOnClickListener(new PlusClickListener(Constants.HandlerCode.PRODUCT_PLUS,
                parentPosition, position));

        viewHolder.imageView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                handler.obtainMessage(Constants.HandlerCode.PRODUCT_DETAIL, parentPosition, position)
                        .sendToTarget();
            }
        });
        viewHolder.minusView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                handler.obtainMessage(Constants.HandlerCode.PRODUCT_MINUS, parentPosition, position)
                        .sendToTarget();
            }
        });
               /* final SaleProduct saleProduct = list.get(position);
                ImageLoaderUtils.load(viewHolder.imageView, saleProduct.getSaleProductImageUrl());
                viewHolder.iconView.setBackgroundResource(saleProduct.getIconTypeResourceId());
                viewHolder.productNameView.setText(saleProduct.getSaleProductName());
                viewHolder.productDescView.setText(saleProduct.getSaleProductSpec());
                if (saleProduct.getPromotionalPrice() == null || saleProduct.getPromotionalPrice() == 0) {
                    viewHolder.productOriginPriceLayout.setVisibility(View.GONE);
                } else {
                    viewHolder.productOriginPriceLayout.setVisibility(View.VISIBLE);
                }
                viewHolder.originPriceView.setText(MoneyUtils.toPrice(saleProduct.getRetailPrice()));
                String price = MoneyUtils.toPrice(saleProduct.getPrice());
                viewHolder.priceView.setText(price);
                viewHolder.numView.setText(String.valueOf(saleProduct.getCartNum()));
                if (saleProduct.getCartNum() > 0) {
                    viewHolder.minusView.setVisibility(View.VISIBLE);
                    viewHolder.numView.setVisibility(View.VISIBLE);
                } else {
                    viewHolder.minusView.setVisibility(View.GONE);
                    viewHolder.numView.setVisibility(View.GONE);
                }
                if ((saleProduct.getLimitCount() >= 0 && saleProduct.getLimitCount() <= saleProduct.getCartNum())
                        || (saleProduct.getHasStock() == Constants.StockType.HAS_STOCK && saleProduct.getStockNum() == 0)) {
                    viewHolder.plusView.setBackgroundResource(R.mipmap.plus_gray);
                    viewHolder.plusView.setOnClickListener(null);
                } else {
                    viewHolder.plusView.setBackgroundResource(R.mipmap.plus);
                    viewHolder.plusView.setOnClickListener(new PlusClickListener(Constants.HandlerCode.PRODUCT_PLUS,
                            parentPosition, position));
                }
                viewHolder.itemLayout.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        handler.obtainMessage(Constants.HandlerCode.PRODUCT_DETAIL, parentPosition, position)
                                .sendToTarget();
                    }
                });
                viewHolder.minusView.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        handler.obtainMessage(Constants.HandlerCode.PRODUCT_MINUS, parentPosition, position)
                                .sendToTarget();
                    }
                });*/
        return convertView;
    }

    private class PlusClickListener implements View.OnClickListener {
        private Integer parentPosition;
        private Integer position;
        private Integer handlerCode;

        public PlusClickListener(Integer handlerCode, Integer parentPosition, Integer position) {
            this.parentPosition = parentPosition;
            this.position = position;
            this.handlerCode = handlerCode;
        }

        @Override
        public void onClick(View view) {
            int[] startLocation = new int[2];
            view.getLocationInWindow(startLocation);
            handler.obtainMessage(handlerCode, parentPosition, position,
                    startLocation).sendToTarget();
        }
    }

    private static class ViewHolder {
        RelativeLayout itemLayout;
        ImageView iconView;
        ImageView imageView;
        TextView productNameView;
        TextView productDescView;
        ImageView plusView;
        ImageView minusView;
        LinearLayout productPriceLayout;
        LinearLayout productOriginPriceLayout;
        TextView originPriceView;
        TextView priceView;
        TextView numView;
    }
}
