package com.yilidi.o2o.user.dao;

import java.util.List;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.CommissionSetting;

/**
 * 功能描述：佣金设置数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface CommissionSettingMapper {
	/**
	 * 保存佣金设置
	 * 
	 * @param record
	 *            佣金设置对象
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_COMMISSION_SETTING })
	Integer save(CommissionSetting record);

	/**
	 * 根据ID更新用户设置
	 * 
	 * @param record
	 *            佣金设置对象
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_COMMISSION_SETTING })
	Integer updateByIdSelective(CommissionSetting record);

	/**
	 * 根据Id获取佣金设置
	 * 
	 * <pre>
	 * 注：该方法 使用缓存
	 * </pre>
	 * 
	 * @param id
	 *            设置Id
	 * @return 佣金设置对象
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_COMMISSION_SETTING })
	CommissionSetting loadById(Integer id);

	/**
	 * 根据店铺ID查询佣金设置
	 * 
	 * <pre>
	 * 注：该方法 使用缓存
	 * </pre>
	 * 
	 * @param storeId
	 *            店铺ID
	 * @return 佣金设置列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_COMMISSION_SETTING })
	CommissionSetting loadByStoreId(Integer storeId);

	/**
	 * 根据结算方式获取结算设置记录
	 * 
	 * @param type
	 *            结算方式
	 * @return 结算设置记录列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_COMMISSION_SETTING })
	List<CommissionSetting> listByType(String type);

}