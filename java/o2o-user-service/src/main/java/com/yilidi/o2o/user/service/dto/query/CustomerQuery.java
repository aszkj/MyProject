/**
 * 文件名称：CustomerQuery.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.user.service.dto.query;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 功能描述：客户查询条件封装类 <br/>
 * 作者： chenlian <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class CustomerQuery extends BaseQuery {

	private static final long serialVersionUID = 3063107551753400367L;

	private String customerType;

	private String masterFlag;

	private String auditCode;

	private String statusCode;

	public String getCustomerType() {
		return customerType;
	}

	public void setCustomerType(String customerType) {
		this.customerType = customerType;
	}

	public String getMasterFlag() {
		return masterFlag;
	}

	public void setMasterFlag(String masterFlag) {
		this.masterFlag = masterFlag;
	}

	public String getAuditCode() {
		return auditCode;
	}

	public void setAuditCode(String auditCode) {
		this.auditCode = auditCode;
	}

	public String getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}

}
