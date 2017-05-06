package com.yilidi.o2o.product.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 数据包产品批次信息实体类，关联产品域表YiLiDiProductCenter.P_PACKET_PRODUCT_BATCH_INFO
 * 
 * @author: chenlian
 * @date: 2016年12月12日 下午5:41:09
 */
public class AuditProductBatchInfo extends BaseModel {

    private static final long serialVersionUID = 1903267708542171150L;
    /**
     * 主键ID
     */
    private Integer id;
    /**
     * 批次号
     */
    private String batchNo;
    /**
     * 批量上传产品数量
     */
    private Integer uploadCount;
    /**
     * 提交审核状态, 关联系统域系统字典S_STYSTEM_DICT表的DICTCODE字段(DICTTYPE=PACKETPRODUCTSUBMITSTATUS)
     */
    private String submitStatus;
    /**
     * 提交审核时间
     */
    private Date submitTime;
    /**
     * 提交审核用户ID
     */
    private Integer submitUserId;
    /**
     * 提交审核产品数量
     */
    private Integer submitCount;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 创建用户ID
     */
    private Integer createUserId;
    /**
     * 修改时间
     */
    private Date modifyTime;
    /**
     * 修改用户ID
     */
    private Integer modifyUserId;
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

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBatchNo() {
        return batchNo;
    }

    public void setBatchNo(String batchNo) {
        this.batchNo = batchNo;
    }

    public Integer getUploadCount() {
        return uploadCount;
    }

    public void setUploadCount(Integer uploadCount) {
        this.uploadCount = uploadCount;
    }

    public String getSubmitStatus() {
        return submitStatus;
    }

    public void setSubmitStatus(String submitStatus) {
        this.submitStatus = submitStatus;
    }

    public Date getSubmitTime() {
        return submitTime;
    }

    public void setSubmitTime(Date submitTime) {
        this.submitTime = submitTime;
    }

    public Integer getSubmitUserId() {
        return submitUserId;
    }

    public void setSubmitUserId(Integer submitUserId) {
        this.submitUserId = submitUserId;
    }

    public Integer getSubmitCount() {
        return submitCount;
    }

    public void setSubmitCount(Integer submitCount) {
        this.submitCount = submitCount;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    public Integer getModifyUserId() {
        return modifyUserId;
    }

    public void setModifyUserId(Integer modifyUserId) {
        this.modifyUserId = modifyUserId;
    }

}