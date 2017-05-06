package com.yilidi.o2o.product.proxy.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：秒杀商品代理DTO类 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SecKillProductProxyDto extends BaseDto {

    private static final long serialVersionUID = 126673636641232578L;
    /**
     * 商品ID，自增主键
     */
    private Integer id;
    /**
     * 产品ID
     */
    private Integer productId;
    /**
     * 商品ID
     */
    private Integer saleProductId;
    /**
     * 商品名称
     */
    private String saleProductName;
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
     * 场次结束时间
     */
    private Date endTime;

    /**
     * 秒杀价格
     */
    private Long secKillProductPrice;
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
     * 参与资格,关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SECKILLSCENEQUALIFYTYPE),默认所有不限
     */
    private String qualifyType;
    /**
     * 抢光时间,单位:秒
     */
    private Long secKillTime;
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

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public String getSaleProductName() {
        return saleProductName;
    }

    public void setSaleProductName(String saleProductName) {
        this.saleProductName = saleProductName;
    }

    public Integer getSceneId() {
        return sceneId;
    }

    public void setSceneId(Integer sceneId) {
        this.sceneId = sceneId;
    }

    public Integer getActivityId() {
        return activityId;
    }

    public void setActivityId(Integer activityId) {
        this.activityId = activityId;
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

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Long getSecKillProductPrice() {
        return secKillProductPrice;
    }

    public void setSecKillProductPrice(Long secKillProductPrice) {
        this.secKillProductPrice = secKillProductPrice;
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