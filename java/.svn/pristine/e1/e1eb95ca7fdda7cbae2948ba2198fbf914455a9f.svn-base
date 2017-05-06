package com.yilidi.o2o.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.LogisticSettingArea;

/**
 * 功能描述：物流地区设置数据层接口类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface LogisticSettingAreaMapper {

	/**
	 * 保存物流地区设置
	 * 
	 * @param record
	 * @return Integer
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_LOGISTICS_SETTING_AREA })
	Integer save(LogisticSettingArea record);

	/**
	 * 根据Id查询物流地区设置信息
	 * 
	 * @param id
	 * @return LogisticSettingArea
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_LOGISTICS_SETTING_AREA })
	LogisticSettingArea loadById(Integer id);

	/**
	 * 根据Id删除物流地区设置
	 * 
	 * @param id
	 * @return Integer
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_LOGISTICS_SETTING_AREA })
	Integer deleteById(Integer id);

	/**
	 * 根据物流设置Id和块Id删除该块的物流地区设置
	 * 
	 * @param settingId
	 * @param blockId
	 * @return Integer
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_LOGISTICS_SETTING_AREA })
	Integer deleteBySettingIdAndBlockId(@Param("settingId") Integer settingId, @Param("blockId") Integer blockId);

	/**
	 * 根据地区设置Id，更新地区设置信息
	 * 
	 * @param record
	 * @return Integer
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_LOGISTICS_SETTING_AREA })
	Integer updateByIdSelective(LogisticSettingArea record);

	/**
	 * 根据物流设置Id获取物流区域设置列表
	 * 
	 * @param settingId
	 * @return List<LogisticSettingArea>
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_LOGISTICS_SETTING_AREA })
	List<LogisticSettingArea> listBySettingId(Integer settingId);

	/**
	 * 根据物流设置Id和块Id获取物流区域设置列表
	 * 
	 * @param settingId
	 * @param blockId
	 * @return List<LogisticSettingArea>
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_LOGISTICS_SETTING_AREA })
	List<LogisticSettingArea> listBySettingIdAndBlockId(@Param("settingId") Integer settingId,
			@Param("blockId") Integer blockId);

	/**
	 * 根据物流设置Id获取排除指定块Id以外的物流区域设置列表
	 * 
	 * @param settingId
	 * @param blockId
	 * @return List<LogisticSettingArea>
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_LOGISTICS_SETTING_AREA })
	List<LogisticSettingArea> listBySettingIdExcludeAssignedBlock(@Param("settingId") Integer settingId,
			@Param("blockId") Integer blockId);

	/**
	 * 根据物流设置Id和块Id获取物流收费设置信息
	 * 
	 * @param settingId
	 * @param blockId
	 * @return LogisticSettingArea
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_LOGISTICS_SETTING_AREA })
	LogisticSettingArea loadChargeSettingBySettingIdAndBlockId(@Param("settingId") Integer settingId,
			@Param("blockId") Integer blockId);

	/**
	 * 根据物流设置Id和省份编码获取物流区域设置信息
	 * 
	 * @param settingId
	 * @param provinceCode
	 * @return LogisticSettingArea
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_LOGISTICS_SETTING_AREA })
	LogisticSettingArea loadAreaSettingByProvinceCode(@Param("settingId") Integer settingId,
			@Param("provinceCode") String provinceCode);

	/**
	 * 根据物流设置Id和地市编码获取物流区域设置信息
	 * 
	 * @param settingId
	 * @param cityCode
	 * @return LogisticSettingArea
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_LOGISTICS_SETTING_AREA })
	LogisticSettingArea loadAreaSettingByCityCode(@Param("settingId") Integer settingId, @Param("cityCode") String cityCode);

	/**
	 * 根据物流设置Id和区县编码获取物流区域设置信息
	 * 
	 * @param settingId
	 * @param countyCode
	 * @return LogisticSettingArea
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_LOGISTICS_SETTING_AREA })
	LogisticSettingArea loadAreaSettingByCountyCode(@Param("settingId") Integer settingId,
			@Param("countyCode") String countyCode);

}