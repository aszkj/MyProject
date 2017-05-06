package com.yilidi.o2o.appvo.seller.product;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：产品品牌实体类，映射产品域表YiLiDiProductCenter.P_PRODUCT_BRAND <br/>
 * 作者：xiasl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class BrandVO extends BaseModel {
	private static final long serialVersionUID = -6565713514280836459L;
	
	/**
	 * 品牌名称
	 */
	private String brandName;
	/**
	 * 品牌描述
	 */
	private String brandDesc;

	/**
	 * 品牌编码
	 */
	private String brandCode;

	/**
     * 品牌图片URL
     */
    private String brandImageUrl;
	/**
     * 品牌LOGO图片URL
     */
    private String brandLogoImageUrl;

	public String getBrandImageUrl() {
		return brandImageUrl;
	}

	public void setBrandImageUrl(String brandImageUrl) {
		this.brandImageUrl = brandImageUrl;
	}

	public String getBrandLogoImageUrl() {
		return brandLogoImageUrl;
	}

	public void setBrandLogoImageUrl(String brandLogoImageUrl) {
		this.brandLogoImageUrl = brandLogoImageUrl;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public String getBrandDesc() {
		return brandDesc;
	}

	public void setBrandDesc(String brandDesc) {
		this.brandDesc = brandDesc;
	}

	public String getBrandCode() {
		return brandCode;
	}

	public void setBrandCode(String brandCode) {
		this.brandCode = brandCode;
	}
}