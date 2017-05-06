/**
 * 文件名称：ISystemParamsService.java
 * 
 * 描述：
 * 
 * 修改
 */
package com.yilidi.o2o.system.service;

import java.util.List;

import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.system.service.dto.SystemParamsDto;
import com.yilidi.o2o.system.service.dto.query.SystemParamsQuery;

/**
 * 功能描述：系统参数服务类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ISystemParamsService {

	/**
	 * 创建系统参数
	 * 
	 * @param systemParamsDto
	 * @throws SystemServiceException
	 */
	public void save(SystemParamsDto systemParamsDto) throws SystemServiceException;

	/**
	 * 根据参数ID获取系统参数
	 * 
	 * @param paramsId
	 * @return SystemParamsDto
	 * @throws SystemServiceException
	 */
	public SystemParamsDto loadByParamsId(Integer paramsId) throws SystemServiceException;

	/**
	 * 根据参数编码获取系统参数
	 * 
	 * @param paramsCode
	 * @return SystemParamsDto
	 * @throws SystemServiceException
	 */
	public SystemParamsDto loadByParamsCode(String paramsCode) throws SystemServiceException;

	/**
	 * 根据参数名称获取系统参数
	 * 
	 * @param paramName
	 * @return SystemParamsDto
	 * @throws SystemServiceException
	 */
	public SystemParamsDto loadByParamName(String paramName) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(获取所有有效的系统参数列表信息)
	 * @return List<SystemParamsDto>
	 * @throws SystemServiceException
	 */
	public List<SystemParamsDto> listAllValidSystemParams() throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(根据不同条件，分页获取系统参数)
	 * @param systemParamsQuery
	 * @return YiLiDiPage
	 * @throws SystemServiceException
	 */
	public YiLiDiPage<SystemParamsDto> findSystemParams(SystemParamsQuery systemParamsQuery) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(修改系统参数)
	 * @param systemParamsDto
	 * @throws SystemServiceException
	 */
	public void update(SystemParamsDto systemParamsDto) throws SystemServiceException;

	/**
	 * 
	 * @Description TODO(修改系统参数状态)
	 * @param systemParamsDto
	 * @throws SystemServiceException
	 */
	public void updateStatus(SystemParamsDto systemParamsDto) throws SystemServiceException;

	/**
	 * 根据参数code获取参数
	 * @param paramsCode
	 * @return MsgBean
	 */
	public SystemParamsDto getSystemParamByParamsCode(SystemParamsDto systemParamsDto);

	/**
	 * @Description TODO(修改系统参数)
	 * @param systemParamsDto
	 * @return MsgBean
	 */
	public void updateSystemParamValue(SystemParamsDto systemParamsDto);

}
