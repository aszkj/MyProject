package com.yilidi.o2o.order.service.dto.query;

import java.io.Serializable;
import java.util.Date;

/**
 * 用于接收订单统计，商品销量统计，分类销量统计，店铺销量统计的入参
 *
 * @author: zhangkun
 * @date: 2016年12月2日 上午11:31:20
 */
public class StatisticsParamQueryDto implements Serializable {
    /**
     * @Fields serialVersionUID
     */
    private static final long serialVersionUID = 1L;
    /**
     * 开始时间
     */
    private Date beginTime;
    /**
     * 结束时间
     */
    private Date endTime;
    /**
     * 开始时间字符串
     */
    private String beginTimeStr;
    /**
     * 结束时间字符串
     */
    private String endTimeStr;
    /**
     * 商品条形码
     */
    private String barCode;
    /**
     * 商品分类名称
     */
    private String productClassName;
    /**
     * 商品分类名称
     */
    private String productClassCode;
    /**
     * 分组参数（product：按商品分组；classes：按商品分类分组；store：按店铺分组）
     */
    private String groupParam;
    /**
     * 排序参数（number：按商品总量排序；price:按商品总价格排序）
     */
    private String orderParam;
    /**
     * 排行基数
     */
    private Integer size;
    /**
     * 搜索时间类型
     */
    private Integer searchDateType;

    public Date getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getBeginTimeStr() {
        return beginTimeStr;
    }

    public void setBeginTimeStr(String beginTimeStr) {
        this.beginTimeStr = beginTimeStr;
    }

    public String getEndTimeStr() {
        return endTimeStr;
    }

    public void setEndTimeStr(String endTimeStr) {
        this.endTimeStr = endTimeStr;
    }

    public String getBarCode() {
        return barCode;
    }

    public void setBarCode(String barCode) {
        this.barCode = barCode;
    }

    public String getProductClassName() {
        return productClassName;
    }

    public void setProductClassName(String productClassName) {
        this.productClassName = productClassName;
    }

    public String getGroupParam() {
        return groupParam;
    }

    public void setGroupParam(String groupParam) {
        this.groupParam = groupParam;
    }

    public String getOrderParam() {
        return orderParam;
    }

    public void setOrderParam(String orderParam) {
        this.orderParam = orderParam;
    }

    public Integer getSearchDateType() {
        return searchDateType;
    }

    public void setSearchDateType(Integer searchDateType) {
        this.searchDateType = searchDateType;
    }

    public Integer getSize() {
        return size;
    }

    public void setSize(Integer size) {
        this.size = size;
    }

    public String getProductClassCode() {
        return productClassCode;
    }

    public void setProductClassCode(String productClassCode) {
        this.productClassCode = productClassCode;
    }
}
