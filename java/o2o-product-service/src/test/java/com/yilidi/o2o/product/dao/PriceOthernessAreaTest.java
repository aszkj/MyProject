/**
 * 文件名称：PriceOthernessAreaTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.dao;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.product.dao.PriceOthernessAreaMapper;
import com.yilidi.o2o.product.model.PriceOthernessArea;

/**
 * 功能描述：<概要描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class PriceOthernessAreaTest extends BaseMapperTest {

	@Autowired
	private PriceOthernessAreaMapper priceOthernessAreaMapper;

	@Test
	public void testlistByOthernessPriceId() {
		List<PriceOthernessArea> pas = priceOthernessAreaMapper
				.listByOthernessPriceId(1);
		printInfo(pas);
	}
}
