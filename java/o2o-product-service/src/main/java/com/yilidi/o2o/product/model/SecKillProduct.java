package com.yilidi.o2o.product.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：秒杀商品实体类，映射商品域表YiLiDiProductCenter.P_SECKILL_PRODUCT <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SecKillProduct extends BaseModel {

    private static final long serialVersionUID = 3981548947693667447L;

    /**
     * 商品ID，自增主键
     */
    private Integer id;
    /**
     * 产品ID, 关联商品域P_PRODUCT表的ID字段
     */
    private Integer productId;
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
     * 参与资格,关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SECKILLSCENEQUALIFYTYPE),默认所有不限
     */
    private String qualifyType;
    /**
     * 抢光时间,单位:秒
     */
    private Long secKillTime;
    /**
     * 秒杀商品状态,关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SECKILLPRODUCTSTATUS),默认有效
     */
    private String secKillProductStatus;
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

    public String getSecKillProductStatus() {
        return secKillProductStatus;
    }

    public void setSecKillProductStatus(String secKillProductStatus) {
        this.secKillProductStatus = secKillProductStatus;
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

}