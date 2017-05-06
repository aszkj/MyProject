package com.yilidi.o2o.user.service;

import java.util.Date;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.user.service.dto.LoginLogDto;
import com.yilidi.o2o.user.service.dto.query.LoginLogQuery;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring.xml" })
public class TestLoginLogService {

	private Logger logger = Logger.getLogger(TestLoginLogService.class);

	@Autowired
	private ILoginLogService loginLogService;

	@Test
	public void testSaveLoginLog() throws UserServiceException {
		try {
			LoginLogDto loginLogDto = new LoginLogDto();
			loginLogDto.setSessionId("YiLiDiSessionCookie_AAAAAAAAAA");
			loginLogDto.setUserId(100);
			loginLogDto.setUserName("HHHHHH");
			loginLogDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_OPERATOR);
			loginLogDto.setLoginTime(new Date());
			loginLogDto.setLoginIP("192.168.2.111");
			loginLogDto.setLoginChannelCode(SystemContext.UserDomain.CHANNELTYPE_WEB);
			loginLogService.saveLoginLog(loginLogDto);
		} catch (Exception e) {
			logger.error("saveLoginLog异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testUpdateLogoutTimeBySessionId() throws UserServiceException {
		try {
			String sessionId = "YiLiDiSessionCookie_AAAAAAAAAA";
			loginLogService.updateLogoutTimeBySessionId(sessionId);
		} catch (Exception e) {
			logger.error("updateLogoutTimeBySessionId异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testFindLoginLogs() throws UserServiceException {
		try {
			// 获取分页数据
			LoginLogQuery loginLogQuery = new LoginLogQuery();
			loginLogQuery.setStart(1);
			loginLogQuery.setPageSize(8);
			// loginLogQuery.setUserId(8);
			loginLogQuery.setUserName("S");
			loginLogQuery.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_OPERATOR);
			loginLogQuery.setChannelCode(SystemContext.UserDomain.CHANNELTYPE_WEB);
			loginLogQuery.setLoginIP("192.168.2.111");
			YiLiDiPage<LoginLogDto> page = loginLogService.findLoginLogs(loginLogQuery);
			logger.info("pageList: ------------> " + JsonUtils.toJsonStringWithDateFormat(page.getResultList()));
		} catch (Exception e) {
			logger.error("findLoginLogs异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

}