package com.yilidi.o2o.appvo.buyer.user;

/**
 * 登录授权
 * 
 * @author: chenb
 * @date: 2016年5月25日 下午2:26:21
 */
public class ConnectUserLoginVO extends LoginVO {

    private static final long serialVersionUID = 1L;

    private int binding;

    public int getBinding() {
        return binding;
    }

    public void setBinding(int binding) {
        this.binding = binding;
    }

}
