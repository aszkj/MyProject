package com.yilidi.o2o.order.model;

import java.util.Date;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：店铺商品库存统计实体类，映射产品域表YiLiDiOrderCenter.T_INVENTORY_STATISTICS <br/>
 * 
 * <pre>
 * 	注： 该实体对应的表数据是有每天晚上的调度任务从T_PRODUCT_INVENTORY中统计
 * </pre>
 * 
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class SaleInventoryStatistics extends BaseModel {
    private static final long serialVersionUID = 220700818515984460L;
    /**
     * ID
     */
    private Integer id;
    /**
     * 供应商ID，关联用户域客户表U_CUSTOMER的CUSTOMERID字段(CUSTOMERTYPE=CUSTOMERTYPE_SELLER)
     */
    private Integer storeId;
    /**
     * 产品类别编码，关联产品域产品分类表P_PRODUCT_CLASS的PRODUCTCLASSCODE字段
     */
    private String productClassCode;
    /**
     * 品牌编码, 关联产品域P_PRODUCT_BRAND表的BRANDCODE字段
     */
    private String brandCode;
    /**
     * 产品名称
     */
    private String productName;
    /**
     * 供应商产品ID， 关联产品域供应商产品表P_SALE_PRODUCT的SALEPRODUCTID字段
     */
    private Integer saleProductId;
    /**
     * 库存量，当前的实际库存量
     */
    private Integer remainCount;
    /**
     * 已订购量，已订购的商品数量
     */
    private Integer orderedCount;
    /**
     * 可订购量，目前可订购的商品数量（=REMAINCOUNT-ORDEREDCOUNT
     */
    private Integer aviableCount;
    /**
     * 待发货数量：已订购且已付款的产品数量（<= ORDEREDCOUNT）
     */
    private Integer standbyCount;
    /**
     * 统计时间
     */
    private Date statisticsDate;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getStoreId() {
		return storeId;
	}

	public void setStoreId(Integer storeId) {
		this.storeId = storeId;
	}

    public String getProductClassCode() {
        return productClassCode;
    }

    public void setProductClassCode(String productClassCode) {
        this.productClassCode = productClassCode;
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

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public Integer getRemainCount() {
        return remainCount;
    }

    public void setRemainCount(Integer remainCount) {
        this.remainCount = remainCount;
    }

    public Integer getOrderedCount() {
        return orderedCount;
    }

    public void setOrderedCount(Integer orderedCount) {
        this.orderedCount = orderedCount;
    }

    public Integer getAviableCount() {
        return aviableCount;
    }

    public void setAviableCount(Integer aviableCount) {
        this.aviableCount = aviableCount;
    }

    public Integer getStandbyCount() {
        return standbyCount;
    }

    public void setStandbyCount(Integer standbyCount) {
        this.standbyCount = standbyCount;
    }

    public Date getStatisticsDate() {
        return statisticsDate;
    }

    public void setStatisticsDate(Date statisticsDate) {
        this.statisticsDate = statisticsDate;
    }

}