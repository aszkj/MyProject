package com.yldbkd.www.buyer.android.bean;

/**
 * Created by linghuxj on 16/9/2.
 */
public class SecKillProduct extends ProductBase {
    /**
     * 商品秒杀价
     */
    private Long seckillPrice;
    /**
     * 商品秒杀场次中库存总数量
     */
    private Integer seckillTotalCount;
    /**
     * 商品秒杀场次中库存显示总数量
     */
    private Integer seckillShowTotalCount;

    public Long getSeckillPrice() {
        return seckillPrice;
    }

    public void setSeckillPrice(Long seckillPrice) {
        this.seckillPrice = seckillPrice;
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
}
