/**
 * 文件名称：ProductQuery.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.product.service.dto.query;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.model.BaseQuery;

/**
 * 功能描述：产品查询查询条件封装类 <br/>
 * 作者：zxs <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class ProductQuery extends BaseQuery {
    private static final long serialVersionUID = 7641532048579854481L;

    /**
     * 产品ID
     */
    private Integer id;
    /**
     * 产品类别编码，关联产品域产品分类表P_PRODUCT_CLASS的PRODUCTCLASSCODE字段
     */
    private String productClassCode;
    /**
     * 产品类别父类编码(目前只有两级分类)，关联产品域产品分类表P_PRODUCT_CLASS的PARENTCODE字段
     */
    private String parentCode;
    /**
     * 产品编码，关联产品域品牌表P_PRODUCT_BRAND的BRANDCODE字段
     */
    private String brandCode;
    /**
     * 产品名称
     */
    private String productName;
    /**
     * 产品条形码，产品的唯一标识
     */
    private String barCode;
    /**
     * 产品状态, 标识该产品是否有效，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PRODUCTSTATUS)
     */
    private String statusCode;
    /**
     * 查询创建用户ID
     */
    private Integer createUserId;
    /**
     * 查询创建开始时间
     */
    private Date startCreateTime;
    /**
     * 查询创建结束时间
     */
    private Date endCreateTime;
    /**
     * 查询修改用户ID
     */
    private Integer modifyUserId;
    /**
     * 查询修改开始时间
     */
    private Date startModifyTime;
    /**
     * 查询修改结束时间
     */
    private Date endModifyTime;
    /**
     * 产品查询促销价最大值，单位厘
     */
    private Long promotionalMaxPrice;
    /**
     * 产品查询促销价最小值，单位厘
     */
    private Long promotionalMinPrice;
    /**
     * 产品查询零售价最大范围值，单位厘
     */
    private Long retailMaxPrice;
    /**
     * 产品查询零售价最小范围值，单位厘
     */
    private Long retailMinPrice;
    /**
     * 卖点描述
     */
    private String sellPoint;
    /**
     * 是否热卖
     */
    private String hotSaleFlag;
    /**
     * 上架状态, 标识该产品是否上架，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=PRODUCTSALESTATUS)
     */
    private String saleStatus;
    /**
     * 产品归属
     */
    private String productOwner;
    /**
     * 详情内容
     */
    private String content;
    /**
     * 渠道编码
     */
    private String channelCode;
    /**
     * 商品分类是否显示
     */
    private String display;
    /**
     * 商品分类数组
     */
    private List<Object> classCodes;
    /**
     * 品牌名称
     */
    private String brandName;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getProductClassCode() {
        return productClassCode;
    }

    public void setProductClassCode(String productClassCode) {
        this.productClassCode = productClassCode;
    }

    public String getParentCode() {
        return parentCode;
    }

    public void setParentCode(String parentCode) {
        this.parentCode = parentCode;
    }

    public String getBrandCode() {
        return brandCode;
    }

    public void setBrandCode(String brandCode) {
        this.brandCode = brandCode;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getBarCode() {
        return barCode;
    }

    public void setBarCode(String barCode) {
        this.barCode = barCode;
    }

    public String getSaleStatus() {
        return saleStatus;
    }

    public void setSaleStatus(String saleStatus) {
        this.saleStatus = saleStatus;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
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

    public Date getStartModifyTime() {
        return startModifyTime;
    }

    public void setStartModifyTime(Date startModifyTime) {
        this.startModifyTime = startModifyTime;
    }

    public Date getEndModifyTime() {
        return endModifyTime;
    }

    public void setEndModifyTime(Date endModifyTime) {
        this.endModifyTime = endModifyTime;
    }

    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

    public Integer getModifyUserId() {
        return modifyUserId;
    }

    public void setModifyUserId(Integer modifyUserId) {
        this.modifyUserId = modifyUserId;
    }

    public Long getPromotionalMaxPrice() {
        return promotionalMaxPrice;
    }

    public void setPromotionalMaxPrice(Long promotionalMaxPrice) {
        this.promotionalMaxPrice = promotionalMaxPrice;
    }

    public Long getPromotionalMinPrice() {
        return promotionalMinPrice;
    }

    public void setPromotionalMinPrice(Long promotionalMinPrice) {
        this.promotionalMinPrice = promotionalMinPrice;
    }

    public Long getRetailMaxPrice() {
        return retailMaxPrice;
    }

    public void setRetailMaxPrice(Long retailMaxPrice) {
        this.retailMaxPrice = retailMaxPrice;
    }

    public Long getRetailMinPrice() {
        return retailMinPrice;
    }

    public void setRetailMinPrice(Long retailMinPrice) {
        this.retailMinPrice = retailMinPrice;
    }

    public String getSellPoint() {
        return sellPoint;
    }

    public void setSellPoint(String sellPoint) {
        this.sellPoint = sellPoint;
    }

    public String getHotSaleFlag() {
        return hotSaleFlag;
    }

    public void setHotSaleFlag(String hotSaleFlag) {
        this.hotSaleFlag = hotSaleFlag;
    }

    public String getProductOwner() {
        return productOwner;
    }

    public void setProductOwner(String productOwner) {
        this.productOwner = productOwner;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getChannelCode() {
        return channelCode;
    }

    public void setChannelCode(String channelCode) {
        this.channelCode = channelCode;
    }

    public String getDisplay() {
        return display;
    }

    public void setDisplay(String display) {
        this.display = display;
    }

    public List<Object> getClassCodes() {
        return classCodes;
    }

    public void setClassCodes(List<Object> classCodes) {
        this.classCodes = classCodes;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

}
