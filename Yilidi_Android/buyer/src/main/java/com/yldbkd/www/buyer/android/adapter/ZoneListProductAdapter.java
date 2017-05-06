package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.os.Handler;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.SecKillProduct;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.library.android.common.MoneyUtils;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;

import java.util.List;

/**
 * @创建者 李贞高
 * @创建时间 2016/9/2 17:12
 * @描述 秒杀商品显示
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class ZoneListProductAdapter extends BaseAdapter {

    private List<SecKillProduct> list;
    private LayoutInflater inflater;
    private Context context;
    private Handler handler;
    private Integer parentPosition;
    private int mActStatusCode;

    public ZoneListProductAdapter(List<SecKillProduct> list, Context context, Integer parentPosition, Handler handler) {
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
            convertView = inflater.inflate(R.layout.zone_list_product_item, parent, false);
            viewHolder.imageView = (ImageView) convertView.findViewById(R.id.product_image_view);
            viewHolder.productNameView = (TextView) convertView.findViewById(R.id.product_name_view);
            viewHolder.productDescView = (TextView) convertView.findViewById(R.id.product_desc_view);
            viewHolder.plusView = (Button) convertView.findViewById(R.id.btn_add_cart);
            viewHolder.priceView = (TextView) convertView.findViewById(R.id.product_price_view);
            viewHolder.progressBar = (ProgressBar) convertView.findViewById(R.id.progress_bar);
            viewHolder.progressNote = (TextView) convertView.findViewById(R.id.progress_note_view);
            convertView.setTag(viewHolder);
        } else {
            viewHolder = (ViewHolder) convertView.getTag();
        }

        final SecKillProduct saleProduct = list.get(position);
        //根据状态code判断显示界面
        ImageLoaderUtils.load(viewHolder.imageView, saleProduct.getSaleProductImageUrl());
        viewHolder.productNameView.setText(saleProduct.getSaleProductName());
        viewHolder.productDescView.setText(saleProduct.getSaleProductSpec());
        viewHolder.priceView.setText(String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(saleProduct.getSeckillPrice())));
        viewHolder.progressNote.setText(String.format(context.getResources().getString(R.string.second_kill_product_count), saleProduct.getSeckillShowTotalCount()));
        viewHolder.progressBar.setProgress(getProgressValue(saleProduct.getSeckillTotalCount(), saleProduct.getStockNum()));

        cartNumShow(position, viewHolder, saleProduct);

        viewHolder.imageView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                handler.obtainMessage(Constants.HandlerCode.PRODUCT_DETAIL, parentPosition, position)
                        .sendToTarget();
            }
        });
        return convertView;
    }

    public void setActStatusCode(int actStatusCode) {
        mActStatusCode = actStatusCode;
    }

    public Integer getProgressValue(Integer totalCount, Integer stockNum) {
        if (totalCount <= 0)
            return 0;
        return (int) (((float) stockNum.intValue() / totalCount.intValue()) * 100);
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

    private void cartNumShow(int position, ViewHolder holder, SecKillProduct saleProduct) {
        int bgId;
        int textId;
        if (mActStatusCode == 1) {//活动未开始
            holder.progressBar.setVisibility(View.GONE);
            holder.progressNote.setVisibility(View.GONE);
            bgId = R.drawable.button_yellow_selector;
            textId = R.string.second_kill_will;
            holder.plusView.setOnClickListener(null);
        } else {//活动开始，可以购买
            holder.progressBar.setVisibility(View.VISIBLE);
            holder.progressNote.setVisibility(View.VISIBLE);

            if (saleProduct.getStockNum() == null || saleProduct.getStockNum() == 0) {
                bgId = R.drawable.button_gray_selector;
                textId = R.string.second_kill_no_stocknum;
                holder.plusView.setOnClickListener(null);
            } else if (saleProduct.getCartNum() >= (saleProduct.getLimitCount() >= 0 && saleProduct.getLimitCount() <= saleProduct.getStockNum()
                    ? saleProduct.getLimitCount() : saleProduct.getStockNum())) {
                bgId = R.drawable.button_gray_selector;
                textId = R.string.second_kill_buy;
                holder.plusView.setOnClickListener(null);
            } else {
                bgId = R.drawable.button_zone_red_selector;
                textId = R.string.second_kill_buy;
                holder.plusView.setOnClickListener(new PlusClickListener(Constants.HandlerCode.PRODUCT_PLUS,
                        parentPosition, position));
            }
        }
        holder.plusView.setBackgroundResource(bgId);
        holder.plusView.setText(context.getResources().getString(textId));
    }

    private static class ViewHolder {
        ImageView iconView;
        ImageView imageView;
        ProgressBar progressBar;
        TextView progressNote;
        TextView productNameView;
        TextView productDescView;
        Button plusView;
        TextView priceView;
    }
}
