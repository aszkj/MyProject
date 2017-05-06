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
import com.yilidi.o2o.user.service.dto.AccountBindingDto;
import com.yilidi.o2o.user.service.dto.query.AccountBindingQuery;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring.xml" })
public class TestAccountBindingService {

	private Logger logger = Logger.getLogger(TestAccountBindingService.class);

	@Autowired
	private IAccountBindingService accountBindingService;

	@Test
	public void testSave() throws UserServiceException {
		try {
			AccountBindingDto accountBindingDto = new AccountBindingDto();
			accountBindingDto.setCustomerId(1);
			accountBindingDto.setAccountBindingType(SystemContext.UserDomain.ACCOUNTBINDINGTYPE_CCB);
			accountBindingDto.setAccountNo("6215220534256325");
			accountBindingDto.setSubBankName("南山支行");
			accountBindingDto.setMasterName("一里递");
			accountBindingDto.setMasterIDcardNo("362227184506153541");
			accountBindingDto.setMasterPhoneNo("18675597225");
			accountBindingDto.setCreateUserId(1);
			accountBindingDto.setCreateTime(new Date()); 
			accountBindingService.save(accountBindingDto);
		} catch (Exception e) {
			logger.error("save异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testLoadById() throws UserServiceException {
		try {
			Integer id = 1;
			AccountBindingDto accountBindingDto = accountBindingService.loadById(id);
			logger.info(JsonUtils.toJsonStringWithDateFormat(accountBindingDto));
		} catch (Exception e) {
			logger.error("loadById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testListByCustomerId() throws UserServiceException {
		try {
			Integer customerId = 1;
			List<AccountBindingDto> accountBindingDtoList = accountBindingService.listByCustomerId(customerId);
			if (null != accountBindingDtoList && !accountBindingDtoList.isEmpty()) {
				for (AccountBindingDto accountBindingDto : accountBindingDtoList) {
					logger.info(JsonUtils.toJsonStringWithDateFormat(accountBindingDto));
				}
			}
		} catch (Exception e) {
			logger.error("listByCustomerId异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
	
	@Test
	public void testLoadAccountBindingDetailById() throws UserServiceException {
		try {
			Integer id = 1;
			AccountBindingDto accountBindingDto = accountBindingService.loadAccountBindingDetailById(id);
			logger.info(JsonUtils.toJsonStringWithDateFormat(accountBindingDto));
		} catch (Exception e) {
			logger.error("loadAccountBindingDetailById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
	
	@Test
	public void testFindAccountBindingBanks() throws UserServiceException {
		try {
			AccountBindingQuery accountBingdingQuery = new AccountBindingQuery();
			accountBingdingQuery.setStart(1);
			accountBingdingQuery.setPageSize(8);
			accountBingdingQuery.setOrder("A.BINGDINGACCOUNTID");
			accountBingdingQuery.setSort("desc");
			YiLiDiPage<AccountBindingDto> page = accountBindingService.findAccountBindingBanks(accountBingdingQuery);
			logger.info("pageSize: ------------> " + page.getPageSize());
			logger.info("pageNumber: ------------> " + page.getCurrentPage());
			logger.info("pageTotal: ------------> " + page.getPageCount());
			logger.info("count: ------------> " + page.getRecordCount());
			logger.info("pageList: ------------> " + JsonUtils.toJsonStringWithDateFormat(page.getResultList()));
		} catch (Exception e) {
			logger.error("findAccountBindingBanks异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
	
	@Test
	public void testDeleteById() throws UserServiceException {
		try {
			Integer id = 1;
			accountBindingService.deleteById(id);
		} catch (Exception e) {
			logger.error("deleteById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

}