package com.yilidi.o2o.appparam.buyer.user;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 删除收货地址
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class AddressDeleteParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;

    @Field("地址ID")
    private Integer addressId;

    public void validateParams() {
        Param addressIdValidate = new Param.Builder(getFieldName("addressId"), Param.ParamType.STR_INTEGER.getType(),
                addressId, false).build();
        ParamValidateUtils.validateParams(addressIdValidate);
    }

    public Integer getAddressId() {
        return addressId;
    }

    public void setAddressId(Integer addressId) {
        this.addressId = addressId;
    }

}
