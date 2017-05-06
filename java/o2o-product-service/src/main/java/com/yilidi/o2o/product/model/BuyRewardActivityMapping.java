package com.yilidi.o2o.product.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：买赠活动详情映射表，映射数据库表 YiLiDiProductCenter.P_BUYREWARD_ACTIVITY_MAPPING 作者： xiasl<br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 * 
 * @date 2017年2月24日
 */
public class BuyRewardActivityMapping extends BaseModel {

    private static final long serialVersionUID = -5506268605419845129L;
    /**
     * 表主键,自增
     */
    private Integer id;
    /**
     * 活动mappingcode
     */
    private Integer activityId;
    /**
     * 主产品id
     */
    private Integer productId;
    /**
     * 奖励条件(多个区间则以 || 分割)
     */
    private String rewardConditions;
    /**
     * 奖励赠品id(赠多个产品或优惠券时，为其id拼接,拼接符为英文逗号)
     */
    private String rewardGifts;
    /**
     * 赠品数量(多个赠品则以 ||分割)
     */
    private String giftAmount;
    /**
     * 创建用户ID
     */
    private Integer createUserId;
    /**
     * 创建时间
     */
    private Date createTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getActivityId() {
        return activityId;
    }

    public void setActivityId(Integer activityId) {
        this.activityId = activityId;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getRewardConditions() {
        return rewardConditions;
    }

    public void setRewardConditions(String rewardConditions) {
        this.rewardConditions = rewardConditions;
    }

    public String getRewardGifts() {
        return rewardGifts;
    }

    public void setRewardGifts(String rewardGifts) {
        this.rewardGifts = rewardGifts;
    }

    public String getGiftAmount() {
        return giftAmount;
    }

    public void setGiftAmount(String giftAmount) {
        this.giftAmount = giftAmount;
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
