package com.yldbkd.www.buyer.android.bean;

import java.util.List;

/**
 * 首页专区信息数据
 * <p/>
 * Created by linghuxj on 16/6/2.
 */
public class ZoneInfo extends BaseModel {

    /**
     * 销售专区ID
     */
    private String saleZoneId;
    /**
     * 销售专区名称
     */
    private String saleZoneName;
    /**
     * 销售专区广告信息
     */
    private Advertisement saleZoneAdvInfo;
    /**
     * 销售专区更多信息
     */
    private ZoneMore saleZoneMoreInfo;
    /**
     * 销售专区产品列表
     */
    private List<SaleProduct> saleZoneProductList;

    public String getSaleZoneId() {
        return saleZoneId;
    }

    public void setSaleZoneId(String saleZoneId) {
        this.saleZoneId = saleZoneId;
    }

    public String getSaleZoneName() {
        return saleZoneName;
    }

    public void setSaleZoneName(String saleZoneName) {
        this.saleZoneName = saleZoneName;
    }

    public Advertisement getSaleZoneAdvInfo() {
        return saleZoneAdvInfo;
    }

    public void setSaleZoneAdvInfo(Advertisement saleZoneAdvInfo) {
        this.saleZoneAdvInfo = saleZoneAdvInfo;
    }

    public ZoneMore getSaleZoneMoreInfo() {
        return saleZoneMoreInfo;
    }

    public void setSaleZoneMoreInfo(ZoneMore saleZoneMoreInfo) {
        this.saleZoneMoreInfo = saleZoneMoreInfo;
    }

    public List<SaleProduct> getSaleZoneProductList() {
        return saleZoneProductList;
    }

    public void setSaleZoneProductList(List<SaleProduct> saleZoneProductList) {
        this.saleZoneProductList = saleZoneProductList;
    }
}
