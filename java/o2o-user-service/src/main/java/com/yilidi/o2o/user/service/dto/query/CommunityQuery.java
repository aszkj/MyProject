/**
 * 文件名称：StoreQuery.java
 * 
 * 描述：
 * 
 * 修改
 */
package com.yilidi.o2o.user.service.dto.query;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 
 * 小区管理查询条件封装类
 * 
 * @author: heyong
 * @date: 2015年11月10日 下午6:08:32
 * 
 */
public class CommunityQuery extends BaseQuery {

    private static final long serialVersionUID = 4948455583439603920L;
    /**
     * 小区名称
     */
    private String communityName;

    /**
     * 市编码
     */
    private String cityCode;

    /**
     * 区县编码
     */
    private String countyCode;

    /**
     * 显示状态 ，是否显示 是=Y，否=N
     */
    private String display;

    /**
     * 小区名称 模糊查询关键字
     */
    private String keywords;
    /**
     * 省份编码
     */
    private String provinceCode;
    /**
     * 距离,单位米
     */
    private Integer distance;
    
    public CommunityQuery(){
        this.distance = 2500;
    }

    public String getCommunityName() {
        return communityName;
    }

    public void setCommunityName(String communityName) {
        this.communityName = communityName;
    }

    public String getCityCode() {
        return cityCode;
    }

    public void setCityCode(String cityCode) {
        this.cityCode = cityCode;
    }

    public String getCountyCode() {
        return countyCode;
    }

    public void setCountyCode(String countyCode) {
        this.countyCode = countyCode;
    }

    public String getDisplay() {
        return display;
    }

    public void setDisplay(String display) {
        this.display = display;
    }

    public String getKeywords() {
        return keywords;
    }

    public void setKeywords(String keywords) {
        this.keywords = keywords;
    }

    public String getProvinceCode() {
        return provinceCode;
    }

    public void setProvinceCode(String provinceCode) {
        this.provinceCode = provinceCode;
    }

    public Integer getDistance() {
        return distance;
    }

    public void setDistance(Integer distance) {
        this.distance = distance;
    }

}
