package com.yilidi.o2o.order.service;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.order.service.dto.FirstOrderCustomerRecDto;

/**
 * 
 * 首单信息业务接口
 * 
 * @author: chenb
 * @date: 2016年7月12日 下午2:13:58
 * 
 */
public interface IFirstOrderCustomerRecService {

    /**
     * 新增保存
     * 
     * @param firstOrderCustomerRecDto
     *            首单信息
     * @throws OrderServiceException
     *             销售域服务异常
     */
    void saveFirstOrderCustomerRec(FirstOrderCustomerRecDto firstOrderCustomerRecDto) throws OrderServiceException;

    /**
     * 根据订单号查看首单记录信息
     * 
     * @param saleOrderNo
     *            订单号
     * @return FirstOrderCustomerRecDto
     * @throws OrderServiceException
     *             销售域服务异常
     */
    FirstOrderCustomerRecDto loadBySaleOrderNo(String saleOrderNo) throws OrderServiceException;

    /**
     * 根据买家客户ID和首单类型查找首单记录信息
     * 
     * @param buyerCustomerId
     *            买家客户ID
     * @param firstOrderType
     *            首单类型
     * @return FirstOrderCustomerRecDto
     * @throws OrderServiceException
     *             销售域服务异常
     */
    FirstOrderCustomerRecDto loadByBuyerCustomerIdAndFirstOrderType(Integer buyerCustomerId, String firstOrderType)
            throws OrderServiceException;

    /**
     * 根据买家客户ID和首单类型查找首单记录信息
     * 
     * @param deviceId
     *            买家设备号
     * @param firstOrderType
     *            首单类型
     * @return FirstOrderCustomerRecDto
     * @throws OrderServiceException
     *             销售域服务异常
     */
    FirstOrderCustomerRecDto loadByDeviceIdAndFirstOrderType(String deviceId, String firstOrderType)
            throws OrderServiceException;
}
