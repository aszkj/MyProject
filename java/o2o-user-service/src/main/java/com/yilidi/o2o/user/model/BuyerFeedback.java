package com.yilidi.o2o.user.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

public class BuyerFeedback extends BaseModel {
    /**
     * @Fields serialVersionUID
     */
    private static final long serialVersionUID = 1L;
    /**
     * id
     */
    private Integer id;
    /**
     * 用户id
     */
    private Integer userId;
    /**
     * 用户手机号
     */
    private String userMobile;
    /**
     * 反馈内容
     */
    private String content;
    /**
     * 内容分类
     */
    private String contentClassify;
    /**
     * 提交时间
     */
    private Date submitTime;
    /**
     * 操作状态
     */
    private String operateStatus;
    /**
     * 操作时间
     */
    private Date operateTime;
    /**
     * 操作人id
     */
    private Integer operateId;
    /**
     * 操作人名称
     */
    private String operateName;

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

    public String getUserMobile() {
        return userMobile;
    }

    public void setUserMobile(String userMobile) {
        this.userMobile = userMobile;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getSubmitTime() {
        return submitTime;
    }

    public void setSubmitTime(Date submitTime) {
        this.submitTime = submitTime;
    }

    public Date getOperateTime() {
        return operateTime;
    }

    public void setOperateTime(Date operateTime) {
        this.operateTime = operateTime;
    }

    public Integer getOperateId() {
        return operateId;
    }

    public void setOperateId(Integer operateId) {
        this.operateId = operateId;
    }

    public String getOperateName() {
        return operateName;
    }

    public void setOperateName(String operateName) {
        this.operateName = operateName;
    }

    public String getContentClassify() {
        return contentClassify;
    }

    public void setContentClassify(String contentClassify) {
        this.contentClassify = contentClassify;
    }

    public String getOperateStatus() {
        return operateStatus;
    }

    public void setOperateStatus(String operateStatus) {
        this.operateStatus = operateStatus;
    }

}
