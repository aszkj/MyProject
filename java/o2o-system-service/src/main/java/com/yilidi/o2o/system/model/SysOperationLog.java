package com.yilidi.o2o.system.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：系统日志记录实体类，映射表 YiLiDiSystemCenter.S_SYSTEM_OPERATION_LOG <br/>
 * 作者：chenl <br/>
 * 
 * BugID:  <br/>
 * 修改内容： <br/>
 */
public class SysOperationLog extends BaseModel {
	private static final long serialVersionUID = 5158175843342405464L;

	/**
	 * 日志ID
	 */
    private Integer logId;
    
	/**
	 * 用户ID
	 */
	private Integer userId;

    /**
     * 操作的用户名
     */
    private String userName;
    /**
     * 操作模块
     */
    private String moduel;

    /**
     * 请求的url
     */
    private String requestUrl;

    /**
     * 请求方法，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SYSLOGREQUESTMETHOD)
     */
    private String requestMethod;

    /**
     * 请求用户的IP地址
     */
    private String remoteIp;

    /**
     * 用户代理
     */
    private String userAgent;

    /**
     * 该请求耗时，单位毫秒
     */
    private Integer costTime;

    /**
     * 请求时间
     */
    private Date createTime;
    
    /**
     * 请求参数
     */
    private String requestParams;

    /**
     * 异常信息
     */
    private String exceptionMsg;
    
    /**
     * 日志类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SYSLOGTYPE)
     */
    private String logType;

	public Integer getLogId() {
		return logId;
	}

	public void setLogId(Integer logId) {
		this.logId = logId;
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

	public String getModuel() {
		return moduel;
	}

	public void setModuel(String moduel) {
		this.moduel = moduel;
	}

	public String getRequestUrl() {
		return requestUrl;
	}

	public void setRequestUrl(String requestUrl) {
		this.requestUrl = requestUrl;
	}

	public String getRequestMethod() {
		return requestMethod;
	}

	public void setRequestMethod(String requestMethod) {
		this.requestMethod = requestMethod;
	}

	public String getRemoteIp() {
		return remoteIp;
	}

	public void setRemoteIp(String remoteIp) {
		this.remoteIp = remoteIp;
	}

	public String getUserAgent() {
		return userAgent;
	}

	public void setUserAgent(String userAgent) {
		this.userAgent = userAgent;
	}

	public Integer getCostTime() {
		return costTime;
	}

	public void setCostTime(Integer costTime) {
		this.costTime = costTime;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getRequestParams() {
		return requestParams;
	}

	public void setRequestParams(String requestParams) {
		this.requestParams = requestParams;
	}

	public String getExceptionMsg() {
		return exceptionMsg;
	}

	public void setExceptionMsg(String exceptionMsg) {
		this.exceptionMsg = exceptionMsg;
	}
	
	public String getLogType() {
		return logType;
	}

	public void setLogType(String logType) {
		this.logType = logType;
	}

}