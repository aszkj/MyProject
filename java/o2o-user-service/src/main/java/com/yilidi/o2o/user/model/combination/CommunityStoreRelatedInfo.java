/**
 * 文件名称：CustomerRelatedInfo.java
 * 
 * 文件描述：
 * 
 *
 * 修改内容：<content>
 */
package com.yilidi.o2o.user.model.combination;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 将小区门店关联相关信息进行组合封装，供Mybatis使用
 * 
 * @author: heyong
 * @date: 2015年11月11日 下午3:34:25
 * 
 */
public class CommunityStoreRelatedInfo extends BaseModel {
    private static final long serialVersionUID = -2375390338484037100L;

    /**
     * 登录账号 对应 U_STORE_PROFILE的MOBILE
     */
    private String userName;

    /**
     * 店铺编号
     */
    private String storeCode;

    /**
     * 手机号码
     */
    private String mobile;

    /**
     * 店铺名称
     */
    private String storeName;

    /**
     * 联系人
     */
    private String contact;

    /**
     * 省份编码，关联系统域下表S_AREADICT的AREACODE字段
     */
    private String provinceCode;
    /**
     * 市编码，关联系统域下表S_AREADICT的AREACODE字段
     */
    private String cityCode;
    /**
     * 区县编码，关联系统域下表S_AREADICT的AREACODE字段
     */
    private String countyCode;
    /**
     * 店铺详细地址
     */
    private String addressDetail;

    /**
     * 店铺状态： （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STORESTATUS的内容）
     */
    private String storeStatus;

    /**
     * 小区名称
     */
    private String communityName;

    /**
     * 小区ID U_DISTRICT_STORE的communityId
     */
    private Integer communityId;

    /**
     * 门店ID U_DISTRICT_STORE的storeId
     */
    private Integer storeId;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 店铺开始营业时间 只有时分秒
     */
    private String businessHoursBegin;

    /**
     * 店铺结束营业时间 只有时分秒
     */
    private String businessHoursEnd;

    /**
     * U_STORE_PROFILE的id
     */
    private Integer id;

    /**
     * 店铺类型： 实体，商超，社区（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STORETYPE的内容）
     */
    private String storeType;

    /**
     * 邀请码
     */
    private String invitationCode;
    /**
     * 是否共享库存
     */
    private String stockShare;

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getStoreCode() {
        return storeCode;
    }

    public void setStoreCode(String storeCode) {
        this.storeCode = storeCode;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
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

    public String getCountyCode() {
        return countyCode;
    }

    public void setCountyCode(String countyCode) {
        this.countyCode = countyCode;
    }

    public String getAddressDetail() {
        return addressDetail;
    }

    public void setAddressDetail(String addressDetail) {
        this.addressDetail = addressDetail;
    }

    public String getStoreStatus() {
        return storeStatus;
    }

    public void setStoreStatus(String storeStatus) {
        this.storeStatus = storeStatus;
    }

    public String getCommunityName() {
        return communityName;
    }

    public void setCommunityName(String communityName) {
        this.communityName = communityName;
    }

    public Integer getCommunityId() {
        return communityId;
    }

    public void setCommunityId(Integer communityId) {
        this.communityId = communityId;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getBusinessHoursBegin() {
        return businessHoursBegin;
    }

    public void setBusinessHoursBegin(String businessHoursBegin) {
        this.businessHoursBegin = businessHoursBegin;
    }

    public String getBusinessHoursEnd() {
        return businessHoursEnd;
    }

    public void setBusinessHoursEnd(String businessHoursEnd) {
        this.businessHoursEnd = businessHoursEnd;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getStoreType() {
        return storeType;
    }

    public void setStoreType(String storeType) {
        this.storeType = storeType;
    }

    public String getInvitationCode() {
        return invitationCode;
    }

    public void setInvitationCode(String invitationCode) {
        this.invitationCode = invitationCode;
    }

    public String getStockShare() {
        return stockShare;
    }

    public void setStockShare(String stockShare) {
        this.stockShare = stockShare;
    }

}