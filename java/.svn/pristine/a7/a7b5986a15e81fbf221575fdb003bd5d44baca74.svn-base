/**
 * 文件名称：OrderPaymentTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.dao;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.dao.OrderPaymentMapper;
import com.yilidi.o2o.order.model.OrderPayment;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public class OrderPaymentTest extends BaseMapperTest {

	
	@Autowired
	private OrderPaymentMapper orderPaymentMapper;
	
	@Test
	public void testSave() {
		OrderPayment payment = new OrderPayment();
		payment.setAccountId(1);
		payment.setCreateTime(new Date());
		payment.setCreateUserId(1);
		payment.setNote("测试");
		payment.setPayAmount(2000 * 1000L);
		payment.setPayTypeCode(StringUtils.randomString(6));
		payment.setSaleOrderNo(StringUtils.generateSaleOrderNo());
		payment.setSeriesNo(StringUtils.randomString(18));
		
		orderPaymentMapper.save(payment);
	}
	
	
	@Test
	public void testList() {
		String saleOrderNo = "20150227151546530L52";
		List<OrderPayment> pList = orderPaymentMapper.listBySaleOrderNo(saleOrderNo);
		
		printInfo(pList);
	}
}
