/**
 * 文件名称：BaseQuery.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.core.model;

import java.io.Serializable;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.utils.JsonUtils;

/**
 * 功能描述：查询封装基础类，实现序列号和toString方法 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class BaseQuery implements Serializable {
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
     * 开始页（分页查询时，用于redis缓存的Key中）
     */
    private Integer start = 1;

    /**
     * 每页的行数（分页查询时，用于redis缓存的Key中）
     */
    private Integer pageSize = CommonConstants.PAGE_SIZE;

    public String getSort() {
        return sort;
    }

    /**
     * 设置排序的方式， ASC ,DESC
     * 
     * @param sort
     *            排序方式
     */
    public void setSort(String sort) {
        this.sort = sort;
    }

    public String getOrder() {
        return order;
    }

    /**
     * 设置排序的字段
     * 
     * @param order
     *            排序字段
     */
    public void setOrder(String order) {
        this.order = order;
    }

    public Integer getStart() {
        return start;
    }

    /**
     * 设置开始页（分页查询时，用于redis缓存的Key中）
     * 
     * @param start
     *            开始页
     */
    public void setStart(Integer start) {
        this.start = start;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    /**
     * 设置每页的行数（分页查询时，用于redis缓存的Key中）
     * 
     * @param pageSize
     *            每页的行数
     */
    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    @Override
    public String toString() {
        return JsonUtils.toJsonStringWithDateFormat(this);
    }
}
