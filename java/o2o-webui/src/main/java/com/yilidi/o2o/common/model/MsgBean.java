package com.yilidi.o2o.common.model;

/**
 * 
 * @Description:TODO( 传到前端数据统一封装类)
 * @author: chenlian
 * @date: 2015年10月26日 下午2:28:12
 * 
 */
public class MsgBean {
	private MsgCode msgCode;
	private String msg;
	private Object entity;
	private String failureCode;

	private String statusCode;

	public int getMsgCode() {
		switch (msgCode) {
		case NOTIPS:
			return 0;
		case SUCCESS:
			return 1;// 成功
		case FAILURE:
			return 2; // 失败
		case LOGIN_EXCEPTION:
			return 3;// 登录异常
		case DENY_ACCESS:
			return 4;// 访问受限

		default:
			return 0;
		}
	}

	public MsgBean setMsgCode(MsgCode msgCode) {
		this.msgCode = msgCode;
		return this;
	}

	public String getMsg() {
		if (this.msgCode == MsgCode.NOTIPS)
			msg = "";
		return msg;
	}

	public MsgBean setMsg(String msg) {
		this.msg = msg;
		return this;
	}

	public enum MsgCode {
		NOTIPS, SUCCESS, FAILURE, LOGIN_EXCEPTION, DENY_ACCESS;
	}

	public Object getEntity() {
		return entity;
	}

	public MsgBean setEntity(Object entity) {
		this.entity = entity;
		return this;
	}

	public static MsgBean getInstance() {
		return new MsgBean();
	}

	public String getFailureCode() {
		return failureCode;
	}

	public void setFailureCode(String failureCode) {
		this.failureCode = failureCode;
	}

	public String getStatusCode() {
		if (statusCode == null) {
			if (msgCode.equals(MsgBean.MsgCode.SUCCESS)) {
				statusCode = "200";
			} else if (msgCode.equals(MsgBean.MsgCode.FAILURE)) {
				statusCode = "300";
			} else if (msgCode.equals(MsgBean.MsgCode.LOGIN_EXCEPTION)) {
				statusCode = "301";
			}

		}
		return statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}

}
