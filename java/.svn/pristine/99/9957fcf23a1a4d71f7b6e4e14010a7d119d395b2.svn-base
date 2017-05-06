/**
 * 文件名称：IAreaDictProxyService.java
 * 
 * 描述：
 * 
 * 修改
 */
package com.yilidi.o2o.system.proxy;

import java.util.List;

import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.system.proxy.dto.AreaDictProxyDto;

/**
 * 功能描述：区域字典代理接口类定义 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IAreaDictProxyService {

	/**
	 * 根据区域编码获取所属地区地址信息
	 * 
	 * @param provinceCode
	 *            省份编码
	 * @param cityCode
	 *            市编码
	 * @param countyCode
	 *            区县编码
	 * @param townCode
	 *            乡镇编码
	 * @param addressDetail
	 *            详细地址
	 * @return String 地区地址信息
	 * @throws SystemServiceException
	 *             系统域异常
	 */
	public String encapsulateAreaNameByCodes(String provinceCode, String cityCode, String countyCode, String townCode,
			String addressDetail) throws SystemServiceException;

	/**
	 * 根据区域编码获取所属地区地址信息
	 * 
	 * @param areaCode
	 * @return
	 * @throws SystemServiceException
	 */
	AreaDictProxyDto loadByAreaCode(String areaCode) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(根据父级节点Code加载所有的区域信息)
	 * @param parentCode
	 * @return List<AreaDictProxyDto>
	 * @throws SystemServiceException
	 */
	public List<AreaDictProxyDto> listByParentCode(String parentCode) throws SystemServiceException;

}
