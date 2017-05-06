package com.yldbkd.www.buyer.android.bean;

import java.util.List;

/**
 * 专题信息数据结构
 * <p/>
 * Created by linghuxj on 16/9/5.
 */
public class SeminarInfo extends BaseModel {

    /**
     * 专题类型编码
     */
    private String typeCode;
    /**
     * 专题名称
     */
    private String themeName;
    /**
     * 专题内图片URL
     */
    private String themeImageUrl;
    /**
     * 专题slogan图片URL
     */
    private String sloganImageUrl;
    /**
     * 专题背景颜色
     * lakeBlue: 湖蓝#007dd5
     * navyBlue	: 深蓝#2271bf
     * lightBlue: 浅蓝#48acdd
     * red:		红#E21855
     * yellow:	黄#F6C71A
     * green:	绿#349F40
     */
    private String baseColor;
    /**
     * 专题商品列表
     */
    private List<SaleProduct> saleProducts;

    public String getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
    }

    public String getThemeName() {
        return themeName;
    }

    public void setThemeName(String themeName) {
        this.themeName = themeName;
    }

    public String getThemeImageUrl() {
        return themeImageUrl;
    }

    public void setThemeImageUrl(String themeImageUrl) {
        this.themeImageUrl = themeImageUrl;
    }

    public String getSloganImageUrl() {
        return sloganImageUrl;
    }

    public void setSloganImageUrl(String sloganImageUrl) {
        this.sloganImageUrl = sloganImageUrl;
    }

    public String getBaseColor() {
        return baseColor;
    }

    public void setBaseColor(String baseColor) {
        this.baseColor = baseColor;
    }

    public List<SaleProduct> getSaleProducts() {
        return saleProducts;
    }

    public void setSaleProducts(List<SaleProduct> saleProducts) {
        this.saleProducts = saleProducts;
    }
}
