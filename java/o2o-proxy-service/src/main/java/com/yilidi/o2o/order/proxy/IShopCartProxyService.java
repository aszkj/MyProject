package com.yilidi.o2o.order.proxy;

import java.util.List;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.order.proxy.dto.ShopCartProxyDto;

/**
 * 购物车代理服务接口
 * 
 * @author: chenb
 * @date: 2016年6月29日 下午5:54:19
 */
public interface IShopCartProxyService {
    /**
     * 同步购物车
     * 
     * @param userId
     *            用户ID
     * @param shopCartProxyDtoList
     *            购物车代理DTO列表
     * @throws OrderServiceException
     *             订单服务异常
     */
    void synchronousCart(Integer userId, List<ShopCartProxyDto> shopCartProxyDtoList) throws OrderServiceException;
}
