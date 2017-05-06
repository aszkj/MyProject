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
import com.yilidi.o2o.user.service.dto.StoreSubsidyRecordDto;
import com.yilidi.o2o.user.service.dto.query.StoreSubsidyRecordQuery;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring.xml" })
public class TestStoreSubsidyRecordService {

	private Logger logger = Logger.getLogger(TestStoreSubsidyRecordService.class);

	@Autowired
	private IStoreSubsidyRecordService storeSubsidyRecordService;

	@Test
	public void testSaveStoreSubsidyRecord() throws UserServiceException {
		try {
			StoreSubsidyRecordDto storeSubsidyRecordDto = new StoreSubsidyRecordDto();
			storeSubsidyRecordDto.setStoreId(2);
			storeSubsidyRecordDto.setSaleOrderNo("8302265");
			storeSubsidyRecordDto.setCouponSubsidy(200L);
			storeSubsidyRecordDto.setLogisticsSubsidy(300L);
			storeSubsidyRecordDto.setCreateTime(new Date());
			storeSubsidyRecordDto.setRemark("test2");
			storeSubsidyRecordService.save(storeSubsidyRecordDto);
		} catch (Exception e) {
			logger.error("testSaveStoreSubsidyRecord异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
	
	@Test
	public void testFindStoreSubsidyCountInfos() throws UserServiceException {
		try {
			// 获取分页数据
			StoreSubsidyRecordQuery query = new StoreSubsidyRecordQuery();
			query.setStart(1);
			query.setPageSize(8);
			query.setOrder("A.STOREID");
			query.setSort("desc");
			YiLiDiPage page = storeSubsidyRecordService.findStoreSubsidyCountInfos(query);
			logger.info("pageSize: ------------> " + page.getPageSize());
			logger.info("pageNumber: ------------> " + page.getCurrentPage());
			logger.info("pageTotal: ------------> " + page.getPageCount());
			logger.info("count: ------------> " + page.getRecordCount());
			logger.info("pageList: ------------> " + JsonUtils.toJsonStringWithDateFormat(page.getResultList()));
		} catch (Exception e) {
			logger.error("findStoreSubsidyCountInfos异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
	
	@Test
	public void testFindStoreSubsidyRecords() throws UserServiceException {
		try {
			// 获取分页数据
			StoreSubsidyRecordQuery query = new StoreSubsidyRecordQuery();
			query.setStart(1);
			query.setPageSize(8);
			query.setOrder("A.CREATETIME");
			query.setSort("desc");
			YiLiDiPage<StoreSubsidyRecordDto> page = storeSubsidyRecordService.findStoreSubsidyRecords(query);
			logger.info("pageSize: ------------> " + page.getPageSize());
			logger.info("pageNumber: ------------> " + page.getCurrentPage());
			logger.info("pageTotal: ------------> " + page.getPageCount());
			logger.info("count: ------------> " + page.getRecordCount());
			logger.info("pageList: ------------> " + JsonUtils.toJsonStringWithDateFormat(page.getResultList()));
		} catch (Exception e) {
			logger.error("findWithdrawApplies异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
}