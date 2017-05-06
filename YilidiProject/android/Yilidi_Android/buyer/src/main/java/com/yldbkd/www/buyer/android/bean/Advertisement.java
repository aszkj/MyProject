package com.yldbkd.www.buyer.android.bean;

import com.yldbkd.www.library.android.banner.BannerBean;

/**
 * 广告数据信息类
 * <p/>
 * Created by linghuxj on 15/9/29.
 */
public class Advertisement extends BannerBean {

    /**
     * 链接类型
     */
    private Integer linkType;
    /**
     * 链接数据
     */
    private String linkData;
    /**
     * 广告名称
     */
    private String titleName;

    public Integer getLinkType() {
        return linkType;
    }

    public void setLinkType(Integer linkType) {
        this.linkType = linkType;
    }

    public String getLinkData() {
        return linkData;
    }

    public void setLinkData(String linkData) {
        this.linkData = linkData;
    }

    public String getTitleName() {
        return titleName;
    }

    public void setTitleName(String titleName) {
        this.titleName = titleName;
    }
}
