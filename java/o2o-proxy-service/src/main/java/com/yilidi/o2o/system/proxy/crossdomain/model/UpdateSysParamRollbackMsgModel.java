package com.yilidi.o2o.system.proxy.crossdomain.model;

import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.system.proxy.dto.SystemParamsProxyDto;

/**
 * 修改系统参数回滚消息Model(供测试跨域事务功能使用，功能OK后应删除)
 * 
 * @author chenl
 * 
 */
public class UpdateSysParamRollbackMsgModel extends JmsMessageModel {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = -8459956545614491817L;

	/**
	 * 系统系统参数代理Dto
	 */
	private SystemParamsProxyDto systemParamsProxyDto;

	public SystemParamsProxyDto getSystemParamsProxyDto() {
		return systemParamsProxyDto;
	}

	public void setSystemParamsProxyDto(SystemParamsProxyDto systemParamsProxyDto) {
		this.systemParamsProxyDto = systemParamsProxyDto;
	}

}
