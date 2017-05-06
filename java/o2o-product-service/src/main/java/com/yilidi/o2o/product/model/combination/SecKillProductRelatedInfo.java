/**
 * 文件名称：SaleProductRelatedInfo.java
 * 
 * 文件描述：
 * 
 *
 * 修改内容：<content>
 */
package com.yilidi.o2o.product.model.combination;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：将秒杀产品相关信息进行组合封装，供Mybatis使用 <br/>
 * 作者： chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SecKillProductRelatedInfo extends BaseModel {

    private static final long serialVersionUID = 1918399883043140350L;

    /**
     * 秒杀产品ID
     */
    private Integer id;
    /**
     * 产品ID
     */
    private Integer productId;

    /**
     * 产品名称
     */
    private String productName;
    /**
     * 产品条形码
     */
    private String barCode;
    /**
     * 秒杀场次ID
     */
    private Integer sceneId;
    /**
     * 活动ID
     */
    private Integer activityId;
    /**
     * 秒杀场次名称
     */
    private String sceneName;
    /**
     * 场次开始时间
     */
    private Date startTime;
    /**
     * 商品VIP价格
     */
    private Long promotionalPrice;
    /**
     * 秒杀价格
     */
    private Long secKillProductPrice;
    /**
     * 显示顺序
     */
    private Integer displayOrder;
    /**
     * 秒杀产品库存
     */
    private Integer remainCount;
    /**
     * 允许秒中数量
     */
    private Integer secKillCount;
    /**
     * 限购数量,按会员、收货地址、设备号限购，0表示不限购
     */
    private Integer limitOrderCount;
    /**
     * 参与资格
     */
    private String qualifyType;
    /**
     * 抢光时间,单位:秒
     */
    private Long secKillTime;
    /**
     * 创建用户ID
     */
    private Integer createUserId;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 最后操作用户ID
     */
    private Integer updateUserId;
    /**
     * 最后操作时间
     */
    private Date updateTime;
    /**
     * 场次关联的秒杀商品状态编码
     */
    private String statusCode;
    /**
     * 秒杀商品状态
     */
    private String secKillProductStatus;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getBarCode() {
        return barCode;
    }

    public void setBarCode(String barCode) {
        this.barCode = barCode;
    }

    public Integer getSceneId() {
        return sceneId;
    }

    public Integer getActivityId() {
        return activityId;
    }

    public void setActivityId(Integer activityId) {
        this.activityId = activityId;
    }

    public void setSceneId(Integer sceneId) {
        this.sceneId = sceneId;
    }

    public String getSceneName() {
        return sceneName;
    }

    public void setSceneName(String sceneName) {
        this.sceneName = sceneName;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Long getPromotionalPrice() {
        return promotionalPrice;
    }

    public void setPromotionalPrice(Long promotionalPrice) {
        this.promotionalPrice = promotionalPrice;
    }

    public Long getSecKillProductPrice() {
        return secKillProductPrice;
    }

    public void setSecKillProductPrice(Long secKillProductPrice) {
        this.secKillProductPrice = secKillProductPrice;
    }

    public Integer getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
    }

    public Integer getRemainCount() {
        return remainCount;
    }

    public void setRemainCount(Integer remainCount) {
        this.remainCount = remainCount;
    }

    public Integer getSecKillCount() {
        return secKillCount;
    }

    public void setSecKillCount(Integer secKillCount) {
        this.secKillCount = secKillCount;
    }

    public Integer getLimitOrderCount() {
        return limitOrderCount;
    }

    public void setLimitOrderCount(Integer limitOrderCount) {
        this.limitOrderCount = limitOrderCount;
    }

    public String getQualifyType() {
        return qualifyType;
    }

    public void setQualifyType(String qualifyType) {
        this.qualifyType = qualifyType;
    }

    public Long getSecKillTime() {
        return secKillTime;
    }

    public void setSecKillTime(Long secKillTime) {
        this.secKillTime = secKillTime;
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

    public Integer getUpdateUserId() {
        return updateUserId;
    }

    public void setUpdateUserId(Integer updateUserId) {
        this.updateUserId = updateUserId;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public String getSecKillProductStatus() {
        return secKillProductStatus;
    }

    public void setSecKillProductStatus(String secKillProductStatus) {
        this.secKillProductStatus = secKillProductStatus;
    }

}