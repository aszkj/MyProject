package com.yilidi.o2o.product.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 红包奖励信息表实体类，映射产品域表YiLiDiProductCenter.P_RED_ENVELOPE_REWARD
 * 
 * @author: chenlian
 * @date: 2016年11月2日 下午2:36:16
 */
public class RedEnvelopeReward extends BaseModel {

    private static final long serialVersionUID = -5205323864799407073L;

    /**
     * ID，自增主键
     */
    private Integer id;

    /**
     * 抢红包活动ID
     */
    private Integer redEnvelopeActivityId;

    /**
     * 奖励类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=REDENVELOPEREWARDTYPE)
     */
    private String rewardType;

    /**
     * 奖品ID
     */
    private Integer prizeId;
    
    /**
     * 奖品发放时间，当奖励类型属于券组形式，例如抵用券时，需根据PRIZEID＋PRIZEGRANTTIME这两个字段共同决定发放给用户若干具体券的ID
     */
    private Date prizeGrantTime;

    /**
     * 发放数量，适用于券类，比如优惠券、抵用券、实物券等
     */
    private Integer releaseCount;

    /**
     * 发放金额，适用于余额类，比如生活费等
     */
    private Long releaseAmount;

    /**
     * 单次中奖金额范围，最低金额_最高金额的字符串形式，适用于余额类，比如生活费等
     */
    private String winAmountScopeOnce;

    /**
     * 中奖几率，单位：%，设置为100%，则表示百分百中奖；设置为0%，则表示不会中奖。
     */
    private String winProbability;

    /**
     * 中奖几率随机数以逗号连接形成字符串，根据中奖几率产生随机数，如中奖几率大于1%则小数部分四舍五入取整，如中奖几率小于1%则小数部分不为0的部分四舍五入。
     */
    private String probabilityRandomNum;

    /**
     * 限中数量（券类）/次数（余额类），每个用户在活动时期限制中奖数量（券类）/次数（余额类），0 表示不限制。
     */
    private Integer winCountLimit;

    /**
     * 奖励状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=REDENVELOPEREWARDSTATUS)
     */
    private String rewardStatus;

    /**
     * 创建用户ID
     */
    private Integer createUserId;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 修改用户ID
     */
    private Integer modifyUserId;

    /**
     * 修改时间
     */
    private Date modifyTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getRedEnvelopeActivityId() {
        return redEnvelopeActivityId;
    }

    public void setRedEnvelopeActivityId(Integer redEnvelopeActivityId) {
        this.redEnvelopeActivityId = redEnvelopeActivityId;
    }

    public String getRewardType() {
        return rewardType;
    }

    public void setRewardType(String rewardType) {
        this.rewardType = rewardType;
    }

    public Integer getPrizeId() {
        return prizeId;
    }

    public void setPrizeId(Integer prizeId) {
        this.prizeId = prizeId;
    } 

    public Date getPrizeGrantTime() {
        return prizeGrantTime;
    }

    public void setPrizeGrantTime(Date prizeGrantTime) {
        this.prizeGrantTime = prizeGrantTime;
    }

    public Integer getReleaseCount() {
        return releaseCount;
    }

    public void setReleaseCount(Integer releaseCount) {
        this.releaseCount = releaseCount;
    }

    public Long getReleaseAmount() {
        return releaseAmount;
    }

    public void setReleaseAmount(Long releaseAmount) {
        this.releaseAmount = releaseAmount;
    }

    public String getWinAmountScopeOnce() {
        return winAmountScopeOnce;
    }

    public void setWinAmountScopeOnce(String winAmountScopeOnce) {
        this.winAmountScopeOnce = winAmountScopeOnce;
    }

    public String getWinProbability() {
        return winProbability;
    }

    public void setWinProbability(String winProbability) {
        this.winProbability = winProbability;
    }

    public String getProbabilityRandomNum() {
        return probabilityRandomNum;
    }

    public void setProbabilityRandomNum(String probabilityRandomNum) {
        this.probabilityRandomNum = probabilityRandomNum;
    }

    public Integer getWinCountLimit() {
        return winCountLimit;
    }

    public void setWinCountLimit(Integer winCountLimit) {
        this.winCountLimit = winCountLimit;
    }

    public String getRewardStatus() {
        return rewardStatus;
    }

    public void setRewardStatus(String rewardStatus) {
        this.rewardStatus = rewardStatus;
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

}