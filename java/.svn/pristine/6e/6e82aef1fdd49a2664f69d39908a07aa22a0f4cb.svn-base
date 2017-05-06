/**
 * 文件名称：StockOutImeiTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.dao;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.dao.StockOutImeiMapper;
import com.yilidi.o2o.order.model.StockOutImei;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public class StockOutImeiTest extends BaseMapperTest {

	
	@Autowired
	private StockOutImeiMapper stockOutImeiMapper;
	private Integer stockOutItemId = 1;
	
	@Test
	public void testSave() {
		StockOutImei imei = new StockOutImei();
		imei.setImeiNo(StringUtils.randomString(15));
		imei.setStockOutItemId(stockOutItemId);
		stockOutImeiMapper.save(imei);
	}
}
