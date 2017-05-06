package com.yldbkd.www.seller.android.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
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
public class ClassProductAdapter extends BaseAdapter<ClassProductAdapter.ViewHolder> {

    private Context context;
    private List<ProductDetail> products;
    private LayoutInflater inflater;

    public ClassProductAdapter(Context context, List<ProductDetail> products) {
        this.context = context;
        this.products = products;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public void onBindHolder(ClassProductAdapter.ViewHolder holder, int position) {
        ProductDetail product = products.get(position);
        holder.checkView.setBackgroundResource(product.isCheck() ? R.mipmap.checkbox_checked : R.mipmap.checkbox_unchecked);
        ImageLoaderUtils.load(holder.productImageView, product.getSaleProductImageUrl());
        holder.productNameView.setText(product.getSaleProductName());

        holder.checkView.setVisibility(UserUtils.getStore().getShareFlag() == 1 ? View.GONE : View.VISIBLE);

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
    }

    @Override
    public ClassProductAdapter.ViewHolder onCreateHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.item_class_product, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public int getCount() {
        return products == null ? 0 : products.size();
    }

    class ViewHolder extends BaseAdapter.Holder {

        ImageView productImageView;
        ImageView checkView;
        TextView productNameView;
        TextView retailPriceView;
        TextView promotionalPriceView;
        TextView saleCountView;
        TextView stockNumView;

        public ViewHolder(View itemView) {
            super(itemView);
            this.productImageView = (ImageView) itemView.findViewById(R.id.iv_class_product_image);
            this.checkView = (ImageView) itemView.findViewById(R.id.iv_class_product_check);
            this.productNameView = (TextView) itemView.findViewById(R.id.tv_class_product_name);
            this.retailPriceView = (TextView) itemView.findViewById(R.id.tv_class_product_retail_price);
            this.promotionalPriceView = (TextView) itemView.findViewById(R.id.tv_class_product_promotional_price);
            this.saleCountView = (TextView) itemView.findViewById(R.id.tv_class_product_sale_count);
            this.stockNumView = (TextView) itemView.findViewById(R.id.tv_class_product_stock_num);
        }
    }
}
