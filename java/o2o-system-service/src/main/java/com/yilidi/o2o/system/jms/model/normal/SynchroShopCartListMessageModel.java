package com.yilidi.o2o.system.jms.model.normal;

import java.util.List;

import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.order.proxy.dto.ShopCartProxyDto;

/**
 * 同步购物车消息
 * 
 * @author: chenbin
 * @date: 2016年5月26日 下午4:24:57
 */
public class SynchroShopCartListMessageModel extends JmsMessageModel {

    private static final long serialVersionUID = 7567603196352412095L;

    private Integer userId;

    private List<ShopCartProxyDto> shopCartProxyDtoList;

    public List<ShopCartProxyDto> getShopCartProxyDtoList() {
        return shopCartProxyDtoList;
    }

    public void setShopCartProxyDtoList(List<ShopCartProxyDto> shopCartProxyDtoList) {
        this.shopCartProxyDtoList = shopCartProxyDtoList;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

}
