package com.yilidi.o2o.product.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 楼层与广告类型关联关系DTO
 * 
 * @author: chenlian
 * @date: 2016年8月25日 上午11:11:01
 */
public class FloorAdvertisementTypeDto extends BaseDto {

    private static final long serialVersionUID = 9122517085982612926L;

    /**
     * ID，自增主键
     */
    private Integer id;

    /**
     * 楼层ID
     */
    private Integer floorId;

    /**
     * 广告类型编码
     */
    private String advertisementTypeCode;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 创建人ID
     */
    private Integer createUserId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getFloorId() {
        return floorId;
    }

    public void setFloorId(Integer floorId) {
        this.floorId = floorId;
    }

    public String getAdvertisementTypeCode() {
        return advertisementTypeCode;
    }

    public void setAdvertisementTypeCode(String advertisementTypeCode) {
        this.advertisementTypeCode = advertisementTypeCode;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

}