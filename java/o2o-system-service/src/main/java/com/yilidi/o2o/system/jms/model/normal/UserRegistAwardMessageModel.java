package com.yilidi.o2o.system.jms.model.normal;

import java.util.Date;

import com.yilidi.o2o.core.model.JmsMessageModel;

public class UserRegistAwardMessageModel extends JmsMessageModel {

	private static final long serialVersionUID = 1L;
	/**
	 * 用户id
	 */
	private Integer userId;
	/**
	 * 当前时间
	 */
	private Date nowTime;
	
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public Date getNowTime() {
		return nowTime;
	}
	public void setNowTime(Date nowTime) {
		this.nowTime = nowTime;
	}

}
