package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 抵用券包信息表，映射交易域表YiLiDiOrderCenter.T_VOUCHER_PACKAGE
 * 
 * @author: chenlian
 * @date: 2016年10月27日 下午2:13:44
 */
public class VoucherPackage extends BaseModel {

    private static final long serialVersionUID = 7860489022605610315L;

    /**
     * ID，主键自增
     */
    private Integer id;

    /**
     * 抵用券/券包名称
     */
    private String vouName;

    /**
     * 抵用金额，所有抵用券面值*张数的总额，单位 厘
     */
    private Long amount;

    /**
     * 抵用券包类型，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=VOUPACKTYPETYPE)
     */
    private String vouPackType;

    /**
     * 抵用券包内容，抵用券面值_张数的形式以逗号连接
     */
    private String vouPackContent;

    /**
     * 状态，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=VOUCHERSTATE) 未发放，已发放，已停用 三个状态
     */
    private String state;

    /**
     * 创建人
     */
    private Integer createUserId;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 修改人ID
     */
    private Integer modifyUserId;

    /**
     * 修改时间
     */
    private Date modifyTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getVouName() {
        return vouName;
    }

    public void setVouName(String vouName) {
        this.vouName = vouName;
    }

    public Long getAmount() {
        return amount;
    }

    public void setAmount(Long amount) {
        this.amount = amount;
    }

    public String getVouPackType() {
        return vouPackType;
    }

    public void setVouPackType(String vouPackType) {
        this.vouPackType = vouPackType;
    }

    public String getVouPackContent() {
        return vouPackContent;
    }

    public void setVouPackContent(String vouPackContent) {
        this.vouPackContent = vouPackContent;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getModifyUserId() {
        return modifyUserId;
    }

    public void setModifyUserId(Integer modifyUserId) {
        this.modifyUserId = modifyUserId;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

}