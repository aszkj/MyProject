package com.yilidi.o2o.appvo.buyer.user;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 绑定微信信息
 * 
 * @author: chenb
 * @date: 2016年5月25日 下午2:26:21
 */
public class BindWXInfoVO extends AppBaseVO {

    private static final long serialVersionUID = -2851348668761599407L;
    /**
     * 用户绑定微信的昵称
     */
    private String nickName;

    public BindWXInfoVO() {
    }

    public BindWXInfoVO(String nickName) {
        this.nickName = nickName;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

}
