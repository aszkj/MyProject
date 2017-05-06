/**
 * 文件名称：OrderConsigneeAddressTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.dao;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.model.OrderConsigneeAddress;

/**
 * 
 * @author: heyong
 * @date: 2015年11月5日 下午8:47:32
 * 
 */
public class OrderConsigneeAddressTest extends BaseMapperTest {

	@Autowired
	private OrderConsigneeAddressMapper orderConsigneeAddressMapper;

	@Test
	public void testLoad() {
		String saleOrderNo = "201502271441371628vC";
		OrderConsigneeAddress addr = orderConsigneeAddressMapper.loadByOrderNo(saleOrderNo);
		printInfo(addr);
	}

	@Test
	public void testSave() {
		OrderConsigneeAddress addr = new OrderConsigneeAddress();
		addr.setAddressDetail(StringUtils.randomString(20));
		addr.setPhoneNo("13900006666");
		addr.setSaleOrderNo(StringUtils.generateSaleOrderNo());
		addr.setUserName(StringUtils.randomString(8));
		addr.setLatitude("12.3213123");
		addr.setLongitude("32.12412432");
		orderConsigneeAddressMapper.save(addr);
	}
}
