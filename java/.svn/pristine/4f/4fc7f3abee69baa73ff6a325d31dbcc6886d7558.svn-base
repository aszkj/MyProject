/**
 * 文件名称：TestLogisticSettingService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.user.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.user.service.dto.FreightCalculateDto;
import com.yilidi.o2o.user.service.dto.LogisticAreaDto;
import com.yilidi.o2o.user.service.dto.LogisticChargeDto;
import com.yilidi.o2o.user.service.dto.LogisticSettingAreaDto;
import com.yilidi.o2o.user.service.dto.LogisticSettingDto;

/**
 * 功能描述：<简单描述> <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class TestLogisticSettingService extends BaseServiceTest {

	@Autowired
	private ILogisticSettingService logisticSettingService;

	@Test
	public void testSaveLogisticSetting() throws UserServiceException {
		try {
			LogisticSettingDto logisticSettingDto = new LogisticSettingDto();
			logisticSettingDto.setOperatorId(5);
			logisticSettingDto.setLogisticsCode(SystemContext.UserDomain.LOGISTICS_SFEXPRESS);
			logisticSettingDto.setFeeType(SystemContext.UserDomain.LOGISTFEETYPE_WEIGHT);
			logisticSettingDto.setFirstCount(100);
			logisticSettingDto.setFirstFee(1500L);
			logisticSettingDto.setAddCount(10);
			logisticSettingDto.setAddFee(100L);
			logisticSettingDto.setFreeQuantity(2);
			logisticSettingDto.setFreeAmount(100000L);
			logisticSettingDto.setEnabledFlag(SystemContext.UserDomain.LOGISTENABLEDFLAG_ON);
			logisticSettingDto.setFreeSetting(SystemContext.UserDomain.LOGISTICS_FREESETTING_PURCHASE_PRICE);
			logisticSettingDto.setCreateUserId(8);
			logisticSettingDto.setCreateTime(new Date());
			logisticSettingService.saveLogisticSetting(logisticSettingDto);
		} catch (Exception e) {
			logger.error("saveLogisticSetting异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testUpdateLogisticSettingByIdSelective() throws UserServiceException {
		try {
			LogisticSettingDto logisticSettingDto = new LogisticSettingDto();
			logisticSettingDto.setId(2);
			logisticSettingDto.setLogisticsCode(SystemContext.UserDomain.LOGISTICS_YTO);
			logisticSettingDto.setFeeType(SystemContext.UserDomain.LOGISTFEETYPE_COUNT);
			logisticSettingDto.setFirstCount(1);
			logisticSettingDto.setFirstFee(2000L);
			logisticSettingDto.setAddCount(1);
			logisticSettingDto.setAddFee(1000L);
			logisticSettingDto.setFreeQuantity(3);
			logisticSettingDto.setFreeAmount(150000L);
			logisticSettingDto.setEnabledFlag(SystemContext.UserDomain.LOGISTENABLEDFLAG_OFF);
			logisticSettingDto.setFreeSetting(SystemContext.UserDomain.LOGISTICS_FREESETTING_PURCHASE_COUNT);
			logisticSettingDto.setModifyUserId(8);
			logisticSettingDto.setModifyTime(new Date());
			logisticSettingService.updateLogisticSettingByIdSelective(logisticSettingDto);
		} catch (Exception e) {
			logger.error("updateLogisticSettingByIdSelective异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testLoadLogisticSettingById() throws UserServiceException {
		try {
			Integer id = 1;
			LogisticSettingDto logisticSettingDto = logisticSettingService.loadLogisticSettingById(id);
			logger.info(JsonUtils.toJsonStringWithDateFormat(logisticSettingDto));
		} catch (Exception e) {
			logger.error("loadLogisticSettingById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testLoadLogisticSettingDefaultByOperatorId() throws UserServiceException {
		try {
			Integer providerId = 5;
			LogisticSettingDto logisticSettingDto = logisticSettingService
					.loadLogisticSettingDefaultByOperatorId(providerId);
			logger.info(JsonUtils.toJsonStringWithDateFormat(logisticSettingDto));
		} catch (Exception e) {
			logger.error("loadLogisticSettingDefaultByOperatorId异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testLoadLogisticSettingByOperatorIdAndTypeCode() throws UserServiceException {
		try {
			Integer operatorId = 5;
			String logisticCode = SystemContext.UserDomain.LOGISTICS_YTO;
			LogisticSettingDto logisticSettingDto = logisticSettingService.loadLogisticSettingByOperatorIdAndTypeCode(
					operatorId, logisticCode);
			logger.info(JsonUtils.toJsonStringWithDateFormat(logisticSettingDto));
		} catch (Exception e) {
			logger.error("loadLogisticSettingByOperatorIdAndTypeCode异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testSaveLogisticSettingArea() throws UserServiceException {
		try {
			LogisticSettingAreaDto logisticSettingAreaDto = new LogisticSettingAreaDto();
			logisticSettingAreaDto.setSettingId(1);
			logisticSettingAreaDto.setOperatorId(5);
			logisticSettingAreaDto.setProvinceCode("7");
			logisticSettingAreaDto.setCityCode("8");
			logisticSettingAreaDto.setCountyCode("9");
			logisticSettingAreaDto.setFirstCount(200);
			logisticSettingAreaDto.setFirstFee(2500L);
			logisticSettingAreaDto.setAddCount(20);
			logisticSettingAreaDto.setAddFee(150L);
			logisticSettingAreaDto.setBlockId(1);
			logisticSettingAreaDto.setCreateUserId(8);
			logisticSettingAreaDto.setCreateTime(new Date());
			logisticSettingService.saveLogisticSettingArea(logisticSettingAreaDto);
		} catch (Exception e) {
			logger.error("saveLogisticSettingArea异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testDeleteLogisticSettingAreaById() throws UserServiceException {
		try {
			Integer id = 2;
			logisticSettingService.deleteLogisticSettingAreaById(id);
		} catch (Exception e) {
			logger.error("deleteLogisticSettingAreaById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testUpdateLogisticSettinAreaByIdSelective() throws UserServiceException {
		try {
			LogisticSettingAreaDto logisticSettingAreaDto = new LogisticSettingAreaDto();
			logisticSettingAreaDto.setId(1);
			logisticSettingAreaDto.setProvinceCode("10");
			logisticSettingAreaDto.setCityCode("11");
			logisticSettingAreaDto.setCountyCode("12");
			logisticSettingAreaDto.setFirstCount(150);
			logisticSettingAreaDto.setFirstFee(2000L);
			logisticSettingAreaDto.setAddCount(30);
			logisticSettingAreaDto.setAddFee(200L);
			logisticSettingAreaDto.setBlockId(2);
			logisticSettingAreaDto.setModifyUserId(8);
			logisticSettingAreaDto.setModifyTime(new Date());
			logisticSettingService.updateLogisticSettinAreaByIdSelective(logisticSettingAreaDto);
		} catch (Exception e) {
			logger.error("updateLogisticSettinAreaByIdSelective异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testLoadLogisticSettingAreaById() throws UserServiceException {
		try {
			Integer id = 1;
			LogisticSettingAreaDto LogisticSettingAreaDto = logisticSettingService.loadLogisticSettingAreaById(id);
			logger.info(JsonUtils.toJsonStringWithDateFormat(LogisticSettingAreaDto));
		} catch (Exception e) {
			logger.error("loadLogisticSettingAreaById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testListLogisticSettingAreaBySettingId() throws UserServiceException {
		try {
			Integer settingId = 1;
			List<LogisticSettingAreaDto> logisticSettingAreaDtoList = logisticSettingService
					.listLogisticSettingAreaBySettingId(settingId);
			if (null != logisticSettingAreaDtoList && !logisticSettingAreaDtoList.isEmpty()) {
				for (LogisticSettingAreaDto LogisticSettingAreaDto : logisticSettingAreaDtoList) {
					logger.info(JsonUtils.toJsonStringWithDateFormat(LogisticSettingAreaDto));
				}
			}
		} catch (Exception e) {
			logger.error("listLogisticSettingAreaBySettingId异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testListLogisticSettingAreaBySettingIdAndBlockId() throws UserServiceException {
		try {
			Integer settingId = 1;
			Integer blockId = 2;
			List<LogisticSettingAreaDto> logisticSettingAreaDtoList = logisticSettingService
					.listLogisticSettingAreaBySettingIdAndBlockId(settingId, blockId);
			if (null != logisticSettingAreaDtoList && !logisticSettingAreaDtoList.isEmpty()) {
				for (LogisticSettingAreaDto LogisticSettingAreaDto : logisticSettingAreaDtoList) {
					logger.info(JsonUtils.toJsonStringWithDateFormat(LogisticSettingAreaDto));
				}
			}
		} catch (Exception e) {
			logger.error("listLogisticSettingAreaBySettingIdAndBlockId异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testListLogisticSettingAreaByBySettingIdExcludeAssignedBlock() throws UserServiceException {
		try {
			Integer settingId = 1;
			Integer blockId = 2;
			List<LogisticSettingAreaDto> logisticSettingAreaDtoList = logisticSettingService
					.listLogisticSettingAreaByBySettingIdExcludeAssignedBlock(settingId, blockId);
			if (null != logisticSettingAreaDtoList && !logisticSettingAreaDtoList.isEmpty()) {
				for (LogisticSettingAreaDto LogisticSettingAreaDto : logisticSettingAreaDtoList) {
					logger.info(JsonUtils.toJsonStringWithDateFormat(LogisticSettingAreaDto));
				}
			}
		} catch (Exception e) {
			logger.error("listLogisticSettingAreaByBySettingIdExcludeAssignedBlock异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testLoadChargeSettingBySettingIdAndBlockId() throws UserServiceException {
		try {
			Integer settingId = 3;
			Integer blockId = 1;
			LogisticSettingAreaDto logisticSettingAreaDto = logisticSettingService.loadChargeSettingBySettingIdAndBlockId(
					settingId, blockId);
			logger.info(JsonUtils.toJsonStringWithDateFormat(logisticSettingAreaDto));
		} catch (Exception e) {
			logger.error("loadChargeSettingBySettingIdAndBlockId异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testGetDisabledAndCheckedArea() throws UserServiceException {
		try {
			Integer settingId = 3;
			Integer blockId = 1;
			Map<String, List<String>> map = logisticSettingService.getDisabledAndCheckedArea(settingId, blockId);
			logger.info(JsonUtils.toJsonStringWithDateFormat(map));
		} catch (Exception e) {
			logger.error("getDisabledAndCheckedArea异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testLoadAreaSettingByProvinceCode() throws UserServiceException {
		try {
			Integer settingId = 1;
			String provinceCode = "10";
			LogisticSettingAreaDto logisticSettingAreaDto = logisticSettingService.loadAreaSettingByProvinceCode(settingId,
					provinceCode);
			logger.info(JsonUtils.toJsonStringWithDateFormat(logisticSettingAreaDto));
		} catch (Exception e) {
			logger.error("loadAreaSettingByProvinceCode异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testLoadAreaSettingByCityCode() throws UserServiceException {
		try {
			Integer settingId = 1;
			String cityCode = "11";
			LogisticSettingAreaDto logisticSettingAreaDto = logisticSettingService.loadAreaSettingByCityCode(settingId,
					cityCode);
			logger.info(JsonUtils.toJsonStringWithDateFormat(logisticSettingAreaDto));
		} catch (Exception e) {
			logger.error("loadAreaSettingByCityCode异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testLoadAreaSettingByCountyCode() throws UserServiceException {
		try {
			Integer settingId = 1;
			String countyCode = "12";
			LogisticSettingAreaDto logisticSettingAreaDto = logisticSettingService.loadAreaSettingByCountyCode(settingId,
					countyCode);
			logger.info(JsonUtils.toJsonStringWithDateFormat(logisticSettingAreaDto));
		} catch (Exception e) {
			logger.error("loadAreaSettingByCountyCode异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testGetFreight() throws UserServiceException {
		try {
			FreightCalculateDto freightCalculateDto = new FreightCalculateDto();
			freightCalculateDto.setStoreId(5);
			freightCalculateDto.setProvinceCode("10");
			freightCalculateDto.setCityCode("11");
			freightCalculateDto.setCountyCode("12");
			freightCalculateDto.setWeight(1000);
			freightCalculateDto.setQuantity(5);
			freightCalculateDto.setTotalPrice(60000L);
			Long freight = logisticSettingService.getFreight(freightCalculateDto);
			logger.info("===============================================================================> freight : "
					+ freight);
		} catch (Exception e) {
			logger.error("getFreight异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testSaveLogistics() throws UserServiceException {
		try {
			LogisticSettingDto logisticSettingDto = new LogisticSettingDto();
			Map<Integer, List<LogisticAreaDto>> areaMap = new HashMap<Integer, List<LogisticAreaDto>>();
			Map<Integer, LogisticChargeDto> chargeMap = new HashMap<Integer, LogisticChargeDto>();
			List<LogisticAreaDto> logisticAreaDtoListForBlock1 = new ArrayList<LogisticAreaDto>();
			List<LogisticAreaDto> logisticAreaDtoListForBlock2 = new ArrayList<LogisticAreaDto>();

			logisticSettingDto.setOperatorId(5);
			logisticSettingDto.setLogisticsCode(SystemContext.UserDomain.LOGISTICS_EMS);
			logisticSettingDto.setFeeType(SystemContext.UserDomain.LOGISTFEETYPE_COUNT);
			logisticSettingDto.setFirstCount(2);
			logisticSettingDto.setFirstFee(2000L);
			logisticSettingDto.setAddCount(1);
			logisticSettingDto.setAddFee(500L);
			logisticSettingDto.setFreeQuantity(4);
			logisticSettingDto.setFreeAmount(100000L);
			logisticSettingDto.setEnabledFlag(SystemContext.UserDomain.LOGISTENABLEDFLAG_ON);
			logisticSettingDto.setFreeSetting(SystemContext.UserDomain.LOGISTICS_FREESETTING_PURCHASE_PRICE);
			logisticSettingDto.setCreateUserId(8);
			logisticSettingDto.setCreateTime(new Date());

			LogisticAreaDto logisticAreaDto1 = new LogisticAreaDto();
			logisticAreaDto1.setProvinceCode("7");

			LogisticAreaDto logisticAreaDto2 = new LogisticAreaDto();
			logisticAreaDto2.setProvinceCode("10");
			logisticAreaDto2.setCityCode("11");

			logisticAreaDtoListForBlock1.add(logisticAreaDto1);
			logisticAreaDtoListForBlock1.add(logisticAreaDto2);

			areaMap.put(1, logisticAreaDtoListForBlock1);

			LogisticAreaDto logisticAreaDto3 = new LogisticAreaDto();
			logisticAreaDto3.setProvinceCode("13");
			logisticAreaDto3.setCityCode("14");
			logisticAreaDto3.setCountyCode("15");
			logisticAreaDtoListForBlock2.add(logisticAreaDto3);
			areaMap.put(2, logisticAreaDtoListForBlock2);

			LogisticChargeDto logisticChargeDto1 = new LogisticChargeDto();
			logisticChargeDto1.setFirstCount(1);
			logisticChargeDto1.setFirstFee(1500L);
			logisticChargeDto1.setAddCount(1);
			logisticChargeDto1.setAddFee(800L);
			chargeMap.put(1, logisticChargeDto1);

			LogisticChargeDto logisticChargeDto2 = new LogisticChargeDto();
			logisticChargeDto2.setFirstCount(3);
			logisticChargeDto2.setFirstFee(2500L);
			logisticChargeDto2.setAddCount(1);
			logisticChargeDto2.setAddFee(600L);
			chargeMap.put(2, logisticChargeDto2);

			logisticSettingService.saveLogistics(logisticSettingDto, areaMap, chargeMap);
		} catch (Exception e) {
			logger.error("saveLogistics异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Test
	public void testSaveOrUpdateLogisticSettingAreaForBlock() throws UserServiceException {
		try {
			Integer settingId = 3;
			Integer blockId = 3;
			Integer userId = 8;
			LogisticAreaDto logisticAreaDto1 = new LogisticAreaDto();
			logisticAreaDto1.setProvinceCode("7");
			logisticAreaDto1.setCityCode("8");
			LogisticAreaDto logisticAreaDto2 = new LogisticAreaDto();
			logisticAreaDto2.setProvinceCode("10");
			List<LogisticAreaDto> logisticAreaDtoList = new ArrayList<LogisticAreaDto>();
			logisticAreaDtoList.add(logisticAreaDto1);
			logisticAreaDtoList.add(logisticAreaDto2);
			LogisticChargeDto logisticChargeDto = new LogisticChargeDto();
			logisticChargeDto.setFirstCount(2);
			logisticChargeDto.setFirstFee(1800L);
			logisticChargeDto.setAddCount(1);
			logisticChargeDto.setAddFee(1000L);
			logisticSettingService.saveOrUpdateLogisticSettingAreaForBlock(settingId, blockId, userId, logisticAreaDtoList,
					logisticChargeDto);
		} catch (Exception e) {
			logger.error("saveOrUpdateLogisticSettingAreaForBlock异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

}
