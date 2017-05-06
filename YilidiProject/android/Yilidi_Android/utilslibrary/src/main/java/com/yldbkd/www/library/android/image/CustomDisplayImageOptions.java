package com.yldbkd.www.library.android.image;

import android.graphics.Bitmap;
import android.view.View;
import android.widget.ImageView;

import com.nostra13.universalimageloader.core.DisplayImageOptions;
import com.nostra13.universalimageloader.core.assist.FailReason;
import com.nostra13.universalimageloader.core.assist.ImageScaleType;
import com.nostra13.universalimageloader.core.display.SimpleBitmapDisplayer;
import com.nostra13.universalimageloader.core.listener.ImageLoadingListener;
import com.yldbkd.www.library.android.R;

public final class CustomDisplayImageOptions {

    /**
     * 获取图片显示选项对象实体
     *
     * @return 图片显示选项
     */
    public static DisplayImageOptions getDisplayImageOptions() {
        return getDisplayImageOptions(R.drawable.no_picture);
    }

    public static DisplayImageOptions getDisplayImageOptions(int noPictureResource) {
        return new DisplayImageOptions.Builder()
                .showImageForEmptyUri(noPictureResource)
                .showImageOnLoading(noPictureResource)
                .showImageOnFail(noPictureResource)
                .cacheInMemory(true).cacheOnDisc(true)
                .imageScaleType(ImageScaleType.IN_SAMPLE_INT)
                .bitmapConfig(Bitmap.Config.RGB_565)
                .displayer(new SimpleBitmapDisplayer())
                .resetViewBeforeLoading(true).build();
    }

    /**
     * 获取图片显示选项对象实体
     *
     * @return 图片显示选项
     */
    public static DisplayImageOptions getDisplayImageNoneOptions() {
        return new DisplayImageOptions.Builder()
                .cacheInMemory(true).cacheOnDisc(true)
                .imageScaleType(ImageScaleType.IN_SAMPLE_INT)
                .bitmapConfig(Bitmap.Config.RGB_565)
                .displayer(new SimpleBitmapDisplayer())
                .resetViewBeforeLoading(true).build();
    }

    /**
     * 获取图片显示Listener
     *
     * @return Listener实体
     */
    public static ImageLoadingListener getImageLoadingListener() {
        return getImageLoadingListener(false);
    }

    /**
     * 获取图片显示Listener（图片转换为灰度图片）
     *
     * @return Listener实体
     */
    public static ImageLoadingListener getImageLoadingListener(final boolean isGrayscale) {
        return new ImageLoadingListener() {

            @Override
            public void onLoadingStarted(String arg0, View arg1) {
            }

            @Override
            public void onLoadingFailed(String arg0, View arg1, FailReason arg2) {
            }

            @Override
            public void onLoadingComplete(String arg0, View arg1, Bitmap arg2) {
                if (isGrayscale) {
                    arg2 = ImageUtils.toGrayscale(arg2);
                }
                ((ImageView) arg1).setImageBitmap(arg2);
            }

            @Override
            public void onLoadingCancelled(String arg0, View arg1) {
            }
        };
    }

}
