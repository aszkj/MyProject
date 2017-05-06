/**
 * 文件名称：StockOutItemTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.dao;

import org.apache.commons.lang.math.RandomUtils;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.order.dao.StockOutItemMapper;
import com.yilidi.o2o.order.model.StockOutItem;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class StockOutItemTest extends BaseMapperTest {

	@Autowired
	private StockOutItemMapper stockOutItemMapper;

	Integer stockOutId = 1;

	@Test
	public void testSave() {
		StockOutItem soi = new StockOutItem();

		soi.setQuantity(RandomUtils.nextInt(500));
		soi.setSaleProductId(RandomUtils.nextInt(200));
		soi.setSendOrderItemId(1);
		soi.setStockOutId(stockOutId);

		stockOutItemMapper.save(soi);
	}

}
