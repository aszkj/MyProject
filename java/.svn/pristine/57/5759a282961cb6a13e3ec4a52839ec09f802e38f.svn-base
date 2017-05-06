/**
 * 文件名称：SendOrderTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.dao;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.math.RandomUtils;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.dao.SendOrderMapper;
import com.yilidi.o2o.order.model.SendOrder;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public class SendOrderTest extends BaseMapperTest {
	
	
	@Autowired
	private SendOrderMapper sendOrderMapper;
	
	String saleOrderNo = "20150227174536115zR6";
	
	@Test
	public void testSave() {
		SendOrder order = new SendOrder();
		
		order.setLogisticsNo(StringUtils.randomString(12));
		order.setRetailerId(RandomUtils.nextInt(100));
		order.setSaleOrderNo(saleOrderNo);
		order.setSendTime(new Date());
		order.setSendUserId(RandomUtils.nextInt(100));
		sendOrderMapper.save(order);
	}
	
	@Test
	public void testList() {
		
		List<SendOrder> oList = sendOrderMapper.listBySaleOrderNo(saleOrderNo);
		printInfo(oList);
	}

}
