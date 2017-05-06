package com.yilidi.o2o.appparam.buyer.order;

import java.util.List;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 订单结算
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class SettlementOrderParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;

    @Field("收货地址ID")
    private Integer addressId;
    @Field("配送类型")
    private Integer deliveryModeCode;
    @Field("店铺ID")
    private Integer storeId;
    @Field("购物车商品数量信息")
    private List<CartInfoParam> cartInfo;

    @Field("经度")
    private String longitude;
    @Field("纬度")
    private String latitude;

    public void validateParams() {
        if (ObjectUtils.isNullOrEmpty(addressId) && ObjectUtils.isNullOrEmpty(storeId)) {
            throw new IllegalArgumentException("小区ID和地址ID不能同时为空");
        }
        Param communityIdValidate = new Param.Builder(getFieldName("addressId"), Param.ParamType.STR_INTEGER.getType(),
                addressId, true).build();
        Param storeIdValidate = new Param.Builder(getFieldName("storeId"), Param.ParamType.STR_INTEGER.getType(), storeId,
                true).build();
        Param deliveryModeCodeValidate = new Param.Builder(getFieldName("deliveryModeCode"),
                Param.ParamType.STR_INTEGER.getType(), deliveryModeCode, true).build();
        Param longitudeValidate = new Param.Builder(getFieldName("longitude"), Param.ParamType.STR_DOUBLE.getType(),
                longitude, false).build();
        Param latitudeValidate = new Param.Builder(getFieldName("latitude"), Param.ParamType.STR_DOUBLE.getType(), latitude,
                false).build();
        ParamValidateUtils.validateParams(communityIdValidate, longitudeValidate, latitudeValidate, storeIdValidate,
                deliveryModeCodeValidate);
        if (ObjectUtils.isNullOrEmpty(cartInfo)) {
            throw new IllegalArgumentException("cartInfo can not be empty");
        }
        for (CartInfoParam cart : cartInfo) {
            cart.validateParams();
        }
    }

    public Integer getAddressId() {
        return addressId;
    }

    public void setAddressId(Integer addressId) {
        this.addressId = addressId;
    }

    public List<CartInfoParam> getCartInfo() {
        return cartInfo;
    }

    public void setCartInfo(List<CartInfoParam> cartInfo) {
        this.cartInfo = cartInfo;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public Integer getDeliveryModeCode() {
        return deliveryModeCode;
    }

    public void setDeliveryModeCode(Integer deliveryModeCode) {
        this.deliveryModeCode = deliveryModeCode;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

}
