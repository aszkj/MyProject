package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.OrderBase;
import com.yldbkd.www.buyer.android.utils.Constants;

/**
 * 订单状态Adapter
 * <p/>
 * Created by linghuxj on 15/10/16.
 */
public class OrderStatusAdapter extends RecyclerView.Adapter<OrderStatusAdapter.ViewHolder> {

    private OrderBase order;
    private LayoutInflater inflater;
    private Context context;
    private static final int SIZE = 4;

    public OrderStatusAdapter(Context context, OrderBase order) {
        this.context = context;
        this.order = order;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.order_status_item, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        int textResId = 0;
        int textColorResId = R.color.secondaryText;
        int imageResId = 0;

        switch (position) {
            case 0:
                if (Constants.OrderStatus.BUILD_CODE.equals(order.getStatusCode())) {
                    textColorResId = R.color.colorPrimary;
                    imageResId = R.drawable.head_red_flag;
                } else {
                    imageResId = R.drawable.head_gray_flag;
                }
                textResId = R.string.order_build_text;
                break;
            case 1:
                if (Constants.OrderStatus.PAY_CODE.equals(order.getStatusCode())) {
                    textColorResId = R.color.colorPrimary;
                    imageResId = R.drawable.middle_red_flag;
                } else {
                    imageResId = R.drawable.middle_gray_flag;
                }
                textResId = R.string.order_pay_text;
                break;
            case 2:
                if (Constants.OrderStatus.WAIT_SEND_CODE.equals(order.getStatusCode())) {
                    textColorResId = R.color.colorPrimary;
                    imageResId = R.drawable.middle_red_flag;
                } else {
                    imageResId = R.drawable.middle_gray_flag;
                }
                textResId = R.string.order_delivery_text;
                break;
            case 3:
                if (Constants.OrderStatus.FINISH.equals(order.getStatusCode())) {
                    textColorResId = R.color.colorPrimary;
                    imageResId = R.drawable.tail_red_flag;
                } else {
                    imageResId = R.drawable.tail_gray_flag;
                }
                textResId = R.string.order_finish_text;
                break;
        }
        holder.imageView.setBackgroundResource(imageResId);
        holder.statusName.setText(context.getResources().getString(textResId));
        holder.statusName.setTextColor(context.getResources().getColor(textColorResId));
    }

    @Override
    public int getItemCount() {
        return SIZE;
    }

    static class ViewHolder extends RecyclerView.ViewHolder {
        private TextView statusName;
        private ImageView imageView;

        public ViewHolder(View itemView) {
            super(itemView);
            statusName = (TextView) itemView.findViewById(R.id.order_status_name_view);
            imageView = (ImageView) itemView.findViewById(R.id.order_status_image_view);
        }
    }
}
