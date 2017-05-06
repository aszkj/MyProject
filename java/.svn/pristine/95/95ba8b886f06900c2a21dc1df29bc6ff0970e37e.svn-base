package com.yilidi.o2o.user.service.crossdomain.impl;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.system.proxy.crossdomain.ISystemLogCrossDomainProxyService;
import com.yilidi.o2o.system.proxy.crossdomain.ISystemParamsCrossDomainProxyService;
import com.yilidi.o2o.system.proxy.dto.SystemLogProxyDto;
import com.yilidi.o2o.user.dao.UserMapper;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.crossdomain.IUserCrossDomainMainService;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.UserProfileDto;

@Service("userCrossDomainMainService")
public class UserCrossDomainMainServiceImpl extends BasicDataService implements IUserCrossDomainMainService {

	@Autowired
	private UserMapper userMapper;

	@Autowired
	private IUserService userService;
	
	@Autowired
	private ISystemLogCrossDomainProxyService systemLogCrossDomainProxyService;
	
	@Autowired
	private ISystemParamsCrossDomainProxyService systemParamsCrossDomainProxyService;

	@Override
	public void updateSubUserForAudit(UserDto userDto) throws UserServiceException {
		try {
			logger.info("----------------------------------------进入 IUserCrossDomainMainService -----------------------------");
//			User user = this.userMapper.loadById(userDto.getId());
//			user.setAuditStatusCode(userDto.getAuditStatusCode());
//			user.setAuditUserId(userDto.getAuditUserId());
//			user.setAuditTime(userDto.getAuditTime());
//			user.setAuditNote(userDto.getAuditNote());
//			user.setModifyUserId(userDto.getModifyUserId());
//			user.setModifyTime(userDto.getModifyTime());
//			this.userMapper.updateByIdSelective(user);
			
			
//			SystemLogProxyDto systemLogProxyDto = new SystemLogProxyDto();
//			systemLogProxyDto.setCreateTime(new Date());
//			systemLogProxyDto.setLogType("微信");
//			systemLogProxyDto.setRequestUrl("www.sohu.com");
//			systemLogProxyDto.setRequestMethod("GET");
//			systemLogProxyDto.setRequestParams("cookieName");
//			systemLogCrossDomainProxyService.saveLog(systemLogProxyDto);
			
			
//			SystemParamsProxyDto systemParamsProxyDto = new SystemParamsProxyDto();
//			systemParamsProxyDto.setParamsId(1);
//			systemParamsProxyDto.setParamValue("8000");
//			systemParamsProxyDto.setNote("DDDDDDDDDDDDD");
//			systemParamsProxyDto.setModifyTime(new Date());
//			systemParamsProxyDto.setModifyUserId(111111);
//			systemParamsCrossDomainProxyService.updateSystemParam(systemParamsProxyDto);
			
			
			UserDto uDto = new UserDto();
			uDto.setCustomerId(100);
			uDto.setUserName("QWERTYU");
			uDto.setRealName("ASDFGH");
			uDto.setEmail("ZXCVB@21cn.com");
			uDto.setPhone("1532398765");
			uDto.setPassword("123456654321");
			uDto.setMasterFlag(SystemContext.UserDomain.USERMASTERFLAG_MAIN);
			uDto.setCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_OPERATOR);
			uDto.setStatusCode(SystemContext.UserDomain.USERSTATUS_ON);
			uDto.setAuditStatusCode(SystemContext.UserDomain.USERAUDITSTATUS_NOT_YET);
			uDto.setCreateTime(new Date());
			uDto.setCreateUserId(111);
			uDto.setNote("SSSSS");
			UserProfileDto upDto = new UserProfileDto();
			upDto.setProvinceCode("4");
			upDto.setCityCode("5");
			upDto.setCountyCode("6");
			upDto.setUserImageUrl("/userImage/hanmeimei.jpg");
			upDto.setImQq("10122220");
			uDto.setUserProfileDto(upDto);
			userService.saveUser(uDto);
			
//			UserDto dto = new UserDto();
//			dto.setAuditNote("QQQQQ");
//			userService.saveUser(dto);
		} catch (Exception e) {
			logger.error("updateSubUserForAudit异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

}
