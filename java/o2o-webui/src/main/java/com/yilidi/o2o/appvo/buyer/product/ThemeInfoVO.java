package com.yilidi.o2o.appvo.buyer.product;

import java.util.List;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 专题信息VO
 * 
 * @author: chenlian
 * @date: 2016年8月26日 上午10:01:56
 */
public class ThemeInfoVO extends AppBaseVO {

    private static final long serialVersionUID = 1L;

    /**
     * 专题名称
     */
    private String themeName;

    /**
     * 专题类型编码
     */
    private String typeCode;

    /**
     * 专题图片URL
     */
    private String themeImageUrl;

    /**
     * 专题slogan图片URL
     */
    private String sloganImageUrl;

    /**
     * 专题底色
     */
    private String baseColor;

    /**
     * 专题产品列表
     */
    private List<SaleProductSearchVO> saleProducts;

    public String getThemeName() {
        return themeName;
    }

    public void setThemeName(String themeName) {
        this.themeName = themeName;
    }

    public String getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
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

    public List<SaleProductSearchVO> getSaleProducts() {
        return saleProducts;
    }

    public void setSaleProducts(List<SaleProductSearchVO> saleProducts) {
        this.saleProducts = saleProducts;
    }

}
