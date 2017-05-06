package com.yilidi.o2o.product.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 
 * @Description:TODO(店铺商品补贴设置实体类，映射数据库表 YiLiDiUserCenter.U_STORE_PRODUCT_SUBSIDY_SETTING) 
 * @author:	llp
 * @date:	2015年11月10日 上午9:54:10 
 *
 */
public class StoreProductSubsidySetting extends BaseModel {
	/** 
	 * @Fields serialVersionUID : TODO(序列号) 
	 */ 
	private static final long serialVersionUID = 8759297684479723895L;
	
	/**
	 * ID，自增主键
	 */
	private Integer id;

	/**
	 * 门店ID，关联用户域U_CUSTOMER表ID
	 */
	private Integer storeId;
	
	/**
	 * 店铺商品ID, 关联产品域P_SALE_PRODUCT表的ID
	 */
	private Integer saleProductId;

	/**
	 * 创建人
	 */
	private Integer createUserId;

	/**
	 * 创建时间
	 */
	private Date createTime;
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getCreateUserId() {
		return createUserId;
	}

	public void setCreateUserId(Integer createUserId) {
		this.createUserId = createUserId;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	
	public Integer getSaleProductId() {
		return saleProductId;
	}

	public void setSaleProductId(Integer saleProductId) {
		this.saleProductId = saleProductId;
	}

	public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}

}
