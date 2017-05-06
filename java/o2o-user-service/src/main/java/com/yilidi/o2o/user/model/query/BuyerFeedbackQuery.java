package com.yilidi.o2o.user.model.query;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 买家反馈查询参数类
 *
 * @author: zhangkun
 * @date: 2016年11月22日 上午10:54:50
 */
public class BuyerFeedbackQuery extends BaseQuery {
    /**
     * @Fields serialVersionUID
     */
    private static final long serialVersionUID = 1L;
    /**
     * 用户手机号
     */
    private String userMobile;
    /**
     * 提交开始时间
     */
    private Date submitBeginTime;
    /**
     * 提交结束时间
     */
    private Date submitEndTime;
    /**
     * 处理开始时间
     */
    private Date operateBeginTime;
    /**
     * 处理结束时间
     */
    private Date operateEndTime;
    /**
     * 处理状态
     */
    private String operateStatus;
    /**
     * 反馈类型
     */
    private String contentClassify;

    public String getUserMobile() {
        return userMobile;
    }

    public void setUserMobile(String userMobile) {
        this.userMobile = userMobile;
    }

    public Date getSubmitBeginTime() {
        return submitBeginTime;
    }

    public void setSubmitBeginTime(Date submitBeginTime) {
        this.submitBeginTime = submitBeginTime;
    }

    public Date getSubmitEndTime() {
        return submitEndTime;
    }

    public void setSubmitEndTime(Date submitEndTime) {
        this.submitEndTime = submitEndTime;
    }

    public Date getOperateBeginTime() {
        return operateBeginTime;
    }

    public void setOperateBeginTime(Date operateBeginTime) {
        this.operateBeginTime = operateBeginTime;
    }

    public Date getOperateEndTime() {
        return operateEndTime;
    }

    public void setOperateEndTime(Date operateEndTime) {
        this.operateEndTime = operateEndTime;
    }

    public String getOperateStatus() {
        return operateStatus;
    }

    public void setOperateStatus(String operateStatus) {
        this.operateStatus = operateStatus;
    }

    public String getContentClassify() {
        return contentClassify;
    }

    public void setContentClassify(String contentClassify) {
        this.contentClassify = contentClassify;
    }
}
