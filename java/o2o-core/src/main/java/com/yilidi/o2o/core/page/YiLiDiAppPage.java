package com.yilidi.o2o.core.page;

import java.io.Serializable;
import java.util.List;

import com.yilidi.o2o.core.model.BaseVO;

/**
 * 
 * @Description:TODO(封装分页返回信息实体供APP使用)
 * @author: chenlian
 * @date: 2015年12月15日 上午9:47:57
 * 
 */
public class YiLiDiAppPage<E extends BaseVO> implements Serializable {

    private static final long serialVersionUID = 668682736357018158L;

    /**
     * 当前页
     */
    private int pageNum;

    /**
     * 总页数
     */
    private int totalPages;

    /**
     * 总记录数
     */
    private long totalRecords;

    /**
     * 每页的记录数
     */
    private int pageSize;

    /**
     * 结果集
     */
    private List<E> list;

    public int getPageNum() {
        return pageNum;
    }

    public void setPageNum(int pageNum) {
        this.pageNum = pageNum;
    }

    public int getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }

    public long getTotalRecords() {
        return totalRecords;
    }

    public void setTotalRecords(long totalRecords) {
        this.totalRecords = totalRecords;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public List<E> getList() {
        return list;
    }

    public void setList(List<E> list) {
        this.list = list;
    }

}
