package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.os.Handler;
import android.support.v4.content.ContextCompat;
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
import com.yldbkd.www.buyer.android.utils.CartUtils;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.library.android.common.MoneyUtils;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;

import java.util.List;

/**
 * 购物车产品列表Adapter
 * <p/>
 * Created by linghuxj on 15/10/20.
 */
public class CartProductAdapter extends BaseAdapter {

    private Context context;
    private List<SaleProduct> products;
    private Handler handler;
    private LayoutInflater inflater;

    public CartProductAdapter(List<SaleProduct> products, Context context, Handler handler) {
        this.products = products;
        this.handler = handler;
        this.inflater = LayoutInflater.from(context);
        this.context = context;
    }

    @Override
    public int getCount() {
        return products == null ? 0 : products.size();
    }

    @Override
    public Object getItem(int i) {
        return getCount() == 0 ? null : products.get(i);
    }

    @Override
    public long getItemId(int i) {
        return i;
    }

    @Override
    public View getView(int i, View view, ViewGroup viewGroup) {
        ViewHolder holder;
        if (view == null) {
            holder = new ViewHolder();
            view = inflater.inflate(R.layout.cart_product_item, viewGroup, false);
            initView(holder, view);
            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }
        setData(holder, i);
        initListener(holder, i);
        return view;
    }

    private void setData(ViewHolder holder, int position) {
        SaleProduct product = products.get(position);

        ImageLoaderUtils.load(holder.proImageView, product.getSaleProductImageUrl());
        int textId;
        int specTextId;
        int itemBg;
        int imageBgId;
        int priceTextId;

        int productCheckType = CartUtils.checkedProductType(product);
        if (CartUtils.checkedProductType(product) != Constants.CartProductStatus.NORMAL) {
            imageBgId = getProductStatusType(productCheckType);

            holder.proImageShadowView.setVisibility(View.VISIBLE);
            holder.proImageShadowView.setBackgroundResource(imageBgId);

            holder.checkView.setBackgroundResource(R.mipmap.checkbox_none);
            holder.relativeLayoutCount.setVisibility(View.GONE);
            textId = R.color.lightText;
            priceTextId = R.color.lightText;
            specTextId = R.color.lightText;
            itemBg = R.color.nochoose_address;
        } else {
            holder.proImageShadowView.setVisibility(View.GONE);
            holder.checkView.setBackgroundResource(product.isCheck() ? R.mipmap.checkbox_checked :
                    R.mipmap.checkbox_unchecked);
            holder.relativeLayoutCount.setVisibility(View.VISIBLE);
            textId = R.color.primaryText;
            priceTextId = R.color.colorPrimary;
            specTextId = R.color.secondaryText;
            itemBg = R.color.white;
        }
        holder.proPriceView.setTextColor(ContextCompat.getColor(context, priceTextId));
        holder.proNameView.setTextColor(ContextCompat.getColor(context, textId));
        holder.proSpecView.setTextColor(ContextCompat.getColor(context, specTextId));
        holder.itemLayout.setBackgroundResource(itemBg);

        holder.deleteProduct.setBackgroundResource(R.color.white);
        holder.proNameView.setText(product.getSaleProductName());
        holder.proSpecView.setText(product.getSaleProductSpec());
        holder.proExchangeFlagView.setVisibility(View.GONE);
        holder.proPriceView.setText(String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(product.getOrderPrice())));
        holder.proNumView.setText(String.valueOf(product.getCartNum()));
        changeBtn(holder, position, product);
        //活动
        if (product.getActivityInfoList() == null || product.getActivityInfoList().size() == 0) {
            holder.cartActInfo.setVisibility(View.GONE);
        } else {
            holder.cartActInfo.setVisibility(View.VISIBLE);
            holder.tvCartAct.setText(product.getActivityInfoList().get(0).getActName());
        }
    }

    private int getProductStatusType(int productCheckType) {
        int imageBgId;
        if (productCheckType == Constants.CartProductStatus.SHADOW) {
            imageBgId = R.mipmap.cart_shadow;//下架、删除
        } else if (productCheckType == Constants.CartProductStatus.BOUGHT) {
            imageBgId = R.mipmap.cart_get;//已经购买
        } else if (productCheckType == Constants.CartProductStatus.STOCK) {
            imageBgId = R.mipmap.cart_stock;//缺货
        } else {
            imageBgId = R.mipmap.cart_act;//活动结束
        }
        return imageBgId;
    }

    private void initListener(final ViewHolder holder, final int position) {
        holder.minusView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                handler.obtainMessage(Constants.HandlerCode.CART_PRO_MINUS, position).sendToTarget();
            }
        });
        holder.deleteProduct.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                handler.obtainMessage(Constants.HandlerCode.CART_PRO_DELETE, position).sendToTarget();
            }
        });
        holder.itemLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                handler.obtainMessage(Constants.HandlerCode.CART_PRO_CHECK_FLASH, position).sendToTarget();
            }
        });
    }

    private void changeBtn(ViewHolder holder, final int position, SaleProduct product) {
        if ((product.getLimitCount() >= 0 && product.getLimitCount() <= product.getStockNum() ? product.getLimitCount() : product.getStockNum()) <= product.getCartNum()) {
            holder.plusView.setBackgroundResource(R.mipmap.cart_plus_gray);
            holder.plusView.setOnClickListener(null);
        } else {
            holder.plusView.setBackgroundResource(R.mipmap.cart_plus);
            holder.plusView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    handler.obtainMessage(Constants.HandlerCode.CART_PRO_PLUS, position).sendToTarget();
                }
            });
        }
    }

    private void initView(ViewHolder holder, View view) {
        holder.itemLayout = (LinearLayout) view.findViewById(R.id.rl_cart_product);
        holder.checkLayout = (LinearLayout) view.findViewById(R.id.cart_check_layout);
        holder.checkView = (ImageView) view.findViewById(R.id.iv_checkbox);
        holder.proImageView = (ImageView) view.findViewById(R.id.cart_product_image_view);
        holder.proImageFlagView = (ImageView) view.findViewById(R.id.cart_product_image_flag_view);
        holder.proImageShadowView = (ImageView) view.findViewById(R.id.cart_product_image_shadow_view);
        holder.proNameView = (TextView) view.findViewById(R.id.cart_product_name_view);
        holder.proSpecView = (TextView) view.findViewById(R.id.cart_product_spec_view);
        holder.proExchangeFlagView = (TextView) view.findViewById(R.id.cart_product_exchange_flag_view);
        holder.proPriceView = (TextView) view.findViewById(R.id.cart_price_view);
        holder.proNumView = (TextView) view.findViewById(R.id.cart_num_view);
        holder.plusView = (ImageView) view.findViewById(R.id.cart_num_plus_view);
        holder.minusView = (ImageView) view.findViewById(R.id.cart_num_minus_view);
        holder.deleteProduct = (RelativeLayout) view.findViewById(R.id.delete_product_for_cart);
        holder.relativeLayoutCount = (RelativeLayout) view.findViewById(R.id.relativeLayout_count);
        holder.cartActInfo = (LinearLayout) view.findViewById(R.id.cart_act_info_layout);
        holder.tvCartAct = (TextView) view.findViewById(R.id.cart_act_info);
    }

    public void changeCartProduct(View view, int position) {
        ViewHolder holder = (ViewHolder) view.getTag();
        SaleProduct product = products.get(position);
        holder.proNumView.setText(String.valueOf(product.getCartNum()));
        changeBtn(holder, position, product);
    }

    public void changeProductCheck(View view, int position) {
        ViewHolder holder = (ViewHolder) view.getTag();
        SaleProduct product = products.get(position);
        holder.checkView.setBackgroundResource(product.isCheck() ? R.mipmap.checkbox_checked :
                R.mipmap.checkbox_unchecked);
    }

    private static class ViewHolder {
        LinearLayout itemLayout;
        RelativeLayout relativeLayoutCount;
        LinearLayout checkLayout;
        ImageView checkView;
        ImageView proImageView;
        ImageView proImageFlagView;
        ImageView proImageShadowView;
        TextView proNameView;
        TextView proSpecView;
        TextView proExchangeFlagView;
        TextView proPriceView;
        TextView proNumView;
        ImageView plusView;
        ImageView minusView;
        RelativeLayout deleteProduct;
        LinearLayout cartActInfo;
        TextView tvCartAct;
    }
}