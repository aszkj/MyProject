package com.yilidi.o2o.product.service.dto.query;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseQueryDto;

/**
 * 功能描述：买赠活动查询Dto
 * 作者： xiasl<br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 * 
 * @date 2017年2月24日
 */
public class BuyRewardActivityQueryDto extends BaseQueryDto {

    private static final long serialVersionUID = 8684342223679268538L;
    /**
     * 表主键,自增
     */
    private Integer id;
    /**
     * 活动名称
     */
    private String activityName;
    /**
     * 取值方式
     */
    private String valueMethod;
    /**
     * 赠品类型
     */
    private String giftType;
    /**
     * 活动状态
     */
    private String statusCode;
    /**
     * 活动审批状态
     */
    private String auditStatus;
    /**
     * 审批页面状态列表
     */
    private List<String> finalAuditStatusList;
    /**
     * 活动开始时间str
     */
    private String activityBeginStr;
    /**
     * 活动结束时间str
     */
    private String activityEndStr;
    /**
     * 创建用户ID
     */
    private Integer createUserId;
    /**
     * 创建开始时间(字符串)
     */
    private String strStartCreateTime;
    /**
     * 创建结束时间(字符串)
     */
    private String strEndCreateTime;
    /**
     * 活动开始时间
     */
    private Date activityBegin;
    /**
     * 活动结束时间
     */
    private Date activityEnd;

    public Date getActivityBegin() {
        return activityBegin;
    }

    public void setActivityBegin(Date activityBegin) {
        this.activityBegin = activityBegin;
    }

    public Date getActivityEnd() {
        return activityEnd;
    }

    public void setActivityEnd(Date activityEnd) {
        this.activityEnd = activityEnd;
    }

    public String getActivityBeginStr() {
        return activityBeginStr;
    }

    public void setActivityBeginStr(String activityBeginStr) {
        this.activityBeginStr = activityBeginStr;
    }

    public String getActivityEndStr() {
        return activityEndStr;
    }

    public void setActivityEndStr(String activityEndStr) {
        this.activityEndStr = activityEndStr;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getActivityName() {
        return activityName;
    }

    public void setActivityName(String activityName) {
        this.activityName = activityName;
    }

    public String getValueMethod() {
        return valueMethod;
    }

    public void setValueMethod(String valueMethod) {
        this.valueMethod = valueMethod;
    }

    public String getGiftType() {
        return giftType;
    }

    public void setGiftType(String giftType) {
        this.giftType = giftType;
    }

    public String getAuditStatus() {
        return auditStatus;
    }

    public void setAuditStatus(String auditStatus) {
        this.auditStatus = auditStatus;
    }

    public List<String> getFinalAuditStatusList() {
        return finalAuditStatusList;
    }

    public void setFinalAuditStatusList(List<String> finalAuditStatusList) {
        this.finalAuditStatusList = finalAuditStatusList;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

    public String getStrStartCreateTime() {
        return strStartCreateTime;
    }

    public void setStrStartCreateTime(String strStartCreateTime) {
        this.strStartCreateTime = strStartCreateTime;
    }

    public String getStrEndCreateTime() {
        return strEndCreateTime;
    }

    public void setStrEndCreateTime(String strEndCreateTime) {
        this.strEndCreateTime = strEndCreateTime;
    }

}
