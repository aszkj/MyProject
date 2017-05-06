/**
 * 文件名称：UserProxyDemoDto.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.user.proxy.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：小区代理服务使用DTO定义 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class StoreProfileProxyDto extends BaseDto {

    private static final long serialVersionUID = 1L;
    /**
     * ID，自增主键
     */
    private Integer id;

    /**
     * 店铺ID, 关联用户域U_CUSTOMER表的CUSTOMERID (CUSTOMERTYPE=CUSTOMERTYPE_SELLER)
     */
    private Integer storeId;

    /**
     * 店铺所在经度
     */
    private String longitude;

    /**
     * 店铺所在纬度
     */
    private String latitude;

    /**
     * 店铺开始营业时间
     */
    private String businessHoursBegin;

    /**
     * 店铺结束营业时间
     */
    private String businessHoursEnd;

    /**
     * 店铺图片地址路径
     */
    private String storeImagePath;

    /**
     * 是否配送，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SENDFLAG)
     */
    private String sendFlag;

    /**
     * 配送起步价 单位 厘
     */
    private Long startSendingPrice;

    /**
     * 增加的配送费（默认2元） 单位 厘
     */
    private Long addSendingPrice;

    /**
     * 联系人
     */
    private String contact;

    /**
     * 店铺名称
     */
    private String storeName;

    /**
     * 店铺编号
     */
    private String storeCode;

    /**
     * 手机号码
     */
    private String mobile;

    /**
     * 联系电话
     */
    private String telPhone;

    /**
     * 邮箱
     */
    private String email;
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
     * 乡镇编码，关联系统域下表S_AREADICT的AREACODE字段
     */
    private String townCode;
    /**
     * 详细地址
     */
    private String addressDetail;

    /**
     * 店铺状态： （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STORESTATUS的内容）
     */
    private String storeStatus;

    /**
     * 创建人ID
     */
    private Integer createUserId;

    /**
     * 创建时间
     */
    private Date createDate;
    /**
     * 店铺登录账号： （对应user表的username）
     */
    private String userName;

    /**
     * 店铺类型： 实体，商超，社区（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STORETYPE的内容）
     */
    private String storeType;
    /** 小区名字 **/
    private String communityName;
    /**
     * 是否共享库存
     */
    private String stockShare;
    /**
     * 店铺评分
     */
    private Float storeScore;

    public Float getStoreScore() {
        return storeScore;
    }

    public void setStoreScore(Float storeScore) {
        this.storeScore = storeScore;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
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

    public String getStoreImagePath() {
        return storeImagePath;
    }

    public void setStoreImagePath(String storeImagePath) {
        this.storeImagePath = storeImagePath;
    }

    public String getSendFlag() {
        return sendFlag;
    }

    public void setSendFlag(String sendFlag) {
        this.sendFlag = sendFlag;
    }

    public Long getStartSendingPrice() {
        return startSendingPrice;
    }

    public void setStartSendingPrice(Long startSendingPrice) {
        this.startSendingPrice = startSendingPrice;
    }

    public Long getAddSendingPrice() {
        return addSendingPrice;
    }

    public void setAddSendingPrice(Long addSendingPrice) {
        this.addSendingPrice = addSendingPrice;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
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

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getTelPhone() {
        return telPhone;
    }

    public void setTelPhone(String telPhone) {
        this.telPhone = telPhone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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

    public String getTownCode() {
        return townCode;
    }

    public void setTownCode(String townCode) {
        this.townCode = townCode;
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

    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getStoreType() {
        return storeType;
    }

    public void setStoreType(String storeType) {
        this.storeType = storeType;
    }

    public String getCommunityName() {
        return communityName;
    }

    public void setCommunityName(String communityName) {
        this.communityName = communityName;
    }

    public String getStockShare() {
        return stockShare;
    }

    public void setStockShare(String stockShare) {
        this.stockShare = stockShare;
    }

}
