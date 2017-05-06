/**
 * 文件名称：PriceOthernessTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.dao;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.product.dao.PriceOthernessMapper;
import com.yilidi.o2o.product.model.PriceOtherness;
import com.yilidi.o2o.product.service.dto.query.PriceOthernessQuery;

/**
 * 功能描述：<概要描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class PriceOthernessTest extends BaseMapperTest {

	@Autowired
	private PriceOthernessMapper priceOthernessMapper;

	@Test
	public void testLoad() {
		PriceOtherness po = priceOthernessMapper.loadById(1);
		printInfo(po);
	}

	@Test
	public void testList() {
		PriceOthernessQuery query = new PriceOthernessQuery();
		query.setProductClass("MOBILE");
		List<PriceOtherness> pList = priceOthernessMapper.list(query);
		printInfo(pList);
	}

	@Test
	public void testUpdate() {
		priceOthernessMapper.updateStatusById(1, "0", 1);
	}
}
