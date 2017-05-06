package com.yilidi.o2o.order.model.query;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseQuery;

public class SettleDetailQuery extends BaseQuery {

    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -7185579307802183692L;

    /**
     * 店铺ID
     */
    private Integer storeId;

    /**
     * 订单状态编码
     */
    private String statusCode;

    /**
     * 开始统计时间
     */
    private Date beginTime;

    /**
     * 结束统计时间
     */
    private Date endTime;

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public Date getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

}
