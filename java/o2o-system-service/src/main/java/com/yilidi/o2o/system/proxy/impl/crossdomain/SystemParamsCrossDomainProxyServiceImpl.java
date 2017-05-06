package com.yilidi.o2o.system.proxy.impl.crossdomain;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.core.service.BaseService;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.system.dao.SystemParamsMapper;
import com.yilidi.o2o.system.model.SystemParams;
import com.yilidi.o2o.system.proxy.crossdomain.ISystemParamsCrossDomainProxyService;
import com.yilidi.o2o.system.proxy.crossdomain.model.UpdateSysParamRollbackMsgModel;
import com.yilidi.o2o.system.proxy.dto.SystemParamsProxyDto;

@Service("systemParamsCrossDomainProxyService")
public class SystemParamsCrossDomainProxyServiceImpl extends BaseService implements ISystemParamsCrossDomainProxyService {

	@Autowired
	private SystemParamsMapper systemParamsMapper;

	@Override
	public JmsMessageModel updateSystemParam(SystemParamsProxyDto systemParamsProxyDto) throws SystemServiceException {
		try {
			SystemParams systemParams = systemParamsMapper.loadById(systemParamsProxyDto.getParamsId());

			SystemParamsProxyDto proxyDto = new SystemParamsProxyDto();
			ObjectUtils.fastCopy(systemParams, proxyDto);
			proxyDto.setParamsId(systemParamsProxyDto.getParamsId());

			if (!StringUtils.isEmpty(systemParamsProxyDto.getParamValue())) {
				systemParams.setParamValue(systemParamsProxyDto.getParamValue());
			}
			if (!StringUtils.isEmpty(systemParamsProxyDto.getNote())) {
				systemParams.setNote(systemParamsProxyDto.getNote());
			}
			if (null != systemParamsProxyDto.getModifyTime()) {
				systemParams.setModifyTime(systemParamsProxyDto.getModifyTime());
			}
			if (null != systemParamsProxyDto.getModifyUserId()) {
				systemParams.setModifyUserId(systemParamsProxyDto.getModifyUserId());
			}
			systemParamsMapper.updateById(systemParams);
			UpdateSysParamRollbackMsgModel updateSysParamRollbackMsgModel = new UpdateSysParamRollbackMsgModel();
			updateSysParamRollbackMsgModel.setSystemParamsProxyDto(proxyDto);
			updateSysParamRollbackMsgModel.setMessageName("更新系统参数回滚消息");
			updateSysParamRollbackMsgModel.setMaxRetryThreshold(20);
			updateSysParamRollbackMsgModel.setIntervalTime(10);
			return updateSysParamRollbackMsgModel;
		} catch (Exception e) {
			logger.error("updateSystemParam异常", e);
			throw new SystemServiceException(e.getMessage());
		}
	}

}
