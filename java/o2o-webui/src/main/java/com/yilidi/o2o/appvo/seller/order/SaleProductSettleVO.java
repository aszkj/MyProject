package com.yilidi.o2o.appvo.seller.order;

import com.yilidi.o2o.appvo.seller.product.SaleProductBaseVO;

/**
 * @Description: TODO(商品结算信息数据)
 * @author: chenlian
 * @date: 2016年6月1日 上午10:10:40
 */
public class SaleProductSettleVO extends SaleProductBaseVO {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -2359972131663323152L;
    /**
     * 商品结算数量
     */
    private Integer settleCount;
    /**
     * 商品结算金额
     */
    private Long settleAmount;

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
