/**
 * 文件名称：StoreQuery.java
 * 
 * 描述：
 * 
 * 修改
 */
package com.yilidi.o2o.user.service.dto.query;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 
 * 小区管理查询条件封装类
 * 
 * @author: heyong
 * @date: 2015年11月10日 下午6:08:32
 * 
 */
public class CommunityStoreRelatedQuery extends BaseQuery {

	private static final long serialVersionUID = 4948455583439603920L;

	/**
	 * 小区ID
	 */
	private Integer communityId;
	/**
	 * 小区名称
	 */
	private String communityName;

	/**
	 * 市编码
	 */
	private String cityCode;

	/**
	 * 区县编码
	 */
	private String countyCode;

	/**
	 * 店铺状态： （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STORESTATUS的内容）
	 */
	private String storeStatus;

	/**
	 * 门店名称
	 */
	private String storeName;

	/**
	 * 店铺编号
	 */
	private String storeCode;
	
	/**
	 * 产品id
	 */
	private Integer productId;
	/**
	 * storeIds
	 */
	private List<Integer> storeIds;
	/**
	 * 用户账号
	 */
	private String userName;

	/**
	 * 手机号码
	 */
	private String mobile;

	/**
	 * 当前时间> 正在营业的时间
	 */
	private Date currentOpenDate;
	/**
	 * 当前时间> 暂停营业的时间
	 */
	private Date currentCloseDate;

	/**
	 * 查询 是否 正在营业，open 正在营业，spam 暂停营业
	 */
	private String businessType;

	/**
	 * 店铺类型： 微仓、合伙人、体验店（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STORETYPE的内容）
	 */
	private String storeType;
	
	/**
     * 排除的店铺类型
     */
    private String excludeStoreType;

    public List<Integer> getStoreIds() {
		return storeIds;
	}

	public void setStoreIds(List<Integer> storeIds) {
		this.storeIds = storeIds;
	}
	
	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public Integer getCommunityId() {
		return communityId;
	}

	public void setCommunityId(Integer communityId) {
		this.communityId = communityId;
	}

	public String getCommunityName() {
		return communityName;
	}

	public void setCommunityName(String communityName) {
		this.communityName = communityName;
	}

	public String getCityCode() {
		return cityCode;
	}

	public void setCityCode(String cityCode) {
		this.cityCode = cityCode;
	}

	public String getCountyCode() {
		return countyCode;
	}

	public void setCountyCode(String countyCode) {
		this.countyCode = countyCode;
	}

	public String getStoreStatus() {
		return storeStatus;
	}

	public void setStoreStatus(String storeStatus) {
		this.storeStatus = storeStatus;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getStoreCode() {
		return storeCode;
	}

	public void setStoreCode(String storeCode) {
		this.storeCode = storeCode;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public Date getCurrentOpenDate() {
		return currentOpenDate;
	}

	public void setCurrentOpenDate(Date currentOpenDate) {
		this.currentOpenDate = currentOpenDate;
	}

	public Date getCurrentCloseDate() {
		return currentCloseDate;
	}

	public void setCurrentCloseDate(Date currentCloseDate) {
		this.currentCloseDate = currentCloseDate;
	}

	public String getBusinessType() {
		return businessType;
	}

	public void setBusinessType(String businessType) {
		this.businessType = businessType;
	}

	public String getStoreType() {
		return storeType;
	}

	public void setStoreType(String storeType) {
		this.storeType = storeType;
	}

    public String getExcludeStoreType() {
        return excludeStoreType;
    }

    public void setExcludeStoreType(String excludeStoreType) {
        this.excludeStoreType = excludeStoreType;
    }

}
