package com.yilidi.o2o.system.dao;

import java.util.List;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.system.model.AreaDict;

/**
 * 
 * @Description:TODO(区域字典数据层操作接口类)
 * @author: chenlian
 * @date: 2015年12月3日 下午3:21:49
 * 
 */
public interface AreaDictMapper {

	/**
	 * 
	 * @Description TODO(保存地区字典信息)
	 * @param record
	 * @return Integer
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_AREA_DICT })
	Integer save(AreaDict record);

	/**
	 * 
	 * @Description TODO(根据地区的区域类型来查询区域信息)
	 * @param areaType
	 * @return List<AreaDict>
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_AREA_DICT })
	List<AreaDict> listByAreaType(String areaType);

	/**
	 * 
	 * @Description TODO(根据父级节点Code加载所有的区域信息)
	 * @param parentCode
	 * @return List<AreaDict>
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_AREA_DICT })
	List<AreaDict> listByParentCode(String parentCode);

	/**
	 * 
	 * @Description TODO(根据区域编码加载所有的区域信息)
	 * @param areaCodes
	 * @return List<AreaDict>
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_AREA_DICT })
	List<AreaDict> listByAreaCodes(List<String> areaCodes);

	/**
	 * 
	 * @Description TODO(根据区域编码加载区域信息)
	 * @param areaCode
	 * @return AreaDict
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.System.S_AREA_DICT })
	AreaDict loadByAreaCode(String areaCode);

	/**
	 * 
	 * @Description TODO(根据ID更新区域信息)
	 * @param record
	 * @return Integer
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_AREA_DICT })
	Integer updateById(AreaDict record);

	/**
	 * 
	 * @Description TODO(根据区域编码更新区域信息)
	 * @param record
	 * @return Integer
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.System.S_AREA_DICT })
	Integer updateByAreaCode(AreaDict record);
}