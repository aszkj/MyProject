package com.yilidi.o2o.system.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 
 * @Description:TODO(系统参数历史DTO)
 * @author: chenlian
 * @date: 2015年11月16日 上午11:16:02
 * 
 */
public class SystemParamsHistoryDto extends BaseDto {

	private static final long serialVersionUID = -7210716428126208072L;

	/**
	 * id, 自增主键
	 */
	private Integer id;
	/**
	 * 参数ID
	 */
	private Integer paramsId;
	/**
	 * 参数编码
	 */
	private String paramsCode;
	/**
	 * 参数名称
	 */
	private String paramName;
	/**
	 * 参数值
	 */
	private String paramValue;
	/**
	 * 参数状态
	 */
	private String paramStatus;
	/**
	 * 操作时间
	 */
	private Date operateTime;
	/**
	 * 操作用户id
	 */
	private Integer operateUserId;
	/**
	 * 操作类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SYSPARAMOPERTYPE)
	 */
	private String operateType;
	/**
	 * 备注
	 */
	private String note;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getParamsId() {
		return paramsId;
	}

	public void setParamsId(Integer paramsId) {
		this.paramsId = paramsId;
	}

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

	public String getParamValue() {
		return paramValue;
	}

	public void setParamValue(String paramValue) {
		this.paramValue = paramValue;
	}

	public String getParamStatus() {
		return paramStatus;
	}

	public void setParamStatus(String paramStatus) {
		this.paramStatus = paramStatus;
	}

	public Date getOperateTime() {
		return operateTime;
	}

	public void setOperateTime(Date operateTime) {
		this.operateTime = operateTime;
	}

	public Integer getOperateUserId() {
		return operateUserId;
	}

	public void setOperateUserId(Integer operateUserId) {
		this.operateUserId = operateUserId;
	}

	public String getOperateType() {
		return operateType;
	}

	public void setOperateType(String operateType) {
		this.operateType = operateType;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

}
