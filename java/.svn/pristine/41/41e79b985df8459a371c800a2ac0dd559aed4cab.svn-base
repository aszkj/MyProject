/**
 * 文件名称：SendOrderDetailTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.dao;

import java.util.List;

import org.apache.commons.lang.math.RandomUtils;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.dao.SendOrderDetailMapper;
import com.yilidi.o2o.order.model.SendOrderDetail;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public class SendOrderDetailTest extends BaseMapperTest {

	
	@Autowired
	private SendOrderDetailMapper sendOrderDetailMapper;
	
	Integer sendOrderId = 123;
	
	@Test
	public void testSave() {
		SendOrderDetail detail = new SendOrderDetail();
		detail.setQuantity(RandomUtils.nextInt(200));
		detail.setSaleProductId(RandomUtils.nextInt(100));
		
		sendOrderDetailMapper.save(detail);
	}
	
	@Test
	public void testList() {
		List<SendOrderDetail> details = sendOrderDetailMapper.listBySendOrderId(sendOrderId);
		printInfo(details);
	}
	
}
