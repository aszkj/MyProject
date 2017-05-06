package com.yldbkd.www.seller.android.adapter;

import android.content.Context;
import android.os.Handler;
import android.support.v4.content.ContextCompat;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.library.android.common.MoneyUtils;
import com.yldbkd.www.library.android.common.TextChangeUtils;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;
import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.bean.ProductDetail;
import com.yldbkd.www.seller.android.utils.Constants;
import com.yldbkd.www.seller.android.utils.UserUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * 分类商品列表数据Adapter
 * <p/>
 * Created by linghuxj on 16/6/3.
 */
public class SearchProductAdapter extends BaseAdapter<SearchProductAdapter.ViewHolder> {

    private Context context;
    private List<ProductDetail> products;
    private LayoutInflater inflater;
    private Handler handler;

    public SearchProductAdapter(Context context, List<ProductDetail> products, Handler handler) {
        this.context = context;
        this.products = products;
        this.inflater = LayoutInflater.from(context);
        this.handler = handler;
    }

    @Override
    public void onBindHolder(ViewHolder holder, final int position) {
        boolean isShare = UserUtils.getStore().getShareFlag() == 1;
        ProductDetail product = products.get(position);
        ImageLoaderUtils.load(holder.productImageView, product.getSaleProductImageUrl());
        holder.productNameView.setText(product.getSaleProductName());

        List<Integer> retailPriceStyles = new ArrayList<>();
        retailPriceStyles.add(R.style.TextAppearance_Small_Secondary);
        TextChangeUtils.setDifferentText(context, holder.retailPriceView, R.string.class_product_retail_price,
                retailPriceStyles, String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(
                        product.getRetailPrice())));

        List<Integer> promotionPriceStyles = new ArrayList<>();
        promotionPriceStyles.add(R.style.TextAppearance_Small_Secondary);
        TextChangeUtils.setDifferentText(context, holder.promotionalPriceView, R.string.class_product_promotion_price,
                promotionPriceStyles, String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(
                        product.getPromotionalPrice())));

        List<Integer> saleStyles = new ArrayList<>();
        saleStyles.add(R.style.TextAppearance_Small_Secondary);
        TextChangeUtils.setDifferentText(context, holder.saleCountView, R.string.class_product_sale_count,
                saleStyles, product.getSaleCount());

        List<Integer> stockStyles = new ArrayList<>();
        stockStyles.add(R.style.TextAppearance_Small_Red);
        TextChangeUtils.setDifferentText(context, holder.stockNumView, R.string.class_product_stock_num,
                stockStyles, product.getRemainCount());

        boolean isOnline = Constants.PRODUCT_STATUS.ONLINE == product.getProductStatus();
        holder.onlineBtn.setVisibility(isOnline ? View.GONE : View.VISIBLE);
        holder.offlineBtn.setVisibility(isOnline ? View.VISIBLE : View.GONE);
        holder.statusView.setImageResource(isOnline ? R.mipmap.product_online_flag :
                R.mipmap.product_offline_flag);

        holder.offlineBtn.setBackgroundResource(isOnline ? R.drawable.button_white_gray :
                R.drawable.button_white_gray);
        holder.offlineBtn.setOnClickListener(isOnline ? new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                handler.obtainMessage(Constants.HandlerCode.PRODUCT_OFFLINE, position).sendToTarget();
            }
        } : null);
        holder.offlineBtn.setTextColor(ContextCompat.getColor(context, isOnline ? R.color.primaryText :
                R.color.primaryText));
        holder.onlineBtn.setBackgroundResource(!isOnline ? R.drawable.button_blue_selector :
                R.drawable.button_white_gray);
        holder.onlineBtn.setOnClickListener(!isOnline ? new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                handler.obtainMessage(Constants.HandlerCode.PRODUCT_ONLINE, position).sendToTarget();
            }
        } : null);
        holder.onlineBtn.setTextColor(ContextCompat.getColor(context, !isOnline ? R.color.white :
                R.color.primaryText));

        holder.isShareView1.setVisibility(isShare ? View.VISIBLE : View.GONE);
        holder.isShareView2.setVisibility(isShare ? View.GONE : View.VISIBLE);
        holder.rlBtn.setVisibility(isShare ? View.GONE : View.VISIBLE);
    }

    @Override
    public ViewHolder onCreateHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.item_search_product, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public int getCount() {
        return products == null ? 0 : products.size();
    }

    class ViewHolder extends BaseAdapter.Holder {

        ImageView productImageView;
        ImageView statusView;
        TextView productNameView;
        TextView retailPriceView;
        TextView promotionalPriceView;
        TextView saleCountView;
        TextView stockNumView;
        Button offlineBtn;
        Button onlineBtn;
        View isShareView1;
        View isShareView2;
        RelativeLayout rlBtn;

        public ViewHolder(View itemView) {
            super(itemView);
            this.productImageView = (ImageView) itemView.findViewById(R.id.iv_search_product_image);
            this.statusView = (ImageView) itemView.findViewById(R.id.iv_search_product_status);
            this.productNameView = (TextView) itemView.findViewById(R.id.tv_search_product_name);
            this.retailPriceView = (TextView) itemView.findViewById(R.id.tv_search_product_retail_price);
            this.promotionalPriceView = (TextView) itemView.findViewById(R.id.tv_search_product_promotional_price);
            this.saleCountView = (TextView) itemView.findViewById(R.id.tv_search_product_sale_count);
            this.stockNumView = (TextView) itemView.findViewById(R.id.tv_search_product_stock_num);
            this.offlineBtn = (Button) itemView.findViewById(R.id.btn_offline);
            this.onlineBtn = (Button) itemView.findViewById(R.id.btn_online);
            this.isShareView1 = itemView.findViewById(R.id.is_share_view1);
            this.isShareView2 = itemView.findViewById(R.id.is_share_view2);
            this.rlBtn = (RelativeLayout) itemView.findViewById(R.id.rl_btn);
        }
    }
}
