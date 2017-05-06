package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.os.Handler;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.base.BaseActivity;
import com.yldbkd.www.buyer.android.bean.OrderList;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.library.android.common.DisplayUtils;
import com.yldbkd.www.library.android.common.MoneyUtils;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;

import java.util.List;

/**
 * 订单列表Adapter
 * <p/>
 * Created by linghuxj on 15/10/15.
 */
public class OrderListAdapter extends BaseAdapter {

    private List<OrderList> orders;
    private LayoutInflater inflater;
    private Context context;
    private Handler handler;
    private ImageView mProductImage;
    private int picCount;

    public OrderListAdapter(List<OrderList> orders, Context context, Handler handler) {
        this.orders = orders;
        this.context = context;
        this.inflater = LayoutInflater.from(context);
        this.handler = handler;
    }

    @Override
    public int getCount() {
        return orders == null ? 0 : orders.size();
    }

    @Override
    public Object getItem(int i) {
        return getCount() == 0 ? null : orders.get(i);
    }

    @Override
    public long getItemId(int i) {
        return i;
    }

    @Override
    public View getView(final int position, View view, ViewGroup viewGroup) {
        ViewHolder holder;
        if (view == null) {
            holder = new ViewHolder();
            view = inflater.inflate(R.layout.order_list_item, viewGroup, false);
            holder.statusView = (TextView) view.findViewById(R.id.order_status_view);
            holder.orderStoreView = (TextView) view.findViewById(R.id.order_store_view);
            holder.orderPic = (LinearLayout) view.findViewById(R.id.ll_product_pic);
            holder.hasMore = (ImageView) view.findViewById(R.id.has_more);
            holder.storeImageviewIcon = (ImageView) view.findViewById(R.id.store_imageview_icon);
            holder.bymyselfImageviewIcon = (ImageView) view.findViewById(R.id.bymyself_imageview_icon);

            holder.amountView = (TextView) view.findViewById(R.id.order_amount_view);
            holder.confirmBtn = (Button) view.findViewById(R.id.order_confirm_btn);
            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }

        OrderList order = orders.get(position);
        if (order.getOrderImageList() != null && order.getOrderImageList().size() > 0 && context != null) {
            int width = DisplayUtils.dp2px((BaseActivity) context, 60);
            int height = DisplayUtils.dp2px((BaseActivity) context, 60);
            int margin = DisplayUtils.px2dp((BaseActivity) context, 2);

            holder.orderPic.removeAllViews();
            if (order.getOrderImageList().size() < 6) {
                picCount = order.getOrderImageList().size();
                holder.hasMore.setVisibility(View.GONE);
            } else {
                picCount = 5;
                holder.hasMore.setVisibility(View.VISIBLE);
            }
            for (int i = 0; i < picCount; i++) {
                mProductImage = new ImageView(context);
                ImageLoaderUtils.load(mProductImage, order.getOrderImageList().get(i).getOrderImage());
                LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(width, height);
                params.leftMargin = margin;
                params.topMargin = margin;
                params.bottomMargin = margin;
                holder.orderPic.addView(mProductImage, params);
            }
        }
        if (order.getDeliveryModeCode() == Constants.DeliveryType.PICKUP) {
            holder.storeImageviewIcon.setVisibility(View.GONE);
            holder.bymyselfImageviewIcon.setVisibility(View.VISIBLE);
        } else {
            holder.storeImageviewIcon.setVisibility(View.VISIBLE);
            holder.bymyselfImageviewIcon.setVisibility(View.GONE);
        }
        holder.orderStoreView.setText(order.getStoreName());
        holder.statusView.setText(order.getStatusCodeName());
        holder.amountView.setText(String.valueOf(Constants.MONEY_FLAG + MoneyUtils.toPrice(order.getTotalAmount())));

        changeOrderButton(holder, order, position);
        return view;
    }

    private void changeOrderButton(ViewHolder holder, OrderList order, final int position) {
        int confirmCode = 0;
        if (Constants.OrderStatus.BUILD_CODE.equals(order.getStatusCode())) {// 未付款=》去支付
            confirmCode = R.string.order_to_pay;
            holder.confirmBtn.setText(context.getResources().getString(R.string.order_to_pay));
            //            holder.confirmBtn.setTextColor(context.getResources().getColor(R.color.colorBlue));
            //            holder.confirmBtn.setBackgroundResource(R.drawable.button_white_blue_selector);
            holder.confirmBtn.setVisibility(View.VISIBLE);
            holder.confirmBtn.setEnabled(true);
        } else if (Constants.OrderStatus.PAY_CODE.equals(order.getStatusCode())) {// 已付款=》取消订单
            confirmCode = R.string.order_to_cancel;
            holder.confirmBtn.setText(context.getResources().getString(R.string.order_to_cancel));
            //            holder.confirmBtn.setTextColor(context.getResources().getColor(R.color.secondaryText));
            //            holder.confirmBtn.setBackgroundResource(R.drawable.button_white_gray_selector);
            holder.confirmBtn.setVisibility(View.VISIBLE);
            holder.confirmBtn.setEnabled(true);
        } else if (Constants.OrderStatus.WAIT_RECEIPT_CODE.equals(order.getStatusCode())) {// 待收货=》确定收货
            confirmCode = R.string.order_to_receive;
            holder.confirmBtn.setText(order.getDeliveryModeCode().intValue() == Constants.DeliveryType.PICKUP ?
                    context.getResources().getString(R.string.order_to_receive_toke) : context.getResources().getString(R.string.order_to_receive));
            //            holder.confirmBtn.setTextColor(context.getResources().getColor(R.color.colorPrimary));
            //            holder.confirmBtn.setBackgroundResource(R.drawable.button_orange_selector);
            holder.confirmBtn.setVisibility(View.VISIBLE);
            holder.confirmBtn.setEnabled(true);
        } else if (Constants.OrderStatus.FINISH.equals(order.getStatusCode()) && order.getIsEvaluated() == 0) {//已收回=》评价
            confirmCode = R.string.order_to_evaluation;
            holder.confirmBtn.setText(context.getResources().getString(R.string.order_to_evaluation));
            holder.confirmBtn.setVisibility(View.VISIBLE);
            holder.confirmBtn.setEnabled(true);
        } else {
            holder.confirmBtn.setVisibility(View.GONE);
            holder.confirmBtn.setEnabled(false);
        }

        final int confirm = confirmCode;
        holder.confirmBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                switch (confirm) {
                    case R.string.order_to_pay:
                        handler.obtainMessage(Constants.HandlerCode.ORDER_PAY, position).sendToTarget();
                        break;
                    case R.string.order_to_receive:
                        handler.obtainMessage(Constants.HandlerCode.ORDER_RECEIVE, position).sendToTarget();
                        break;
                    case R.string.order_to_cancel:
                        handler.obtainMessage(Constants.HandlerCode.ORDER_CANCEL, position).sendToTarget();
                        break;
                    case R.string.order_to_evaluation:
                        handler.obtainMessage(Constants.HandlerCode.ORDER_EVALUATION, position).sendToTarget();
                        break;
                }
            }
        });
    }

    private static class ViewHolder {
        ImageView imageView;
        ImageView hasMore;
        ImageView storeImageviewIcon;
        ImageView bymyselfImageviewIcon;
        TextView orderStoreView;
        TextView statusView;
        TextView amountView;
        Button confirmBtn;
        LinearLayout orderPic;
    }
}
