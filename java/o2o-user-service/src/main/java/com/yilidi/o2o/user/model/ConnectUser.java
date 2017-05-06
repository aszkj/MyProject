/**
 * 文件名称：UserSSL.java
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
 * 功能描述：用户 实体类，映射数据库表 YiLiDiUserCenter.U_CONNECT_USER <br/>
 * 作者： chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class ConnectUser extends BaseModel {

    private static final long serialVersionUID = -7872523982571290145L;

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
     * 修改记录时间
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

    public String getConnectType() {
        return connectType;
    }

    public void setConnectType(String connectType) {
        this.connectType = connectType;
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

}