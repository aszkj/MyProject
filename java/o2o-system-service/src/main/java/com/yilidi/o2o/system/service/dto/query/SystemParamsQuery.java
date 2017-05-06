package com.yilidi.o2o.system.service.dto.query;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 
 * @Description:TODO(系统参数查询实体)
 * @author: chenlian
 * @date: 2015年12月1日 下午3:21:17
 * 
 */
public class SystemParamsQuery extends BaseQuery {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 2605190084866711440L;

	/**
	 * 参数编码
	 */
	private String paramsCode;

	/**
	 * 参数名称
	 */
	private String paramName;

	/**
	 * 参数状态
	 */
	private String paramStatus;

	public String getParamsCode() {
		return paramsCode;
	}

	public void setParamsCode(String paramsCode) {
		this.paramsCode = paramsCode;
	}

	public String getParamName() {
		return paramName;
	}

	public void setParamName(String paramName) {
		this.paramName = paramName;
	}

	public String getParamStatus() {
		return paramStatus;
	}

	public void setParamStatus(String paramStatus) {
		this.paramStatus = paramStatus;
	}

}
