package com.yldbkd.www.buyer.android.adapter;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import com.yldbkd.www.buyer.android.R;
import com.yldbkd.www.buyer.android.activity.MainActivity;
import com.yldbkd.www.buyer.android.bean.Advertisement;
import com.yldbkd.www.buyer.android.utils.JumpUtils;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;

import java.util.List;

/**
 * 横向滑动ViewAdapter
 * <p/>
 * Created by linghuxj on 16/8/22.
 */
public class AdvertZoneAdapter extends RecyclerView.Adapter<AdvertZoneAdapter.ViewHolder> {

    private Context context;
    private List<Advertisement> advertisements;
    private LayoutInflater inflater;

    public AdvertZoneAdapter(List<Advertisement> advertisements, Context context) {
        this.advertisements = advertisements;
        this.context = context;
        this.inflater = LayoutInflater.from(context);
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = inflater.inflate(R.layout.item_advert_zone, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        final Advertisement advert = advertisements.get(position);
        ImageLoaderUtils.load(holder.zoneImageView, advert.getImageUrl(), com.yldbkd.www.library.android.R.drawable.no_picture_rect);
        final MainActivity activity = (MainActivity) context;
        holder.zoneImageView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                JumpUtils.jump(activity, advert.getLinkType(), advert.getLinkData());
            }
        });
    }

    @Override
    public int getItemCount() {
        return advertisements == null ? 0 : advertisements.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {

        ImageView zoneImageView;

        public ViewHolder(View itemView) {
            super(itemView);
            this.zoneImageView = (ImageView) itemView.findViewById(R.id.item_advert_zone_image);
        }
    }
}
