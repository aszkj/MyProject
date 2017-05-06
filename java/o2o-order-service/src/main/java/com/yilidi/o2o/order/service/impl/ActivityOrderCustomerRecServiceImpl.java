/**
 * 文件名称：CommissionClearupService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.dao.ActivityOrderCustomerRecMapper;
import com.yilidi.o2o.order.service.IActivityOrderCustomerRecService;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 
 * 活动订单记录service实现
 * 
 * @author: chenb
 * @date: 2016年7月12日 下午3:14:31
 * 
 */
@Service("activityOrderCustomerRecService")
public class ActivityOrderCustomerRecServiceImpl extends BasicDataService implements IActivityOrderCustomerRecService {

    @Autowired
    private ActivityOrderCustomerRecMapper activityOrderCustomerRecMapper;

    @Override
    public Integer loadOrderCountByBuyerCustomerIdAndActivityIdAndDeviceId(Integer buyerCustomerId, Integer activityId,
            Integer saleProductId, String deviceId, String addressDetail) {
        try {
            if (ObjectUtils.isNullOrEmpty(buyerCustomerId) || ObjectUtils.isNullOrEmpty(activityId)
                    || ObjectUtils.isNullOrEmpty(saleProductId) || ObjectUtils.isNullOrEmpty(deviceId)) {
                throw new OrderServiceException("参数不能为空");
            }
            Integer result = activityOrderCustomerRecMapper.loadOrderCountByBuyerCustomerIdAndActivityIdAndDeviceId(
                    buyerCustomerId, activityId, saleProductId, deviceId, addressDetail);
            return ArithUtils.converIntegerToInt(result);
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public Integer loadSaleProductOrderCountByActivityIdAndSaleProductId(Integer activityId, Integer saleProductId) {
        try {
            if (ObjectUtils.isNullOrEmpty(activityId) || ObjectUtils.isNullOrEmpty(saleProductId)) {
                throw new OrderServiceException("参数不能为空");
            }
            Integer result = activityOrderCustomerRecMapper.loadSaleProductOrderCountByActivityIdAndSaleProductId(activityId,
                    saleProductId, SystemContext.OrderDomain.ACTIVITYORDERCUSTOMERRESTATUS_NORMAL);
            return ArithUtils.converIntegerToInt(result);
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

}
