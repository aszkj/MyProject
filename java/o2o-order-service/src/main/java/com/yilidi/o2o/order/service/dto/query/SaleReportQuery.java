/**
 * 文件名称：SaleDailyQuery.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service.dto.query;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 功能描述：每日销售统计查询条件封装实体类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleReportQuery extends BaseQuery {
	private static final long serialVersionUID = -1264452391391061417L;

	/**
	 * 供应商id
	 */
	private Integer providerId;
	/**
	 * 商品类别编码
	 */
	private String productClassCode;
	/**
	 * 型号编码
	 */
	private String modelCode;
	/**
	 * 品牌编码
	 */
	private String brandCode;

	/**
	 * 查询开始时间
	 */
	private Date startDate;
	/**
	 * 查询结束时间
	 */
	private Date endDate;

	public Integer getProviderId() {
		return providerId;
	}

	public void setProviderId(Integer providerId) {
		this.providerId = providerId;
	}

	public String getProductClassCode() {
		return productClassCode;
	}

	public void setProductClassCode(String productClassCode) {
		this.productClassCode = productClassCode;
	}

	public String getModelCode() {
		return modelCode;
	}

	public void setModelCode(String modelCode) {
		this.modelCode = modelCode;
	}

	public String getBrandCode() {
		return brandCode;
	}

	public void setBrandCode(String brandCode) {
		this.brandCode = brandCode;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

}
