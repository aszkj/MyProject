package com.yilidi.o2o.core.model;

import java.io.Serializable;

import com.yilidi.o2o.core.utils.JsonUtils;

/**
 * @Description: TODO(查询DTO基类)
 * @author: chenlian
 * @date: 2016年6月15日 下午5:56:43
 */
public class BaseQueryDto implements Serializable {
    private static final long serialVersionUID = 1512662657616992044L;

    /**
     * 排序字段
     */
    private String order;

    /**
     * 排序方式
     */
    private String sort;

    /**
     * 开始页
     */
    private Integer start;

    /**
     * 每页的行数
     */
    private Integer pageSize;

    public String getOrder() {
        return order;
    }

    public void setOrder(String order) {
        this.order = order;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public Integer getStart() {
        return start;
    }

    public void setStart(Integer start) {
        this.start = start;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    @Override
    public String toString() {
        return JsonUtils.toJsonStringWithDateFormat(this);
    }

}
