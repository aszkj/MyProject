package com.yldbkd.www.seller.android.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.yldbkd.www.seller.android.R;
import com.yldbkd.www.seller.android.bean.InvitationUser;
import com.yldbkd.www.seller.android.utils.Constants;

import java.util.List;

/**
 * 邀请人员列表Adapter
 * <p/>
 * Created by linghuxj on 16/5/30.
 */
public class InviteRecordAdapter extends BaseAdapter<InviteRecordAdapter.ViewHolder> {

    private Context mContext;
    private List<InvitationUser> invitationUsers;
    private LayoutInflater mInflater;

    public InviteRecordAdapter(Context mContext, List<InvitationUser> invitationUsers) {
        this.mContext = mContext;
        this.invitationUsers = invitationUsers;
        this.mInflater = LayoutInflater.from(mContext);
    }

    @Override
    public ViewHolder onCreateHolder(ViewGroup parent, int viewType) {
        View view = mInflater.inflate(R.layout.item_invite_record, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindHolder(ViewHolder holder, int position) {
        final InvitationUser invitationUser = invitationUsers.get(position);
        holder.mobileView.setText(invitationUser.getUserMaskMobile());
        holder.userNameView.setText(invitationUser.getUserName());
        holder.flagView.setVisibility(invitationUser.getVipFlag() == Constants.VIP_LEVEL.NORMAL ?
                View.GONE : View.VISIBLE);
        holder.flagView.setText(invitationUser.getVipFlag() == Constants.VIP_LEVEL.PLATINUM ?
                mContext.getString(R.string.invite_list_vip_type_1) : invitationUser.getVipFlag() == Constants.VIP_LEVEL.PLATINUM_PAUSE ?
                mContext.getString(R.string.invite_list_vip_type_2) : "");
    }

    @Override
    public int getCount() {
        return invitationUsers == null ? 0 : invitationUsers.size();
    }

    class ViewHolder extends BaseAdapter.Holder {

        TextView mobileView;
        TextView userNameView;
        TextView flagView;

        public ViewHolder(View itemView) {
            super(itemView);
            this.mobileView = (TextView) itemView.findViewById(R.id.tv_item_invite_mobile);
            this.userNameView = (TextView) itemView.findViewById(R.id.tv_item_invite_user);
            this.flagView = (TextView) itemView.findViewById(R.id.tv_item_vip_flag);
        }
    }
}
