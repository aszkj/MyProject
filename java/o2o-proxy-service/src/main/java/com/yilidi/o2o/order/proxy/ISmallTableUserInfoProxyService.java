package com.yilidi.o2o.order.proxy;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.user.proxy.dto.SmallTableUserInfoProxyDto;

/**
 * 用户信息小表代理Service接口
 * 
 * @author: chenlian
 * @date: 2016年8月11日 下午10:58:03
 */
public interface ISmallTableUserInfoProxyService {

    /**
     * 保存用户信息小表
     * 
     * @param smallTableUserInfoProxyDto
     *            用户信息小表
     * @throws OrderServiceException
     *             服务异常
     */
    public void save(SmallTableUserInfoProxyDto smallTableUserInfoProxyDto) throws OrderServiceException;

    /**
     * 根据用户ID更新用户信息小表
     * 
     * @param smallTableUserInfoProxyDto
     *            用户信息小表
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateByUserId(SmallTableUserInfoProxyDto smallTableUserInfoProxyDto) throws OrderServiceException;

}
