package com.yilidi.o2o.appvo.buyer.product;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 查询首页正在活动的秒杀活动信息接口出参实体类
 * 
 * @author: chenb
 * @date: 2016年5月30日 下午9:03:43
 */
public class SecKillProdutctsVO extends AppBaseVO {

    private static final long serialVersionUID = -671382910287269872L;

    /**
     * 商品ID
     */
    private Integer saleProductId;
    /**
     * 产品ID
     */
    private Integer productId;

    /**
     * 秒杀商品品牌名称
     */
    private String brandName;
    /**
     * 秒杀商品名称
     */
    private String saleProductName;
    /**
     * 秒杀商品图片地址
     */
    private String saleProductImageUrl;
    /**
     * 商品秒杀价
     */
    private Long seckillPrice;
    /**
     * 商品当前库存数量
     */
    private Integer stockNum;
    /**
     * 商品规格
     */
    private String saleProductSpec;
    /**
     * 允许秒中数量
     */
    private Integer seckillTotalCount;
    /**
     * 商品秒杀场次中库存总数量
     */
    private Integer seckillShowTotalCount;
    /**
     * 限购数量
     */
    private Integer limitCount;
    /**
     * 活动ID
     */
    private Integer actId;

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getSaleProductName() {
        return saleProductName;
    }

    public void setSaleProductName(String saleProductName) {
        this.saleProductName = saleProductName;
    }

    public String getSaleProductImageUrl() {
        return saleProductImageUrl;
    }

    public void setSaleProductImageUrl(String saleProductImageUrl) {
        this.saleProductImageUrl = saleProductImageUrl;
    }

    public Long getSeckillPrice() {
        return seckillPrice;
    }

    public void setSeckillPrice(Long seckillPrice) {
        this.seckillPrice = seckillPrice;
    }

    public Integer getStockNum() {
        return stockNum;
    }

    public void setStockNum(Integer stockNum) {
        this.stockNum = stockNum;
    }

    public String getSaleProductSpec() {
        return saleProductSpec;
    }

    public void setSaleProductSpec(String saleProductSpec) {
        this.saleProductSpec = saleProductSpec;
    }

    public Integer getSeckillTotalCount() {
        return seckillTotalCount;
    }

    public void setSeckillTotalCount(Integer seckillTotalCount) {
        this.seckillTotalCount = seckillTotalCount;
    }

    public Integer getSeckillShowTotalCount() {
        return seckillShowTotalCount;
    }

    public void setSeckillShowTotalCount(Integer seckillShowTotalCount) {
        this.seckillShowTotalCount = seckillShowTotalCount;
    }

    public Integer getLimitCount() {
        return limitCount;
    }

    public void setLimitCount(Integer limitCount) {
        this.limitCount = limitCount;
    }

    public Integer getActId() {
        return actId;
    }

    public void setActId(Integer actId) {
        this.actId = actId;
    }

}
