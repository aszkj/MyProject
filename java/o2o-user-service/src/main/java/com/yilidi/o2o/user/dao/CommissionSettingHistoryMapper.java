package com.yilidi.o2o.user.dao;

import java.util.List;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.CommissionSettingHistory;

/**
 * 功能描述：用户设定历史数据层操作接口 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface CommissionSettingHistoryMapper {

	/**
	 * 保存佣金设定历史记录
	 * 
	 * @param record
	 *            设定记录
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_COMMISSION_SETTING_HISTORY })
	Integer save(CommissionSettingHistory record);

	/**
	 * 根据设定的ID查询历史记录
	 * 
	 * <pre>
	 * 注：该方法 使用缓存
	 * </pre>
	 * 
	 * @param settingId
	 *            佣金设定Id
	 * @return 历史记录列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_COMMISSION_SETTING_HISTORY })
	List<CommissionSettingHistory> listBySettingId(Integer settingId);

	/**
	 * 根据同步标识查询历史记录
	 * 
	 * <pre>
	 * 注：该方法 使用缓存
	 * </pre>
	 * 
	 * @param synFlag
	 *            "0"未同步 "1" 已同步,表示该设置是否已同步到表U_COMMISSION_SETTING中
	 * @return 列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_COMMISSION_SETTING_HISTORY })
	List<CommissionSettingHistory> listBySynFlag(String synFlag);

}