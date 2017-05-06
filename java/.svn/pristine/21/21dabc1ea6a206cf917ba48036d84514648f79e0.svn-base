package com.yilidi.o2o.user.service;

import java.util.Date;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.user.service.IAccountTypeInfoService;
import com.yilidi.o2o.user.service.dto.AccountTypeInfoDto;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring.xml" })
public class TestAccountTypeInfoSerivce {

	private Logger logger = Logger.getLogger(TestAccountTypeInfoSerivce.class);

	@Autowired
	private IAccountTypeInfoService accountTypeInfoService;

	@Test
	public void testAddAccountTypeInfo() throws Exception {
		try {
			// AccountTypeInfoDto accountTypeInfoDto = new AccountTypeInfoDto();
			// accountTypeInfoDto.setAccountTypeCode(AccountTypeInfoDto.Type.YE);
			// accountTypeInfoDto.setAccountTypeName("余额账户");
			// accountTypeInfoDto.setPayPriority(1);
			// accountTypeInfoDto.setPayMode(SystemContext.UserDomain.ACCOUNTPAYMODE_FULLPAY);
			// accountTypeInfoDto.setPayScale(100);
			// accountTypeInfoDto.setCreateUserId(999);
			// accountTypeInfoDto.setCreateTime(new Date());
			// accountTypeInfoDto.setNote("我的余额账户");
			// accountTypeInfoService.saveAccountTypeInfo(accountTypeInfoDto);

			AccountTypeInfoDto accountTypeInfoDto = new AccountTypeInfoDto();
			accountTypeInfoDto.setAccountTypeCode(AccountTypeInfoDto.Type.BJ);
			accountTypeInfoDto.setAccountTypeName("保价返利账户");
			accountTypeInfoDto.setPayPriority(2);
			accountTypeInfoDto.setPayMode(SystemContext.UserDomain.ACCOUNTPAYMODE_PERCENTPAY);
			accountTypeInfoDto.setPayScale(60);
			accountTypeInfoDto.setCreateUserId(999);
			accountTypeInfoDto.setCreateTime(new Date());
			accountTypeInfoDto.setNote("我的保价返利账户");
			accountTypeInfoService.saveAccountTypeInfo(accountTypeInfoDto);

		} catch (Exception e) {
			logger.error("testAddAccountTypeInfo异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testUpdateAccountTypeInfo() throws Exception {
		try {
			AccountTypeInfoDto accountTypeInfoDto = new AccountTypeInfoDto();
			Integer accountTypeId = 2;
			accountTypeInfoDto.setAccountTypeId(accountTypeId);
			accountTypeInfoDto.setAccountTypeName("保价返利账户2");
			accountTypeInfoDto.setPayPriority(3);
			accountTypeInfoDto.setPayScale(80);
			accountTypeInfoDto.setModifyUserId(888);
			accountTypeInfoDto.setModifyTime(new Date());
			accountTypeInfoDto.setNote("我的保价返利账户2");
			accountTypeInfoService.updateAccountTypeInfo(accountTypeInfoDto);
		} catch (Exception e) {
			logger.error("testUpdateAccountTypeInfo异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testLoadAccountTypeInfoById() throws Exception {
		Integer id = 2;
		AccountTypeInfoDto accountTypeInfoDto = accountTypeInfoService.loadAccountTypeInfoById(id);
		logger.info(JsonUtils.toJsonStringWithDateFormat(accountTypeInfoDto));
	}

}