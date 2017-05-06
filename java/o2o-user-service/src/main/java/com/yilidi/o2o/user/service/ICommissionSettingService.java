package com.yilidi.o2o.user.service;

import java.util.List;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.user.service.dto.CommissionSettingDto;
import com.yilidi.o2o.user.service.dto.CommissionSettingHistoryDto;

/**
 * 功能描述：CommissionSetting服务层接口 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ICommissionSettingService {

	/**
	 * 添加佣金设置信息
	 * 
	 * @param commissionSettingDto
	 * @throws UserServiceException
	 */
	public void saveCommissionSetting(CommissionSettingDto commissionSettingDto) throws UserServiceException;

	/**
	 * 更新佣金设置信息
	 * 
	 * @param commissionSettingDto
	 * @throws UserServiceException
	 */
	public void updateCommissionSettingByIdSelective(CommissionSettingDto commissionSettingDto) throws UserServiceException;

	/**
	 * 根据佣金设置ID获取佣金设置信息
	 * 
	 * @param id
	 * @return CommissionSettingDto
	 * @throws UserServiceException
	 */
	public CommissionSettingDto loadCommissionSettingById(Integer id) throws UserServiceException;

	/**
	 * 根据店铺ID获取佣金设置信息
	 * 
	 * @param storeId
	 * @return CommissionSettingDto
	 * @throws UserServiceException
	 */
	public CommissionSettingDto loadCommissionSettingByStoreId(Integer storeId) throws UserServiceException;

	/**
	 * 根据结算方式获取佣金设置信息列表
	 * 
	 * @param type
	 * @return List<CommissionSettingDto>
	 * @throws UserServiceException
	 */
	public List<CommissionSettingDto> listCommissionSettingByType(String type) throws UserServiceException;

	/**
	 * 添加佣金设置历史信息
	 * 
	 * @param commissionSettingHistoryDto
	 * @throws UserServiceException
	 */
	public void saveCommissionSettingHistory(CommissionSettingHistoryDto commissionSettingHistoryDto)
			throws UserServiceException;

	/**
	 * 根据佣金设置ID获取佣金设置历史信息列表
	 * 
	 * @param settingId
	 * @return List<CommissionSettingHistoryDto>
	 * @throws UserServiceException
	 */
	public List<CommissionSettingHistoryDto> listCommissionSettingHistoryBySettingId(Integer settingId)
			throws UserServiceException;

	/**
	 * 根据同步标识获取佣金设置历史信息列表
	 * 
	 * @param synFlag
	 * @return List<CommissionSettingHistoryDto>
	 * @throws UserServiceException
	 */
	public List<CommissionSettingHistoryDto> listCommissionSettingHistoryBySynFlag(String synFlag)
			throws UserServiceException;

}
