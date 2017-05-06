package com.yilidi.o2o.product.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 专题栏目与产品关联关系DTO
 * 
 * @author: chenlian
 * @date: 2016年9月10日 下午3:53:09
 */
public class ThemeColumnProductDto extends BaseDto {
    private static final long serialVersionUID = -5205323864799407073L;
    /**
     * id
     */
    private Integer id;
    /**
     * 专题栏目ID
     */
    private Integer themeColumnId;
    /**
     * 产品ID
     */
    private Integer productId;
    /**
     * 排序
     */
    private Integer sort;
    /**
     * 渠道编码
     */
    private String channelCode;
    /**
     * 创建用户ID
     */
    private Integer createUserId;
    /**
     * 创建时间
     */
    private Date createTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getThemeColumnId() {
        return themeColumnId;
    }

    public void setThemeColumnId(Integer themeColumnId) {
        this.themeColumnId = themeColumnId;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public String getChannelCode() {
        return channelCode;
    }

    public void setChannelCode(String channelCode) {
        this.channelCode = channelCode;
    }

    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

}