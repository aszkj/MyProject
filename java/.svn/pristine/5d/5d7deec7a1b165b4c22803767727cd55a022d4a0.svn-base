/**
 * 文件名称：LogisticSettingSerivce.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.user.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.LogisticSettingAreaMapper;
import com.yilidi.o2o.user.dao.LogisticSettingMapper;
import com.yilidi.o2o.user.model.LogisticSetting;
import com.yilidi.o2o.user.model.LogisticSettingArea;
import com.yilidi.o2o.user.service.ILogisticSettingService;
import com.yilidi.o2o.user.service.dto.FreightCalculateDto;
import com.yilidi.o2o.user.service.dto.LogisticAreaDto;
import com.yilidi.o2o.user.service.dto.LogisticChargeDto;
import com.yilidi.o2o.user.service.dto.LogisticSettingAreaDto;
import com.yilidi.o2o.user.service.dto.LogisticSettingDto;

/**
 * 功能描述：物流设置服务类实现 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("logisticSettingSerivce")
public class LogisticSettingSerivceImpl extends BasicDataService implements ILogisticSettingService {

	@Autowired
	private LogisticSettingMapper logisticSettingMapper;

	@Autowired
	private LogisticSettingAreaMapper logisticSettingAreaMapper;

	@Override
	public Integer saveLogisticSetting(LogisticSettingDto logisticSettingDto) throws UserServiceException {
		try {
			LogisticSetting logisticSetting = new LogisticSetting();
			ObjectUtils.fastCopy(logisticSettingDto, logisticSetting);
			logisticSettingMapper.save(logisticSetting);
			return logisticSetting.getId();
		} catch (Exception e) {
			logger.error("saveLogisticSetting异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public void updateLogisticSettingByIdSelective(LogisticSettingDto logisticSettingDto) throws UserServiceException {
		try {
			LogisticSetting logisticSetting = logisticSettingMapper.loadById(logisticSettingDto.getId());
			if (!StringUtils.isEmpty(logisticSetting.getLogisticsCode())) {
				logisticSetting.setLogisticsCode(logisticSettingDto.getLogisticsCode());
			}
			if (!StringUtils.isEmpty(logisticSetting.getFeeType())) {
				logisticSetting.setFeeType(logisticSettingDto.getFeeType());
			}
			if (null != logisticSetting.getFirstCount()) {
				logisticSetting.setFirstCount(logisticSettingDto.getFirstCount());
			}
			if (null != logisticSetting.getFirstFee()) {
				logisticSetting.setFirstFee(logisticSettingDto.getFirstFee());
			}
			if (null != logisticSetting.getAddCount()) {
				logisticSetting.setAddCount(logisticSettingDto.getAddCount());
			}
			if (null != logisticSetting.getAddFee()) {
				logisticSetting.setAddFee(logisticSettingDto.getAddFee());
			}
			if (null != logisticSetting.getFreeQuantity()) {
				logisticSetting.setFreeQuantity(logisticSettingDto.getFreeQuantity());
			}
			if (null != logisticSetting.getFreeAmount()) {
				logisticSetting.setFreeAmount(logisticSettingDto.getFreeAmount());
			}
			if (!StringUtils.isEmpty(logisticSetting.getEnabledFlag())) {
				logisticSetting.setEnabledFlag(logisticSettingDto.getEnabledFlag());
			}
			if (!StringUtils.isEmpty(logisticSetting.getFreeSetting())) {
				logisticSetting.setFreeSetting(logisticSettingDto.getFreeSetting());
			}
			logisticSetting.setModifyUserId(logisticSettingDto.getModifyUserId());
			logisticSetting.setModifyTime(logisticSettingDto.getModifyTime());
			logisticSettingMapper.updateByIdSelective(logisticSetting);
		} catch (Exception e) {
			logger.error("updateLogisticSettingByIdSelective异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public LogisticSettingDto loadLogisticSettingById(Integer id) throws UserServiceException {
		try {
			LogisticSetting logisticSetting = logisticSettingMapper.loadById(id);
			LogisticSettingDto logisticSettingDto = null;
			if (null != logisticSetting) {
				logisticSettingDto = new LogisticSettingDto();
				ObjectUtils.fastCopy(logisticSetting, logisticSettingDto);
			}
			return logisticSettingDto;
		} catch (Exception e) {
			logger.error("loadLogisticSettingById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public LogisticSettingDto loadLogisticSettingDefaultByOperatorId(Integer operatorId) throws UserServiceException {
		try {
			LogisticSetting logisticSetting = logisticSettingMapper.loadDefaultByOperatorId(operatorId);
			LogisticSettingDto logisticSettingDto = null;
			if (null != logisticSetting) {
				logisticSettingDto = new LogisticSettingDto();
				ObjectUtils.fastCopy(logisticSetting, logisticSettingDto);
			}
			return logisticSettingDto;
		} catch (Exception e) {
			logger.error("loadLogisticSettingDefaultByOperatorId异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public LogisticSettingDto loadLogisticSettingByOperatorIdAndTypeCode(Integer operatorId, String logisticCode)
			throws UserServiceException {
		try {
			LogisticSetting logisticSetting = logisticSettingMapper.loadByOperatorIdAndTypeCode(operatorId, logisticCode);
			LogisticSettingDto logisticSettingDto = null;
			if (null != logisticSetting) {
				logisticSettingDto = new LogisticSettingDto();
				ObjectUtils.fastCopy(logisticSetting, logisticSettingDto);
			}
			return logisticSettingDto;
		} catch (Exception e) {
			logger.error("loadLogisticSettingByOperatorIdAndTypeCode异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public void saveLogisticSettingArea(LogisticSettingAreaDto logisticSettingAreaDto) throws UserServiceException {
		try {
			LogisticSettingArea logisticSettingArea = new LogisticSettingArea();
			ObjectUtils.fastCopy(logisticSettingAreaDto, logisticSettingArea);
			logisticSettingAreaMapper.save(logisticSettingArea);
		} catch (Exception e) {
			logger.error("saveLogisticSettingArea异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public void deleteLogisticSettingAreaById(Integer id) throws UserServiceException {
		try {
			logisticSettingAreaMapper.deleteById(id);
		} catch (Exception e) {
			logger.error("deleteLogisticSettingAreaById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public void updateLogisticSettinAreaByIdSelective(LogisticSettingAreaDto logisticSettingAreaDto)
			throws UserServiceException {
		try {
			LogisticSettingArea logisticSettingArea = logisticSettingAreaMapper.loadById(logisticSettingAreaDto.getId());
			if (!StringUtils.isEmpty(logisticSettingArea.getProvinceCode())) {
				logisticSettingArea.setProvinceCode(logisticSettingAreaDto.getProvinceCode());
			}
			if (!StringUtils.isEmpty(logisticSettingArea.getCityCode())) {
				logisticSettingArea.setCityCode(logisticSettingAreaDto.getCityCode());
			}
			if (!StringUtils.isEmpty(logisticSettingArea.getCountyCode())) {
				logisticSettingArea.setCountyCode(logisticSettingAreaDto.getCountyCode());
			}
			if (null != logisticSettingArea.getFirstCount()) {
				logisticSettingArea.setFirstCount(logisticSettingAreaDto.getFirstCount());
			}
			if (null != logisticSettingArea.getFirstFee()) {
				logisticSettingArea.setFirstFee(logisticSettingAreaDto.getFirstFee());
			}
			if (null != logisticSettingArea.getAddCount()) {
				logisticSettingArea.setAddCount(logisticSettingAreaDto.getAddCount());
			}
			if (null != logisticSettingArea.getAddFee()) {
				logisticSettingArea.setAddFee(logisticSettingAreaDto.getAddFee());
			}
			if (null != logisticSettingArea.getBlockId()) {
				logisticSettingArea.setBlockId(logisticSettingAreaDto.getBlockId());
			}
			logisticSettingArea.setModifyUserId(logisticSettingAreaDto.getModifyUserId());
			logisticSettingArea.setModifyTime(logisticSettingAreaDto.getModifyTime());
			logisticSettingAreaMapper.updateByIdSelective(logisticSettingArea);
		} catch (Exception e) {
			logger.error("updateLogisticSettinAreaByIdSelective异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public LogisticSettingAreaDto loadLogisticSettingAreaById(Integer id) throws UserServiceException {
		try {
			LogisticSettingArea logisticSettingArea = logisticSettingAreaMapper.loadById(id);
			LogisticSettingAreaDto logisticSettingAreaDto = null;
			if (null != logisticSettingArea) {
				logisticSettingAreaDto = new LogisticSettingAreaDto();
				ObjectUtils.fastCopy(logisticSettingArea, logisticSettingAreaDto);
			}
			return logisticSettingAreaDto;
		} catch (Exception e) {
			logger.error("loadLogisticSettingAreaById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public List<LogisticSettingAreaDto> listLogisticSettingAreaBySettingId(Integer settingId) throws UserServiceException {
		try {
			List<LogisticSettingArea> logisticSettingAreas = logisticSettingAreaMapper.listBySettingId(settingId);
			List<LogisticSettingAreaDto> logisticSettingAreaDtos = null;
			if (!ObjectUtils.isNullOrEmpty(logisticSettingAreas)) {
				logisticSettingAreaDtos = new ArrayList<LogisticSettingAreaDto>();
				for (LogisticSettingArea logisticSettingArea : logisticSettingAreas) {
					LogisticSettingAreaDto logisticSettingAreaDto = new LogisticSettingAreaDto();
					ObjectUtils.fastCopy(logisticSettingArea, logisticSettingAreaDto);
					logisticSettingAreaDtos.add(logisticSettingAreaDto);
				}
			}
			return logisticSettingAreaDtos;
		} catch (Exception e) {
			logger.error("listLogisticSettinAreaBySettingId异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public List<LogisticSettingAreaDto> listLogisticSettingAreaBySettingIdAndBlockId(Integer settingId, Integer blockId)
			throws UserServiceException {
		try {
			List<LogisticSettingArea> logisticSettingAreas = logisticSettingAreaMapper.listBySettingIdAndBlockId(settingId,
					blockId);
			List<LogisticSettingAreaDto> logisticSettingAreaDtos = null;
			if (!ObjectUtils.isNullOrEmpty(logisticSettingAreas)) {
				logisticSettingAreaDtos = new ArrayList<LogisticSettingAreaDto>();
				for (LogisticSettingArea logisticSettingArea : logisticSettingAreas) {
					LogisticSettingAreaDto logisticSettingAreaDto = new LogisticSettingAreaDto();
					ObjectUtils.fastCopy(logisticSettingArea, logisticSettingAreaDto);
					logisticSettingAreaDtos.add(logisticSettingAreaDto);
				}
			}
			return logisticSettingAreaDtos;
		} catch (Exception e) {
			logger.error("listLogisticSettinAreaBySettingIdAndBlockId异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public List<LogisticSettingAreaDto> listLogisticSettingAreaByBySettingIdExcludeAssignedBlock(Integer settingId,
			Integer blockId) throws UserServiceException {
		try {
			List<LogisticSettingArea> logisticSettingAreas = logisticSettingAreaMapper.listBySettingIdExcludeAssignedBlock(
					settingId, blockId);
			List<LogisticSettingAreaDto> logisticSettingAreaDtos = null;
			if (!ObjectUtils.isNullOrEmpty(logisticSettingAreas)) {
				logisticSettingAreaDtos = new ArrayList<LogisticSettingAreaDto>();
				for (LogisticSettingArea logisticSettingArea : logisticSettingAreas) {
					LogisticSettingAreaDto logisticSettingAreaDto = new LogisticSettingAreaDto();
					ObjectUtils.fastCopy(logisticSettingArea, logisticSettingAreaDto);
					logisticSettingAreaDtos.add(logisticSettingAreaDto);
				}
			}
			return logisticSettingAreaDtos;
		} catch (Exception e) {
			logger.error("listLogisticSettingAreaByBySettingIdExcludeAssignedBlock异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public LogisticSettingAreaDto loadChargeSettingBySettingIdAndBlockId(Integer settingId, Integer blockId)
			throws UserServiceException {
		try {
			LogisticSettingArea logisticSettingArea = logisticSettingAreaMapper.loadChargeSettingBySettingIdAndBlockId(
					settingId, blockId);
			LogisticSettingAreaDto logisticSettingAreaDto = null;
			if (null != logisticSettingArea) {
				logisticSettingAreaDto = new LogisticSettingAreaDto();
				ObjectUtils.fastCopy(logisticSettingArea, logisticSettingAreaDto);
			}
			return logisticSettingAreaDto;
		} catch (Exception e) {
			logger.error("loadChargeSettingBySettingIdAndBlockId异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	public Map<String, List<String>> getDisabledAndCheckedArea(Integer settingId, Integer blockId)
			throws UserServiceException {
		try {
			List<String> disabledProvinceCodeList = new ArrayList<String>();
			List<String> disabledCityCodeList = new ArrayList<String>();
			List<String> disabledCountyCodeList = new ArrayList<String>();
			List<String> checkedProvinceCodeList = new ArrayList<String>();
			List<String> checkedCityCodeList = new ArrayList<String>();
			List<String> checkedCountyCodeList = new ArrayList<String>();
			List<LogisticSettingAreaDto> disabledList = listLogisticSettingAreaByBySettingIdExcludeAssignedBlock(settingId,
					blockId);
			if (!ObjectUtils.isNullOrEmpty(disabledList)) {
				for (LogisticSettingAreaDto logisticSettingAreaDto : disabledList) {
					if (StringUtils.isEmpty(logisticSettingAreaDto.getCountyCode())) {
						if (StringUtils.isEmpty(logisticSettingAreaDto.getCityCode())) {
							disabledProvinceCodeList.add(logisticSettingAreaDto.getProvinceCode());
						} else {
							disabledCityCodeList.add(logisticSettingAreaDto.getCityCode());
						}
					} else {
						disabledCountyCodeList.add(logisticSettingAreaDto.getCountyCode());
					}
				}
			}
			List<LogisticSettingAreaDto> checkedList = listLogisticSettingAreaBySettingIdAndBlockId(settingId, blockId);
			if (!ObjectUtils.isNullOrEmpty(checkedList)) {
				for (LogisticSettingAreaDto logisticSettingAreaDto : checkedList) {
					if (StringUtils.isEmpty(logisticSettingAreaDto.getCountyCode())) {
						if (StringUtils.isEmpty(logisticSettingAreaDto.getCityCode())) {
							checkedProvinceCodeList.add(logisticSettingAreaDto.getProvinceCode());
						} else {
							checkedCityCodeList.add(logisticSettingAreaDto.getCityCode());
						}
					} else {
						checkedCountyCodeList.add(logisticSettingAreaDto.getCountyCode());
					}
				}
			}
			Map<String, List<String>> map = new HashMap<String, List<String>>();
			map.put("disabledProvinceCodeList", disabledProvinceCodeList);
			map.put("disabledCityCodeList", disabledCityCodeList);
			map.put("disabledCountyCodeList", disabledCountyCodeList);
			map.put("checkedProvinceCodeList", checkedProvinceCodeList);
			map.put("checkedCityCodeList", checkedCityCodeList);
			map.put("checkedCountyCodeList", checkedCountyCodeList);
			return map;
		} catch (Exception e) {
			logger.error("getDisabledAndCheckedArea异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public LogisticSettingAreaDto loadAreaSettingByProvinceCode(Integer settingId, String provinceCode)
			throws UserServiceException {
		try {
			LogisticSettingArea logisticSettingArea = logisticSettingAreaMapper.loadAreaSettingByProvinceCode(settingId,
					provinceCode);
			LogisticSettingAreaDto logisticSettingAreaDto = null;
			if (null != logisticSettingArea) {
				logisticSettingAreaDto = new LogisticSettingAreaDto();
				ObjectUtils.fastCopy(logisticSettingArea, logisticSettingAreaDto);
			}
			return logisticSettingAreaDto;
		} catch (Exception e) {
			logger.error("loadAreaSettingByProvinceCode异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public LogisticSettingAreaDto loadAreaSettingByCityCode(Integer settingId, String cityCode) throws UserServiceException {
		try {
			LogisticSettingArea logisticSettingArea = logisticSettingAreaMapper.loadAreaSettingByCityCode(settingId,
					cityCode);
			LogisticSettingAreaDto logisticSettingAreaDto = null;
			if (null != logisticSettingArea) {
				logisticSettingAreaDto = new LogisticSettingAreaDto();
				ObjectUtils.fastCopy(logisticSettingArea, logisticSettingAreaDto);
			}
			return logisticSettingAreaDto;
		} catch (Exception e) {
			logger.error("loadAreaSettingByCityCode异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public LogisticSettingAreaDto loadAreaSettingByCountyCode(Integer settingId, String countyCode)
			throws UserServiceException {
		try {
			LogisticSettingArea logisticSettingArea = logisticSettingAreaMapper.loadAreaSettingByCountyCode(settingId,
					countyCode);
			LogisticSettingAreaDto logisticSettingAreaDto = null;
			if (null != logisticSettingArea) {
				logisticSettingAreaDto = new LogisticSettingAreaDto();
				ObjectUtils.fastCopy(logisticSettingArea, logisticSettingAreaDto);
			}
			return logisticSettingAreaDto;
		} catch (Exception e) {
			logger.error("loadAreaSettingByCountyCode异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public Long getFreight(FreightCalculateDto freightCalculateDto) throws UserServiceException {
		String msg = null;
		if (null == freightCalculateDto.getStoreId()) {
			msg = "运费计算DTO参数中providerId不能为null";
			logger.error(msg);
			throw new UserServiceException(msg);
		}
		if (null == freightCalculateDto.getQuantity()) {
			msg = "运费计算DTO参数中quantity不能为null";
			logger.error(msg);
			throw new UserServiceException(msg);
		}
		if (null == freightCalculateDto.getTotalPrice()) {
			msg = "运费计算DTO参数中totalPrice不能为null";
			logger.error(msg);
			throw new UserServiceException(msg);
		}
		if (null == freightCalculateDto.getProvinceCode()) {
			msg = "运费计算DTO参数中provinceCode不能为null";
			logger.error(msg);
			throw new UserServiceException(msg);
		}
		if (null == freightCalculateDto.getCityCode()) {
			msg = "运费计算DTO参数中cityCode不能为null";
			logger.error(msg);
			throw new UserServiceException(msg);
		}
		if (null == freightCalculateDto.getCountyCode()) {
			msg = "运费计算DTO参数中countyCode不能为null";
			logger.error(msg);
			throw new UserServiceException(msg);
		}
		LogisticSetting setting = logisticSettingMapper.loadDefaultByOperatorId(freightCalculateDto.getStoreId());
		if (ObjectUtils.isNullOrEmpty(setting)) {
			msg = "logisticSettingMapper.loadDefaultByProviderId(" + freightCalculateDto.getStoreId() + ")返回结果为null";
			logger.error(msg);
			throw new UserServiceException(msg);
		}
		// 判断是否免运费
		if (isFreeFreight(setting, freightCalculateDto.getQuantity(), freightCalculateDto.getTotalPrice())) {
			return 0L;
		}
		LogisticSettingArea areaSetting = null;
		LogisticSettingArea countySetting = logisticSettingAreaMapper.loadAreaSettingByCountyCode(setting.getId(),
				freightCalculateDto.getCountyCode());
		if (null != countySetting) {
			areaSetting = countySetting;
		} else {
			LogisticSettingArea citySetting = logisticSettingAreaMapper.loadAreaSettingByCityCode(setting.getId(),
					freightCalculateDto.getCityCode());
			if (null != citySetting) {
				areaSetting = citySetting;
			} else {
				LogisticSettingArea provinceSetting = logisticSettingAreaMapper.loadAreaSettingByProvinceCode(
						setting.getId(), freightCalculateDto.getProvinceCode());
				areaSetting = provinceSetting;
			}
		}
		if (SystemContext.UserDomain.LOGISTFEETYPE_WEIGHT.equals(setting.getFeeType())) {
			if (null == freightCalculateDto.getWeight()) {
				msg = "由于卖家是按重量计算运费，因此运费计算DTO参数中weight不能为null";
				logger.error(msg);
				throw new UserServiceException(msg);
			}
			// 按重量计算运费
			return getFreight(setting, areaSetting, freightCalculateDto.getWeight());
		} else if (SystemContext.UserDomain.LOGISTFEETYPE_COUNT.equals(setting.getFeeType())) {
			// 按数量计算运费
			return getFreight(setting, areaSetting, freightCalculateDto.getQuantity());
		} else {
			return 0L;
		}
	}

	private Long getFreight(LogisticSetting setting, LogisticSettingArea area, Integer count) {
		Long freight = 0L;
		if (ObjectUtils.isNullOrEmpty(area)) {
			if (count <= setting.getFirstCount()) {
				freight = setting.getFirstFee();
			} else {
				freight = setting.getFirstFee() + ((count - setting.getFirstCount()) / setting.getAddCount())
						* setting.getAddFee();
			}
		} else {
			if (count < area.getFirstCount()) {
				freight = area.getFirstFee();
			} else {
				freight = area.getFirstFee() + ((count - area.getFirstCount()) / area.getAddCount()) * area.getAddFee();
			}
		}
		return freight;
	}

	private boolean isFreeFreight(LogisticSetting setting, Integer quantity, Long totalPrice) {
		String free = setting.getFreeSetting();
		if (SystemContext.UserDomain.LOGISTICS_FREESETTING_NONE.equals(free)) {
			return false;
		} else if (SystemContext.UserDomain.LOGISTICS_FREESETTING_PURCHASE_PRICE.equals(free)) { // 按金额免费
			return setting.getFreeAmount() <= totalPrice;
		} else if (SystemContext.UserDomain.LOGISTICS_FREESETTING_PURCHASE_COUNT.equals(free)) { // 按件数
			return setting.getFreeQuantity() <= quantity;
		} else if (SystemContext.UserDomain.LOGISTICS_FREESETTING_PURCHASE_PRICE_AND_COUNT.equals(free)) { // 按金额和件数，只要有一个满足就免费
			if (setting.getFreeAmount() <= totalPrice) {
				return true;
			}
			if (setting.getFreeQuantity() <= quantity) {
				return true;
			}
		}
		return false;
	}

	@Override
	public void saveLogistics(LogisticSettingDto logisticSettingDto, Map<Integer, List<LogisticAreaDto>> areaMap,
			Map<Integer, LogisticChargeDto> chargeMap) throws UserServiceException {
		try {
			Integer settingId = this.saveLogisticSetting(logisticSettingDto);
			if (!ObjectUtils.isNullOrEmpty(areaMap)) {
				if (ObjectUtils.isNullOrEmpty(chargeMap)) {
					String msg = "物流区域设置中的费用相关设置不能为空！";
					logger.error(msg);
					throw new UserServiceException(msg);
				}
				for (Map.Entry<Integer, List<LogisticAreaDto>> entry : areaMap.entrySet()) {
					Integer blockId = entry.getKey();
					List<LogisticAreaDto> logisticAreaDtoList = entry.getValue();
					for (LogisticAreaDto logisticAreaDto : logisticAreaDtoList) {
						LogisticSettingAreaDto logisticSettingAreaDto = new LogisticSettingAreaDto();
						logisticSettingAreaDto.setSettingId(settingId);
						logisticSettingAreaDto.setOperatorId(logisticSettingDto.getOperatorId());
						logisticSettingAreaDto.setProvinceCode(logisticAreaDto.getProvinceCode());
						logisticSettingAreaDto.setCityCode(logisticAreaDto.getCityCode());
						logisticSettingAreaDto.setCountyCode(logisticAreaDto.getCountyCode());
						LogisticChargeDto logisticChargeDto = chargeMap.get(blockId);
						logisticSettingAreaDto.setFirstCount(logisticChargeDto.getFirstCount());
						logisticSettingAreaDto.setFirstFee(logisticChargeDto.getFirstFee());
						logisticSettingAreaDto.setAddCount(logisticChargeDto.getAddCount());
						logisticSettingAreaDto.setAddFee(logisticChargeDto.getAddFee());
						logisticSettingAreaDto.setBlockId(blockId);
						logisticSettingAreaDto.setCreateUserId(logisticSettingDto.getCreateUserId());
						logisticSettingAreaDto.setCreateTime(logisticSettingDto.getCreateTime());
						this.saveLogisticSettingArea(logisticSettingAreaDto);
					}
				}
			}
		} catch (Exception e) {
			logger.error("saveLogistics异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public void saveOrUpdateLogisticSettingAreaForBlock(Integer settingId, Integer blockId, Integer userId,
			List<LogisticAreaDto> logisticAreaDtoList, LogisticChargeDto logisticChargeDto) throws UserServiceException {
		try {
			String msg = null;
			if (ObjectUtils.isNullOrEmpty(logisticAreaDtoList)) {
				msg = "物流选择的区域不能为空！";
				logger.error(msg);
				throw new UserServiceException(msg);
			}
			if (ObjectUtils.isNullOrEmpty(logisticChargeDto)) {
				msg = "物流区域设置中的费用相关设置不能为空！";
				logger.error(msg);
				throw new UserServiceException(msg);
			}
			logisticSettingAreaMapper.deleteBySettingIdAndBlockId(settingId, blockId);
			LogisticSetting logisticSetting = logisticSettingMapper.loadById(settingId);
			for (LogisticAreaDto logisticAreaDto : logisticAreaDtoList) {
				LogisticSettingAreaDto logisticSettingAreaDto = new LogisticSettingAreaDto();
				logisticSettingAreaDto.setSettingId(settingId);
				logisticSettingAreaDto.setOperatorId(logisticSetting.getOperatorId());
				logisticSettingAreaDto.setProvinceCode(logisticAreaDto.getProvinceCode());
				logisticSettingAreaDto.setCityCode(logisticAreaDto.getCityCode());
				logisticSettingAreaDto.setCountyCode(logisticAreaDto.getCountyCode());
				logisticSettingAreaDto.setFirstCount(logisticChargeDto.getFirstCount());
				logisticSettingAreaDto.setFirstFee(logisticChargeDto.getFirstFee());
				logisticSettingAreaDto.setAddCount(logisticChargeDto.getAddCount());
				logisticSettingAreaDto.setAddFee(logisticChargeDto.getAddFee());
				logisticSettingAreaDto.setBlockId(blockId);
				logisticSettingAreaDto.setCreateUserId(userId);
				logisticSettingAreaDto.setCreateTime(new Date());
				logisticSettingAreaDto.setModifyUserId(userId);
				logisticSettingAreaDto.setModifyTime(new Date());
				this.saveLogisticSettingArea(logisticSettingAreaDto);
			}
		} catch (Exception e) {
			logger.error("saveOrUpdateLogisticSettingAreaForBlock异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

}
