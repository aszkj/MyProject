package com.yilidi.o2o.user.service;

import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.user.service.dto.StoreEvaluationDto;
import com.yilidi.o2o.user.service.dto.query.StoreEvaluateQuery;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring.xml" })
public class TestStoreEvaluationSerivce {

	private Logger logger = Logger.getLogger(TestStoreEvaluationSerivce.class);

	@Autowired
	private IStoreEvaluationService storeEvaluationService;
	
	@Test
	public void testSaveStoreEvaluation() throws UserServiceException {
		try {
			StoreEvaluationDto storeEvaluationDto = new StoreEvaluationDto();
			storeEvaluationDto.setStoreId(1);
			storeEvaluationDto.setUserId(1);
			storeEvaluationDto.setSaleOrderNo("830254212");
			storeEvaluationDto.setContent("东西不错，赞一个！");
			storeEvaluationDto.setCoincideStar(5);
			storeEvaluationDto.setSendStar(5);
			storeEvaluationDto.setAttitudeStar(5);
			//门店评论默认都为匿名评论
			storeEvaluationDto.setAnonymityEvaluate(SystemContext.UserDomain.STOREEVALUATIONANONYMITYEVAL_YES);
			storeEvaluationDto.setSystemEvaluate(SystemContext.UserDomain.STOREEVALUATIONSYSTEMEVAL_YES);
			storeEvaluationDto.setShowStatus(SystemContext.UserDomain.STOREEVALUATIONSTATUS_YES);
			storeEvaluationDto.setCreateTime(new Date());
			storeEvaluationService.save(storeEvaluationDto);
			logger.info(JsonUtils.toJsonStringWithDateFormat(storeEvaluationDto));
		} catch (Exception e) {
			logger.error("saveStoreEvaluation异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
	
	@Test
	public void testLoadById() throws UserServiceException {
		try {
			StoreEvaluationDto storeEvaluationDto = storeEvaluationService.loadById(1);
			logger.info(JsonUtils.toJsonStringWithDateFormat(storeEvaluationDto));
		} catch (Exception e) {
			logger.error("loadById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testLoadStoreEvaluationDetailById() throws UserServiceException {
		try {
			Integer id = 1;
			StoreEvaluationDto storeEvaluationDto = storeEvaluationService.loadStoreEvaluationDetailById(id);
			logger.info(JsonUtils.toJsonStringWithDateFormat(storeEvaluationDto));
		} catch (Exception e) {
			logger.error("testLoadStoreEvaluationDetailById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testListStoreEvaluationByStoreId() throws UserServiceException {
		try {
			Integer storeId = 1;
			List<StoreEvaluationDto> storeEvaluationDtos = storeEvaluationService.listStoreEvaluationByStoreId(storeId);
			if (null != storeEvaluationDtos && !storeEvaluationDtos.isEmpty()) {
				for (StoreEvaluationDto storeEvaluationDto : storeEvaluationDtos) {
					logger.info(JsonUtils.toJsonStringWithDateFormat(storeEvaluationDto));
				}
			}
		} catch (Exception e) {
			logger.error("testListStoreEvaluationByStoreId异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testFindStoreEvaluations() throws UserServiceException {
		try {
			// 获取分页数据
			StoreEvaluateQuery query = new StoreEvaluateQuery();
			query.setStart(1);
			query.setPageSize(8);
			YiLiDiPage<StoreEvaluationDto> page = storeEvaluationService.findStoreEvaluations(query);
			logger.info("pageSize: ------------> " + page.getPageSize());
			logger.info("pageNumber: ------------> " + page.getCurrentPage());
			logger.info("pageTotal: ------------> " + page.getPageCount());
			logger.info("count: ------------> " + page.getRecordCount());
			logger.info("pageList: ------------> " + JsonUtils.toJsonStringWithDateFormat(page.getResultList()));
		} catch (Exception e) {
			logger.error("findStoreEvaluations异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
}