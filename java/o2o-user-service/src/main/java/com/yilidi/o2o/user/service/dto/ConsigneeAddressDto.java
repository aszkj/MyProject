/**
 * 文件名称：ConsigneeAddressDto.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.user.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：<简单描述> <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class ConsigneeAddressDto extends BaseDto {
    private static final long serialVersionUID = -2184893739375023003L;

    /**
     * 地址id，自增主键
     */
    private Integer addressId;
    /**
     * 客户ID，关联用户域表U_CUSTOMER字段CUSTOMERID，标识该地址属于那个客户
     */
    private Integer customerId;
    /**
     * 省份编码， 关联系统域表S_AREADICT的AREACODE字段
     */
    private String provinceCode;
    /**
     * 市编码， 关联系统域表S_AREADICT的AREACODE字段
     */
    private String cityCode;
    /**
     * 区/县编码， 关联系统域表S_AREADICT的AREACODE字段
     */
    private String countyCode;
    /**
     * 乡/镇编码， 关联系统域表S_AREADICT的AREACODE字段
     */
    private String townCode;
    /**
     * 具体地址信息
     */
    private String addressDetail;
    /**
     * 默认标志, "CONSADDRDEFAULTFLAG_NO" 不是默认的收货地址， “CONSADDRDEFAULTFLAG_YES” 默认收货地址
     */
    private String defaultFlag;
    /**
     * 收货人姓名
     */
    private String consigneeName;
    /**
     * 收货人手机号码
     */
    private String phoneNo;

    /**
     * 小区ID
     */
    private Integer communityId;

    /**
     * 小区名称
     */
    private String communityName;

    /**
     * 创建用户ID
     */
    private Integer createUserId;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 修改用户id
     */
    private Integer modifyUserId;
    /**
     * 修改时间
     */
    private Date modifyTime;
    /**
     * 状态, "CONSADDRSTATUS_OFF"禁用 ，"CONSADDRSTATUS_ON" 启用
     */
    private String status;
    /**
     * 备注信息
     */
    private String note;
    /**
     * 完整收货地址
     */
    private String fullConsigneeAddress;
    /** 店铺信息 **/
    private StoreProfileDto storeProfileDto;

    public Integer getAddressId() {
        return addressId;
    }

    public void setAddressId(Integer addressId) {
        this.addressId = addressId;
    }

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
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

    public String getDefaultFlag() {
        return defaultFlag;
    }

    public void setDefaultFlag(String defaultFlag) {
        this.defaultFlag = defaultFlag;
    }

    public String getConsigneeName() {
        return consigneeName;
    }

    public void setConsigneeName(String consigneeName) {
        this.consigneeName = consigneeName;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
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

    public Integer getModifyUserId() {
        return modifyUserId;
    }

    public void setModifyUserId(Integer modifyUserId) {
        this.modifyUserId = modifyUserId;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getFullConsigneeAddress() {
        return fullConsigneeAddress;
    }

    public void setFullConsigneeAddress(String fullConsigneeAddress) {
        this.fullConsigneeAddress = fullConsigneeAddress;
    }

    public StoreProfileDto getStoreProfileDto() {
        return storeProfileDto;
    }

    public void setStoreProfileDto(StoreProfileDto storeProfileDto) {
        this.storeProfileDto = storeProfileDto;
    }

}
