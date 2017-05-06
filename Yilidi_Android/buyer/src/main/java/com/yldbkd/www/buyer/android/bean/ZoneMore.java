package com.yldbkd.www.buyer.android.bean;

/**
 * 销售专区更多信息数据
 * <p/>
 * Created by linghuxj on 16/6/2.
 */
public class ZoneMore extends BaseModel {
    /**
     * 专区连接分类
     */
    private Integer moreType;
    /**
     * 类型名称
     */
    private String moreData;

    /**
     * 专区图片
     */
    private String moreImgUrl;

    public Integer getMoreType() {
        return moreType;
    }

    public void setMoreType(Integer moreType) {
        this.moreType = moreType;
    }

    public String getMoreData() {
        return moreData;
    }

    public void setMoreData(String moreData) {
        this.moreData = moreData;
    }

    public String getMoreImgUrl() {
        return moreImgUrl;
    }

    public void setMoreImgUrl(String moreImgUrl) {
        this.moreImgUrl = moreImgUrl;
    }
}
