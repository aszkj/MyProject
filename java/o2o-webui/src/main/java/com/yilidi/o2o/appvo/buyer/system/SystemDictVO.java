package com.yilidi.o2o.appvo.buyer.system;

import java.util.Date;

import com.yilidi.o2o.appvo.AppBaseVO;

public class SystemDictVO extends AppBaseVO {
	private static final long serialVersionUID = 1L;
	
	/**
	 * 字典类型名称
	 */
	private String typeName;
	/**
	 * 字典对应的值
	 */
	private Integer typeValue;

	//时间
	private Date msgTime;
	//简介
	private String msgAbstract;


	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public Integer getTypeValue() {
		return typeValue;
	}

	public void setTypeValue(Integer typeValue) {
		this.typeValue = typeValue;
	}

	public String getMsgAbstract() {
		return msgAbstract;
	}

	public void setMsgAbstract(String msgAbstract) {
		this.msgAbstract = msgAbstract;
	}

	public Date getMsgTime() {
		return msgTime;
	}

	public void setMsgTime(Date msgTime) {
		this.msgTime = msgTime;
	}

}
