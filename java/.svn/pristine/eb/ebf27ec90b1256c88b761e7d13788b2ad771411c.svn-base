package com.yilidi.o2o.user.dao;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.LogisticSetting;

/**
 * 功能描述：物流设置数据层操作接口类定义 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface LogisticSettingMapper {

	/**
	 * 保存物流设置
	 * 
	 * @param record
	 *            物流设置对象
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_LOGISTICS_SETTING })
	Integer save(LogisticSetting record);

	/**
	 * 根据Id查询物流设置信息
	 * 
	 * <pre>
	 * 注：该方法 使用缓存
	 * </pre>
	 * 
	 * @param id
	 *            物流设置ID
	 * @return 物流设置对象
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_LOGISTICS_SETTING })
	LogisticSetting loadById(Integer id);

	/**
	 * 根据物流ID更新物流设置
	 * 
	 * @param record
	 *            物流设置记录
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_LOGISTICS_SETTING })
	Integer updateByIdSelective(LogisticSetting record);

	/**
	 * 根据运营商ID加载默认的设置
	 * 
	 * @param operatorId
	 *            运营商ID
	 * @return 运营商默认的物流设置
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_LOGISTICS_SETTING })
	LogisticSetting loadDefaultByOperatorId(Integer operatorId);

	/**
	 * 根据运营商ID和物流类型编码查询当前物流设置信息
	 * 
	 * @param operatorId
	 *            运营商ID
	 * @param logisticCode
	 *            物流类型编码，有系统字典中定义
	 * @return 物流设置信息
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_LOGISTICS_SETTING })
	LogisticSetting loadByOperatorIdAndTypeCode(@Param("operatorId") Integer providerId,
			@Param("logisticCode") String logisticCode);

}