package com.yldbkd.www.seller.android.adapter;

import android.content.Context;
import android.os.Handler;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.yldbkd.www.library.android.image.ImageLoaderUtils;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.bean.ProductAllot;
import com.yldbkd.www.seller.android.utils.AllotOrderStatusUtils;
import com.yldbkd.www.seller.android.utils.Constants;

import java.util.List;

/**
 * 调货单详情商品列表
 * <p/>
 * Created by linghuxj on 16/6/6.
 */
public class AllotOrderProductAdapter extends BaseAdapter<AllotOrderProductAdapter.ViewHolder> {

    private Context context;
    private List<ProductAllot> productAllots;
    private int allotOrderStatus;
    private Handler handler;
    private LayoutInflater inflater;

    public AllotOrderProductAdapter(Context context, List<ProductAllot> productAllots,
                                    int allotOrderStatus, Handler handler) {
        this.context = context;
        this.productAllots = productAllots;
        this.allotOrderStatus = allotOrderStatus;
        this.handler = handler;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public ViewHolder onCreateHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.item_allot_order_product, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindHolder(final ViewHolder holder, final int position) {
        ProductAllot product = productAllots.get(position);
        int allotCount = product.getAllotCount();
        int operateAllotCount = product.getOperateAllotCount();
        boolean isEnough = operateAllotCount >= allotCount;
        boolean isEmpty = operateAllotCount <= 0 && allotCount > 0;

        boolean isChecking = allotOrderStatus == AllotOrderStatusUtils.CHECKING_CODE;
        Integer realAllotCount = product.getRealAllotCount();

        ImageLoaderUtils.load(holder.imageView, product.getSaleProductImageUrl());
        holder.productNameView.setText(product.getSaleProductName());
        holder.productCountView.setText(String.format(context.getString(R.string.allot_order_detail_item_count),
                allotCount));

        holder.actualLayout.setVisibility(isChecking ? View.VISIBLE : View.GONE);
        holder.actualNumView.setText(String.valueOf(operateAllotCount));
        holder.plusView.setBackgroundResource(isEnough ? R.mipmap.plus_gray : R.mipmap.plus);
        holder.plusView.setOnClickListener(isEnough ? null : new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                handler.obtainMessage(Constants.HandlerCode.PRODUCT_PLUS, position).sendToTarget();
            }
        });
        holder.minusView.setBackgroundResource(isEmpty ? R.mipmap.minus_gray : R.mipmap.minus);
        holder.minusView.setOnClickListener(isEmpty ? null : new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                handler.obtainMessage(Constants.HandlerCode.PRODUCT_MINUS, position).sendToTarget();
            }
        });

        holder.actualCountView.setVisibility(realAllotCount != null ? View.VISIBLE : View.GONE);
        holder.actualCountView.setText(String.format(context.getString(R.string.allot_order_detail_item_real_count),
                realAllotCount));
    }

    @Override
    public int getCount() {
        return productAllots == null ? 0 : productAllots.size();
    }

    class ViewHolder extends BaseAdapter.Holder {

        ImageView imageView;
        TextView productNameView;
        TextView productCountView;
        LinearLayout actualLayout;
        ImageView minusView;
        TextView actualNumView;
        ImageView plusView;
        TextView actualCountView;

        public ViewHolder(View itemView) {
            super(itemView);
            this.imageView = (ImageView) itemView.findViewById(R.id.iv_item_allot_order_detail_product);
            this.productNameView = (TextView) itemView.findViewById(R.id.tv_item_allot_order_detail_product_name);
            this.productCountView = (TextView) itemView.findViewById(R.id.tv_item_allot_order_detail_product_count);
            this.actualLayout = (LinearLayout) itemView.findViewById(R.id.ll_item_allot_order_detail_actual);
            this.minusView = (ImageView) itemView.findViewById(R.id.iv_item_allot_order_detail_product_minus);
            this.actualNumView = (TextView) itemView.findViewById(R.id.iv_item_allot_order_detail_product_num);
            this.plusView = (ImageView) itemView.findViewById(R.id.iv_item_allot_order_detail_product_plus);
            this.actualCountView = (TextView) itemView.findViewById(R.id.tv_item_allot_order_detail_product_actual);

        }
    }
}
