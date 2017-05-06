package com.yilidi.o2o.system.proxy.crossdomain.model;

import com.yilidi.o2o.core.model.JmsMessageModel;

/**
 * 保存系统日志回滚消息Model(供测试跨域事务功能使用，功能OK后应删除)
 * 
 * @author chenl
 * 
 */
public class SaveSysLogRollbackMsgModel extends JmsMessageModel {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = -8459956545614491817L;

	/**
	 * 系统日志ID
	 */
	private Integer logId;

	public Integer getLogId() {
		return logId;
	}

	public void setLogId(Integer logId) {
		this.logId = logId;
	}

}
