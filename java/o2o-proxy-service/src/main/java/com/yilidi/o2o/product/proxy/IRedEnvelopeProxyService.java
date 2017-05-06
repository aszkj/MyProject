package com.yilidi.o2o.product.proxy;

import com.yilidi.o2o.core.exception.ProductServiceException;

/**
 * 红包代理service接口
 * 
 * @author: chenlian
 * @date: 2016年11月15日 上午9:45:34
 */
public interface IRedEnvelopeProxyService {

    /**
     * 根据id更新用户抢到红包的数量
     * 
     * @param id
     *            用户抢红包活动信息ID
     * @return 更新记录条数
     * @throws ProductServiceException
     *             产品域服务异常
     */
    public Integer updateUserActivityByIdWithRedEnvelopeCount(Integer id) throws ProductServiceException;

}
