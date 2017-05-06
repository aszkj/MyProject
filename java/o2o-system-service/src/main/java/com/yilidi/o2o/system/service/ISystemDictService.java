package com.yilidi.o2o.system.service;

import java.util.List;
import java.util.Map;

import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.system.service.dto.SystemDictDto;
import com.yilidi.o2o.system.service.dto.query.SystemDictQuery;

/**
 * 
 * @Description:TODO(系统字典Service接口)
 * @author: chenlian
 * @date: 2015年11月16日 上午10:51:08
 * 
 */
public interface ISystemDictService {

	/**
	 * 
	 * @Description TODO(创建系统字典)
	 * @param systemDictDto
	 * @throws SystemServiceException
	 */
	public void save(SystemDictDto systemDictDto) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(根据系统字典ID获取字典信息)
	 * @param id
	 * @return SystemDictDto
	 * @throws SystemServiceException
	 */
	public SystemDictDto loadById(Integer id) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(根据系统字典编码获取字典信息)
	 * @param dictCode
	 * @return SystemDictDto
	 * @throws SystemServiceException
	 */
	public SystemDictDto loadByDictCode(String dictCode) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(获取所有有效的系统字典类型与字典类型名称)
	 * @return List<Map<String, String>>
	 * @throws SystemServiceException
	 */
	public List<Map<String, String>> listAllValidDictType() throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(根据系统字典类型获取有效的字典列表信息)
	 * @param dictType
	 * @return List<SystemDictDto>
	 * @throws SystemServiceException
	 */
	public List<SystemDictDto> listAllValidDictByDictType(String dictType) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(根据不同条件，分页获取系统字典)
	 * @param systemDictQuery
	 * @return YiLiDiPage
	 * @throws SystemServiceException
	 */
	public YiLiDiPage<SystemDictDto> findSystemDict(SystemDictQuery systemDictQuery) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(修改系统字典)
	 * @param systemDictDto
	 * @throws SystemServiceException
	 */
	public void update(SystemDictDto systemDictDto) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(修改系统字典状态)
	 * @param systemDictDto
	 * @throws SystemServiceException
	 */
	public void updateStatus(SystemDictDto systemDictDto) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(修改系统字典排序)
	 * @param systemDictDto
	 * @throws SystemServiceException
	 */
	public void updateSort(SystemDictDto systemDictDto) throws SystemServiceException;

}
