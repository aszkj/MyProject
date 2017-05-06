package com.yilidi.o2o.appvo.buyer.user;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 获取分享短信信息
 * 
 * @author: chenb
 * @date: 2016年5月27日 上午11:41:15
 */
public class ShareToSmsVO extends AppBaseVO {

    private static final long serialVersionUID = -6259885479905064989L;

    /**
     * 分享短信内容
     */
    private String content;

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

}
