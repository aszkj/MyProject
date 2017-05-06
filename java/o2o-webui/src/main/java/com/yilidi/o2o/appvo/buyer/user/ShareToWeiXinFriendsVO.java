package com.yilidi.o2o.appvo.buyer.user;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 获取分享微信好友信息
 * 
 * @author: chenb
 * @date: 2016年5月27日 上午11:41:15
 */
public class ShareToWeiXinFriendsVO extends AppBaseVO {

    private static final long serialVersionUID = -5018888875702154627L;

    /**
     * 分享标题
     */
    private String title;
    /**
     * 分享内容信息
     */
    private String content;
    /**
     * 分享图片信息(为空使用应用logo)
     */
    private String imageUrl;
    /**
     * 分享链接HTML页面URL
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
