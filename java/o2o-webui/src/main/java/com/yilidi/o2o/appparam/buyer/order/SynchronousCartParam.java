package com.yilidi.o2o.appparam.buyer.order;

import java.util.List;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 同步购物车
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class SynchronousCartParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;
    /** 小区ID **/
    public static final String COMMUNITY_ID = "communityId";
    /** 店铺ID **/
    public static final String STORE_ID = "storeId";
    /** 购物车商品信息 **/
    public static final String CART_INFO = "cartInfo";

    @Field("小区ID")
    private Integer communityId;
    @Field("店铺ID")
    private Integer storeId;
    @Field("购物车商品信息")
    private List<CartInfoParam> cartInfo;

    public void validateParams() {
        if (ObjectUtils.isNullOrEmpty(storeId) && ObjectUtils.isNullOrEmpty(communityId)) {
            throw new IllegalArgumentException("小区ID和店铺ID不能同时为空");
        }
        Param communityIdValidate = new Param.Builder(getFieldName(COMMUNITY_ID), Param.ParamType.STR_INTEGER.getType(),
                communityId, true).build();
        Param storeIdValidate = new Param.Builder(getFieldName(STORE_ID), Param.ParamType.STR_INTEGER.getType(), storeId,
                true).build();
        ParamValidateUtils.validateParams(communityIdValidate, storeIdValidate);
        if (!ObjectUtils.isNullOrEmpty(cartInfo)) {
            for (CartInfoParam cart : cartInfo) {
                cart.validateParams();
            }
        }
    }

    public Integer getCommunityId() {
        return communityId;
    }

    public void setCommunityId(Integer communityId) {
        this.communityId = communityId;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

    public List<CartInfoParam> getCartInfo() {
        return cartInfo;
    }

    public void setCartInfo(List<CartInfoParam> cartInfo) {
        this.cartInfo = cartInfo;
    }
}
