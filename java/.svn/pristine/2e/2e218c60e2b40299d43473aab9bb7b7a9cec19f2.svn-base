/**
 * 文件名称：CommissionClearupService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service.impl;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.dao.FirstOrderCustomerRecMapper;
import com.yilidi.o2o.order.model.FirstOrderCustomerRec;
import com.yilidi.o2o.order.service.IFirstOrderCustomerRecService;
import com.yilidi.o2o.order.service.dto.FirstOrderCustomerRecDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 
 * 首单信息service实现
 * 
 * @author: chenb
 * @date: 2016年7月12日 下午3:14:31
 * 
 */
@Service("firstOrderCustomerRecService")
public class FirstOrderCustomerRecServiceImpl extends BasicDataService implements IFirstOrderCustomerRecService {

    @Autowired
    private FirstOrderCustomerRecMapper firstOrderCustomerRecMapper;

    @Override
    public void saveFirstOrderCustomerRec(FirstOrderCustomerRecDto firstOrderCustomerRecDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(firstOrderCustomerRecDto)) {
                throw new OrderServiceException("参数不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(firstOrderCustomerRecDto.getBuyerCustomerId())) {
                throw new OrderServiceException("客户Id不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(firstOrderCustomerRecDto.getSaleOrderNo())) {
                throw new OrderServiceException("订单号不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(firstOrderCustomerRecDto.getFirstOrderType())) {
                throw new OrderServiceException("首单类型不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(firstOrderCustomerRecDto.getCreateUserId())) {
                throw new OrderServiceException("操作用户ID不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(firstOrderCustomerRecDto.getCreateTime())) {
                firstOrderCustomerRecDto.setCreateTime(new Date());
            }
            FirstOrderCustomerRec FirstOrderCustomerRec = new FirstOrderCustomerRec();
            ObjectUtils.fastCopy(firstOrderCustomerRecDto, FirstOrderCustomerRec);
            Integer effectCount = firstOrderCustomerRecMapper.save(FirstOrderCustomerRec);
            if (1 != effectCount) {
                logger.error("INSERT 数据库失败");
                throw new OrderServiceException("保存首单记录信息失败");
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public FirstOrderCustomerRecDto loadBySaleOrderNo(String saleOrderNo) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(saleOrderNo)) {
                throw new OrderServiceException("订单号不能为空");
            }
            FirstOrderCustomerRec firstOrderCustomerRec = firstOrderCustomerRecMapper.loadBySaleOrderNo(saleOrderNo);
            if (ObjectUtils.isNullOrEmpty(firstOrderCustomerRec)) {
                return null;
            }
            FirstOrderCustomerRecDto firstOrderCustomerRecDto = new FirstOrderCustomerRecDto();
            ObjectUtils.fastCopy(firstOrderCustomerRec, firstOrderCustomerRecDto);
            return firstOrderCustomerRecDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public FirstOrderCustomerRecDto loadByBuyerCustomerIdAndFirstOrderType(Integer buyerCustomerId, String firstOrderType)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(buyerCustomerId)) {
                throw new OrderServiceException("客户ID不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(firstOrderType)) {
                throw new OrderServiceException("首单类型不能为空");
            }
            FirstOrderCustomerRec firstOrderCustomerRec = firstOrderCustomerRecMapper
                    .loadByBuyerCustomerIdAndFirstOrderType(buyerCustomerId, firstOrderType);
            if (ObjectUtils.isNullOrEmpty(firstOrderCustomerRec)) {
                return null;
            }
            FirstOrderCustomerRecDto firstOrderCustomerRecDto = new FirstOrderCustomerRecDto();
            ObjectUtils.fastCopy(firstOrderCustomerRec, firstOrderCustomerRecDto);
            return firstOrderCustomerRecDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public FirstOrderCustomerRecDto loadByDeviceIdAndFirstOrderType(String deviceId, String firstOrderType)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(deviceId) || ObjectUtils.isNullOrEmpty(firstOrderType)) {
                return null;
            }
            FirstOrderCustomerRec firstOrderCustomerRec = firstOrderCustomerRecMapper
                    .loadByDeviceIdAndFirstOrderType(deviceId, firstOrderType);
            if (ObjectUtils.isNullOrEmpty(firstOrderCustomerRec)) {
                return null;
            }
            FirstOrderCustomerRecDto firstOrderCustomerRecDto = new FirstOrderCustomerRecDto();
            ObjectUtils.fastCopy(firstOrderCustomerRec, firstOrderCustomerRecDto);
            return firstOrderCustomerRecDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

}
