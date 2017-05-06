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
import com.yilidi.o2o.user.service.dto.AccountDetailCountDto;
import com.yilidi.o2o.user.service.dto.AccountDetailDto;
import com.yilidi.o2o.user.service.dto.AccountDto;
import com.yilidi.o2o.user.service.dto.AccountTypeInfoDto;
import com.yilidi.o2o.user.service.dto.query.AccountDetailQuery;
import com.yilidi.o2o.user.service.dto.query.CustomerBalanceQuery;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring.xml" })
public class TestAccountSerivce {

	private Logger logger = Logger.getLogger(TestAccountSerivce.class);

	@Autowired
	private IAccountService accountService;
	
	@Test
	public void testSaveAccount() throws UserServiceException {
		try {
			AccountDto accountDto =  new AccountDto();
			accountDto.setCustomerId(2);
			//accountDto.setAccountTypeCode(SystemContext.UserDomain.ACCOUNTTYPECODE_CASH);
			//accountDto.setAccountTypeCode(SystemContext.UserDomain.ACCOUNTTYPECODE_COUPONSUBSIDY);
			//accountDto.setAccountTypeCode(SystemContext.UserDomain.ACCOUNTTYPECODE_PRODCUTPRICESUBSIDY);
			accountDto.setAccountTypeCode(SystemContext.UserDomain.ACCOUNTTYPECODE_LOGISTICSSUBSIDY);
			accountDto.setCurrentBalance(10000L);
			accountDto.setCreateUserId(1);
			accountDto.setCreateTime(new Date());
			accountService.save(accountDto);
			logger.info(JsonUtils.toJsonStringWithDateFormat(accountDto));
		} catch (Exception e) {
			logger.error("save异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
	
	@Test
	public void testLoadById() throws UserServiceException {
		try {
			AccountDto accountDto = accountService.loadById(1);
			logger.info(JsonUtils.toJsonStringWithDateFormat(accountDto));
		} catch (Exception e) {
			logger.error("loadById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testLoadByCustomerIdAndAccountTypeCode() throws UserServiceException {
		try {
			Integer customerId = 5;
			String accountTypeCode = AccountTypeInfoDto.Type.YE;
			AccountDto accountDto = accountService.loadByCustomerIdAndAccountTypeCode(customerId, accountTypeCode);
			logger.info(JsonUtils.toJsonStringWithDateFormat(accountDto));
		} catch (Exception e) {
			logger.error("loadByCustomerIdAndAccountTypeCode异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testListByCustomerId() throws UserServiceException {
		try {
			Integer customerId = 5;
			List<AccountDto> accountDtoList = accountService.listByCustomerId(customerId);
			if (null != accountDtoList && !accountDtoList.isEmpty()) {
				for (AccountDto accountDto : accountDtoList) {
					logger.info(JsonUtils.toJsonStringWithDateFormat(accountDto));
				}
			}
		} catch (Exception e) {
			logger.error("listByCustomerId异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testFindAccountsForCustomerBalance() throws UserServiceException {
		try {
			// 获取分页数据
			CustomerBalanceQuery customerBalanceQuery = new CustomerBalanceQuery();
			customerBalanceQuery.setStart(1);
			customerBalanceQuery.setPageSize(8);
			customerBalanceQuery.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
			customerBalanceQuery.setAccountTypeCode(SystemContext.UserDomain.ACCOUNTTYPECODE_CASH);
			YiLiDiPage<AccountDto> page = accountService.findAccountsForCustomerBalance(customerBalanceQuery);
			logger.info("pageSize: ------------> " + page.getPageSize());
			logger.info("pageNumber: ------------> " + page.getCurrentPage());
			logger.info("pageTotal: ------------> " + page.getPageCount());
			logger.info("count: ------------> " + page.getRecordCount());
			logger.info("pageList: ------------> " + JsonUtils.toJsonStringWithDateFormat(page.getResultList()));
		} catch (Exception e) {
			logger.error("findAccountsForCustomerBalance异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testUpdateForRecharge() throws UserServiceException {
		try {
			Integer userId = 8;
			Long rechargeAmount = 200000L;
			accountService.updateForRecharge(userId, rechargeAmount);
		} catch (Exception e) {
			logger.error("updateForRecharge异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testUpdateForWithdraw() throws UserServiceException {
		try {
			Integer userId = 8;
			Long rechargeAmount = 50000L;
			Integer count = accountService.updateForWithdraw(userId, rechargeAmount);
			logger.info("=====================================count : " + count);
		} catch (Exception e) {
			logger.error("updateForRecharge异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testUpdateForPayOrder() throws UserServiceException {
		try {
			Integer userId = 8;
			Long payOrderAmount = 60000L;
			String orderNo = "ORDER_111111111111";
			Integer count = accountService.updateForPayOrder(userId, payOrderAmount, orderNo);
			logger.info("=====================================count : " + count);
		} catch (Exception e) {
			logger.error("updateForPayOrder异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testUpdateForRefund() throws UserServiceException {
		try {
			Integer userId = 8;
			Long refundAmount = 60000L;
			String orderNo = "ORDER_111111111111";
			accountService.updateForRefund(userId, refundAmount, orderNo);
		} catch (Exception e) {
			logger.error("updateForRefund异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testUpdateForAdjustBalancePlus() throws UserServiceException {
		try {
			Integer userId = 8;
			Long adjustAmount = 30000L;
			accountService.updateForAdjustBalancePlus(userId, adjustAmount);
		} catch (Exception e) {
			logger.error("updateForAdjustBalancePlus异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testUpdateForAdjustBalanceMinus() throws UserServiceException {
		try {
			Integer userId = 8;
			Long adjustAmount = 50000L;
			Integer count = accountService.updateForAdjustBalanceMinus(userId, adjustAmount);
			logger.info("=====================================count : " + count);
		} catch (Exception e) {
			logger.error("updateForAdjustBalanceMinus异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testUpdateForConsumeDeposit() throws UserServiceException {
		try {
			Integer userId = 8;
			Long amount = 60000L;
			Integer count = accountService.updateForConsumeDeposit(userId, amount);
			logger.info("=====================================count : " + count);
		} catch (Exception e) {
			logger.error("updateForConsumeDeposit异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testUpdateForFreeze() throws UserServiceException {
		try {
			Integer userId = 8;
			Long amount = 70000L;
			Integer count = accountService.updateForFreeze(userId, amount);
			logger.info("=====================================count : " + count);
		} catch (Exception e) {
			logger.error("updateForFreeze异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testUpdateForUnfreezePartFrozenFund() throws UserServiceException {
		try {
			Integer userId = 8;
			Long amount = 40000L;
			Integer count = accountService.updateForUnfreezePartFrozenFund(userId, amount);
			logger.info("=====================================count : " + count);
		} catch (Exception e) {
			logger.error("updateForUnfreezePartFrozenFund异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testUpdateForUnfreezeAllFrozenFund() throws UserServiceException {
		try {
			Integer userId = 8;
			accountService.updateForUnfreezeAllFrozenFund(userId);
		} catch (Exception e) {
			logger.error("updateForUnfreezeAllFrozenFund异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testFindAccountDetails() throws UserServiceException {
		try {
			// 获取分页数据
			AccountDetailQuery accountDetailQuery = new AccountDetailQuery();
			accountDetailQuery.setStart(1);
			accountDetailQuery.setPageSize(8);
			//accountDetailQuery.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
			YiLiDiPage<AccountDetailDto> page = accountService.findAccountDetails(accountDetailQuery);
			logger.info("pageSize: ------------> " + page.getPageSize());
			logger.info("pageNumber: ------------> " + page.getCurrentPage());
			logger.info("pageTotal: ------------> " + page.getPageCount());
			logger.info("count: ------------> " + page.getRecordCount());
			logger.info("pageList: ------------> " + JsonUtils.toJsonStringWithDateFormat(page.getResultList()));
		} catch (Exception e) {
			logger.error("findAccountDetails异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testLoadAccountDetailByDetailId() throws UserServiceException {
		try {
			Integer id = 2;
			AccountDetailDto accountDetailDto = accountService.loadAccountDetailByDetailId(id);
			logger.info(JsonUtils.toJsonStringWithDateFormat(accountDetailDto));
		} catch (Exception e) {
			logger.error("loadAccountDetailByDetailId异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testFindCountSellerAccountsBalance() throws UserServiceException {
		try {
			// 获取分页数据
			CustomerBalanceQuery customerBalanceQuery = new CustomerBalanceQuery();
			customerBalanceQuery.setStart(1);
			customerBalanceQuery.setPageSize(8);
			customerBalanceQuery.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
			YiLiDiPage<AccountDto> page = accountService.findCountSellerAccountsBalance(customerBalanceQuery);
			logger.info("pageSize: ------------> " + page.getPageSize());
			logger.info("pageNumber: ------------> " + page.getCurrentPage());
			logger.info("pageTotal: ------------> " + page.getPageCount());
			logger.info("count: ------------> " + page.getRecordCount());
			logger.info("pageList: ------------> " + JsonUtils.toJsonStringWithDateFormat(page.getResultList()));
		} catch (Exception e) {
			logger.error("findAccountsForCustomerBalance异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
	
	@Test
	public void testListDataForExportAccountDetails() throws UserServiceException {
		try {
			// 获取分页数据
			AccountDetailQuery query = new AccountDetailQuery();
			query.setOrder("A.CREATETIME"); // 交易时间
			query.setSort("DESC");
			query.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
			List<AccountDetailDto> accountDetailDtos = accountService.listDataForExportAccountDetails(query, 0L, 20);
			logger.info("pageList: ------------> " + JsonUtils.toJsonStringWithDateFormat(accountDetailDtos));
		} catch (Exception e) {
			logger.error("findAccountsForCustomerBalance异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
	
	@Test
	public void testFindCountSellerAccountsDetail() throws UserServiceException {
		try {
			// 获取分页数据
			CustomerBalanceQuery customerBalanceQuery = new CustomerBalanceQuery();
			customerBalanceQuery.setStart(1);
			customerBalanceQuery.setPageSize(20);
			YiLiDiPage<AccountDetailCountDto> page = accountService.findCountSellerAccountsDetail(customerBalanceQuery);
			logger.info("pageSize: ------------> " + page.getPageSize());
			logger.info("pageNumber: ------------> " + page.getCurrentPage());
			logger.info("pageTotal: ------------> " + page.getPageCount());
			logger.info("count: ------------> " + page.getRecordCount());
			logger.info("pageList: ------------> " + JsonUtils.toJsonStringWithDateFormat(page.getResultList()));
		} catch (Exception e) {
			logger.error("findCountSellerAccountsDetail异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}
}