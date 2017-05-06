/**
 * 文件名称：SaleOrderPriceHistoryTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.dao;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.order.dao.SaleOrderPriceHistoryMapper;
import com.yilidi.o2o.order.model.SaleOrderPriceHistory;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public class SaleOrderPriceHistoryTest extends BaseMapperTest {

	
	@Autowired
	private SaleOrderPriceHistoryMapper saleOrderPriceHistoryMapper;
	
	@Test
	public void testListBySaleOrderNo() {
		
		String saleOrderNo = "20150304172049185182";
		List<SaleOrderPriceHistory> his = saleOrderPriceHistoryMapper.listBySaleOrderNo(saleOrderNo, "ORDERPRICEHISSTATUS_ON");
		
		printInfo(his);
	}
}
