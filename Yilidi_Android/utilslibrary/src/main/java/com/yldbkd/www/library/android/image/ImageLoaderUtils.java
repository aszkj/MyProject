package com.yldbkd.www.library.android.image;

import android.app.ActivityManager;
import android.content.Context;
import android.text.TextUtils;
import android.view.View;
import android.widget.ImageView;

import com.nostra13.universalimageloader.cache.memory.impl.WeakMemoryCache;
import com.nostra13.universalimageloader.core.DisplayImageOptions;
import com.nostra13.universalimageloader.core.ImageLoader;
import com.nostra13.universalimageloader.core.ImageLoaderConfiguration;
import com.yldbkd.www.library.android.R;

/**
 * 远程加载图片信息工具类
 * <p/>
 * Created by linghuxj on 15/8/20.
 */
public class ImageLoaderUtils {

    public static void load(ImageView imageView, String url) {
        load(imageView, url, R.drawable.no_picture);
    }

    public static void load(ImageView imageView, String url, int noPictureResource) {
        if (TextUtils.isEmpty(url)) {
            imageView.setImageResource(noPictureResource);
            return;
        }
        if (!url.equals(imageView.getTag())) {
            imageView.setTag(url);
            ImageLoader.getInstance().displayImage(url, imageView, CustomDisplayImageOptions.getDisplayImageOptions(noPictureResource),
                    CustomDisplayImageOptions.getImageLoadingListener());
        }
    }

    public static void loadNoneBG(ImageView imageView, String url) {
        if (TextUtils.isEmpty(url)) {
            imageView.setVisibility(View.INVISIBLE);
            return;
        }
        if (!url.equals(imageView.getTag())) {
            imageView.setTag(url);
            ImageLoader.getInstance().displayImage(url, imageView, CustomDisplayImageOptions.getDisplayImageNoneOptions(),
                    CustomDisplayImageOptions.getImageLoadingListener());
        }
    }

    public static void initImageLoader(Context context) {
        // 获取可用内存缓存大小
        int memClass = ((ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE)).getMemoryClass();
        memClass = memClass > 256 ? 256 : memClass;
        // 使用可用内存的1/4作为图片缓存
        final int cacheSize = 1024 * 1024 * memClass / 4;
        DisplayImageOptions defaultOptions = CustomDisplayImageOptions.getDisplayImageOptions();
        ImageLoaderConfiguration config = new ImageLoaderConfiguration.Builder(context)
                .denyCacheImageMultipleSizesInMemory().threadPoolSize(memClass / 3)
                .memoryCache(new WeakMemoryCache()).memoryCacheSize(cacheSize)
                .defaultDisplayImageOptions(defaultOptions)
                .build();

        ImageLoader.getInstance().init(config);
    }
}
