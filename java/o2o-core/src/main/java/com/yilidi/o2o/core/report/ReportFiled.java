package com.yilidi.o2o.core.report;

import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.paramvalidate.state.IParamType;

/**
 * 
 * @Description:TODO(报表字段)
 * @author: chenlian
 * @date: 2015年11月21日 下午6:00:56
 * 
 */
public class ReportFiled extends Param {

	private Integer sheetNum;

	private Integer rowNum;

	public ReportFiled(Integer sheetNum, Integer rowNum, String name, Object value) {
		super();
		this.sheetNum = sheetNum;
		this.rowNum = rowNum;
		this.name = name;
		this.value = value;
	}

	public ReportFiled paramType(IParamType val) {
		this.paramType = val;
		return this;
	}

	public ReportFiled isAllowEmpty(Boolean val) {
		this.isAllowEmpty = val;
		return this;
	}

	public ReportFiled minLength(Integer val) {
		this.minLength = val;
		return this;
	}

	public ReportFiled maxLength(Integer val) {
		this.maxLength = val;
		return this;
	}

	public ReportFiled minValue(Long val) {
		this.minValue = val;
		return this;
	}

	public ReportFiled maxValue(Long val) {
		this.maxValue = val;
		return this;
	}

	public ReportFiled regex(String val) {
		this.regex = val;
		return this;
	}

	public Integer getSheetNum() {
		return sheetNum;
	}

	public void setSheetNum(Integer sheetNum) {
		this.sheetNum = sheetNum;
	}

	public Integer getRowNum() {
		return rowNum;
	}

	public void setRowNum(Integer rowNum) {
		this.rowNum = rowNum;
	}

}
