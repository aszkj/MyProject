/**
 * 文件名称：ProductClassDto.java
 * 
 * 描述：产品类别Dto
 * 
 *
 */
package com.yilidi.o2o.product.service.dto;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：产品类别实体类Dto<br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class ProductClassDto extends BaseDto {
    private static final long serialVersionUID = 1078165196917737515L;
    private static final String DEFAULT_STATUSCODE = "PRODUCTCLASSSTATUS_ON";

    public ProductClassDto() {
        this.statusCode = DEFAULT_STATUSCODE;
    }

    /**
     * 产品类别ID，自增主键
     */
    private Integer id;
    /**
     * 产品类别编码
     */
    private String classCode;
    /**
     * 产品类别级别
     */
    private String classLevel;
    /**
     * 产品类别url
     */
    private String classImageUrl;
    /**
     * 产品类别排序
     */
    private Integer classSort;
    /**
     * 产品类别名称
     */
    private String className;
    /**
     * 状态编码
     */
    private String statusCode;
    /**
     * 状态编码描述
     */
    private String statusCodeName;
    /**
     * 是否显示
     */
    private String display;
    /**
     * 产品类别描述
     */
    private String note;
    /**
     * 创建用户ID
     */
    private Integer createUserId;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 修改用户ID
     */
    private Integer modifyUserId;
    /**
     * 修改时间
     */
    private Date modifyTime;
    /**
     * 图片增加标示
     */
    private String imageFlag;
    /**
     * 图片需要删除的Url
     */
    private String delImageUrl;

    private List<ProductClassDto> subClassList;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getClassCode() {
        return classCode;
    }

    public void setClassCode(String classCode) {
        this.classCode = classCode;
    }

    public String getClassLevel() {
        return classLevel;
    }

    public void setClassLevel(String classLevel) {
        this.classLevel = classLevel;
    }

    public String getClassImageUrl() {
        return classImageUrl;
    }

    public void setClassImageUrl(String classImageUrl) {
        this.classImageUrl = classImageUrl;
    }

    public Integer getClassSort() {
        return classSort;
    }

    public void setClassSort(Integer classSort) {
        this.classSort = classSort;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public String getStatusCodeName() {
        return statusCodeName;
    }

    public void setStatusCodeName(String statusCodeName) {
        this.statusCodeName = statusCodeName;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
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

    public String getImageFlag() {
        return imageFlag;
    }

    public void setImageFlag(String imageFlag) {
        this.imageFlag = imageFlag;
    }

    public String getDelImageUrl() {
        return delImageUrl;
    }

    public void setDelImageUrl(String delImageUrl) {
        this.delImageUrl = delImageUrl;
    }

    public String getDisplay() {
        return display;
    }

    public void setDisplay(String display) {
        this.display = display;
    }

    public List<ProductClassDto> getSubClassList() {
        return subClassList;
    }

    public void setSubClassList(List<ProductClassDto> subClassList) {
        this.subClassList = subClassList;
    }

}