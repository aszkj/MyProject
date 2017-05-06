package com.yilidi.o2o.appvo.buyer.order;

import java.util.List;

import com.yilidi.o2o.appvo.AppBaseVO;
import com.yilidi.o2o.appvo.buyer.product.RewardTicketVO;
import com.yilidi.o2o.appvo.buyer.product.RewardSaleProductVO;

/**
 * 订单赠品信息
 * 
 * @author: chenb
 * @date: 2016年5月27日 下午7:26:46
 */
public class GiftInfoVO extends AppBaseVO {

    private static final long serialVersionUID = -2586510275431448839L;

    /**
     * 赠品商品信息
     */
    private List<RewardSaleProductVO> giftProductList;
    /**
     * 赠品奖券信息
     */
    private List<RewardTicketVO> giftCouponList;

    public List<RewardSaleProductVO> getGiftProductList() {
        return giftProductList;
    }

    public void setGiftProductList(List<RewardSaleProductVO> giftProductList) {
        this.giftProductList = giftProductList;
    }

    public List<RewardTicketVO> getGiftCouponList() {
        return giftCouponList;
    }

    public void setGiftCouponList(List<RewardTicketVO> giftCouponList) {
        this.giftCouponList = giftCouponList;
    }

}
