package com.yilidi.o2o.order.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 
 * 首单信息记录Dto
 * 
 * @author: chenb
 * @date: 2016年7月12日 下午2:17:14
 * 
 */
public class FirstOrderCustomerRecDto extends BaseDto {

    private static final long serialVersionUID = 5371470127828648308L;

    /**
     * 记录编号，主键
     */
    private Integer id;
    /**
     * 买家客户ID
     */
    private Integer buyerCustomerId;
    /**
     * 订单编号
     */
    private String saleOrderNo;
    /**
     * 首单类型编码
     */
    private String firstOrderType;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 创建用户ID
     */
    private Integer createUserId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getBuyerCustomerId() {
        return buyerCustomerId;
    }

    public void setBuyerCustomerId(Integer buyerCustomerId) {
        this.buyerCustomerId = buyerCustomerId;
    }

    public String getSaleOrderNo() {
        return saleOrderNo;
    }

    public void setSaleOrderNo(String saleOrderNo) {
        this.saleOrderNo = saleOrderNo;
    }

    public String getFirstOrderType() {
        return firstOrderType;
    }

    public void setFirstOrderType(String firstOrderType) {
        this.firstOrderType = firstOrderType;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

}
