package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.os.Handler;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.*;
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
public class StoreProductAdapter extends BaseAdapter {

    private List<SaleProduct> list;
    private LayoutInflater inflater;
    private Context context;
    private Integer totalCount = 0;
    private Handler handler;
    private Integer parentPosition;

    private static final int COMMON = 0, SPECIAL = 1;
    private static final int TYPE_COUNT = 2;
    private static final int SIZE = 11;

    private Integer itemHeight;

    public StoreProductAdapter(List<SaleProduct> list, Context context, Integer parentPosition, Handler handler) {
        this.list = list;
        inflater = LayoutInflater.from(context);
        this.context = context;
        this.parentPosition = parentPosition;
        this.handler = handler;
    }

    @Override
    public int getViewTypeCount() {
        return TYPE_COUNT;
    }

    @Override
    public int getItemViewType(int position) {
        return position > list.size() - 1 || position >= SIZE ? SPECIAL : COMMON;
    }

    @Override
    public int getCount() {
        return list == null ? 0 : list.size() <= SIZE ? ((int) Math.ceil(list.size() / 3.0)) * 3 : SIZE + 1;
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
        MoreViewHolder moreViewHolder;
        switch (getItemViewType(position)) {
            case COMMON:
                if (convertView == null) {
                    viewHolder = new ViewHolder();
                    convertView = inflater.inflate(R.layout.product_item, parent, false);
                    viewHolder.itemLayout = (RelativeLayout) convertView.findViewById(R.id.product_detail_item_layout);
                    viewHolder.imageView = (ImageView) convertView.findViewById(R.id.product_image_view);
                    viewHolder.productNameView = (TextView) convertView.findViewById(R.id.product_name_view);
                    viewHolder.productDescView = (TextView) convertView.findViewById(R.id.product_desc_view);
                    viewHolder.plusView = (ImageView) convertView.findViewById(R.id.product_num_plus_view);
                    viewHolder.minusView = (ImageView) convertView.findViewById(R.id.product_num_minus_view);
                    viewHolder.productPriceLayout = (LinearLayout) convertView.findViewById(R.id.product_price_layout);
                    viewHolder.priceView = (TextView) convertView.findViewById(R.id.product_price_view);
                    viewHolder.numView = (TextView) convertView.findViewById(R.id.product_num_view);
                    convertView.setTag(viewHolder);
                } else {
                    viewHolder = (ViewHolder) convertView.getTag();
                }
                if (position > SIZE) {
                    break;
                }
                final SaleProduct saleProduct = list.get(position);
                ImageLoaderUtils.load(viewHolder.imageView, saleProduct.getSaleProductImageUrl());
                viewHolder.productNameView.setText(saleProduct.getSaleProductName());
                viewHolder.productDescView.setText(saleProduct.getSaleProductSpec());
                String price = MoneyUtils.toPrice(saleProduct.getRetailPrice());
                viewHolder.priceView.setText(price);
                viewHolder.numView.setText(String.valueOf(saleProduct.getCartNum()));
                if (saleProduct.getCartNum() > 0) {
                    viewHolder.productPriceLayout.setVisibility(View.GONE);
                    viewHolder.minusView.setVisibility(View.VISIBLE);
                    viewHolder.numView.setVisibility(View.VISIBLE);
                } else {
                    viewHolder.productPriceLayout.setVisibility(View.VISIBLE);
                    viewHolder.minusView.setVisibility(View.GONE);
                    viewHolder.numView.setVisibility(View.GONE);
                }
                viewHolder.itemLayout.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        handler.obtainMessage(Constants.HandlerCode.PRODUCT_DETAIL, parentPosition, position)
                                .sendToTarget();
                    }
                });
                viewHolder.plusView.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        int[] startLocation = new int[2];
                        view.getLocationInWindow(startLocation);
                        handler.obtainMessage(Constants.HandlerCode.PRODUCT_PLUS, parentPosition, position,
                                startLocation).sendToTarget();
                    }
                });
                viewHolder.minusView.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        handler.obtainMessage(Constants.HandlerCode.PRODUCT_MINUS, parentPosition, position)
                                .sendToTarget();
                    }
                });
                if (itemHeight == null || itemHeight == 0) {
                    itemHeight = convertView.getMeasuredHeight();
                }
                break;
            case SPECIAL:
            default:
                if (convertView == null) {
                    moreViewHolder = new MoreViewHolder();
                    convertView = inflater.inflate(R.layout.product_more_item, parent, false);
                    moreViewHolder.itemLayout = (RelativeLayout) convertView.findViewById(R.id.product_more_item_layout);
                    moreViewHolder.button = (Button) convertView.findViewById(R.id.more_product_btn);
                    moreViewHolder.totalView = (TextView) convertView.findViewById(R.id.more_product_num);
                    convertView.setTag(moreViewHolder);
                } else {
                    moreViewHolder = (MoreViewHolder) convertView.getTag();
                }
                if (list.size() < SIZE) {
                    moreViewHolder.button.setVisibility(View.GONE);
                    moreViewHolder.totalView.setVisibility(View.GONE);
                } else {
                    moreViewHolder.button.setVisibility(View.VISIBLE);
                    moreViewHolder.totalView.setVisibility(View.VISIBLE);
                    moreViewHolder.totalView.setText(String.format(context.getString(R.string.find_more_num), totalCount));
                }
                moreViewHolder.itemLayout.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        handler.obtainMessage(Constants.HandlerCode.PRODUCT_MORE, parentPosition, position).sendToTarget();
                    }
                });
                if (itemHeight != null) {
                    ViewGroup.LayoutParams lp = convertView.getLayoutParams();
                    lp.height = itemHeight;
                    convertView.setLayoutParams(lp);
                }
                break;
        }
        return convertView;
    }

    public void setTotalCount(Integer totalCount) {
        this.totalCount = totalCount;
    }

    private static class ViewHolder {
        RelativeLayout itemLayout;
        ImageView imageView;
        TextView productNameView;
        TextView productDescView;
        ImageView plusView;
        ImageView minusView;
        LinearLayout productPriceLayout;
        TextView priceView;
        TextView numView;
    }

    private static class MoreViewHolder {
        RelativeLayout itemLayout;
        TextView totalView;
        Button button;
    }
}
