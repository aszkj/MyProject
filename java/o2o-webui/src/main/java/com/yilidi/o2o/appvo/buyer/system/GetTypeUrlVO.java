package com.yilidi.o2o.appvo.buyer.system;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 获取url跳转地址
 * 
 * @author: chenb
 * @date: 2016年5月27日 上午9:32:37
 */
public class GetTypeUrlVO extends AppBaseVO {
    private static final long serialVersionUID = 4971955272559408454L;

    /**
     * 跳转地址
     */
    private String value;

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public GetTypeUrlVO() {
    }

    public GetTypeUrlVO(String url) {
        this.value = url;
    }
}
