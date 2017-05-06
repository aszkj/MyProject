package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.os.Handler;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.MessageDetail;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;

import java.util.List;

/**
 * @创建者 李贞高
 * @创建时间 2016/12/12 11:14
 * @描述 有图片消息adapter
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class MessageActivityAdapter extends RecyclerView.Adapter<MessageActivityAdapter.ViewHolder> {
    private Handler handler;
    private Context context;
    private List<MessageDetail> mMessageList;
    private LayoutInflater inflater;

    public MessageActivityAdapter(List<MessageDetail> messages, Context context, Handler handler) {
        this.mMessageList = messages;
        this.context = context;
        this.handler = handler;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.message_activity_item, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
        MessageDetail messageDetail = mMessageList.get(position);
        holder.messageTime.setText(messageDetail.getMsgTime());
        holder.messageTitle.setText(messageDetail.getMsgTitle());
        holder.messageAbstract.setText(messageDetail.getMsgAbstract());
        ImageLoaderUtils.load(holder.messageImage, messageDetail.getMsgImage(), com.yldbkd.www.library.android.R.drawable.no_picture_rect);
        final int directType = messageDetail.getDirectType();
        final int msgId = messageDetail.getMsgId();
        final String directCode = messageDetail.getDirectCode() + "";
        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                handler.obtainMessage(Constants.HandlerCode.MESSAGEJUMP, msgId, directType, directCode).sendToTarget();
            }
        });
    }

    @Override
    public int getItemCount() {
        return mMessageList == null ? 0 : mMessageList.size();
    }

    static class ViewHolder extends RecyclerView.ViewHolder {

        private TextView messageTime;
        private TextView messageTitle;
        private TextView messageAbstract;
        private ImageView messageImage;

        public ViewHolder(View itemView) {
            super(itemView);
            messageTime = (TextView) itemView.findViewById(R.id.message_time);
            messageTitle = (TextView) itemView.findViewById(R.id.message_title);
            messageAbstract = (TextView) itemView.findViewById(R.id.message_abstract);
            messageImage = (ImageView) itemView.findViewById(R.id.message_image);
        }
    }

    public interface OnItemClickListener {
        void onItemClick(View view, int position);
    }

    private OnItemClickListener itemClickListener;

    public void setItemClickListener(OnItemClickListener itemClickListener) {
        this.itemClickListener = itemClickListener;
    }
}
