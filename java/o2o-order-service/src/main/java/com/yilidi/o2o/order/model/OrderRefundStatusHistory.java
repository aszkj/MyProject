package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;

/**
 * 功能描述：订单退款状态历史记录数据模型，映射交易域表 YiLiDiOrderCenter.T_ORDER_REFUND_STATUS_HISTORY
 * <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class OrderRefundStatusHistory extends BaseModel {
    private static final long serialVersionUID = 1051677188068969141L;

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

    /**
     * 获取id
     * 
     * @return id
     */
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

    public String getOperationDesc() {
        return operationDesc;
    }

    public void setOperationDesc(String operationDesc) {
        this.operationDesc = operationDesc;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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