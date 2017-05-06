package com.yilidi.o2o.appparam.buyer.order;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 购物车信息
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class CartInfoParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;
    /**
     * 商品ID
     */
    public static final String SALE_PRODUCT_ID = "saleProductId";
    /**
     * 商品数量
     */
    public static final String CART_NUM = "cartNum";
    /**
     * 活动ID
     */
    public static final String ACTID = "actId";

    @Field("商品ID")
    private Integer saleProductId;

    @Field("商品数量")
    private Integer cartNum;
    @Field("活动ID")
    private Integer actId;

    public void validateParams() {
        Param saleProductIdValidate = new Param.Builder(getFieldName(SALE_PRODUCT_ID), Param.ParamType.STR_INTEGER.getType(),
                saleProductId, false).build();
        Param cartNumValidate = new Param.Builder(getFieldName(CART_NUM), Param.ParamType.STR_INTEGER.getType(), cartNum,
                false).build();
        Param actIdValidate = new Param.Builder(getFieldName(ACTID), Param.ParamType.STR_INTEGER.getType(), actId, true)
                .build();
        ParamValidateUtils.validateParams(saleProductIdValidate, cartNumValidate, actIdValidate);
    }

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public Integer getCartNum() {
        return cartNum;
    }

    public void setCartNum(Integer cartNum) {
        this.cartNum = cartNum;
    }

    public Integer getActId() {
        return actId;
    }

    public void setActId(Integer actId) {
        this.actId = actId;
    }

}
