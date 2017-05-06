package com.yilidi.o2o.order.service.dto;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * @Description: TODO(商品结算信息数据DTO)
 * @author: chenlian
 * @date: 2016年6月1日 上午10:10:40
 */
public class SaleProductSettleDto extends BaseDto {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -2359972131663323152L;
    /**
     * 商品ID
     */
    private Integer saleProductId;
    /**
     * 商品名称
     */
    private String saleProductName;
    /**
     * 品牌名称
     */
    private String brandName;
    /**
     * 商品结算数量
     */
    private Integer settleCount;
    /**
     * 商品结算金额
     */
    private Long settleAmount;

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public String getSaleProductName() {
        return saleProductName;
    }

    public void setSaleProductName(String saleProductName) {
        this.saleProductName = saleProductName;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public Integer getSettleCount() {
        return settleCount;
    }

    public void setSettleCount(Integer settleCount) {
        this.settleCount = settleCount;
    }

    public Long getSettleAmount() {
        return settleAmount;
    }

    public void setSettleAmount(Long settleAmount) {
        this.settleAmount = settleAmount;
    }
}
