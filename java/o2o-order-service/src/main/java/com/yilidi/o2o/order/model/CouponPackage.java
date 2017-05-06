package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 优惠券包信息表，映射交易域表YiLiDiOrderCenter.T_COUPON_PACKAGE
 * 
 * @author: chenlian
 * @date: 2016年10月18日 下午5:47:26
 */
public class CouponPackage extends BaseModel {

    private static final long serialVersionUID = 7860489022605610315L;

    /**
     * ID，主键自增
     */
    private Integer id;

    /**
     * 优惠券/券包名称
     */
    private String conName;

    /**
     * 面值 单位 厘
     */
    private Long amount;

    /**
     * 使用条件(单笔订单金额满X元) 单位 厘
     */
    private Long useCondition;

    /**
     * 状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=COUPONSSTATE) 未发放，已发放，已停用 三个状态
     */
    private String state;

    /**
     * 创建人
     */
    private Integer createUserId;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 修改人ID
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

    public String getConName() {
        return conName;
    }

    public void setConName(String conName) {
        this.conName = conName;
    }

    public Long getAmount() {
        return amount;
    }

    public void setAmount(Long amount) {
        this.amount = amount;
    }

    public Long getUseCondition() {
        return useCondition;
    }

    public void setUseCondition(Long useCondition) {
        this.useCondition = useCondition;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
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