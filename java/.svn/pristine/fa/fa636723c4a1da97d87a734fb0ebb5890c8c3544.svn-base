package com.yilidi.o2o.user.service;

import java.util.ArrayList;
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
import com.yilidi.o2o.user.service.dto.WithdrawApplyDto;
import com.yilidi.o2o.user.service.dto.query.WithdrawApplyQuery;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring.xml" })
public class TestWithdrawApplyService {

	private Logger logger = Logger.getLogger(TestWithdrawApplyService.class);

	@Autowired
	private IWithdrawApplyService withdrawApplyService;

	@Test
	public void testSaveWithdrawApply() throws UserServiceException {
		try {
			WithdrawApplyDto withdrawApplyDto = new WithdrawApplyDto();
			withdrawApplyDto.setAccountTypeCode(SystemContext.UserDomain.ACCOUNTTYPECODE_CASH);
			withdrawApplyDto.setCustomerId(1);
			withdrawApplyDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
			withdrawApplyDto.setAmount(1000L);
			withdrawApplyDto.setCurrentBalance(999999L);
			withdrawApplyDto.setHaveWithdraw(0L);
			withdrawApplyDto.setApplyUserId(1);
			withdrawApplyDto.setApplyTime(new Date());
			withdrawApplyDto.setStatusCode(SystemContext.UserDomain.WITHDRAWAPPLYAUDITSTATUS_NOT_PASSED);
			withdrawApplyDto.setBindingAccountId(1);
			withdrawApplyService.saveWithdrawApply(withdrawApplyDto);
		} catch (Exception e) {
			logger.error("saveWithdrawApply异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testUpdateForAudit() throws UserServiceException {
		try {
			Integer id = 6;
			String statusCode = SystemContext.UserDomain.WITHDRAWAPPLYAUDITSTATUS_PASSED;
			String auditNote = "同意此提款申请";
			Integer auditUserId = 999;
			withdrawApplyService.updateForAudit(id, statusCode, auditNote, auditUserId);
		} catch (Exception e) {
			logger.error("updateForAudit异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testLoadById() throws UserServiceException {
		try {
			Integer id = 3;
			WithdrawApplyDto withdrawApplyDto = withdrawApplyService.loadById(id);
			logger.info(JsonUtils.toJsonStringWithDateFormat(withdrawApplyDto));
		} catch (Exception e) {
			logger.error("loadById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
	
	@Test
	public void testLoadWithdrawApplyById() throws UserServiceException {
		try {
			Integer id = 3;
			WithdrawApplyDto withdrawApplyDto = withdrawApplyService.loadWithdrawApplyById(id);
			logger.info(JsonUtils.toJsonStringWithDateFormat(withdrawApplyDto));
		} catch (Exception e) {
			logger.error("loadWithdrawApplyById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
	
	@Test
	public void testFindWithdrawApplies() throws UserServiceException {
		try {
			// 获取分页数据
			WithdrawApplyQuery withdrawApplyQuery = new WithdrawApplyQuery();
			withdrawApplyQuery.setStart(1);
			withdrawApplyQuery.setPageSize(8);
			//withdrawApplyQuery.setApplyUserName("Ma Hua Teng");
			//withdrawApplyQuery.setCustomerName("腾讯公司");
			//withdrawApplyQuery.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
			withdrawApplyQuery.setOrder("A.APPLYTIME");
			withdrawApplyQuery.setSort("desc");
			YiLiDiPage<WithdrawApplyDto> page = withdrawApplyService.findWithdrawApplies(withdrawApplyQuery);
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
	
	
	@Test
	public void testListDataForExportWithdrawApply() throws UserServiceException {
		try {
			// 获取分页数据
			WithdrawApplyQuery withdrawApplyQuery = new WithdrawApplyQuery();
			withdrawApplyQuery.setStart(1);
			withdrawApplyQuery.setPageSize(8);
			withdrawApplyQuery.setOrder("A.APPLYTIME");
			withdrawApplyQuery.setSort("desc");
			List<WithdrawApplyDto> withdrawApplyDtos = withdrawApplyService.listDataForExportWithdrawApply(
					withdrawApplyQuery, new Long(0), 20);
			logger.info("pageList: ------------> " + JsonUtils.toJsonStringWithDateFormat(withdrawApplyDtos));
		} catch (Exception e) {
			logger.error("listDataForExportWithdrawApply异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
	
	@Test
	public void testCountSellerWithdrawBalance() throws UserServiceException {
		try {
			// 获取分页数据
			WithdrawApplyQuery withdrawApplyQuery = new WithdrawApplyQuery();
			withdrawApplyQuery.setCustomerId(1);
			List<String> statusCodes = new ArrayList<String>();
			statusCodes.add(SystemContext.UserDomain.WITHDRAWAPPLYAUDITSTATUS_PASSED);
			statusCodes.add(SystemContext.UserDomain.WITHDRAWAPPLYAUDITSTATUS_NOT_YET);
			withdrawApplyQuery.setStatusCodes(statusCodes);
			Long counts = withdrawApplyService.countSellerWithdrawBalance(withdrawApplyQuery);
			logger.info("pageList: ------------> " + JsonUtils.toJsonStringWithDateFormat(counts));
		} catch (Exception e) {
			logger.error("countSellerWithdrawBalance异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
	
	@Test
	public void testGetCountsForExportWithdrawApply() throws UserServiceException {
		try {
			// 获取分页数据
			WithdrawApplyQuery withdrawApplyQuery = new WithdrawApplyQuery();
			withdrawApplyQuery.setStart(1);
			withdrawApplyQuery.setPageSize(8);
			withdrawApplyQuery.setOrder("A.APPLYTIME");
			withdrawApplyQuery.setSort("desc");
			Long count = withdrawApplyService.getCountsForExportWithdrawApply(withdrawApplyQuery);
			logger.info("pageList: ------------> " + JsonUtils.toJsonStringWithDateFormat(count));
		} catch (Exception e) {
			logger.error("getCountsForExportWithdrawApply异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
}