package com.yilidi.o2o.user.proxy;

import com.yilidi.o2o.user.proxy.dto.UserClientTokenProxyDto;

/**
 * 用户与APP客户端Token关联关系代理Service接口
 * 
 * @author: chenlian
 * @date: 2016年8月8日 下午6:46:27
 */
public interface IUserClientTokenProxyService {

    /**
     * 根据用户ID获取用户与APP客户端Token关联关系
     * 
     * @param userId
     * @return UserClientTokenProxyDto
     */
    public UserClientTokenProxyDto loadByUserId(Integer userId);

}
