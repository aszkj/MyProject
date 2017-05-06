package com.yilidi.o2o.product.proxy.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.service.BaseService;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.dao.UserRedEnvelopeActivityMapper;
import com.yilidi.o2o.product.proxy.IRedEnvelopeProxyService;

/**
 * 红包代理service接口实现类
 * 
 * @author: chenlian
 * @date: 2016年11月15日 上午9:52:27
 */
@Service("redEnvelopeProxyService")
public class RedEnvelopeProxyService extends BaseService implements IRedEnvelopeProxyService {

    @Autowired
    private UserRedEnvelopeActivityMapper userRedEnvelopeActivityMapper;

    @Override
    public Integer updateUserActivityByIdWithRedEnvelopeCount(Integer id) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new ProductServiceException("参数id不能为空");
            }
            Integer affectedCount = userRedEnvelopeActivityMapper.updateByIdWithRedEnvelopeCount(id);
            return affectedCount;
        } catch (Exception e) {
            logger.error("updateUserActivityByIdWithRedEnvelopeCount异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

}
