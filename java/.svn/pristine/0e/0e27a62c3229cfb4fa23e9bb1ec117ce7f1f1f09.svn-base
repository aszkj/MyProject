package com.yilidi.o2o.order.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.dao.OrderConsigneeAddressMapper;
import com.yilidi.o2o.order.model.OrderConsigneeAddress;
import com.yilidi.o2o.order.service.IOrderConsigneeAddressService;
import com.yilidi.o2o.order.service.dto.OrderConsigneeAddressDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 
 * 订单收货地址服务实现类
 * 
 * @author: heyong
 * @date: 2015年11月5日 下午2:31:39
 * 
 */
@Service("orderConsigneeAddressService")
public class OrderConsigneeAddressServiceImpl extends BasicDataService implements IOrderConsigneeAddressService {

	@Autowired
	private OrderConsigneeAddressMapper orderConsigneeAddressMapper;

	@Override
	public OrderConsigneeAddressDto loadByOrderNo(String orderNo) throws OrderServiceException {
		logger.debug("========orderNo=" + orderNo);
		if (ObjectUtils.isNullOrEmpty(orderNo)) {
			logger.error("orderConsigneeAddressService.loadByOrderNo->orderNo为空");
			throw new OrderServiceException("按条件查询的订单orderNo为空");
		}
		OrderConsigneeAddress address = orderConsigneeAddressMapper.loadByOrderNo(orderNo);
		OrderConsigneeAddressDto addressDto = null;
		if (!ObjectUtils.isNullOrEmpty(address)) {
		    addressDto = new OrderConsigneeAddressDto();
			ObjectUtils.fastCopy(address, addressDto);
		}
		return addressDto;
	}

	public void save(OrderConsigneeAddressDto orderConsigneeAddressDto) throws OrderServiceException {
		if (ObjectUtils.isNullOrEmpty(orderConsigneeAddressDto)) {
			logger.error("orderConsigneeAddressService.save->orderConsigneeAddressDto为空");
			throw new OrderServiceException("按条件查询的订单orderConsigneeAddressDto为空");
		}
		OrderConsigneeAddress address = new OrderConsigneeAddress();
		ObjectUtils.fastCopy(orderConsigneeAddressDto, address);
		orderConsigneeAddressMapper.save(address);
	}

}
