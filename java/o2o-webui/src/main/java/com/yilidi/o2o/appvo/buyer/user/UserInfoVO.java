package com.yilidi.o2o.appvo.buyer.user;

/**
 * 用户信息
 * 
 * @author: chenb
 * @date: 2016年5月27日 上午11:41:15
 */
public class UserInfoVO extends UserBaseInfoVO {

    private static final long serialVersionUID = 2585477308129727989L;
    /**
     * 绑定QQ账号信息
     */
    private BindQQInfoVO bindQQInfo;
    /**
     * 绑定微信账号信息
     */
    private BindWXInfoVO bindWXInfo;

    public BindQQInfoVO getBindQQInfo() {
        return bindQQInfo;
    }

    public void setBindQQInfo(BindQQInfoVO bindQQInfo) {
        this.bindQQInfo = bindQQInfo;
    }

    public BindWXInfoVO getBindWXInfo() {
        return bindWXInfo;
    }

    public void setBindWXInfo(BindWXInfoVO bindWXInfo) {
        this.bindWXInfo = bindWXInfo;
    }
}
