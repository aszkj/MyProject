package com.yilidi.o2o.core.paramvalidate;

/**
 * 参数验证返回信息Bean
 * 
 * @author chenl
 * 
 */
public class ParamValidateMessageBean {

	private MsgCode msgCode;

	private String msg;

	public enum MsgCode {
		SUCCESS(1), FAILURE(2);

		private MsgCode(Integer value) {
			this.value = value;
		}

		private Integer value;

		public Integer getValue() {
			return value;
		}

		public void setValue(Integer value) {
			this.value = value;
		}

	}

	public int getMsgCode() {
		switch (msgCode) {
		case SUCCESS:
			return 1;// 成功
		case FAILURE:
			return 2; // 失败
		default:
			return 1;
		}
	}

	public void setMsgCode(MsgCode msgCode) {
		this.msgCode = msgCode;
	}

	public String getMsg() {
		return msg;
	}

	public ParamValidateMessageBean setMsg(String msg) {
		this.msg = msg;
		return this;
	}

}
