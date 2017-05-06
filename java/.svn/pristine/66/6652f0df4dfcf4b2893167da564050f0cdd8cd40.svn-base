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
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.user.service.dto.CommissionSettingDto;
import com.yilidi.o2o.user.service.dto.CommissionSettingHistoryDto;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring.xml" })
public class TestCommissionSettingService {

	private Logger logger = Logger.getLogger(TestCommissionSettingService.class);

	@Autowired
	private ICommissionSettingService commissionSettingService;

	@Test
	public void testSaveCommissionSetting() throws UserServiceException {
		try {
			CommissionSettingDto commissionSettingDto = new CommissionSettingDto();
			commissionSettingDto.setClearType(SystemContext.UserDomain.COMMISSIONCLEARTYPE_MONTH);
			commissionSettingDto.setEffectiveDate(new Date());
			commissionSettingDto.setStoreId(4);
			commissionSettingDto.setRate(2);
			commissionSettingDto.setStatus(SystemContext.UserDomain.COMMISSIONSTATUS_ON);
			commissionSettingService.saveCommissionSetting(commissionSettingDto);
		} catch (Exception e) {
			logger.error("saveCommissionSetting异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testUpdateCommissionSettingByIdSelective() throws UserServiceException {
		try {
			CommissionSettingDto commissionSettingDto = new CommissionSettingDto();
			commissionSettingDto.setSettingId(3);
			commissionSettingDto.setClearType(SystemContext.UserDomain.COMMISSIONCLEARTYPE_ORDER);
			commissionSettingDto.setEffectiveDate(new Date());
			commissionSettingDto.setStoreId(3);
			commissionSettingDto.setRate(1);
			commissionSettingDto.setStatus(SystemContext.UserDomain.COMMISSIONSTATUS_OFF);
			commissionSettingService.updateCommissionSettingByIdSelective(commissionSettingDto);
		} catch (Exception e) {
			logger.error("updateCommissionSettingByIdSelective异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testLoadCommissionSettingById() throws UserServiceException {
		try {
			Integer id = 1;
			CommissionSettingDto commissionSettingDto = commissionSettingService.loadCommissionSettingById(id);
			logger.info(JsonUtils.toJsonStringWithDateFormat(commissionSettingDto));
		} catch (Exception e) {
			logger.error("loadCommissionSettingById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testLoadCommissionSettingByStoreId() throws UserServiceException {
		try {
			Integer storeId = 5;
			CommissionSettingDto commissionSettingDto = commissionSettingService.loadCommissionSettingByStoreId(storeId);
			logger.info(JsonUtils.toJsonStringWithDateFormat(commissionSettingDto));
		} catch (Exception e) {
			logger.error("loadCommissionSettingByStoreId异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testListCommissionSettingByType() throws UserServiceException {
		try {
			String type = SystemContext.UserDomain.COMMISSIONCLEARTYPE_MONTH;
			List<CommissionSettingDto> commissionSettingDtoList = commissionSettingService.listCommissionSettingByType(type);
			if (null != commissionSettingDtoList && !commissionSettingDtoList.isEmpty()) {
				for (CommissionSettingDto commissionSettingDto : commissionSettingDtoList) {
					logger.info(JsonUtils.toJsonStringWithDateFormat(commissionSettingDto));
				}
			}
		} catch (Exception e) {
			logger.error("listCommissionSettingByType异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testSaveCommissionSettingHistory() throws UserServiceException {
		try {
			CommissionSettingHistoryDto commissionSettingHistoryDto = new CommissionSettingHistoryDto();
			commissionSettingHistoryDto.setClearType(SystemContext.UserDomain.COMMISSIONCLEARTYPE_MONTH);
			commissionSettingHistoryDto.setEffectiveDate(new Date());
			commissionSettingHistoryDto.setStoreId(5);
			commissionSettingHistoryDto.setRate(2);
			commissionSettingHistoryDto.setSettingId(1);
			commissionSettingHistoryDto.setSynFlag(SystemContext.UserDomain.COMMISSIONSYNCFLAG_YES);
			commissionSettingService.saveCommissionSettingHistory(commissionSettingHistoryDto);
		} catch (Exception e) {
			logger.error("saveCommissionSettingHistory异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testListCommissionSettingHistoryBySettingId() throws UserServiceException {
		try {
			Integer settingId = 1;
			List<CommissionSettingHistoryDto> commissionSettingHistoryDtoList = commissionSettingService
					.listCommissionSettingHistoryBySettingId(settingId);
			if (null != commissionSettingHistoryDtoList && !commissionSettingHistoryDtoList.isEmpty()) {
				for (CommissionSettingHistoryDto commissionSettingHistoryDto : commissionSettingHistoryDtoList) {
					logger.info(JsonUtils.toJsonStringWithDateFormat(commissionSettingHistoryDto));
				}
			}
		} catch (Exception e) {
			logger.error("listCommissionSettingHistoryBySettingId异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testListCommissionSettingHistoryBySynFlag() throws UserServiceException {
		try {
			String synFlag = SystemContext.UserDomain.COMMISSIONSYNCFLAG_YES;
			List<CommissionSettingHistoryDto> commissionSettingHistoryDtoList = commissionSettingService
					.listCommissionSettingHistoryBySynFlag(synFlag);
			if (null != commissionSettingHistoryDtoList && !commissionSettingHistoryDtoList.isEmpty()) {
				for (CommissionSettingHistoryDto commissionSettingHistoryDto : commissionSettingHistoryDtoList) {
					logger.info(JsonUtils.toJsonStringWithDateFormat(commissionSettingHistoryDto));
				}
			}
		} catch (Exception e) {
			logger.error("listCommissionSettingHistoryBySynFlag异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

}