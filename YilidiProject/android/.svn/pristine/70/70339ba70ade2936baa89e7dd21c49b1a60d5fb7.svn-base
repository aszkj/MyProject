package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.os.Handler;
import android.text.TextUtils;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.bean.Advertisement;
import com.yldbkd.www.buyer.android.bean.FloorInfo;
import com.yldbkd.www.buyer.android.bean.HomeFloorInfo;
import com.yldbkd.www.buyer.android.bean.SaleProduct;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.buyer.android.utils.JumpUtils;
import com.yldbkd.www.library.android.common.MoneyUtils;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;

import java.util.List;

/**
 * 首页店铺包含商品列表的类型列表
 * <p/>
 * Created by linghuxj on 15/12/16.
 */
public class HomeClassProductAdapter extends BaseAdapter {

    private List<HomeFloorInfo> homeFloorInfos;
    private Context context;
    private LayoutInflater inflater;
    private Handler handler;

    public HomeClassProductAdapter(List<HomeFloorInfo> homeFloorInfos, Context context, Handler handler) {
        this.homeFloorInfos = homeFloorInfos;
        this.context = context;
        this.inflater = LayoutInflater.from(context);
        this.handler = handler;
    }

    @Override
    public int getCount() {
        return homeFloorInfos == null ? 0 : homeFloorInfos.size();
    }

    @Override
    public Object getItem(int i) {
        return getCount() == 0 ? null : homeFloorInfos.get(i);
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
            view = inflater.inflate(R.layout.home_class_product_item, viewGroup, false);
            initView(holder, view);
            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }
        initData(holder, i);
        initListener(holder, i);
        return view;
    }

    private void initView(ViewHolder holder, View view) {
        holder.classLayout = (RelativeLayout) view.findViewById(R.id.home_class_layout);
        holder.classNameView = (TextView) view.findViewById(R.id.home_class_name_view);
        holder.classImageView = (ImageView) view.findViewById(R.id.home_class_image_view);
        holder.classAdvertImage = (ImageView) view.findViewById(R.id.home_class_advert_image);
        holder.moreView = (TextView) view.findViewById(R.id.tv_home_product_more);
        holder.productLayout0 = (LinearLayout) view.findViewById(R.id.ll_home_product_all_layout0);
        holder.productLayout1 = (LinearLayout) view.findViewById(R.id.ll_home_product_all_layout1);
        initProView(holder.productView0, view, 0);
        initProView(holder.productView1, view, 1);
        initProView(holder.productView2, view, 2);
        initProView(holder.productView3, view, 3);
    }

    private void initProView(ViewHolder.ProductView productView, View view, int index) {
        int layoutResId = index == 0 ? R.id.rl_home_product0 : index == 1 ? R.id.rl_home_product1 :
                index == 2 ? R.id.rl_home_product2 : R.id.rl_home_product3;
        productView.productLayout = (RelativeLayout) view.findViewById(layoutResId);
        int imageResId = index == 0 ? R.id.iv_home_product_image0 : index == 1 ? R.id.iv_home_product_image1 :
                index == 2 ? R.id.iv_home_product_image2 : R.id.iv_home_product_image3;
        productView.imageView = (ImageView) view.findViewById(imageResId);
        int nameResId = index == 0 ? R.id.tv_home_product_name0 : index == 1 ? R.id.tv_home_product_name1 :
                index == 2 ? R.id.tv_home_product_name2 : R.id.tv_home_product_name3;
        productView.productNameView = (TextView) view.findViewById(nameResId);
        int descResId = index == 0 ? R.id.tv_home_product_desc0 : index == 1 ? R.id.tv_home_product_desc1 :
                index == 2 ? R.id.tv_home_product_desc2 : R.id.tv_home_product_desc3;
        productView.productDescView = (TextView) view.findViewById(descResId);
        int plusResId = index == 0 ? R.id.iv_home_product_plus0 : index == 1 ? R.id.iv_home_product_plus1 :
                index == 2 ? R.id.iv_home_product_plus2 : R.id.iv_home_product_plus3;
        productView.plusView = (ImageView) view.findViewById(plusResId);
        int minusResId = index == 0 ? R.id.iv_home_product_minus0 : index == 1 ? R.id.iv_home_product_minus1 :
                index == 2 ? R.id.iv_home_product_minus2 : R.id.iv_home_product_minus3;
        productView.minusView = (ImageView) view.findViewById(minusResId);
        int priceResId = index == 0 ? R.id.tv_home_product_retail_price0 : index == 1 ? R.id.tv_home_product_retail_price1 :
                index == 2 ? R.id.tv_home_product_retail_price2 : R.id.tv_home_product_retail_price3;
        productView.retailPriceView = (TextView) view.findViewById(priceResId);
        int proPriceResId = index == 0 ? R.id.tv_home_product_promotional_price0 : index == 1 ? R.id.tv_home_product_promotional_price1 :
                index == 2 ? R.id.tv_home_product_promotional_price2 : R.id.tv_home_product_promotional_price3;
        productView.promotionalPriceView = (TextView) view.findViewById(proPriceResId);
        int numResId = index == 0 ? R.id.tv_home_product_num0 : index == 1 ? R.id.tv_home_product_num1 :
                index == 2 ? R.id.tv_home_product_num2 : R.id.tv_home_product_num3;
        productView.numView = (TextView) view.findViewById(numResId);
    }

    private void initData(ViewHolder holder, int position) {
        HomeFloorInfo homeFloorInfo = homeFloorInfos.get(position);
        FloorInfo floorInfo = homeFloorInfo.getFloorInfo();
        Advertisement advertInfo = homeFloorInfo.getAdvertisementInfo();
        boolean isEmptyFloor = floorInfo == null || floorInfo.getFloorProductList() == null ||
                floorInfo.getFloorProductList().size() == 0;
        boolean isEmptyAdvert = advertInfo == null;
        holder.classLayout.setVisibility(!isEmptyFloor ? View.VISIBLE : View.GONE);
        holder.productLayout0.setVisibility(!isEmptyFloor ? View.VISIBLE : View.GONE);
        holder.productLayout1.setVisibility(!isEmptyFloor ? View.VISIBLE : View.GONE);
        holder.classAdvertImage.setVisibility(!isEmptyAdvert ? View.VISIBLE : View.GONE);
        if (!isEmptyFloor) {
            // 楼层信息
            ImageLoaderUtils.load(holder.classImageView, floorInfo.getFloorImageUrl());
            holder.classNameView.setText(floorInfo.getFloorName());
            // 楼层商品
            List<SaleProduct> list = floorInfo.getFloorProductList();
            if (list != null) {
                int size = list.size();
                holder.productLayout0.setVisibility(size == 0 ? View.GONE : View.VISIBLE);
                holder.productLayout1.setVisibility(size <= 2 ? View.GONE : View.VISIBLE);
                if (size > 0) {
                    holder.productView0.productLayout.setVisibility(View.VISIBLE);
                    setProData(holder.productView0, list.get(0), 0, position);
                } else {
                    holder.productView0.productLayout.setVisibility(View.INVISIBLE);
                }
                if (size > 1) {
                    holder.productView1.productLayout.setVisibility(View.VISIBLE);
                    setProData(holder.productView1, list.get(1), 1, position);
                } else {
                    holder.productView1.productLayout.setVisibility(View.INVISIBLE);
                }
                if (size > 2) {
                    holder.productView2.productLayout.setVisibility(View.VISIBLE);
                    setProData(holder.productView2, list.get(2), 2, position);
                } else {
                    holder.productView2.productLayout.setVisibility(View.INVISIBLE);
                }
                if (size > 3) {
                    holder.productView3.productLayout.setVisibility(View.VISIBLE);
                    setProData(holder.productView3, list.get(3), 3, position);
                } else {
                    holder.productView3.productLayout.setVisibility(View.INVISIBLE);
                }
            }
        }
        if (!isEmptyAdvert) {
            //专区广告图
            if (!TextUtils.isEmpty(advertInfo.getImageUrl())) {
                holder.classAdvertImage.setVisibility(View.VISIBLE);
                ImageLoaderUtils.load(holder.classAdvertImage, advertInfo.getImageUrl(), com.yldbkd.www.library.android.R.drawable.no_picture_rect);
            } else {
                holder.classAdvertImage.setVisibility(View.GONE);
            }
        }
    }

    private void setProData(ViewHolder.ProductView productView, SaleProduct product, final int index,
                            final int position) {
        if (product == null) {
            return;
        }
        ImageLoaderUtils.load(productView.imageView, product.getSaleProductImageUrl());
        productView.productNameView.setText(product.getSaleProductName());
        productView.productDescView.setText(product.getSaleProductSpec());
        productView.retailPriceView.setText(String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(
                product.getRetailPrice())));
        productView.promotionalPriceView.setText(String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(
                product.getPromotionalPrice())));
        boolean isEmpty = product.getCartNum() <= 0;
        boolean isEnough = product.getCartNum() >= product.getStockNum();
        productView.minusView.setVisibility(isEmpty ? View.INVISIBLE : View.VISIBLE);
        productView.numView.setVisibility(isEmpty ? View.INVISIBLE : View.VISIBLE);
        productView.numView.setText(String.valueOf(product.getCartNum()));
        productView.minusView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                int[] startLocation = new int[2];
                v.getLocationInWindow(startLocation);
                handler.obtainMessage(Constants.HandlerCode.PRODUCT_MINUS, position, index
                        , startLocation).sendToTarget();
            }
        });
        productView.plusView.setBackgroundResource(isEnough ? R.mipmap.plus_gray : R.mipmap.plus);
        productView.plusView.setOnClickListener(isEnough ? null : new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                int[] startLocation = new int[2];
                v.getLocationInWindow(startLocation);
                handler.obtainMessage(Constants.HandlerCode.PRODUCT_PLUS, position, index
                        , startLocation).sendToTarget();
            }
        });
        productView.productLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                handler.obtainMessage(Constants.HandlerCode.PRODUCT_DETAIL, position, index
                ).sendToTarget();
            }
        });
    }

    private void initListener(final ViewHolder holder, final int position) {
        HomeFloorInfo homeFloorInfo = homeFloorInfos.get(position);
        final FloorInfo floorInfo = homeFloorInfo.getFloorInfo();
        final Advertisement advertInfo = homeFloorInfo.getAdvertisementInfo();
        holder.classLayout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                handler.obtainMessage(Constants.HandlerCode.HOME_PRODUCT_CLASS, position).sendToTarget();
            }
        });
        holder.moreView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                BaseActivity activity = (BaseActivity) context;
                JumpUtils.moreJump(activity, floorInfo.getLinkType(), floorInfo.getLinkData(),
                        floorInfo.getFloorName());
            }
        });
        holder.classAdvertImage.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                BaseActivity activity = (BaseActivity) context;
                JumpUtils.jump(activity, advertInfo.getLinkType(), advertInfo.getLinkData());
            }
        });
    }

    private static class ViewHolder {
        RelativeLayout classLayout;
        ImageView classImageView, classAdvertImage;
        TextView classNameView;
        TextView moreView;
        LinearLayout productLayout0;
        LinearLayout productLayout1;
        ProductView productView0 = new ProductView();
        ProductView productView1 = new ProductView();
        ProductView productView2 = new ProductView();
        ProductView productView3 = new ProductView();

        class ProductView {
            RelativeLayout productLayout;
            ImageView imageView;
            TextView productNameView;
            TextView productDescView;
            ImageView plusView;
            ImageView minusView;
            TextView retailPriceView;
            TextView promotionalPriceView;
            TextView numView;
        }
    }
}
