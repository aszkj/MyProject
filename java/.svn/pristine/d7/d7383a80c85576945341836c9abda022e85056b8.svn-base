package com.yilidi.o2o.user.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.CommissionSettingHistoryMapper;
import com.yilidi.o2o.user.dao.CommissionSettingMapper;
import com.yilidi.o2o.user.model.CommissionSetting;
import com.yilidi.o2o.user.model.CommissionSettingHistory;
import com.yilidi.o2o.user.service.ICommissionSettingService;
import com.yilidi.o2o.user.service.dto.CommissionSettingDto;
import com.yilidi.o2o.user.service.dto.CommissionSettingHistoryDto;

/**
 * 功能描述：佣金设置Service服务实现类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("commissionSettingService")
public class CommissionSettingServiceImpl extends BasicDataService implements ICommissionSettingService {

	@Autowired
	private CommissionSettingMapper commissionSettingMapper;

	@Autowired
	private CommissionSettingHistoryMapper commissionSettingHistoryMapper;

	@Override
	public void saveCommissionSetting(CommissionSettingDto commissionSettingDto) throws UserServiceException {
		try {
			CommissionSetting commissionSetting = new CommissionSetting();
			ObjectUtils.fastCopy(commissionSettingDto, commissionSetting);
			this.commissionSettingMapper.save(commissionSetting);
		} catch (Exception e) {
			logger.error("saveCommissionSetting异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public void updateCommissionSettingByIdSelective(CommissionSettingDto commissionSettingDto) throws UserServiceException {
		try {
			CommissionSetting commissionSetting = this.commissionSettingMapper.loadById(commissionSettingDto.getSettingId());
			if (!StringUtils.isEmpty(commissionSettingDto.getClearType())) {
				commissionSetting.setClearType(commissionSettingDto.getClearType());
			}
			if (!StringUtils.isEmpty(commissionSettingDto.getStatus())) {
				commissionSetting.setStatus(commissionSettingDto.getStatus());
			}
			if (null != commissionSettingDto.getEffectiveDate()) {
				commissionSetting.setEffectiveDate(commissionSettingDto.getEffectiveDate());
			}
			if (null != commissionSettingDto.getRate()) {
				commissionSetting.setRate(commissionSettingDto.getRate());
			}
			this.commissionSettingMapper.updateByIdSelective(commissionSetting);
		} catch (Exception e) {
			logger.error("updateCommissionSettingByIdSelective异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public CommissionSettingDto loadCommissionSettingById(Integer id) throws UserServiceException {
		try {
			CommissionSetting commissionSetting = this.commissionSettingMapper.loadById(id);
			CommissionSettingDto commissionSettingDto = null;
			if (null != commissionSetting) {
				commissionSettingDto = new CommissionSettingDto();
				ObjectUtils.fastCopy(commissionSetting, commissionSettingDto);
			}
			return commissionSettingDto;
		} catch (Exception e) {
			logger.error("loadCommissionSettingById异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public CommissionSettingDto loadCommissionSettingByStoreId(Integer providerId) throws UserServiceException {
		try {
			CommissionSetting commissionSetting = this.commissionSettingMapper.loadByStoreId(providerId);
			CommissionSettingDto commissionSettingDto = null;
			if (null != commissionSetting) {
				commissionSettingDto = new CommissionSettingDto();
				ObjectUtils.fastCopy(commissionSetting, commissionSettingDto);
			}
			return commissionSettingDto;
		} catch (Exception e) {
			logger.error("loadCommissionSettingByProviderId异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public List<CommissionSettingDto> listCommissionSettingByType(String type) throws UserServiceException {
		try {
			List<CommissionSetting> commissionSettings = this.commissionSettingMapper.listByType(type);
			List<CommissionSettingDto> commissionSettingDtos = null;
			if (!ObjectUtils.isNullOrEmpty(commissionSettings)) {
				commissionSettingDtos = new ArrayList<CommissionSettingDto>();
				for (CommissionSetting commissionSetting : commissionSettings) {
					CommissionSettingDto commissionSettingDto = new CommissionSettingDto();
					ObjectUtils.fastCopy(commissionSetting, commissionSettingDto);
					commissionSettingDtos.add(commissionSettingDto);
				}
			}
			return commissionSettingDtos;
		} catch (Exception e) {
			logger.error("listCommissionSettingByType异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public void saveCommissionSettingHistory(CommissionSettingHistoryDto commissionSettingHistoryDto)
			throws UserServiceException {
		try {
			CommissionSettingHistory commissionSettingHistory = new CommissionSettingHistory();
			ObjectUtils.fastCopy(commissionSettingHistoryDto, commissionSettingHistory);
			this.commissionSettingHistoryMapper.save(commissionSettingHistory);
		} catch (Exception e) {
			logger.error("saveCommissionSettingHistory异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public List<CommissionSettingHistoryDto> listCommissionSettingHistoryBySettingId(Integer settingId)
			throws UserServiceException {
		try {
			List<CommissionSettingHistory> commissionSettingHistories = this.commissionSettingHistoryMapper
					.listBySettingId(settingId);
			List<CommissionSettingHistoryDto> commissionSettingHistoryDtos = null;
			if (!ObjectUtils.isNullOrEmpty(commissionSettingHistories)) {
				commissionSettingHistoryDtos = new ArrayList<CommissionSettingHistoryDto>();
				for (CommissionSettingHistory commissionSettingHistory : commissionSettingHistories) {
					CommissionSettingHistoryDto commissionSettingHistoryDto = new CommissionSettingHistoryDto();
					ObjectUtils.fastCopy(commissionSettingHistory, commissionSettingHistoryDto);
					commissionSettingHistoryDtos.add(commissionSettingHistoryDto);
				}
			}
			return commissionSettingHistoryDtos;
		} catch (Exception e) {
			logger.error("listCommissionSettingHistoryBySettingId异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

	@Override
	public List<CommissionSettingHistoryDto> listCommissionSettingHistoryBySynFlag(String synFlag)
			throws UserServiceException {
		try {
			List<CommissionSettingHistory> commissionSettingHistories = this.commissionSettingHistoryMapper
					.listBySynFlag(synFlag);
			List<CommissionSettingHistoryDto> commissionSettingHistoryDtos = null;
			if (!ObjectUtils.isNullOrEmpty(commissionSettingHistories)) {
				commissionSettingHistoryDtos = new ArrayList<CommissionSettingHistoryDto>();
				for (CommissionSettingHistory commissionSettingHistory : commissionSettingHistories) {
					CommissionSettingHistoryDto commissionSettingHistoryDto = new CommissionSettingHistoryDto();
					ObjectUtils.fastCopy(commissionSettingHistory, commissionSettingHistoryDto);
					commissionSettingHistoryDtos.add(commissionSettingHistoryDto);
				}
			}
			return commissionSettingHistoryDtos;
		} catch (Exception e) {
			logger.error("listCommissionSettingHistoryBySynFlag异常", e);
			throw new UserServiceException(e.getMessage());
		}
	}

}
