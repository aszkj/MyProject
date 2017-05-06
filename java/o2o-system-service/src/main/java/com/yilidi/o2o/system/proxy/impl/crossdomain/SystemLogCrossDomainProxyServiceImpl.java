package com.yilidi.o2o.system.proxy.impl.crossdomain;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.core.service.BaseService;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.system.dao.SysOperationLogMapper;
import com.yilidi.o2o.system.model.SysOperationLog;
import com.yilidi.o2o.system.proxy.crossdomain.ISystemLogCrossDomainProxyService;
import com.yilidi.o2o.system.proxy.crossdomain.model.SaveSysLogRollbackMsgModel;
import com.yilidi.o2o.system.proxy.dto.SystemLogProxyDto;

@Service("systemLogCrossDomainProxyService")
public class SystemLogCrossDomainProxyServiceImpl extends BaseService implements ISystemLogCrossDomainProxyService {

	@Autowired
	private SysOperationLogMapper sysOperationLogMapper;

	@Override
	public JmsMessageModel saveLog(SystemLogProxyDto systemLogProxyDto) throws SystemServiceException {
		try {
			SysOperationLog sysLog = new SysOperationLog();
			ObjectUtils.fastCopy(systemLogProxyDto, sysLog);
			sysOperationLogMapper.save(sysLog);
			Integer logId = sysLog.getLogId();
			SaveSysLogRollbackMsgModel saveSysLogRollbackMsgModel = new SaveSysLogRollbackMsgModel();
			saveSysLogRollbackMsgModel.setLogId(logId);
			return saveSysLogRollbackMsgModel;
		} catch (Exception e) {
			logger.error("saveLog异常", e);
			throw new SystemServiceException(e.getMessage());
		}
	}
}
