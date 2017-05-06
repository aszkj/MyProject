package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;

/**
 * 功能描述：订单状态历史记录数据模型，映射交易域表 YiLiDiOrderCenter.T_SALE_ORDER_HISTORY <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleOrderHistory extends BaseModel {
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
     * 订单状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SALEORDERSTATUS)
     */
    private String orderStatus;

    /**
     * 操作描述
     */
    private String operationDesc;

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

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getOperationDesc() {
        return operationDesc;
    }

    public void setOperationDesc(String operationDesc) {
        this.operationDesc = operationDesc;
    }

}