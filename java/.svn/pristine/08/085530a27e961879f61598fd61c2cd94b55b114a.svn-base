/**
 * 文件名称：StockOutTest.java
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
import com.yilidi.o2o.order.dao.StockOutMapper;
import com.yilidi.o2o.order.model.StockOut;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public class StockOutTest extends BaseMapperTest {

	
	@Autowired
	private StockOutMapper stockOutMapper;
	
	@Test
	public void testSave() {
		StockOut so = new StockOut();
		so.setCreateTime(new Date());
		so.setCreateUserId(10);
		so.setNote("测试");
		so.setStockOutType(StringUtils.randomString(8));
		so.setStockOutCount(RandomUtils.nextInt(1000));
		
		stockOutMapper.save(so);
	}
	
}
