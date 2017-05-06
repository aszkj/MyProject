package com.yldbkd.www.library.android.banner;

import android.content.Context;
import android.support.v4.view.PagerAdapter;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import com.yldbkd.www.library.android.R;
import com.yldbkd.www.library.android.image.ImageLoaderUtils;

import java.util.List;

/**
 * 基于PagerAdapter的轮播Adapter
 * <p/>
 * Created by linghuxj on 2015/9/28.
 */
public abstract class BannerViewAdapter<T extends BannerBean> extends PagerAdapter {

    private List<T> list;
    private Context context;
    private int count;

    private static final ImageView.ScaleType DEFAULT_TYPE = ImageView.ScaleType.FIT_XY;
    private ImageView.ScaleType scaleType;

    public BannerViewAdapter(Context context, List<T> list) {
        this.context = context;
        this.list = list;
        if (list == null) {
            this.count = 0;
        } else {
            this.count = list.size();
        }
    }

    public BannerViewAdapter(Context context, List<T> list, ImageView.ScaleType scaleType) {
        this.context = context;
        this.list = list;
        if (list == null) {
            this.count = 0;
        } else {
            this.count = list.size();
        }
        this.scaleType = scaleType;
    }

    @Override
    public int getCount() {
        if (list != null && list.size() > 1) {
            return Integer.MAX_VALUE;
        } else if (list != null) {
            return 1;
        } else {
            return 0;
        }
    }

    @Override
    public boolean isViewFromObject(View view, Object o) {
        return view == o;
    }

    @Override
    public Object instantiateItem(ViewGroup container, final int position) {
        if (count == 0) {
            return null;
        }
        BannerBean advert = list.get(position % count);
        String url = advert.getImageUrl();
        ImageView view = new ImageView(context);
        view.setImageDrawable(null);
        view.setAdjustViewBounds(true);
        view.setScaleType(scaleType == null ? DEFAULT_TYPE : scaleType);
        view.setBackgroundColor(context.getResources().getColor(R.color.white));
        ImageLoaderUtils.load(view, url, R.drawable.no_picture_rect);
        container.addView(view, 0);
        view.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                jumpTo(position);
            }
        });
        return view;
    }

    @Override
    public void destroyItem(ViewGroup container, int position, Object object) {
        container.removeView((View) object);
    }

    @Override
    public int getItemPosition(Object object) {
        if (count > 0) {
            count--;
            return POSITION_NONE;
        }
        return super.getItemPosition(object);
    }

    /**
     * 抽象化轮播图片点击产生后续跳转的操作（由各子类实现其跳转处理逻辑）
     */
    public abstract void jumpTo(int position);

    @Override
    public void notifyDataSetChanged() {
        count = getCount();
        super.notifyDataSetChanged();
    }

}
