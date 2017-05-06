package com.yilidi.o2o.system.proxy;

import java.util.List;
import java.util.Map;

import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.system.proxy.dto.SystemDictProxyDto;

/**
 * 
 * @Description:TODO(系统字典代理Service接口)
 * @author: chenlian
 * @date: 2015年11月16日 下午5:33:33
 * 
 */
public interface ISystemDictProxyService {

	/**
	 * 
	 * @Description TODO(根据系统字典编码获取字典信息)
	 * @param dictCode
	 * @return SystemDictProxyDto
	 * @throws SystemServiceException
	 */
	public SystemDictProxyDto loadByDictCode(String dictCode) throws SystemServiceException;

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
	public List<SystemDictProxyDto> listAllValidDictByDictType(String dictType) throws SystemServiceException;

}
