package com.yldbkd.www.buyer.android.bean;

/**
 * @创建者 李贞高
 * @创建时间 2016/12/8 9:19
 * @描述 分享微信好友
 * @更新者 $Author$
 * @更新时间 $Date$
 * @更新描述
 */
public class WEChat extends BaseModel {
    /**
     * 分享标题
     */
    private String title;
    /**
     * 分享内容
     */
    private String content;
    /**
     * 分享图片信息
     */
    private String imageUrl;
    /**
     * 分享链接
     */
    private String redirectUrl;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getRedirectUrl() {
        return redirectUrl;
    }

    public void setRedirectUrl(String redirectUrl) {
        this.redirectUrl = redirectUrl;
    }
}
