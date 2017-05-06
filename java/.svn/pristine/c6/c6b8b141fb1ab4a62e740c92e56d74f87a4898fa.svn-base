/**
 * 文件名称：ILogisticSettingService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.user.service;

import java.util.List;
import java.util.Map;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.user.service.dto.FreightCalculateDto;
import com.yilidi.o2o.user.service.dto.LogisticAreaDto;
import com.yilidi.o2o.user.service.dto.LogisticChargeDto;
import com.yilidi.o2o.user.service.dto.LogisticSettingAreaDto;
import com.yilidi.o2o.user.service.dto.LogisticSettingDto;

/**
 * 功能描述：物流设置服务接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ILogisticSettingService {

	/**
	 * 新增物流设置
	 * 
	 * @param logisticSettingDto
	 * @return Integer 物流设置ID
	 * @throws UserServiceException
	 */
	public Integer saveLogisticSetting(LogisticSettingDto logisticSettingDto) throws UserServiceException;

	/**
	 * 修改物流设置
	 * 
	 * @param logisticSettingDto
	 * @throws UserServiceException
	 */
	public void updateLogisticSettingByIdSelective(LogisticSettingDto logisticSettingDto) throws UserServiceException;

	/**
	 * 根据物流设置ID查询物流设置信息
	 * 
	 * @param id
	 * @return LogisticSettingDto
	 * @throws UserServiceException
	 */
	public LogisticSettingDto loadLogisticSettingById(Integer id) throws UserServiceException;

	/**
	 * 根据运营商ID获取该运营商当前默认使用的物流设置信息
	 * 
	 * @param operatorId
	 * @return LogisticSettingDto
	 * @throws UserServiceException
	 */
	public LogisticSettingDto loadLogisticSettingDefaultByOperatorId(Integer operatorId) throws UserServiceException;

	/**
	 * 根据运营商ID和物流类型编码查询物流设置信息
	 * 
	 * @param operatorId
	 * @param logisticCode
	 * @return LogisticSettingDto
	 * @throws UserServiceException
	 */
	public LogisticSettingDto loadLogisticSettingByOperatorIdAndTypeCode(Integer operatorId, String logisticCode)
			throws UserServiceException;

	/**
	 * 新增物流的地区设置
	 * 
	 * @param logisticSettingAreaDto
	 * @throws UserServiceException
	 */
	public void saveLogisticSettingArea(LogisticSettingAreaDto logisticSettingAreaDto) throws UserServiceException;

	/**
	 * 根据物流的地区设置ID删除该地区设置
	 * 
	 * @param id
	 * @throws UserServiceException
	 */
	public void deleteLogisticSettingAreaById(Integer id) throws UserServiceException;

	/**
	 * 修改物流的地区设置
	 * 
	 * @param logisticSettingAreaDto
	 * @throws UserServiceException
	 */
	public void updateLogisticSettinAreaByIdSelective(LogisticSettingAreaDto logisticSettingAreaDto)
			throws UserServiceException;

	/**
	 * 根据物流地区设置ID查询物流地区设置信息
	 * 
	 * @param id
	 * @return LogisticSettingAreaDto
	 * @throws UserServiceException
	 */
	public LogisticSettingAreaDto loadLogisticSettingAreaById(Integer id) throws UserServiceException;

	/**
	 * 根据物流设置ID获取所有的地区设置
	 * 
	 * @param settingId
	 * @return List<LogisticSettingAreaDto>
	 * @throws UserServiceException
	 */
	public List<LogisticSettingAreaDto> listLogisticSettingAreaBySettingId(Integer settingId) throws UserServiceException;

	/**
	 * 根据物流设置Id和块Id获取物流区域设置列表
	 * 
	 * @param settingId
	 * @param blockId
	 * @return List<LogisticSettingAreaDto>
	 * @throws UserServiceExceptiono
	 */
	public List<LogisticSettingAreaDto> listLogisticSettingAreaBySettingIdAndBlockId(Integer settingId, Integer blockId)
			throws UserServiceException;

	/**
	 * 根据物流设置Id获取排除指定块Id以外的物流区域设置列表
	 * 
	 * @param settingId
	 * @param blockId
	 * @return List<LogisticSettingAreaDto>
	 * @throws UserServiceException
	 */
	public List<LogisticSettingAreaDto> listLogisticSettingAreaByBySettingIdExcludeAssignedBlock(Integer settingId,
			Integer blockId) throws UserServiceException;

	/**
	 * 根据物流设置Id和块Id获取物流收费设置信息
	 * 
	 * @param settingId
	 * @param blockId
	 * @return LogisticSettingAreaDto
	 * @throws UserServiceException
	 */
	public LogisticSettingAreaDto loadChargeSettingBySettingIdAndBlockId(Integer settingId, Integer blockId)
			throws UserServiceException;

	/**
	 * 在弹出区域选择页面时，获取应该被置灰和应该被勾选的区域
	 * 
	 * @param settingId
	 * @param blockId
	 * @return Map<String, List<String>>
	 * @throws UserServiceException
	 */
	public Map<String, List<String>> getDisabledAndCheckedArea(Integer settingId, Integer blockId)
			throws UserServiceException;

	/**
	 * 根据物流设置Id和省份编码获取物流区域设置信息
	 * 
	 * @param settingId
	 * @param provinceCode
	 * @return LogisticSettingAreaDto
	 * @throws UserServiceException
	 */
	public LogisticSettingAreaDto loadAreaSettingByProvinceCode(Integer settingId, String provinceCode)
			throws UserServiceException;

	/**
	 * 根据物流设置Id和地市编码获取物流区域设置信息
	 * 
	 * @param settingId
	 * @param cityCode
	 * @return LogisticSettingAreaDto
	 * @throws UserServiceException
	 */
	public LogisticSettingAreaDto loadAreaSettingByCityCode(Integer settingId, String cityCode) throws UserServiceException;

	/**
	 * 根据物流设置Id和区县编码获取物流区域设置信息
	 * 
	 * @param settingId
	 * @param countyCode
	 * @return LogisticSettingAreaDto
	 * @throws UserServiceException
	 */
	public LogisticSettingAreaDto loadAreaSettingByCountyCode(Integer settingId, String countyCode)
			throws UserServiceException;

	/**
	 * 获取运费
	 * 
	 * @param freightCalculateDto
	 * @return Long
	 * @throws UserServiceException
	 */
	Long getFreight(FreightCalculateDto freightCalculateDto) throws UserServiceException;

	/**
	 * 新增完整的物流信息
	 * 
	 * @param logisticSettingDto
	 *            物流设置DTO
	 * @param areaMap
	 *            以blockId为Key，LogisticAreaDto的List为Value的Map
	 * @param chargeMap
	 *            以blockId为Key，LogisticChargeDto为Value的Map
	 * @throws UserServiceException
	 */
	public void saveLogistics(LogisticSettingDto logisticSettingDto, Map<Integer, List<LogisticAreaDto>> areaMap,
			Map<Integer, LogisticChargeDto> chargeMap) throws UserServiceException;

	/**
	 * 添加或修改一个块内的物流区域设置信息
	 * 
	 * @param settingId
	 * @param blockId
	 * @param userId
	 * @param logisticAreaDtoList
	 * @param logisticChargeDto
	 * @throws UserServiceException
	 */
	public void saveOrUpdateLogisticSettingAreaForBlock(Integer settingId, Integer blockId, Integer userId,
			List<LogisticAreaDto> logisticAreaDtoList, LogisticChargeDto logisticChargeDto) throws UserServiceException;

}
