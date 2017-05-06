/**
 * 文件名称：ImpressionStatisticsTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.dao;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.order.dao.ImpressionStatisticsMapper;
import com.yilidi.o2o.order.model.ImpressionStatistics;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class ImpressionStatisticsTest extends BaseMapperTest {

	@Autowired
	private ImpressionStatisticsMapper impressionStatisticsMapper;

	private Integer saleProductId = 1;
	private String code = "code2";

	
	@Test
	public void testCheck() {
		Integer count = impressionStatisticsMapper.checkSaleProduct(saleProductId, code);
		if (0 < count) {
			printInfo("存在");
		} else {
			printInfo("不存在");
		}
	}
	
	@Test
	public void testList() {
		List<ImpressionStatistics> is = impressionStatisticsMapper.listBySaleProductId(saleProductId);
		printInfo(is);
	}
	
	@Test
	public void testUpdate() {
		
		Integer count = impressionStatisticsMapper.checkSaleProduct(saleProductId, code);
		if (0 < count) {
			impressionStatisticsMapper.updateBySaleProductId(saleProductId, code);
		} else {
			ImpressionStatistics is = new ImpressionStatistics();
			is.setSaleProductId(saleProductId);
			is.setLabelCode(code);
			is.setTotalCount(1);
			impressionStatisticsMapper.save(is);
		}
		
	}
}
