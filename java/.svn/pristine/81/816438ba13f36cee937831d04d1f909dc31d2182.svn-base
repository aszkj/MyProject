package com.yilidi.o2o.system.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.system.model.SystemDict;
import com.yilidi.o2o.system.service.dto.query.SystemDictQuery;

/**
 * 
 * @Description:TODO(系统字典Mapper接口)
 * @author: chenlian
 * @date: 2015年11月16日 上午11:07:57
 * 
 */
public interface SystemDictMapper {

	/**
	 * 保存系统字典
	 * 
	 * @param record
	 *            系统字典对象
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_SYSTEM_DICT })
	Integer save(SystemDict record);

	/**
	 * 根据ID更新系统字典名称
	 * 
	 * @param id
	 *            字典ID
	 * @param dictName
	 *            字典名称
	 * @param modifyUserId
	 *            修改用户Id
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_SYSTEM_DICT })
	Integer updateDictNameById(@Param("id") Integer id, @Param("dictName") String dictName,
			@Param("modifyUserId") Integer modifyUserId);

	/**
	 * 根据字典编码更新系统字典名称
	 * 
	 * @param dictCode
	 *            字典编码
	 * @param dictName
	 *            字典名称
	 * @param modifyUserId
	 *            修改用户id
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_SYSTEM_DICT })
	Integer updateNameByDictCode(@Param("dictCode") String dictCode, @Param("dictName") String dictName,
			@Param("modifyUserId") Integer modifyUserId);

	/**
	 * 
	 * @Description TODO(判空更新)
	 * @param record
	 * @return Integer
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_SYSTEM_DICT })
	Integer updateByIdSelective(SystemDict record);

	/**
	 * 
	 * @Description TODO(非判空更新)
	 * @param record
	 * @return Integer
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_SYSTEM_DICT })
	Integer updateById(SystemDict record);

	/**
	 * 根据ID查询字典
	 * 
	 * @param id
	 *            字典Id
	 * @return 字典对象
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_SYSTEM_DICT })
	SystemDict loadById(Integer id);

	/**
	 * 根据字典编码查询字典信息
	 * 
	 * @param dictCode
	 *            字典编码
	 * @return 字典对象
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_SYSTEM_DICT })
	SystemDict loadByDictCode(String dictCode);

	/**
	 * 根据字典名称模糊查询字典信息
	 * 
	 * @param dictName
	 *            字典名称
	 * @return 字典列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_SYSTEM_DICT })
	List<SystemDict> listByDictName(@Param("dictName") String dictName);

	/**
	 * 获取所有有效的字典类型和名称
	 * 
	 * @return 字典类型和名称列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_SYSTEM_DICT })
	List<Map<String, String>> listAllValidDictType();

	/**
	 * 根据字典类型查询有效的字典
	 * 
	 * @param dictType
	 *            字典类型
	 * @return 字典列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_SYSTEM_DICT })
	List<SystemDict> listAllValidDictByDictType(@Param("dictType") String dictType);

	/**
	 * 
	 * @Description TODO(根据字典类型获取该类型下字典的记录数)
	 * @param dictType
	 * @return Integer
	 */
	Integer getDictCountsByDictType(@Param("dictType") String dictType);

	/**
	 * 
	 * @Description TODO(分页查询系统字典)
	 * @param systemDictQuery
	 * @return Page<SystemDict>
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_SYSTEM_DICT })
	Page<SystemDict> findSystemDict(SystemDictQuery systemDictQuery);

}