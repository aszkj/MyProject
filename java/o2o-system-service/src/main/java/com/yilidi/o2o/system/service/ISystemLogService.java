/**
 * 文件名称：ISystemLogService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.system.service;

import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.system.service.dto.SystemLogDto;

/**
 * 功能描述：系统日志服务类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ISystemLogService {

	/**
	 * 保存系统日志
	 * 
	 * @param sysLog
	 *            系统日志对象
	 * @throws SystemServiceException
	 *             系统服务异常
	 * @return 日志id
	 */
	public Integer saveLog(SystemLogDto sysLog) throws SystemServiceException;

	/**
	 * 根据系统日志ID删除日志信息
	 * 
	 * @param logId
	 * @throws SystemServiceException
	 */
	public void deleteLogById(Integer logId) throws SystemServiceException;
}
