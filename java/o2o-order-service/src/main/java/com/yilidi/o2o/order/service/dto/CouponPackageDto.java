package com.yilidi.o2o.order.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 优惠券包DTO
 * 
 * @author: chenlian
 * @date: 2016年10月18日 下午6:44:16
 */
public class CouponPackageDto extends BaseDto {

    private static final long serialVersionUID = 7860489022605610315L;

    /**
     * ID
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
     * 状态
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