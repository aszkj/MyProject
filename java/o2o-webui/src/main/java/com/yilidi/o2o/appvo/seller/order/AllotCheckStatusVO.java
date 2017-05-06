package com.yilidi.o2o.appvo.seller.order;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * @Description: TODO(调货单验货状态信息数据)
 * @author: chenlian
 * @date: 2016年6月1日 上午10:08:36
 */
public class AllotCheckStatusVO extends AppBaseVO {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -7501215177535981194L;
    /**
     * 调货单ID
     */
    private Integer allotOrderId;
    /**
     * 调货单编号
     */
    private String allotOrderNo;
    /**
     * 调拨单状态
     */
    private Integer statusCode;
    /**
     * 状态时间
     */
    private String statusTime;

    public Integer getAllotOrderId() {
        return allotOrderId;
    }

    public void setAllotOrderId(Integer allotOrderId) {
        this.allotOrderId = allotOrderId;
    }

    public String getAllotOrderNo() {
        return allotOrderNo;
    }

    public void setAllotOrderNo(String allotOrderNo) {
        this.allotOrderNo = allotOrderNo;
    }

    public Integer getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(Integer statusCode) {
        this.statusCode = statusCode;
    }

    public String getStatusTime() {
        return statusTime;
    }

    public void setStatusTime(String statusTime) {
        this.statusTime = statusTime;
    }
}
