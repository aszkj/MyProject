package com.yilidi.o2o.user.service;

import java.util.Date;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.user.service.dto.StoreProductSubsidyDto;
import com.yilidi.o2o.user.service.dto.query.StoreProductSubsidyQuery;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring.xml" })
public class TestStoreProductSubsidyService {

	private Logger logger = Logger.getLogger(TestStoreProductSubsidyService.class);

	@Autowired
	private IStoreProductSubsidyService storeProductSubsidyService;

	@Test
	public void testSaveStoreProductSubsidy() throws UserServiceException {
		try {
			StoreProductSubsidyDto storeProductSubsidyDto = new StoreProductSubsidyDto();
			storeProductSubsidyDto.setStoreId(1);
			storeProductSubsidyDto.setSaleOrderNo("8252202");
			storeProductSubsidyDto.setSaleProductId(1);
			storeProductSubsidyDto.setProductName("可口可乐");
			storeProductSubsidyDto.setRetailPrice(300L);
			storeProductSubsidyDto.setPromotionalPrice(200L);
			storeProductSubsidyDto.setPriceSubsidy(110L);
			storeProductSubsidyDto.setProductNum(1);
			storeProductSubsidyDto.setCreateTime(new Date());
			storeProductSubsidyDto.setRemark("test3");
			storeProductSubsidyService.save(storeProductSubsidyDto);
		} catch (Exception e) {
			logger.error("testSaveStoreProductSubsidy异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testCountPriceSubsidy() throws UserServiceException{
		try{
			Integer storeId = 1;
			Long priceSubsidy = storeProductSubsidyService.countPriceSubsidy(storeId);
			logger.info("(根据店铺ID，统计该店铺所有的商品差价补贴金额: ------------> " + priceSubsidy);
		} catch (Exception e) {
			logger.error("testCountPriceSubsidy异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
	
	@Test
	public void testFindStoreProductSubsidies() throws UserServiceException {
		try {
			// 获取分页数据
			StoreProductSubsidyQuery query = new StoreProductSubsidyQuery();
			query.setStart(1);
			query.setPageSize(8);
			query.setOrder("A.CREATETIME");
			query.setSort("desc");
			YiLiDiPage<StoreProductSubsidyDto> page = storeProductSubsidyService.findStoreProductSubsidies(query);
			logger.info("pageSize: ------------> " + page.getPageSize());
			logger.info("pageNumber: ------------> " + page.getCurrentPage());
			logger.info("pageTotal: ------------> " + page.getPageCount());
			logger.info("count: ------------> " + page.getRecordCount());
			logger.info("pageList: ------------> " + JsonUtils.toJsonStringWithDateFormat(page.getResultList()));
		} catch (Exception e) {
			logger.error("testFindStoreProductSubsidies异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
}