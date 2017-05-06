package com.yilidi.o2o.order.service.dto.query;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseQueryDto;

/**
 * 抵用券包查询DTO
 * 
 * @author: chenlian
 * @date: 2016年10月27日 下午2:21:15
 */
public class VoucherPackageQueryDto extends BaseQueryDto {

    private static final long serialVersionUID = 742973554402582744L;

    /**
     * 抵用券/券包名称
     */
    private String vouName;

    /**
     * 状态
     */
    private String state;

    /**
     * 查询开始创建时间
     */
    private String startCreateTime;

    /**
     * 查询结束创建时间
     */
    private String endCreateTime;

    /**
     * 查询开始创建时间
     */
    private Date startCreateDate;

    /**
     * 查询结束创建时间
     */
    private Date endCreateDate;

    public String getVouName() {
        return vouName;
    }

    public void setVouName(String vouName) {
        this.vouName = vouName;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getStartCreateTime() {
        return startCreateTime;
    }

    public void setStartCreateTime(String startCreateTime) {
        this.startCreateTime = startCreateTime;
    }

    public String getEndCreateTime() {
        return endCreateTime;
    }

    public void setEndCreateTime(String endCreateTime) {
        this.endCreateTime = endCreateTime;
    }

    public Date getStartCreateDate() {
        return startCreateDate;
    }

    public void setStartCreateDate(Date startCreateDate) {
        this.startCreateDate = startCreateDate;
    }

    public Date getEndCreateDate() {
        return endCreateDate;
    }

    public void setEndCreateDate(Date endCreateDate) {
        this.endCreateDate = endCreateDate;
    }

}
