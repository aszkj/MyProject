/**
 * 文件名称：BaseServiceTest.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.product.service.dto.AdvertisementDto;
import com.yilidi.o2o.product.service.dto.query.AdvertisementQuery;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */

public class AdvertisementServiceTest extends BaseServiceTest {

	protected Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	protected IAdvertisementService advertisementService;

	@Test
	public void testList() throws ProductServiceException {

		AdvertisementQuery query = new AdvertisementQuery();
		// query.setStartTime(new Date());
		// query.setEndTime(new Date());
		query.setTypeCode("ADVERTISEMENTTYPE_HOMEBANNER1");
		query.setStatusCode("ON");
		List<AdvertisementDto> dtos = advertisementService.list(query);
	}
}
