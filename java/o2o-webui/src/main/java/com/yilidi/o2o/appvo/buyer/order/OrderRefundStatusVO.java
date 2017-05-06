package com.yilidi.o2o.appvo.buyer.order;

import java.util.Date;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 订单退款状态
 * 
 * @author: chenb
 * @date: 2016年5月27日 下午7:26:46
 */
public class OrderRefundStatusVO extends AppBaseVO {
    private static final long serialVersionUID = 4971955272559408454L;

    /**
     * 订单状态码
     */
    private Integer statusCode;
    /**
     * 订单状态名称
     */
    private String statusCodeName;
    /**
     * 订单状态时间
     */
    private Date statusTime;
    /**
     * 订单状态说明
     */
    private String statusNote;

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

    public Date getStatusTime() {
        return statusTime;
    }

    public void setStatusTime(Date statusTime) {
        this.statusTime = statusTime;
    }

    public String getStatusNote() {
        return statusNote;
    }

    public void setStatusNote(String statusNote) {
        this.statusNote = statusNote;
    }

}
