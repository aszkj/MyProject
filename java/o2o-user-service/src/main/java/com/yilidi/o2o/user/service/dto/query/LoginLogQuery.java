/**
 * 文件名称：LoginLogQuery.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.user.service.dto.query;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 功能描述：登陆日志查询条件封装类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class LoginLogQuery extends BaseQuery {

	private static final long serialVersionUID = -3600895097027838868L;

	/**
	 * 查询登录开始时间
	 */
	private String startLoginTime;
	/**
	 * 查询登录结束时间
	 */
	private String endLoginTime;

	/**
	 * 查询登录渠道
	 */
	private String channelCode;
	/**
	 * 查询登录用户Id
	 */
	private Integer userId;

	/**
	 * 查询用户名
	 */
	private String userName;
	/**
	 * 查询客户类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=CUSTOMERTYPE)
	 */
	private String customerType;

	/**
	 * 查询登录Ip
	 */
	private String loginIP;

	public String getStartLoginTime() {
		return startLoginTime;
	}

	public void setStartLoginTime(String startLoginTime) {
		this.startLoginTime = startLoginTime;
	}

	public String getEndLoginTime() {
		return endLoginTime;
	}

	public void setEndLoginTime(String endLoginTime) {
		this.endLoginTime = endLoginTime;
	}

	public String getChannelCode() {
		return channelCode;
	}

	public void setChannelCode(String channelCode) {
		this.channelCode = channelCode;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getCustomerType() {
		return customerType;
	}

	public void setCustomerType(String customerType) {
		this.customerType = customerType;
	}

	public String getLoginIP() {
		return loginIP;
	}

	public void setLoginIP(String loginIP) {
		this.loginIP = loginIP;
	}
}
