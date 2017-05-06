/**
 * 文件名称：ProductClassDto.java
 * 
 * 描述：产品类别Dto
 * 
 *
 */
package com.yilidi.o2o.product.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：产品类别与店铺类型映射实体类Dto<br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class ProductClassStoreTypeDto extends BaseDto {

    private static final long serialVersionUID = 572902020233354543L;

    /**
     * 产品类别与店铺类型映射实体ID，自增主键
     */
    private Integer id;
    /**
     * 店铺类别
     */
    private String storeType;
    /**
     * 店铺类别名称
     */
    private String storeTypeName;
    /**
     * 产品类别编码
     */
    private String classCode;
    /**
     * 产品类别名称
     */
    private String className;
    /**
     * 创建用户ID
     */
    private Integer createUserId;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 是否存在类型为storeType的店铺里，所属于classCode的分类下的上架商品
     */
    private String isExistOnShelfSaleProduct = "N";

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

    public String getStoreTypeName() {
        return storeTypeName;
    }

    public void setStoreTypeName(String storeTypeName) {
        this.storeTypeName = storeTypeName;
    }

    public String getClassCode() {
        return classCode;
    }

    public void setClassCode(String classCode) {
        this.classCode = classCode;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
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

    public String getIsExistOnShelfSaleProduct() {
        return isExistOnShelfSaleProduct;
    }

    public void setIsExistOnShelfSaleProduct(String isExistOnShelfSaleProduct) {
        this.isExistOnShelfSaleProduct = isExistOnShelfSaleProduct;
    }

}