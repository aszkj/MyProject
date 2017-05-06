package com.yilidi.o2o.system.service;

import java.util.List;

import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.system.service.dto.AreaDictDto;

/**
 * 
 * @Description:TODO(区域字典Service接口)
 * @author: chenlian
 * @date: 2015年12月3日 下午3:29:08
 * 
 */
public interface IAreaDictService {

	/**
	 * 
	 * @Description TODO(创建区域字典)
	 * @param areaDictDto
	 * @return AreaDictDto
	 * @throws SystemServiceException
	 */
	public AreaDictDto save(AreaDictDto areaDictDto) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(根据区域字典编码获取区域信息)
	 * @param areaCode
	 * @return AreaDictDto
	 * @throws SystemServiceException
	 */
	public AreaDictDto loadByAreaCode(String areaCode) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(根据地区的区域类型来查询区域信息)
	 * @param areaType
	 * @return List<AreaDictDto>
	 * @throws SystemServiceException
	 */
	public List<AreaDictDto> listByAreaType(String areaType) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(根据父级节点Code加载所有的区域信息)
	 * @param parentCode
	 * @return List<AreaDictDto>
	 * @throws SystemServiceException
	 */
	public List<AreaDictDto> listByParentCode(String parentCode) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(根据区域编码更新区域信息)
	 * @param areaDictDto
	 * @throws SystemServiceException
	 */
	public void updateByAreaCode(AreaDictDto areaDictDto) throws SystemServiceException;

}
