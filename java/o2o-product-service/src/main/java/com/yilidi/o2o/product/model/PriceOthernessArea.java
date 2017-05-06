package com.yilidi.o2o.product.model;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：价格差异化地区配置实体类，映射到产品域表YiLiDiProductCenter.P_PRICE_OTHERNESS_AREA <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class PriceOthernessArea extends BaseModel {
	private static final long serialVersionUID = -6998449923086778909L;
	/**
	 * ID, 自增主键
	 */
	private Integer id;
	/**
	 * 差异化价格ID， 关联产品域价格定向表P_PRICE_OTHERNESS的PRICEOTHERNESSID字段
	 */
	private Integer othernessPriceId;
	/**
	 * 省份编码， 关联系统域区域字典S_AREA_DICT表的AREACODE字段
	 */
	private String provinceCode;
	/**
	 * 市区编码， 关联系统域区域字典S_AREA_DICT表的AREACODE字段
	 */
	private String cityCode;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getOthernessPriceId() {
		return othernessPriceId;
	}

	public void setOthernessPriceId(Integer othernessPriceId) {
		this.othernessPriceId = othernessPriceId;
	}

	public String getProvinceCode() {
		return provinceCode;
	}

	public void setProvinceCode(String provinceCode) {
		this.provinceCode = provinceCode;
	}

	public String getCityCode() {
		return cityCode;
	}

	public void setCityCode(String cityCode) {
		this.cityCode = cityCode;
	}

}