package com.yilidi.o2o.order.model;

import com.yilidi.o2o.core.model.BaseModel;

/**
 * 功能描述：买家印象统计实体类，映射交易域表YiLiDiOrderCenter.T_IMPRESSION_STATISTICS <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class ImpressionStatistics extends BaseModel {
    private static final long serialVersionUID = -1553038057057122411L;
    /**
     * ID, 自增主键
     */
    private Integer id;
    /**
     * 供应商产品ID，关联产品域供应商产品表P_SALE_PRODUCT的SALEPRODUCTID字段
     */
    private Integer saleProductId;
    /**
     * 印象标签编码，关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=TRADEEVALUATIONIMPRESSION)
     */
    private String labelCode;
    /**
     * 印象统计数据
     */
    private Integer totalCount;

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

    public String getLabelCode() {
        return labelCode;
    }

    public void setLabelCode(String labelCode) {
        this.labelCode = labelCode;
    }

    public Integer getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(Integer totalCount) {
        this.totalCount = totalCount;
    }
}