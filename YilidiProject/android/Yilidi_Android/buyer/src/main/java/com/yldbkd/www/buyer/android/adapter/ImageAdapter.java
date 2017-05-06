package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.os.Handler;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.bean.ImageUrlBean;
import com.yldbkd.www.buyer.android.utils.Constants;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;

import java.util.List;

/**
 * @创建者 李贞高
 * @创建时间 2017/2/8 10:43
 * @描述 每个商品评价内容
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class ImageAdapter extends RecyclerView.Adapter<ImageAdapter.ViewHolder> {

    private int number;
    private Context context;
    private boolean isShow;
    private List<ImageUrlBean> imageUrls;
    private LayoutInflater inflater;
    private Handler handler;

    public ImageAdapter(Context context, int number, List<ImageUrlBean> imageUrls, Handler handler, boolean isShow) {
        this.imageUrls = imageUrls;
        this.context = context;
        this.handler = handler;
        this.number = number;
        this.isShow = isShow;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.image_item, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final ViewHolder holder, final int position) {
        if (imageUrls == null || imageUrls.size() == 0 || position == imageUrls.size()) {
            holder.imageView.setImageResource(R.mipmap.camera);
            holder.imageView.setVisibility(isShow ? View.GONE : View.VISIBLE);
        } else {
            ImageUrlBean imageUrl = imageUrls.get(position);
            ImageLoaderUtils.load(holder.imageView, imageUrl.getImageUrl());
        }
        holder.imageView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                holder.imageView.setFocusable(true);
                holder.imageView.setFocusableInTouchMode(true);
                holder.imageView.requestFocus();
                //预览还是添加
                handler.obtainMessage(Constants.HandlerCode.EVALUTIONPICTUREITEM, number, position)
                        .sendToTarget();
            }
        });
    }

    @Override
    public int getItemCount() {
        return imageUrls == null ? 1 : imageUrls.size() >= 10 ? 10 : (imageUrls.size() + 1);
    }

    static class ViewHolder extends RecyclerView.ViewHolder {
        private ImageView imageView;

        public ViewHolder(View itemView) {
            super(itemView);
            imageView = (ImageView) itemView.findViewById(R.id.image_show_view);
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
