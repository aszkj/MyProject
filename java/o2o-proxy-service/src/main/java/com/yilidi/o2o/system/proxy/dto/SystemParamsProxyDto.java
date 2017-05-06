/**
 * 文件名称：SystemParamsProxyDto.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.system.proxy.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：<简单描述> <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SystemParamsProxyDto extends BaseDto {

	private static final long serialVersionUID = 1604220299353643889L;

	/**
	 * 参数ID，自增主键
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
	 * 创建时间
	 */
	private Date createTime;

	/**
	 * 创建用户ID
	 */
	private Integer createUserId;

	/**
	 * 修改时间
	 */
	private Date modifyTime;

	/**
	 * 修改用户ID
	 */
	private Integer modifyUserId;

	/**
	 * 备注信息
	 */
	private String note;

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

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Integer getCreateUserId() {
		return createUserId;
	}

	public void setCreateUserId(Integer createUserId) {
		this.createUserId = createUserId;
	}

	public Date getModifyTime() {
		return modifyTime;
	}

	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}

	public Integer getModifyUserId() {
		return modifyUserId;
	}

	public void setModifyUserId(Integer modifyUserId) {
		this.modifyUserId = modifyUserId;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

}
