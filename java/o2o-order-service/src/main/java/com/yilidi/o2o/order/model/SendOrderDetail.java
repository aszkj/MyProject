package com.yilidi.o2o.order.model;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：发货明细记录实体类，映射交易域表YiLiDiOrderCenter.T_SEND_ORDER_DETAIL <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SendOrderDetail extends BaseModel {
    private static final long serialVersionUID = -1204020172005509277L;
    /**
     * 发货记录明细ID，主键自增
     */
    private Integer id;
    /**
     * 发货记录ID， 关联交易域发货单表T_SEND_ORDER的ID字段
     */
    private Integer sendOrderId;
    /**
     * 订单明细ID
     */
    private Integer saleOrderItemId;
    /**
     * 商品ID
     */
    private Integer saleProductId;
    /**
     * 发货数量， 标识该发货单中此产品的发货数量（该数字小于等于发货单明细中的产品数量字段值）
     */
    private Integer quantity;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSendOrderId() {
        return sendOrderId;
    }

    public void setSendOrderId(Integer sendOrderId) {
        this.sendOrderId = sendOrderId;
    }

    public Integer getSaleOrderItemId() {
        return saleOrderItemId;
    }

    public void setSaleOrderItemId(Integer saleOrderItemId) {
        this.saleOrderItemId = saleOrderItemId;
    }

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

}