package com.yldbkd.www.buyer.android.bean;

import java.util.List;

/**
 * 楼层数据结构信息
 * <p/>
 * Created by linghuxj on 16/9/2.
 */
public class FloorInfo extends BaseModel {

    /**
     * 楼层ID
     */
    private Integer floorId;
    /**
     * 楼层名称
     */
    private String floorName;
    /**
     * 楼层跳转链接类型。
     * 1:商品分类
     * 2:专区页面
     * 3:楼层商品
     */
    private Integer linkType;
    /**
     * 楼层关键链接数据
     */
    private String linkData;
    /**
     * 楼层icon图片URL
     */
    private String floorImageUrl;
    /**
     * 楼层产品列表
     */
    private List<SaleProduct> floorProductList;

    public Integer getFloorId() {
        return floorId;
    }

    public void setFloorId(Integer floorId) {
        this.floorId = floorId;
    }

    public String getFloorName() {
        return floorName;
    }

    public void setFloorName(String floorName) {
        this.floorName = floorName;
    }

    public Integer getLinkType() {
        return linkType;
    }

    public void setLinkType(Integer linkType) {
        this.linkType = linkType;
    }

    public String getLinkData() {
        return linkData;
    }

    public void setLinkData(String linkData) {
        this.linkData = linkData;
    }

    public String getFloorImageUrl() {
        return floorImageUrl;
    }

    public void setFloorImageUrl(String floorImageUrl) {
        this.floorImageUrl = floorImageUrl;
    }

    public List<SaleProduct> getFloorProductList() {
        return floorProductList;
    }

    public void setFloorProductList(List<SaleProduct> floorProductList) {
        this.floorProductList = floorProductList;
    }
}
