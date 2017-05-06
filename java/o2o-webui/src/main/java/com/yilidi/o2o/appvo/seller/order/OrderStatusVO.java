package com.yilidi.o2o.appvo.seller.order;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * @Description: TODO(订单状态信息数据)
 * @author: chenlian
 * @date: 2016年6月1日 上午10:09:37
 */
public class OrderStatusVO extends AppBaseVO {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = 8576744985217410260L;
    /**
     * 订单ID
     */
    private Integer saleOrderId;
    /**
     * 订单编码
     */
    private String saleOrderNo;
    /**
     * 订单状态
     */
    private Integer statusCode;
    /**
     * 订单状态名称
     */
    private String statusCodeName;

    public Integer getSaleOrderId() {
        return saleOrderId;
    }

    public void setSaleOrderId(Integer saleOrderId) {
        this.saleOrderId = saleOrderId;
    }

    public String getSaleOrderNo() {
        return saleOrderNo;
    }

    public void setSaleOrderNo(String saleOrderNo) {
        this.saleOrderNo = saleOrderNo;
    }

    public Integer getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(Integer statusCode) {
        this.statusCode = statusCode;
    }

    public String getStatusCodeName() {
        return statusCodeName;
    }

    public void setStatusCodeName(String statusCodeName) {
        this.statusCodeName = statusCodeName;
    }
}
