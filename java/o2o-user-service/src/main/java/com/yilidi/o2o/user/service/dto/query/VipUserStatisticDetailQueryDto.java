package com.yilidi.o2o.user.service.dto.query;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseQueryDto;

public class VipUserStatisticDetailQueryDto extends BaseQueryDto {

    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -7185579307802183692L;

    /**
     * 店铺ID
     */
    private Integer storeId;

    /**
     * 客户状态编码
     */
    private String statusCode;

    /**
     * 买家用户级别
     */
    private String buyerLevelCode;

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

    public String getBuyerLevelCode() {
        return buyerLevelCode;
    }

    public void setBuyerLevelCode(String buyerLevelCode) {
        this.buyerLevelCode = buyerLevelCode;
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
