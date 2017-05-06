/**
 * 文件名称：User.java
 * 
 * 文件描述：
 * 
 *
 * 修改内容：<content>
 */
package com.yilidi.o2o.user.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：用户分享记录DTO<br/>
 * 作者： chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class InvitedUserShareAwardDto extends BaseDto {

    private static final long serialVersionUID = -7523022231834922932L;
    /**
     * 表主键,自增
     */
    private Integer id;
    /**
     * 分享码
     */
    private String shareCode;
    /**
     * 分享用户ID
     */
    private Integer shareUserId;
    /**
     * 被邀请用户
     */
    private Integer invitedUserId;
    /**
     * 被邀请人手机号码
     */
    private String invitedUserName;
    /**
     * 分享规则ID
     */
    private Integer shareRuleId;
    /**
     * 积分奖励
     */
    private Integer awardPoints;
    /**
     * 现金奖励
     */
    private Long awardCash;
    /**
     * 优惠券ID
     */
    private Integer awardCouponId;
    /**
     * 优惠券数量
     */
    private Integer awardCouponCount;
    /**
     * 优惠券金额
     */
    private Long awardCouponAmount;

    /**
     * 创建记录用户ID
     */
    private Integer createUserId;
    /**
     * 创建记录时间
     */
    private Date createTime;

    private String strStartCreateTime;

    private String strEndCreateTime;
    /**
     * 被邀请人奖励条件名称
     */
    private String invitedConditionTypeName;
    /**
     * 被邀请人奖励类型名称
     */
    private String invitedAwardTypeName;
    /**
     * 被邀请人奖励描述
     */
    private String invitedAwardDesc;

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

    public Integer getShareUserId() {
        return shareUserId;
    }

    public void setShareUserId(Integer shareUserId) {
        this.shareUserId = shareUserId;
    }

    public Integer getInvitedUserId() {
        return invitedUserId;
    }

    public void setInvitedUserId(Integer invitedUserId) {
        this.invitedUserId = invitedUserId;
    }

    public String getInvitedUserName() {
        return invitedUserName;
    }

    public void setInvitedUserName(String invitedUserName) {
        this.invitedUserName = invitedUserName;
    }

    public Integer getShareRuleId() {
        return shareRuleId;
    }

    public void setShareRuleId(Integer shareRuleId) {
        this.shareRuleId = shareRuleId;
    }

    public Integer getAwardPoints() {
        return awardPoints;
    }

    public void setAwardPoints(Integer awardPoints) {
        this.awardPoints = awardPoints;
    }

    public Long getAwardCash() {
        return awardCash;
    }

    public void setAwardCash(Long awardCash) {
        this.awardCash = awardCash;
    }

    public Integer getAwardCouponId() {
        return awardCouponId;
    }

    public void setAwardCouponId(Integer awardCouponId) {
        this.awardCouponId = awardCouponId;
    }

    public Integer getAwardCouponCount() {
        return awardCouponCount;
    }

    public void setAwardCouponCount(Integer awardCouponCount) {
        this.awardCouponCount = awardCouponCount;
    }

    public Long getAwardCouponAmount() {
        return awardCouponAmount;
    }

    public void setAwardCouponAmount(Long awardCouponAmount) {
        this.awardCouponAmount = awardCouponAmount;
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

    public String getInvitedConditionTypeName() {
        return invitedConditionTypeName;
    }

    public void setInvitedConditionTypeName(String invitedConditionTypeName) {
        this.invitedConditionTypeName = invitedConditionTypeName;
    }

    public String getInvitedAwardTypeName() {
        return invitedAwardTypeName;
    }

    public void setInvitedAwardTypeName(String invitedAwardTypeName) {
        this.invitedAwardTypeName = invitedAwardTypeName;
    }

    public String getInvitedAwardDesc() {
        return invitedAwardDesc;
    }

    public void setInvitedAwardDesc(String invitedAwardDesc) {
        this.invitedAwardDesc = invitedAwardDesc;
    }

}