/**
 * 文件名称：UserProfile.java
 * 
 * 文件描述：
 * 
 *
 * 修改内容：<content>
 */
package com.yilidi.o2o.user.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：用户属性 实体类，映射数据库表 YiLiDiUserCenter.U_USER_BRANCH <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class UserProfile extends BaseModel {

    private static final long serialVersionUID = -6764772039833458287L;

    /**
     * 用户属性Id,自增主键
     */
    private Integer id;

    /**
     * 用户ID, 关联用户域表U_USER的USERID字段，标识该属性是那个用户的属性
     */
    private Integer userId;

    /**
     * 身份证号码
     */
    private String idCardNo;

    /**
     * 省份编码， 关联系统域表S_AREADICT中的AREACODE字段
     */
    private String provinceCode;

    /**
     * 市编码， 关联系统域表S_AREADICT中的AREACODE字段
     */
    private String cityCode;

    /**
     * 区县编码， 关联系统域表S_AREADICT中的AREACODE字段
     */
    private String countyCode;

    /**
     * 乡/镇编码， 关联系统域表S_AREADICT中的AREACODE字段
     */
    private String townCode;

    /**
     * 详细地址
     */
    private String addressDetail;

    /**
     * 用户照片URL（头像）
     */
    private String userImageUrl;

    /**
     * QQ
     */
    private String imQq;
    /**
     * 用户昵称
     */
    private String nickName;
    /**
     * 用户性别，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=USERGENDER)
     */
    private String gender;
    /**
     * 出生日期
     */
    private Date birthday;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getIdCardNo() {
        return idCardNo;
    }

    public void setIdCardNo(String idCardNo) {
        this.idCardNo = idCardNo;
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

    public String getUserImageUrl() {
        return userImageUrl;
    }

    public void setUserImageUrl(String userImageUrl) {
        this.userImageUrl = userImageUrl;
    }

    public String getImQq() {
        return imQq;
    }

    public void setImQq(String imQq) {
        this.imQq = imQq;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

}