package com.yilidi.o2o.core.page;

import java.io.Serializable;
import java.util.List;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 
 * @Description:TODO(封装分页返回信息实体)
 * @author: chenlian
 * @date: 2015年11月11日 下午4:06:21
 * 
 */
public class YiLiDiPage<T extends BaseDto> implements Serializable {

    private static final long serialVersionUID = 668682736357018158L;

    /**
     * 当前页
     */
    private int currentPage;

    /**
     * 总页数
     */
    private int pageCount;

    /**
     * 总记录数
     */
    private long recordCount;

    /**
     * 每页的记录数
     */
    private int pageSize;

    /**
     * 结果集
     */
    private List<T> resultList;

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getPageCount() {
        return pageCount;
    }

    public void setPageCount(int pageCount) {
        this.pageCount = pageCount;
    }

    public long getRecordCount() {
        return recordCount;
    }

    public void setRecordCount(long recordCount) {
        this.recordCount = recordCount;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public List<T> getResultList() {
        return resultList;
    }

    public void setResultList(List<T> resultList) {
        this.resultList = resultList;
    }

}
