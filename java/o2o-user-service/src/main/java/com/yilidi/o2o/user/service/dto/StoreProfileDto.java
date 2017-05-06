package com.yilidi.o2o.user.service.dto;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 
 * 店铺信息
 * 
 * @author: heyong
 * @date: 2015年11月11日 上午11:14:12
 * 
 */
public class StoreProfileDto extends BaseDto {

    private static final long serialVersionUID = 8409921404363651742L;

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
     * 全地址
     */
    private String fullAddress;

    /**
     * 店铺状态： （对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STORESTATUS的内容）
     */
    private String storeStatus;

    /**
     * 已选择小区的ID列表
     */
    private List<Integer> communityIds;

    /**
     * 已选择小区的名称列表
     */
    private List<String> communityNames;

    /**
     * 选择小区的id,以,逗号隔开相连
     */
    private String communityIdString;

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
     * 店铺类型： 合伙人、微仓（对应系统域系统字典S_SYETEM_DICT表的DICTTYPE=STORETYPE的内容）
     */
    private String storeType;
    /**
     * 共享是否库存
     */
    private String stockShare;

    /** 小区信息 **/
    private CommunityDto communityDto;

    /**
     * 修改人ID
     */
    private Integer modifyUserId;

    /**
     * 修改时间
     */
    private Date modifyDate;
    /**
     * 店铺评论得分
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

    public Long getAddSendingPrice() {
        return addSendingPrice;
    }

    public void setAddSendingPrice(Long addSendingPrice) {
        this.addSendingPrice = addSendingPrice;
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

    public String getFullAddress() {
        return fullAddress;
    }

    public void setFullAddress(String fullAddress) {
        this.fullAddress = fullAddress;
    }

    public String getStoreStatus() {
        return storeStatus;
    }

    public void setStoreStatus(String storeStatus) {
        this.storeStatus = storeStatus;
    }

    public List<Integer> getCommunityIds() {
        return communityIds;
    }

    public void setCommunityIds(List<Integer> communityIds) {
        this.communityIds = communityIds;
    }

    public List<String> getCommunityNames() {
        return communityNames;
    }

    public void setCommunityNames(List<String> communityNames) {
        this.communityNames = communityNames;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCommunityIdString() {
        return communityIdString;
    }

    public void setCommunityIdString(String communityIdString) {
        this.communityIdString = communityIdString;
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

    public Long getStartSendingPrice() {
        return startSendingPrice;
    }

    public void setStartSendingPrice(Long startSendingPrice) {
        this.startSendingPrice = startSendingPrice;
    }

    public String getStoreType() {
        return storeType;
    }

    public void setStoreType(String storeType) {
        this.storeType = storeType;
    }

    public CommunityDto getCommunityDto() {
        return communityDto;
    }

    public void setCommunityDto(CommunityDto communityDto) {
        this.communityDto = communityDto;
    }

    public Integer getModifyUserId() {
        return modifyUserId;
    }

    public void setModifyUserId(Integer modifyUserId) {
        this.modifyUserId = modifyUserId;
    }

    public Date getModifyDate() {
        return modifyDate;
    }

    public void setModifyDate(Date modifyDate) {
        this.modifyDate = modifyDate;
    }

    public String getStockShare() {
        return stockShare;
    }

    public void setStockShare(String stockShare) {
        this.stockShare = stockShare;
    }

}
