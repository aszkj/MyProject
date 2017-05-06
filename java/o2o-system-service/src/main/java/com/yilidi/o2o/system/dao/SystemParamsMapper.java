package com.yilidi.o2o.system.dao;

import java.util.List;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.system.model.SystemParams;
import com.yilidi.o2o.system.service.dto.query.SystemParamsQuery;

/**
 * 功能描述：系统参数数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SystemParamsMapper {

	/**
	 * 保存系统参数
	 * 
	 * @param record
	 *            系统字典对象
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_SYSTEM_PARAMS })
	Integer save(SystemParams record);

	/**
	 * 根据ID更新系统参数（如果字段值为null，则不更新该字典，推荐使用该方法进行更新）
	 * 
	 * @param record
	 *            系统参数对象
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_SYSTEM_PARAMS })
	Integer updateByIdSelective(SystemParams record);

	/**
	 * 根据ID更新系统参数
	 * 
	 * @param record
	 *            系统参数对象
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_SYSTEM_PARAMS })
	Integer updateById(SystemParams record);

	/**
	 * 根据ID查询参数
	 * 
	 * @param paramsId
	 *            参数Id
	 * @return 参数对象
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_SYSTEM_PARAMS })
	SystemParams loadById(Integer paramsId);

	/**
	 * 根据参数状态获取系统参数列表
	 * 
	 * @param paramStatus
	 *            参数状态
	 * @return 参数列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_SYSTEM_PARAMS })
	List<SystemParams> listByParamStatus(String paramStatus);

	/**
	 * 根据参数编码获取系统参数
	 * 
	 * @param paramsCode
	 *            参数编码
	 * @return 参数对象
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_SYSTEM_PARAMS })
	SystemParams loadByParamsCode(String paramsCode);

	/**
	 * 根据参数名称获取系统参数
	 * 
	 * @param paramName
	 *            参数名称
	 * @return 参数对象
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_SYSTEM_PARAMS })
	SystemParams loadByParamName(String paramName);

	/**
	 * 根据不同条件，分页获取系统参数
	 * 
	 * @param systemParamsQuery
	 *            系统参数查询对象
	 * @return 系统参数分页信息
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_SYSTEM_PARAMS })
	Page<SystemParams> findSystemParams(SystemParamsQuery systemParamsQuery);

	/**
	 * 根据参数code获取参数
	 * @param paramsCode
	 * @return MsgBean
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_SYSTEM_PARAMS })
	SystemParams getSystemParamByParamsCode(SystemParams systemParams);

}