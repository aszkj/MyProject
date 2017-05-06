package com.yilidi.o2o.order.service.dto;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * @Description: TODO(订单取消商品明细信息)
 * @author: chenlian
 * @date: 2016年6月17日 下午5:22:18
 */
public class CancelOrderItemDto extends BaseDto {

    /**
     * serialVersionUID
     */
    private static final long serialVersionUID = 2881494466155584336L;

    /**
     * 商品ID
     */
    private Integer saleProductId;

    /**
     * 商品数量
     */
    private Integer quantity;
    /**
     * 活动ID
     */
    private Integer actId;

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

    public Integer getActId() {
        return actId;
    }

    public void setActId(Integer actId) {
        this.actId = actId;
    }

}
