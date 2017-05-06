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
import com.yilidi.o2o.core.utils.EncryptUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.user.service.dto.AdminUserInfoDto;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.UserProfileDto;
import com.yilidi.o2o.user.service.dto.query.UserQuery;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring.xml" })
public class TestUserSerivceWithSpringTest {

	private Logger logger = Logger.getLogger(TestUserSerivceWithSpringTest.class);

	@Autowired
	private IUserService userService;

	@Test
	public void testCheckUserNameIsExist() throws Exception {
		try {
			String userName = "Edison";
			String customerType = SystemContext.UserDomain.CUSTOMERTYPE_OPERATOR;
			Boolean flag = userService.checkUserNameIsExist(userName, customerType);
			logger.info("flag: ------------> " + flag);
		} catch (Exception e) {
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testAddUser() throws Exception {
		try {
			UserDto uDto = new UserDto();
			uDto.setCustomerId(1);
			uDto.setUserName("Lucy");
			uDto.setRealName("露西");
			uDto.setEmail("Lucy@126.com");
			uDto.setPhone("13631533698");
			uDto.setPassword("888888");
			uDto.setMasterFlag(SystemContext.UserDomain.USERMASTERFLAG_MAIN);
			uDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_OPERATOR);
			uDto.setStatusCode(SystemContext.UserDomain.USERSTATUS_ON);
			uDto.setAuditStatusCode(SystemContext.UserDomain.USERAUDITSTATUS_NOT_YET);
			uDto.setCreateTime(new Date());
			uDto.setCreateUserId(111);
			// uDto.setNote("HOHO");
			UserProfileDto upDto = new UserProfileDto();
			upDto.setProvinceCode("4");
			upDto.setCityCode("5");
			upDto.setCountyCode("6");
			upDto.setUserImageUrl("/userImage/1.jpg");
			upDto.setImQq("10122218");
			uDto.setUserProfileDto(upDto);
			userService.saveUser(uDto);
		} catch (Exception e) {
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testViewUserDetail() throws Exception {
		Integer id = 6;
		UserDto u = userService.viewUserDetail(id);
		logger.info(JsonUtils.toJsonStringWithDateFormat(u));
	}

	@Test
	public void testLoadById() throws Exception {
		UserDto u = userService.loadUserById(1);
		logger.info(JsonUtils.toJsonStringWithDateFormat(u));
	}

	@Test
	public void testLoadByName() throws Exception {
		UserDto u = userService.loadUserByNameAndType("Andy", SystemContext.UserDomain.CUSTOMERTYPE_OPERATOR);
		logger.info(JsonUtils.toJsonStringWithDateFormat(u));
	}

	@Test
	public void testPageHelperByStartPage() throws Exception {
		// 获取分页数据
		UserQuery query = new UserQuery();
		query.setStart(1);
		query.setPageSize(8);
		query.setTable("U_USER");
		// query.setMasterFlag("0");
		// query.setCustomerType("0");
		YiLiDiPage<UserDto> yiLiDiPage = userService.findUsers(query);
		logger.info("yiLiDiPage: ------------> " + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage));
		logger.info("pageSize: ------------> " + yiLiDiPage.getPageSize());
		logger.info("pageCount: ------------> " + yiLiDiPage.getPageCount());
		logger.info("recordCount: ------------> " + yiLiDiPage.getRecordCount());
		logger.info("currentPage: ------------> " + yiLiDiPage.getCurrentPage());
		logger.info("resultList: ------------> " + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage.getResultList()));
	}

	@Test
	public void testUpdateUser() throws Exception {
		try {
			UserDto uDto = new UserDto();
			uDto.setId(4);
			uDto.setCustomerId(1111);
			uDto.setUserName("Andy");
			uDto.setRealName("LiuDehua");
			uDto.setEmail("Andy_Lau@sohu.com");
			uDto.setPhone("13631555888");
			uDto.setPassword(EncryptUtils.md5Crypt("888888"));
			uDto.setMasterFlag(SystemContext.UserDomain.USERMASTERFLAG_MAIN);
			uDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_OPERATOR);
			uDto.setStatusCode(SystemContext.UserDomain.USERSTATUS_ON);
			uDto.setAuditStatusCode(SystemContext.UserDomain.USERAUDITSTATUS_NOT_YET);
			// uDto.setModifyUserId(111);
			// uDto.setModifyTime(new Date());
			uDto.setNote("HEHEFF");
			UserProfileDto upDto = new UserProfileDto();
			upDto.setId(2);
			upDto.setUserId(uDto.getId());
			upDto.setProvinceCode("44");
			upDto.setCityCode("55");
			upDto.setCountyCode("66");
			upDto.setUserImageUrl("/userImage/11.jpg");
			upDto.setImQq("10122266");
			uDto.setUserProfileDto(upDto);
			userService.updateUser(uDto);
		} catch (Exception e) {
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testUpdateUserForAudit() throws Exception {
		try {
			Integer id = 4;
			UserDto uDto = new UserDto();
			uDto.setId(id);
			uDto.setAuditStatusCode(SystemContext.UserDomain.USERAUDITSTATUS_PASSED);
			uDto.setAuditUserId(999);
			uDto.setAuditTime(new Date());
			uDto.setAuditNote("同意");
			uDto.setModifyUserId(999);
			uDto.setModifyTime(new Date());
			userService.updateUserForAudit(uDto);
		} catch (Exception e) {
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testUpdateUserForStatus() throws Exception {
		try {
			Integer id = 1;
			UserDto uDto = new UserDto();
			uDto.setId(id);
			uDto.setStatusCode(SystemContext.UserDomain.USERSTATUS_ON);
			uDto.setModifyUserId(999);
			uDto.setModifyTime(new Date());
			userService.updateUserForStatus(uDto);
		} catch (Exception e) {
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testUpdateUserForPassword() throws Exception {
		try {
			Integer id = 1;
			UserDto uDto = new UserDto();
			uDto.setId(id);
			uDto.setPassword("12261226Cl");
			uDto.setModifyUserId(999);
			uDto.setModifyTime(new Date());
			userService.updateUserForPassword(uDto);
		} catch (Exception e) {
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testAddSubUser() throws Exception {
		try {
			Integer customerId = 3;
			UserDto uDto = new UserDto();
			uDto.setCustomerId(customerId);
			uDto.setUserName("Lili");
			uDto.setRealName("莉莉");
			uDto.setEmail("Lili@126.com");
			uDto.setPhone("13625987412");
			uDto.setPassword("123456");
			uDto.setMasterFlag(SystemContext.UserDomain.USERMASTERFLAG_SUB);
			uDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
			uDto.setStatusCode(SystemContext.UserDomain.USERSTATUS_ON);
			uDto.setAuditStatusCode(SystemContext.UserDomain.USERAUDITSTATUS_NOT_YET);
			uDto.setCreateTime(new Date());
			uDto.setCreateUserId(111);
			uDto.setNote("I am Lili");
			UserProfileDto upDto = new UserProfileDto();
			uDto.setUserProfileDto(upDto);
			userService.saveSubUser(uDto, customerId);
		} catch (Exception e) {
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testUpdateSubUser() throws Exception {
		try {
			UserDto uDto = new UserDto();
			uDto.setId(6);
			uDto.setRealName("Fiona");
			uDto.setEmail("Fiona_Zhuang@126.com");
			uDto.setPhone("18675592333");
			uDto.setModifyUserId(888);
			uDto.setModifyTime(new Date());
			uDto.setNote("I am Fiona");
			UserProfileDto upDto = new UserProfileDto();
			uDto.setUserProfileDto(upDto);
			userService.updateSubUser(uDto);
		} catch (Exception e) {
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testFindSubUsers() throws Exception {
		// 获取分页数据
		UserQuery query = new UserQuery();
		query.setStart(1);
		query.setPageSize(2);
		query.setTable("U_USER");
		// query.setMasterFlag(SystemContext.UserDomain.USERMASTERFLAG_SUB);
		// query.setCustomerId(3);
		Page<UserDto> page = userService.findSubUsers(query);
		logger.info("page: ------------> " + JsonUtils.toJsonStringWithDateFormat(page));
		logger.info("pageSize: ------------> " + page.size());
		logger.info("pageNumber: ------------> " + page.getPageNum());
		logger.info("pageEndRow: ------------> " + page.getEndRow());
		logger.info("pageTotal: ------------> " + page.getTotal());
		logger.info("pageList: ------------> " + JsonUtils.toJsonStringWithDateFormat(page.getResult()));
	}

	@Test
	public void testUpdateSubUserForAudit() throws Exception {
		try {
			Integer id = 6;
			UserDto uDto = new UserDto();
			uDto.setId(id);
			uDto.setAuditStatusCode(SystemContext.UserDomain.USERAUDITSTATUS_PASSED);
			uDto.setAuditUserId(999);
			uDto.setAuditTime(new Date());
			uDto.setAuditNote("批注，欢迎加入");
			uDto.setModifyUserId(999);
			uDto.setModifyTime(new Date());
			userService.updateSubUserForAudit(uDto);
		} catch (Exception e) {
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testUpdateSubUserForStatus() throws Exception {
		try {
			Integer id = 6;
			UserDto uDto = new UserDto();
			uDto.setId(id);
			uDto.setStatusCode(SystemContext.UserDomain.USERSTATUS_OFF);
			uDto.setModifyUserId(999);
			uDto.setModifyTime(new Date());
			userService.updateSubUserForStatus(uDto);
		} catch (Exception e) {
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testUpdateSubUserForPassword() throws Exception {
		try {
			Integer id = 6;
			UserDto uDto = new UserDto();
			uDto.setId(id);
			uDto.setPassword("999999");
			uDto.setModifyUserId(999);
			uDto.setModifyTime(new Date());
			userService.updateSubUserForPassword(uDto);
		} catch (Exception e) {
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testFindAdminUsers() throws Exception {
		// 获取分页数据
		UserQuery query = new UserQuery();
		query.setStart(1);
		query.setPageSize(8);
		//后台管理员
		query.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
		YiLiDiPage<AdminUserInfoDto> yiLiDiPage = userService.findAdminUsers(query);
		logger.info("yiLiDiPage: ------------> " + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage));
		logger.info("pageSize: ------------> " + yiLiDiPage.getPageSize());
		logger.info("pageCount: ------------> " + yiLiDiPage.getPageCount());
		logger.info("recordCount: ------------> " + yiLiDiPage.getRecordCount());
		logger.info("currentPage: ------------> " + yiLiDiPage.getCurrentPage());
		logger.info("resultList: ------------> " + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage.getResultList()));
	}
}