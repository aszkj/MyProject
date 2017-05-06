package com.yilidi.o2o.appvo.buyer.user;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 绑定QQ信息
 * 
 * @author: chenb
 * @date: 2016年5月25日 下午2:26:21
 */
public class BindQQInfoVO extends AppBaseVO {

    private static final long serialVersionUID = -8671234813375104177L;
    /**
     * 用户绑定QQ的昵称
     */
    private String nickName;

    public BindQQInfoVO() {
    }

    public BindQQInfoVO(String nickName) {
        this.nickName = nickName;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

}
