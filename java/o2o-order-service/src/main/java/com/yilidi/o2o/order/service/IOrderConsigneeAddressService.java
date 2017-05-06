package com.yilidi.o2o.order.service;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.order.service.dto.OrderConsigneeAddressDto;

/**
 * 
 * 订单收货地址服务接口
 * 
 * @author: heyong
 * @date: 2015年11月5日 下午2:31:39
 * 
 */
public interface IOrderConsigneeAddressService {

	/**
	 * 根据订单编号获取订单的地址
	 * 
	 * @param orderNo
	 *            订单编号
	 * @return 订单地址DTO
	 * @throws OrderServiceException
	 *             销售域服务异常
	 */
	public OrderConsigneeAddressDto loadByOrderNo(String orderNo) throws OrderServiceException;

	/**
	 * 保存
	 * 
	 * @param orderConsigneeAddressDto
	 *            订单地址DTO
	 * @throws OrderServiceException
	 *             销售域服务异常
	 */
	public void save(OrderConsigneeAddressDto orderConsigneeAddressDto) throws OrderServiceException;
}
