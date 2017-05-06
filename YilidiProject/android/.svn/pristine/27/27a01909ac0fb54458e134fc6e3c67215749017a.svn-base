package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.os.Handler;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.AddressBase;
import com.yldbkd.www.buyer.android.bean.Community;
import com.yldbkd.www.buyer.android.utils.CommunityUtils;
import com.yldbkd.www.buyer.android.utils.Constants;

import java.util.List;

/**
 * 页面的地址列表Adapter
 * <p/>
 * Created by linghuxj on 15/10/28.
 */
public class AddressAdapter extends BaseAdapter {

    private boolean isCartSelected;
    private Context context;
    private List<AddressBase> addresses;
    private LayoutInflater inflater;
    private Handler handler;

    private AddressAdapter(List<AddressBase> addresses, Context context, Handler handler) {
        this.context = context;
        this.addresses = addresses;
        this.inflater = LayoutInflater.from(context);
        this.handler = handler;
    }

    public AddressAdapter(List<AddressBase> addresses, Context context, Handler handler, boolean isCartSelected) {
        this(addresses, context, handler);
        this.isCartSelected = isCartSelected;
    }

    @Override
    public int getCount() {
        return addresses == null ? 0 : addresses.size();
    }

    @Override
    public Object getItem(int i) {
        return getCount() == 0 ? null : addresses.get(i);
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
            view = inflater.inflate(R.layout.address_item, viewGroup, false);
            holder.contentLayout = (RelativeLayout) view.findViewById(R.id.address_content_layout);
            holder.itemViewLayout = (RelativeLayout) view.findViewById(R.id.rl_address_item_view);
            holder.userNameView = (TextView) view.findViewById(R.id.address_user_view);
            holder.mobileView = (TextView) view.findViewById(R.id.address_mobile_view);
            holder.addressView = (TextView) view.findViewById(R.id.address_detail_view);
            holder.editView = (ImageView) view.findViewById(R.id.address_edit_view);
            holder.noChooseNote = (TextView) view.findViewById(R.id.address_no_choose);
            view.setTag(holder);
        } else {
            holder = (ViewHolder) view.getTag();
        }

        setData(holder, position);
        return view;
    }

    private void setData(final ViewHolder holder, final int position) {
        AddressBase address = addresses.get(position);
        Community community = address.getCommunity();
        holder.userNameView.setText(address.getConsigneeName());
        holder.mobileView.setText(address.getPhoneNo());
        holder.addressView.setText(String.valueOf(community.getCommunityName() + community.getAddressDetail()));
        if (isCartSelected) {
            int textId;
            int bgId = 0;
            int editImage;
            Integer saveStoreId = CommunityUtils.getCurrentStoreId();

            if (community.getStoreInfo() == null || community.getStoreInfo().getStoreId().intValue() != saveStoreId.intValue()) {
                //灰色，不可选择
                holder.editView.setEnabled(false);
                holder.noChooseNote.setVisibility(View.VISIBLE);
                editImage = R.mipmap.address_no_edit;
                textId = R.color.lightText;
                bgId = R.color.nochoose_address;
                holder.addressView.setTextColor(context.getResources().getColor(R.color.lightText));
                holder.contentLayout.setOnClickListener(null);
            } else {
                editImage = R.mipmap.address_edit;
                holder.editView.setEnabled(true);
                holder.noChooseNote.setVisibility(View.GONE);
                textId = R.color.primaryText;
                holder.addressView.setTextColor(context.getResources().getColor(R.color.secondaryText));
                holder.contentLayout.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        handler.obtainMessage(Constants.HandlerCode.ADDRESS_SELECT, position).sendToTarget();
                    }
                });
            }
            holder.contentLayout.setBackgroundResource(bgId);
            holder.itemViewLayout.setBackgroundResource(bgId);
            holder.userNameView.setTextColor(context.getResources().getColor(textId));
            holder.mobileView.setTextColor(context.getResources().getColor(textId));
            holder.editView.setBackgroundResource(editImage);
        }
        holder.editView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                handler.obtainMessage(Constants.HandlerCode.ADDRESS_MODIFY, position).sendToTarget();
            }
        });
    }

    private static class ViewHolder {
        RelativeLayout contentLayout;
        RelativeLayout itemViewLayout;
        TextView userNameView;
        TextView mobileView;
        TextView addressView;
        TextView noChooseNote;
        ImageView editView;
    }
}
