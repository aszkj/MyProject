package com.yilidi.o2o.user.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 
 * 第三方用户信息DTO
 * 
 * @author: chenb
 * @date: 2015年11月4日 下午5:10:17
 * 
 */
public class ConnectUserDto extends BaseDto {

    private static final long serialVersionUID = -4768729304238715129L;
    /**
     * 用户ID，自增主键
     */
    private Integer id;
    /**
     * 调用第三方返回的openid
     */
    private String openId;
    /**
     * 用户统一标识,微信多个app应用同一用户的唯一
     */
    private String unionId;
    /**
     * 用户ID
     */
    private Integer userId;
    /**
     * 用户昵称
     */
    private String nickName;
    /**
     * 用户性别,1-男;2-女
     */
    private Integer gender;
    /**
     * 用户头像地址
     */
    private String headImgUrl;

    /**
     * 第三方接入类型
     */
    private String connectType;
    /**
     * 创建记录时间
     */
    private Date createTime;
    /**
     * 最后操作时间
     */
    private Date modifyTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getOpenId() {
        return openId;
    }

    public void setOpenId(String openId) {
        this.openId = openId;
    }

    public String getUnionId() {
        return unionId;
    }

    public void setUnionId(String unionId) {
        this.unionId = unionId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public Integer getGender() {
        return gender;
    }

    public void setGender(Integer gender) {
        this.gender = gender;
    }

    public String getHeadImgUrl() {
        return headImgUrl;
    }

    public void setHeadImgUrl(String headImgUrl) {
        this.headImgUrl = headImgUrl;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    public String getConnectType() {
        return connectType;
    }

    public void setConnectType(String connectType) {
        this.connectType = connectType;
    }

}
