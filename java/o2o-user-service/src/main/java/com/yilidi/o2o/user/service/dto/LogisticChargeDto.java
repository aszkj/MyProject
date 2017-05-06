/**
 * 文件名称：LogisticChargeDto.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.user.service.dto;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：<简单描述> <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class LogisticChargeDto extends BaseDto {
	private static final long serialVersionUID = -2184893739375023003L;
	/**
	 * 首量，单位件或克
	 */
	private Integer firstCount;
	/**
	 * 首费，单位厘
	 */
	private Long firstFee;
	/**
	 * 增量， 单位为件或克
	 */
	private Integer addCount;
	/**
	 * 增费，单位厘
	 */
	private Long addFee;

	public Integer getFirstCount() {
		return firstCount;
	}

	public void setFirstCount(Integer firstCount) {
		this.firstCount = firstCount;
	}

	public Long getFirstFee() {
		return firstFee;
	}

	public void setFirstFee(Long firstFee) {
		this.firstFee = firstFee;
	}

	public Integer getAddCount() {
		return addCount;
	}

	public void setAddCount(Integer addCount) {
		this.addCount = addCount;
	}

	public Long getAddFee() {
		return addFee;
	}

	public void setAddFee(Long addFee) {
		this.addFee = addFee;
	}

}
