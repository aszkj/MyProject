package com.yldbkd.www.library.android.banner;

import java.io.Serializable;

/**
 * 轮播基类BEAN(所有可用于轮播的地方所需要的BEAN都必须继承该BEAN以方便实现轮播方式)
 * <p/>
 * Created by linghuxj on 2015/9/28.
 */
public class BannerBean implements Serializable {
    /**
     * 轮播图片的URL
     */
    private String imageUrl;

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

}
