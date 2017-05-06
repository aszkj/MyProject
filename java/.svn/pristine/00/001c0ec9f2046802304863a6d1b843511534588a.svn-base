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
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.user.service.dto.CustomerDto;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.UserProfileDto;
import com.yilidi.o2o.user.service.dto.query.CustomerQuery;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring.xml" })
public class TestCustomerSerivce {

	private Logger logger = Logger.getLogger(TestCustomerSerivce.class);

	@Autowired
	private ICustomerService customerService;

	@Test
	public void testAddCustomer() throws Exception {
		try {
			CustomerDto customerDto = new CustomerDto();
			customerDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
			customerDto.setSellerLevelCode(SystemContext.UserDomain.SELLERLEVEL_A);
			customerDto.setCustomerName("腾讯公司");
			customerDto.setMasterName("Mahuateng");
			customerDto.setIdCardNo("420103197205170812");
			customerDto.setIdCardUrl("/customer/photo/Mahuateng_idCard");
			customerDto.setTelPhone("0755-21705388");
			customerDto.setProvinceCode("7");
			customerDto.setCityCode("8");
			customerDto.setCountyCode("9");
			customerDto.setAddressDetail("QQ大厦");
			customerDto.setBusinessLicenseNo("87412356985233");
			customerDto.setLicenseUrl("/customer/photo/TengXun_License.jpg");
			customerDto.setAuthOrganization("深圳市南山区工商局");
			customerDto.setExpireDate(DateUtils.parseDate("2050-12-01", "yyyy-MM-dd"));
			customerDto.setTaxCode("8566985698563322424");
			customerDto.setTaxUrl("/customer/photo/TengXun_Tax.jpg");
			customerDto.setCreateUserId(999);
			customerDto.setCreateTime(new Date());
			UserDto uDto = new UserDto();
			uDto.setUserName("Ma Hua Teng");
			uDto.setRealName("Ma Hua Teng");
			uDto.setEmail("Ma Hua Teng@yahoo.com");
			uDto.setPhone("18675597226");
			uDto.setPassword("888888");
			uDto.setMasterFlag(SystemContext.UserDomain.USERMASTERFLAG_MAIN);
			uDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_SELLER);
			uDto.setStatusCode(SystemContext.UserDomain.USERSTATUS_ON);
			uDto.setAuditStatusCode(SystemContext.UserDomain.USERAUDITSTATUS_NOT_YET);
			uDto.setCreateUserId(999);
			uDto.setCreateTime(new Date());
			uDto.setNote("TX CEO");
			UserProfileDto upDto = new UserProfileDto();
			upDto.setProvinceCode("7");
			upDto.setCityCode("8");
			upDto.setCountyCode("9");
			upDto.setImQq("6499185");
			uDto.setUserProfileDto(upDto);
			customerDto.setMasterUserDto(uDto);
			customerService.saveCustomer(customerDto);
		} catch (Exception e) {
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testViewCustomerDetail() throws Exception {
		Integer id = 2;
		CustomerDto customerDto = customerService.viewCustomerDetail(id);
		logger.info(JsonUtils.toJsonStringWithDateFormat(customerDto));
	}

	@Test
	public void testViewEnterprise() throws Exception {
		Integer id = 2;
		CustomerDto customerDto = customerService.viewEnterprise(id);
		logger.info(JsonUtils.toJsonStringWithDateFormat(customerDto));
	}

	@Test
	public void testLoadByCustomerId() throws Exception {
		CustomerDto customerDto = customerService.loadCustomerById(1);
		logger.info(JsonUtils.toJsonStringWithDateFormat(customerDto));
	}

	@Test
	public void testLoadByCustomerName() throws Exception {
		CustomerDto customerDto = customerService.loadCustomerByName("Microsoft有限公司");
		logger.info(JsonUtils.toJsonStringWithDateFormat(customerDto));
	}

	@Test
	public void testCheckCustomerNameIsExist() throws Exception {
		try {
			String customerName = "华为技术有限公司";
			Boolean flag = customerService.checkCustomerNameIsExist(customerName);
			logger.info("flag: ------------> " + flag);
		} catch (Exception e) {
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testFindCustomers() throws Exception {

		// 获取分页数据
		CustomerQuery query = new CustomerQuery();
		query.setStart(1);
		query.setPageSize(10);
		// query.setMasterFlag(SystemContext.UserDomain.USERMASTERFLAG_MAIN);
		// query.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
		YiLiDiPage<CustomerDto> yiLiDiPage = customerService.findCustomers(query);
		logger.info("yiLiDiPage: ------------> " + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage));
		logger.info("pageSize: ------------> " + yiLiDiPage.getPageSize());
		logger.info("pageCount: ------------> " + yiLiDiPage.getPageCount());
		logger.info("recordCount: ------------> " + yiLiDiPage.getRecordCount());
		logger.info("currentPage: ------------> " + yiLiDiPage.getCurrentPage());
		logger.info("resultList: ------------> " + JsonUtils.toJsonStringWithDateFormat(yiLiDiPage.getResultList()));
	}

	@Test
	public void testUpdateCustomer() throws Exception {
		try {
			Integer id = 2;
			CustomerDto customerDto = customerService.viewCustomerDetail(id);
			customerDto.setBuyerLevelCode(SystemContext.UserDomain.BUYERLEVEL_A);
			customerDto.setCustomerName("华为技术有限公司");
			customerDto.setMasterName("Renzhengfei");
			customerDto.setIdCardNo("420103194503010888");
			customerDto.setTelPhone("0755-85705349");
			customerDto.setProvinceCode("7");
			customerDto.setCityCode("8");
			customerDto.setCountyCode("9");
			customerDto.setAddressDetail("华为基地");
			customerDto.setLicenseUrl("/customer/photo/HW_license.jpg");
			customerDto.setModifyTime(new Date());
			customerDto.setModifyUserId(999);
			UserDto uDto = customerDto.getMasterUserDto();
			uDto.setUserName("Jim");
			uDto.setRealName("吉姆");
			uDto.setEmail("Jim_Zhang@126.com");
			uDto.setPhone("13635554598");
			uDto.setModifyTime(new Date());
			uDto.setModifyUserId(999);
			uDto.setNote("HW CEO");
			UserProfileDto upDto = customerDto.getMasterUserDto().getUserProfileDto();
			upDto.setProvinceCode("7");
			upDto.setCityCode("8");
			upDto.setCountyCode("9");
			upDto.setImQq("8796534");
			customerService.updateCustomer(customerDto);
		} catch (Exception e) {
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testUpdateCustomerForAudit() throws Exception {
		try {
			Integer id = 2;
			CustomerDto customerDto = new CustomerDto();
			customerDto.setId(id);
			UserDto masterUserDto = new UserDto();
			masterUserDto.setAuditStatusCode(SystemContext.UserDomain.USERAUDITSTATUS_PASSED);
			masterUserDto.setAuditUserId(999);
			masterUserDto.setAuditTime(new Date());
			masterUserDto.setAuditNote("同意");
			masterUserDto.setModifyUserId(999);
			masterUserDto.setModifyTime(new Date());
			customerDto.setMasterUserDto(masterUserDto);
			customerDto.setModifyUserId(999);
			customerDto.setModifyTime(new Date());
			customerService.updateCustomerForAudit(customerDto);
		} catch (Exception e) {
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testUpdateCustomerForStatus() throws Exception {
		try {
			Integer id = 2;
			UserDto userDto = new UserDto();
			userDto.setId(id);
			userDto.setStatusCode(SystemContext.UserDomain.USERSTATUS_ON);
			userDto.setModifyUserId(999);
			userDto.setModifyTime(new Date());
			customerService.updateCustomerForStatus(userDto);
		} catch (Exception e) {
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testUpdateCustomerForPassword() throws Exception {
		try {
			Integer id = 2;
			UserDto uDto = new UserDto();
			uDto.setId(id);
			uDto.setPassword("20121221");
			uDto.setModifyUserId(999);
			uDto.setModifyTime(new Date());
			customerService.updateCustomerForPassword(uDto);
		} catch (Exception e) {
			throw new UserServiceException(e.getMessage());
		}
	}

}