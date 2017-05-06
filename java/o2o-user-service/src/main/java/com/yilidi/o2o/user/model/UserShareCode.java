/**
 * 文件名称：User.java
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
 * 功能描述：用户分享码表 实体类，映射数据库表 YiLiDiUserCenter.U_USER_SHARECODE <br/>
 * 作者： chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class UserShareCode extends BaseModel {

    private static final long serialVersionUID = 6920920568021594803L;
    /**
     * 表主键,自增
     */
    private Integer id;
    /**
     * 用户分享码,一个用户只能有一个分享码
     */
    private String shareCode;
    /**
     * 分享用户ID
     */
    private Integer shareUserId;
    /**
     * 二维码图片地址
     */
    private String qrCodeUrl;

    /**
     * 创建记录用户ID
     */
    private Integer createUserId;
    /**
     * 记录创建时间
     */
    private Date createTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getShareCode() {
        return shareCode;
    }

    public void setShareCode(String shareCode) {
        this.shareCode = shareCode;
    }

    public String getQrCodeUrl() {
        return qrCodeUrl;
    }

    public void setQrCodeUrl(String qrCodeUrl) {
        this.qrCodeUrl = qrCodeUrl;
    }

    public Integer getShareUserId() {
        return shareUserId;
    }

    public void setShareUserId(Integer shareUserId) {
        this.shareUserId = shareUserId;
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

}