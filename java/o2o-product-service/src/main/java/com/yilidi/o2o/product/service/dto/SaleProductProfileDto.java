/**
 * 文件名称：SaleProductProfileDto.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service.dto;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 功能描述：商品描述模型Dto <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleProductProfileDto extends BaseDto {
    private static final long serialVersionUID = 8171417452199944834L;

    private static final String DEFAULT_SALESTATUS = "SALEPRODUCTSALESTATUS_INIT";
    private static final String DEFAULT_PRODUCTOWNER = "PRODUCTOWNER_OTHER";
    private static final String DEFAULT_HOTSALEFLAG = "HOTSALEFLAG_NO";

    public SaleProductProfileDto() {
        this.productOwner = DEFAULT_PRODUCTOWNER;
        this.hotSaleFlag = DEFAULT_HOTSALEFLAG;
        this.saleStatus = DEFAULT_SALESTATUS;
    }

    /**
     * ID, 自增主键
     */
    private Integer id;
    /**
     * 商品ID
     */
    private Integer saleProductId;
    /**
     * 渠道编码
     */
    private String channelCode;
    /**
     * 卖点描述
     */
    private String sellPoint;
    /**
     * 产品归属
     */
    private String productOwner;
    /**
     * 是否热卖
     */
    private String hotSaleFlag;
    /**
     * 商品上下架状态
     */
    private String saleStatus;
    /**
     * 商品上下架状态
     */
    private String saleStatusName;
    /**
     * 详情内容
     */
    private String content;
    /**
     * 商品来源
     */
    private String saleProductSource;
    /**
     * 商品规格
     */
    private String saleProductSpec;
    /**
     * 显示顺序
     */
    private Integer displayOrder;
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

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public String getChannelCode() {
        return channelCode;
    }

    public void setChannelCode(String channelCode) {
        this.channelCode = channelCode;
    }

    public String getSellPoint() {
        return sellPoint;
    }

    public void setSellPoint(String sellPoint) {
        this.sellPoint = sellPoint;
    }

    public String getProductOwner() {
        return productOwner;
    }

    public void setProductOwner(String productOwner) {
        this.productOwner = productOwner;
    }

    public String getHotSaleFlag() {
        return hotSaleFlag;
    }

    public void setHotSaleFlag(String hotSaleFlag) {
        this.hotSaleFlag = hotSaleFlag;
    }

    public String getSaleStatus() {
        return saleStatus;
    }

    public void setSaleStatus(String saleStatus) {
        this.saleStatus = saleStatus;
    }

    public String getSaleStatusName() {
        return saleStatusName;
    }

    public void setSaleStatusName(String saleStatusName) {
        this.saleStatusName = saleStatusName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getSaleProductSource() {
        return saleProductSource;
    }

    public void setSaleProductSource(String saleProductSource) {
        this.saleProductSource = saleProductSource;
    }

    public String getSaleProductSpec() {
        return saleProductSpec;
    }

    public void setSaleProductSpec(String saleProductSpec) {
        this.saleProductSpec = saleProductSpec;
    }

    public Integer getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
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
