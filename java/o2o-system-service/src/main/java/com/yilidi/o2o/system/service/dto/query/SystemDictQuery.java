package com.yilidi.o2o.system.service.dto.query;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 
 * @Description:TODO(系统字典查询实体)
 * @author: chenlian
 * @date: 2015年12月2日 下午2:43:56
 * 
 */
public class SystemDictQuery extends BaseQuery {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 2605190084866711440L;

	/**
	 * 字典名称
	 */
	private String dictName;

	/**
	 * 字典编码
	 */
	private String dictCode;

	/**
	 * 字典类型
	 */
	private String dictType;

	/**
	 * 字典类型名称
	 */
	private String typeName;

	/**
	 * 系统字典状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SYSDICTSTATUS) SYSDICTSTATUS_ON：启用 SYSDICTSTATUS_OFF：禁用
	 */
	private String dictStatus;

	public String getDictName() {
		return dictName;
	}

	public void setDictName(String dictName) {
		this.dictName = dictName;
	}

	public String getDictCode() {
		return dictCode;
	}

	public void setDictCode(String dictCode) {
		this.dictCode = dictCode;
	}

	public String getDictType() {
		return dictType;
	}

	public void setDictType(String dictType) {
		this.dictType = dictType;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public String getDictStatus() {
		return dictStatus;
	}

	public void setDictStatus(String dictStatus) {
		this.dictStatus = dictStatus;
	}

}
