package com.yilidi.o2o.product.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 店铺类型与产品类别关系实体类，映射数据库表 YiLiDiProductCenter.P_STORE_TYPE_PRODUCT_CLASS)
 * 
 * @author: chenb
 * @date: 2016年6月17日 上午9:57:34
 */
public class StoreTypeProductClass extends BaseModel {
    private static final long serialVersionUID = 1L;

    /**
     * ID，自增主键
     */
    private Integer id;
    /**
     * 店铺类型
     */
    private String storeType;
    /**
     * 产品分类编码
     */
    private String classCode;
    /**
     * 创建者ID
     */
    private Integer createUserId;
    /**
     * 创建时间
     */
    private Date createTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getStoreType() {
        return storeType;
    }

    public void setStoreType(String storeType) {
        this.storeType = storeType;
    }

    public String getClassCode() {
        return classCode;
    }

    public void setClassCode(String classCode) {
        this.classCode = classCode;
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

}
