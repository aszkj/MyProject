package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.os.Handler;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.library.android.common.MoneyUtils;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;

import java.util.List;

/**
 * 商品列表Adapter
 * <p/>
 * Created by linghuxj on 15/9/29.
 */
public class ZoneProductAdapter extends BaseAdapter {

    private List<SaleProduct> list;
    private LayoutInflater inflater;
    private Context context;
    private Handler handler;
    private Integer parentPosition;

    public ZoneProductAdapter(List<SaleProduct> list, Context context, Integer parentPosition, Handler handler) {
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
            convertView = inflater.inflate(R.layout.zone_product_item, parent, false);
            viewHolder.imageView = (ImageView) convertView.findViewById(R.id.product_image_view);
            viewHolder.productNameView = (TextView) convertView.findViewById(R.id.product_name_view);
            viewHolder.productDescView = (TextView) convertView.findViewById(R.id.product_desc_view);
            viewHolder.plusView = (ImageView) convertView.findViewById(R.id.product_num_plus_view);
            viewHolder.minusView = (ImageView) convertView.findViewById(R.id.product_num_minus_view);
            viewHolder.productPriceLayout = (LinearLayout) convertView.findViewById(R.id.product_price_layout);
            viewHolder.productOriginPriceLayout = (LinearLayout) convertView.findViewById(R.id.product_origin_price_layout);
            viewHolder.retailPriceView = (TextView) convertView.findViewById(R.id.product_retail_price_view);
            // viewHolder.originPriceView.getPaint().setFlags(Paint.STRIKE_THRU_TEXT_FLAG | Paint.ANTI_ALIAS_FLAG);
            viewHolder.promotionalPriceView = (TextView) convertView.findViewById(R.id.product_promotional_price_view);
            viewHolder.numView = (TextView) convertView.findViewById(R.id.product_num_view);
            convertView.setTag(viewHolder);
        } else {
            viewHolder = (ViewHolder) convertView.getTag();
        }

        final SaleProduct saleProduct = list.get(position);
        ImageLoaderUtils.load(viewHolder.imageView, saleProduct.getSaleProductImageUrl());
        viewHolder.productNameView.setText(saleProduct.getSaleProductName());
        viewHolder.productDescView.setText(saleProduct.getSaleProductSpec());
        if (saleProduct.getPromotionalPrice() == null || saleProduct.getPromotionalPrice() == 0) {
            viewHolder.productOriginPriceLayout.setVisibility(View.GONE);
        } else {
            viewHolder.productOriginPriceLayout.setVisibility(View.VISIBLE);
        }
        viewHolder.retailPriceView.setText(MoneyUtils.toPrice(saleProduct.getRetailPrice()));
        viewHolder.promotionalPriceView.setText(MoneyUtils.toPrice(saleProduct.getPromotionalPrice()));

        cartNumShow(position, viewHolder, saleProduct);

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

    public View getItemView(GridView gridView, int position) {
        final int firstListItemPosition = gridView.getFirstVisiblePosition();
        final int lastListItemPosition = firstListItemPosition + gridView.getChildCount() - 1;

        if (position < firstListItemPosition || position > lastListItemPosition) {
            return gridView.getAdapter().getView(position, null, gridView);
        } else {
            final int childIndex = position - firstListItemPosition;
            return gridView.getChildAt(childIndex);
        }
    }

    public void changeProductNum(View view, int position) {
        ViewHolder holder = (ViewHolder) view.getTag();
        SaleProduct saleProduct = list.get(position);

        cartNumShow(position, holder, saleProduct);

    }

    private void cartNumShow(int position, ViewHolder holder, SaleProduct saleProduct) {
        if (saleProduct.getCartNum() > 0) {
            holder.minusView.setVisibility(View.VISIBLE);
            holder.numView.setVisibility(View.VISIBLE);
        } else {
            holder.minusView.setVisibility(View.GONE);
            holder.numView.setVisibility(View.GONE);
        }
        if (saleProduct.getStockNum() == null || saleProduct.getStockNum() == 0 || saleProduct.getCartNum() >= saleProduct.getStockNum()) {
            holder.plusView.setBackgroundResource(R.mipmap.plus_gray);
            holder.plusView.setOnClickListener(null);
        } else {
            holder.plusView.setBackgroundResource(R.mipmap.plus);
            holder.plusView.setOnClickListener(new PlusClickListener(Constants.HandlerCode.PRODUCT_PLUS,
                    parentPosition, position));
        }
        holder.numView.setText(String.valueOf(saleProduct.getCartNum()));
    }

    private static class ViewHolder {
        ImageView iconView;
        ImageView imageView;
        TextView productNameView;
        TextView productDescView;
        ImageView plusView;
        ImageView minusView;
        LinearLayout productPriceLayout;
        LinearLayout productOriginPriceLayout;
        TextView retailPriceView;
        TextView promotionalPriceView;
        TextView numView;
    }
}
