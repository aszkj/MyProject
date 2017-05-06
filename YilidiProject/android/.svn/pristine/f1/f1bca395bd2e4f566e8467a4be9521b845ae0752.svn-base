package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.support.v4.content.ContextCompat;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.OrderDetail;
import com.yldbkd.www.buyer.android.bean.OrderStatus;

/**
 * @创建者 李贞高
 * @创建时间 2016/6/18 16:47
 * @描述 订单状态列表
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class NewOrderStatusAdapter extends BaseAdapter {

    private OrderDetail mOrderDetail;
    private LayoutInflater inflater;
    private Context context;

    public NewOrderStatusAdapter(OrderDetail orderDetail, Context context) {
        mOrderDetail = orderDetail;
        this.inflater = LayoutInflater.from(context);
        this.context = context;
    }

    @Override
    public int getCount() {
        return mOrderDetail.getOrderStatusList() == null ? 0 : mOrderDetail.getOrderStatusList().size();
    }

    @Override
    public Object getItem(int i) {
        return getCount() == 0 ? null : mOrderDetail.getOrderStatusList().get(i);
    }

    @Override
    public long getItemId(int i) {
        return i;
    }

    @Override
    public View getView(int position, View view, ViewGroup viewGroup) {
        ViewHolder holder;
        if (view == null) {
            holder = new ViewHolder();
            view = inflater.inflate(R.layout.new_order_status_item, viewGroup, false);
            holder.statusName = (TextView) view.findViewById(R.id.order_status_name_view);
            holder.statusTime = (TextView) view.findViewById(R.id.order_status_change_time);
            holder.statusNote = (TextView) view.findViewById(R.id.order_status_note);
            holder.imageView = (ImageView) view.findViewById(R.id.order_status_image_view);
            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }
        int imageResId;
        int nameTextColorId;
        int descTextColorId;
        OrderStatus orderStatus = mOrderDetail.getOrderStatusList().get(position);
        //如果是第一条
        if (getCount() > 1) {
            if (position == getCount() - 1) {
                imageResId = R.drawable.start_normal;
                nameTextColorId = R.color.lightText;
                descTextColorId = R.color.lightText;
            } else if (position == 0) {
                imageResId = R.drawable.end;
                nameTextColorId = R.color.colorBlue;
                descTextColorId = R.color.colorBlue;
            } else {
                imageResId = R.drawable.middle;
                nameTextColorId = R.color.lightText;
                descTextColorId = R.color.lightText;
            }
        } else {
            imageResId = R.drawable.start_checked;
            nameTextColorId = R.color.colorBlue;
            descTextColorId = R.color.colorBlue;
        }
        holder.imageView.setBackgroundResource(imageResId);

        holder.statusName.setTextColor(ContextCompat.getColor(context, nameTextColorId));
        holder.statusTime.setTextColor(ContextCompat.getColor(context, descTextColorId));
        holder.statusNote.setTextColor(ContextCompat.getColor(context, descTextColorId));

        holder.statusName.setText(orderStatus.getStatusCodeName());
        holder.statusTime.setText(orderStatus.getStatusTime());
        holder.statusNote.setText(orderStatus.getStatusNote());
        return view;
    }

    private static class ViewHolder {
        private TextView statusName;
        private TextView statusTime;
        private TextView statusNote;
        private ImageView imageView;
    }
}
