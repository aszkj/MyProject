/**
 * 文件名称：SystemLogService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.system.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.service.BaseService;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.system.dao.SysOperationLogMapper;
import com.yilidi.o2o.system.model.SysOperationLog;
import com.yilidi.o2o.system.service.ISystemLogService;
import com.yilidi.o2o.system.service.dto.SystemLogDto;

/**
 * 功能描述：系统日志服务实现类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("systemLogService")
public class SystemLogService extends BaseService implements ISystemLogService {

	@Autowired
	private SysOperationLogMapper sysOperationLogMapper;

	@Override
	public Integer saveLog(SystemLogDto sysLogDto) throws SystemServiceException {

		SysOperationLog sysLog = new SysOperationLog();
		ObjectUtils.fastCopy(sysLogDto, sysLog);

		return sysOperationLogMapper.save(sysLog);
	}

	@Override
	public void deleteLogById(Integer logId) throws SystemServiceException {
		try {
			sysOperationLogMapper.deleteById(logId);
			logger.info("根据ID删除系统日志成功！logId : " + logId);
		} catch (Exception e) {
			logger.error("deleteLogById异常", e);
			throw new SystemServiceException(e.getMessage());
		}
	}

}
