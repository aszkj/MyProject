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
 * 功能描述：用户分享结果DTO<br/>
 * 作者： chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class InviterUserShareAwardDto extends BaseDto {

    private static final long serialVersionUID = 1454060899960624429L;
    /**
     * 表主键,自增
     */
    private Integer id;
    /**
     * 用户分享码
     */
    private String shareCode;
    /**
     * 分享用户ID
     */
    private Integer userId;
    /**
     * 被邀请用户ID
     */
    private Integer invitedUserId;
    /**
     * 分享用户手机号码
     */
    private String shareUserName;
    /**
     * 分享规则ID
     */
    private Integer shareRuleId;
    /**
     * 奖励积分
     */
    private Integer awardPoints;
    /**
     * 奖励金额
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
    /**
     * 上周邀请人数
     */
    private Integer prevWeekInviterCount;
    /**
     * 本周邀请人数
     */
    private Integer curWeekInviterCount;

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

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getInvitedUserId() {
        return invitedUserId;
    }

    public void setInvitedUserId(Integer invitedUserId) {
        this.invitedUserId = invitedUserId;
    }

    public String getShareUserName() {
        return shareUserName;
    }

    public void setShareUserName(String shareUserName) {
        this.shareUserName = shareUserName;
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

    public Integer getPrevWeekInviterCount() {
        return prevWeekInviterCount;
    }

    public void setPrevWeekInviterCount(Integer prevWeekInviterCount) {
        this.prevWeekInviterCount = prevWeekInviterCount;
    }

    public Integer getCurWeekInviterCount() {
        return curWeekInviterCount;
    }

    public void setCurWeekInviterCount(Integer curWeekInviterCount) {
        this.curWeekInviterCount = curWeekInviterCount;
    }

}