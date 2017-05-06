package com.yilidi.o2o.product.service.dto.query;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseQueryDto;

/**
 * 数据包产品批次信息查询DTO
 * 
 * @author: chenlian
 * @date: 2016年12月12日 下午5:53:49
 */
public class AuditProductBatchInfoQueryDto extends BaseQueryDto {

    private static final long serialVersionUID = 1903267708542171150L;
    /**
     * 批次号
     */
    private String batchNo;
    /**
     * 提交审核状态
     */
    private String submitStatus;
    /**
     * 创建开始时间
     */
    private Date startCreateTime;
    /**
     * 创建结束时间
     */
    private Date endCreateTime;
    /**
     * 创建开始时间(字符串)
     */
    private String strStartCreateTime;
    /**
     * 创建结束时间(字符串)
     */
    private String strEndCreateTime;
    /**
     * 数据来源
     */
    private String dataResource;
    

    public String getDataResource() {
		return dataResource;
	}

	public void setDataResource(String dataResource) {
		this.dataResource = dataResource;
	}
    public String getBatchNo() {
        return batchNo;
    }

    public void setBatchNo(String batchNo) {
        this.batchNo = batchNo;
    }

    public String getSubmitStatus() {
        return submitStatus;
    }

    public void setSubmitStatus(String submitStatus) {
        this.submitStatus = submitStatus;
    }

    public Date getStartCreateTime() {
        return startCreateTime;
    }

    public void setStartCreateTime(Date startCreateTime) {
        this.startCreateTime = startCreateTime;
    }

    public Date getEndCreateTime() {
        return endCreateTime;
    }

    public void setEndCreateTime(Date endCreateTime) {
        this.endCreateTime = endCreateTime;
    }

    public String getStrStartCreateTime() {
        return strStartCreateTime;
    }

    public void setStrStartCreateTime(String strStartCreateTime) {
        this.strStartCreateTime = strStartCreateTime;
    }

    public String getStrEndCreateTime() {
        return strEndCreateTime;
    }

    public void setStrEndCreateTime(String strEndCreateTime) {
        this.strEndCreateTime = strEndCreateTime;
    }

}