package com.yilidi.o2o.user.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 推广客户与店铺关联关系实体类DTO
 * 
 * @author: chenlian
 * @date: 2016年8月11日 下午4:18:12
 */
public class RecommendCustomerStoreDto extends BaseDto {

    private static final long serialVersionUID = 9122517085982612926L;

    /**
     * ID，自增主键
     */
    private Integer id;

    /**
     * 推广客户ID
     */
    private Integer recommendCustomerId;

    /**
     * 店铺ID
     */
    private Integer storeId;

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

    public Integer getRecommendCustomerId() {
        return recommendCustomerId;
    }

    public void setRecommendCustomerId(Integer recommendCustomerId) {
        this.recommendCustomerId = recommendCustomerId;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
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
