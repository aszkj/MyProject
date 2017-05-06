package com.yilidi.o2o.order.service.dto;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 订单退款历史DTO
 * 
 * @author: chenb
 * @date: 2016年6月3日 上午10:59:52
 */
public class OrderRefundStatusHistoryDto extends BaseDto {

    private static final long serialVersionUID = -83375850884957847L;

    /**
     * ID, 主键
     */
    private Integer id;

    /**
     * 订单编号
     */
    private String saleOrderNo;

    /**
     * 操作用户id
     */
    private Integer operateUserId;

    /**
     * 操作时间
     */
    private Date operateTime;

    /**
     * 退款状态,关联系统字典DICTTYPE=ORDERREFUNDSTATUS
     */
    private String status;

    /**
     * 操作描述
     */
    private String operationDesc;
    /**
     * 操作记录用户ID
     */
    private Integer createUserId;
    /**
     * 操作记录时间
     */
    private Date createTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSaleOrderNo() {
        return saleOrderNo;
    }

    public void setSaleOrderNo(String saleOrderNo) {
        this.saleOrderNo = saleOrderNo;
    }

    public Integer getOperateUserId() {
        return operateUserId;
    }

    public void setOperateUserId(Integer operateUserId) {
        this.operateUserId = operateUserId;
    }

    public Date getOperateTime() {
        return operateTime;
    }

    public void setOperateTime(Date operateTime) {
        this.operateTime = operateTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getOperationDesc() {
        return operationDesc;
    }

    public void setOperationDesc(String operationDesc) {
        this.operationDesc = operationDesc;
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
