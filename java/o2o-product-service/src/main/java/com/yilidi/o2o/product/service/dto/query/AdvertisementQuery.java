/**
 * 文件名称：AdvertisementQuery.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service.dto.query;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 功能描述：广告查询条件封装类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class AdvertisementQuery extends BaseQuery {
    private static final long serialVersionUID = 3416581011835124021L;
    /**
     * 广告名称
     */
    private String advertisementName;
    /**
     * 广告类型
     */
    private String typeCode;
    /**
     * 广告状态
     */
    private String statusCode;
    /**
     * 广告查询开始时间
     */
    private Date startTime;
    /**
     * 广告查询结束时间
     */
    private Date endTime;
    /**
     * 广告查询开始时间(字符串)
     */
    private String strStartTime;
    /**
     * 广告查询结束时间(字符串)
     */
    private String strEndTime;

    public String getAdvertisementName() {
        return advertisementName;
    }

    public void setAdvertisementName(String advertisementName) {
        this.advertisementName = advertisementName;
    }

    public String getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getStrStartTime() {
        return strStartTime;
    }

    public void setStrStartTime(String strStartTime) {
        this.strStartTime = strStartTime;
    }

    public String getStrEndTime() {
        return strEndTime;
    }

    public void setStrEndTime(String strEndTime) {
        this.strEndTime = strEndTime;
    }

}
