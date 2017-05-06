package com.yldbkd.www.buyer.android.bean;

import java.util.List;

/**
 * 分页数据类型
 * <p/>
 * Created by linghuxj on 15/10/14.
 */
public class Page<T extends BaseModel> extends BaseModel {

    /**
     * 当前页
     */
    private int pageNum;
    /**
     * 每页的记录数
     */
    private int pageSize;
    /**
     * 当前页的数量
     */
    private int currentSize;
    /**
     * 总记录数
     */
    private long totalRecords = 0l;
    /**
     * 总页数
     */
    private int totalPages = 0;
    /**
     * 结果集
     */
    private List<T> list;

    public int getPageNum() {
        return pageNum;
    }

    public void setPageNum(int pageNum) {
        this.pageNum = pageNum;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getCurrentSize() {
        return currentSize;
    }

    public void setCurrentSize(int currentSize) {
        this.currentSize = currentSize;
    }

    public long getTotalRecords() {
        return totalRecords;
    }

    public void setTotalRecords(long totalRecords) {
        this.totalRecords = totalRecords;
    }

    public int getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }
}
