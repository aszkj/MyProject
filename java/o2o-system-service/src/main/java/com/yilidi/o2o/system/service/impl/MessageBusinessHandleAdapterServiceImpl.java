package com.yilidi.o2o.system.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.service.BaseService;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.system.jms.handler.YiLiDiMessageHandler;
import com.yilidi.o2o.system.proxy.crossdomain.model.SaveSysLogRollbackMsgModel;
import com.yilidi.o2o.system.proxy.crossdomain.model.UpdateSysParamRollbackMsgModel;
import com.yilidi.o2o.system.proxy.dto.SystemParamsProxyDto;
import com.yilidi.o2o.system.service.IMessageBusinessHandleAdapterService;
import com.yilidi.o2o.system.service.ISystemLogService;
import com.yilidi.o2o.system.service.ISystemParamsService;
import com.yilidi.o2o.system.service.dto.SystemParamsDto;

/**
 * 回滚子事务服务实现类
 * 
 * @author chenl
 * 
 */
@Service("messageBusinessHandleAdapterService")
public class MessageBusinessHandleAdapterServiceImpl extends BaseService implements IMessageBusinessHandleAdapterService {

	@Autowired
	private ISystemLogService systemLogService;

	@Autowired
	private ISystemParamsService systemParamsService;

	@Autowired
	private YiLiDiMessageHandler yilidiMessageHandler;

	@Override
	public void rollbackSaveSysLog(SaveSysLogRollbackMsgModel saveSysLogRollbackMsgModel) throws SystemServiceException {
		try {
			systemLogService.deleteLogById(saveSysLogRollbackMsgModel.getLogId());
			yilidiMessageHandler.handleSuccess(saveSysLogRollbackMsgModel);
		} catch (Exception e) {
			logger.info(e.getMessage());
			throw new SystemServiceException("回滚保存系统日志子事务异常：" + e.getMessage(), e);
		}
	}

	@Override
	public void rollbackUpdateSysParam(UpdateSysParamRollbackMsgModel updateSysParamRollbackMsgModel)
			throws SystemServiceException {
		try {
			SystemParamsProxyDto systemParamsProxyDto = updateSysParamRollbackMsgModel.getSystemParamsProxyDto();
			SystemParamsDto systemParamsDto = new SystemParamsDto();
			ObjectUtils.fastCopy(systemParamsProxyDto, systemParamsDto);
			systemParamsService.update(systemParamsDto);
			yilidiMessageHandler.handleSuccess(updateSysParamRollbackMsgModel);
		} catch (Exception e) {
			logger.info(e.getMessage());
			throw new SystemServiceException("回滚修改系统参数子事务异常：" + e.getMessage(), e);
		}
	}

}
