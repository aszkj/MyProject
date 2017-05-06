/**
 * 文件名称：ConsigneeAddressProxyDto.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service.dto;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：秒杀商品库存DTO <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SecKillSaleProductInventoryDto extends BaseDto {
    private static final long serialVersionUID = 434455647322939097L;

    /**
     * 活动ID
     */
    private Integer activityId;
    /**
     * 店铺ID
     */
    private Integer storeId;
    /**
     * 商品ID
     */
    private Integer saleProductId;
    /**
     * 库存量,当前的实际量
     */
    private Integer remainCount;

    public Integer getActivityId() {
        return activityId;
    }

    public void setActivityId(Integer activityId) {
        this.activityId = activityId;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public Integer getRemainCount() {
        return remainCount;
    }

    public void setRemainCount(Integer remainCount) {
        this.remainCount = remainCount;
    }

}
