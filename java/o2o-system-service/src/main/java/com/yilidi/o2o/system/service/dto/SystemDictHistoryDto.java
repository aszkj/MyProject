package com.yilidi.o2o.system.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 
 * @Description:TODO(系统字典历史DTO)
 * @author: chenlian
 * @date: 2015年11月16日 上午11:16:02
 * 
 */
public class SystemDictHistoryDto extends BaseDto {
	private static final long serialVersionUID = -7210716428126208072L;

	/**
	 * 主键ID
	 */
	private Integer id;
	/**
	 * 字典ID
	 */
	private Integer dictId;
	/**
	 * 字典名称
	 */
	private String dictName;
	/**
	 * 字典编码，参考文档《/doc/3-design/系统字典菜单权限定义表.xlsx》中的系统字典页中的字典编码列。
	 */
	private String dictCode;
	/**
	 * 字典类型，参考文档《/doc/3-design/系统字典菜单权限定义表.xlsx》中的系统字典页中的字典类型列。
	 */
	private String dictType;
	/**
	 * 字典类型名称
	 */
	private String typeName;
	/**
	 * 字典描述
	 */
	private String dictDesc;
	/**
	 * 显示顺序
	 */
	private Integer sort;
	/**
	 * 系统字典状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SYSDICTSTATUS) SYSDICTSTATUS_ON：启用 SYSDICTSTATUS_OFF：禁用
	 */
	private String dictStatus;
	/**
	 * 操作时间
	 */
	private Date operateTime;
	/**
	 * 操作用户id
	 */
	private Integer operateUserId;
	/**
	 * 操作类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SYSDICTOPERTYPE)
	 */
	private String operateType;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getDictId() {
		return dictId;
	}

	public void setDictId(Integer dictId) {
		this.dictId = dictId;
	}

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

	public String getDictDesc() {
		return dictDesc;
	}

	public void setDictDesc(String dictDesc) {
		this.dictDesc = dictDesc;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getDictStatus() {
		return dictStatus;
	}

	public void setDictStatus(String dictStatus) {
		this.dictStatus = dictStatus;
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

}
