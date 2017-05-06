package com.yilidi.o2o.order.model;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：交易评价统计实体类，映射交易域表YiLiDiOrderCenter.T_EVALUATION_STATISTICS <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class EvaluationStatistics extends BaseModel {
	private static final long serialVersionUID = 7030383257682525448L;
	/**
	 * id， 自增主键
	 */
	private Integer id;
	/**
	 * 商品ID
	 */
	private Integer saleProductId;
	/**
	 * 好评统计数
	 */
	private Integer goodCount;
	/**
	 * 中评统计数
	 */
	private Integer normalCount;
	/**
	 * 差评统计数
	 */
	private Integer poorCount;
	/**
	 * 有图统计数
	 */
	private Integer imageCount;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getSaleProductId() {
		return saleProductId;
	}

	public void setSaleProductId(Integer saleProductId) {
		this.saleProductId = saleProductId;
	}

	public Integer getGoodCount() {
		return goodCount;
	}

	public void setGoodCount(Integer goodCount) {
		this.goodCount = goodCount;
	}

	public Integer getNormalCount() {
		return normalCount;
	}

	public void setNormalCount(Integer normalCount) {
		this.normalCount = normalCount;
	}

	public Integer getPoorCount() {
		return poorCount;
	}

	public void setPoorCount(Integer poorCount) {
		this.poorCount = poorCount;
	}

	public Integer getImageCount() {
		return imageCount;
	}

	public void setImageCount(Integer imageCount) {
		this.imageCount = imageCount;
	}
}