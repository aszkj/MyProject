package com.yilidi.o2o.system.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.system.model.SystemDictHistory;

/**
 * 
 * @Description:TODO(系统字典历史Mapper)
 * @author: chenlian
 * @date: 2015年11月16日 下午12:28:30
 * 
 */
public interface SystemDictHistoryMapper {

	/**
	 * 
	 * @Description TODO(保存系统字典历史信息)
	 * @param record
	 * @return Integer
	 */
	Integer save(SystemDictHistory record);

	/**
	 * 
	 * @Description TODO(获取系统字典历史信息列表)
	 * @return List<SystemDictHistory>
	 */
	List<SystemDictHistory> list();

	/**
	 * 
	 * @Description TODO(根据字典ID获取系统字典历史信息列表)
	 * @param dictId
	 * @return List<SystemDictHistory>
	 */
	List<SystemDictHistory> listByDictId(@Param("dictId") Integer dictId);

}