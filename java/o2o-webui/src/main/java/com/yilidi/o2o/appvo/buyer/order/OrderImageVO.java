package com.yilidi.o2o.appvo.buyer.order;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * orderImage
 * 
 * @author: chenb
 * @date: 2016年5月30日 下午9:03:43
 */
public class OrderImageVO extends AppBaseVO {

    private static final long serialVersionUID = 1L;

    /**
     * 订单商品图片
     */
    private String orderImage;

    public String getOrderImage() {
        return orderImage;
    }

    public void setOrderImage(String orderImage) {
        this.orderImage = orderImage;
    }

}
