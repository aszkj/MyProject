package com.yilidi.o2o.product.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 楼层信息实体类，映射产品域表YiLiDiProductCenter.P_FLOOR
 * 
 * @author: chenlian
 * @date: 2016年8月24日 下午2:12:50
 */
public class Floor extends BaseModel {

    private static final long serialVersionUID = -5205323864799407073L;

    /**
     * 楼层ID，自增主键
     */
    private Integer id;

    /**
     * 楼层名称
     */
    private String floorName;

    /**
     * 楼层icon图片URL
     */
    private String floorImageUrl;

    /**
     * 楼层排序
     */
    private Integer sort;

    /**
     * 楼层状态编码, 关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=FLOORSTATUS)
     */
    private String statusCode;

    /**
     * 楼层跳转链接类型编码, 关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=FLOORLINKTYPE)
     */
    private String linkType;

    /**
     * 关键链接数据
     */
    private String linkData;

    /**
     * 创建用户ID
     */
    private Integer createUserId;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 修改用户ID
     */
    private Integer modifyUserId;

    /**
     * 修改时间
     */
    private Date modifyTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFloorName() {
        return floorName;
    }

    public void setFloorName(String floorName) {
        this.floorName = floorName;
    }

    public String getFloorImageUrl() {
        return floorImageUrl;
    }

    public void setFloorImageUrl(String floorImageUrl) {
        this.floorImageUrl = floorImageUrl;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public String getLinkType() {
        return linkType;
    }

    public void setLinkType(String linkType) {
        this.linkType = linkType;
    }

    public String getLinkData() {
        return linkData;
    }

    public void setLinkData(String linkData) {
        this.linkData = linkData;
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

    public Integer getModifyUserId() {
        return modifyUserId;
    }

    public void setModifyUserId(Integer modifyUserId) {
        this.modifyUserId = modifyUserId;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

}