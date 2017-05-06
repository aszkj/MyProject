package com.yilidi.o2o.appparam.buyer.product;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 首页分类专区
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class HomeClassZoneSaleProductParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;

    @Field("专区类型编码")
    private String zoneCode;
    @Field("店铺ID")
    private Integer storeId;

    public void validateParams() {
        Param zoneCodeValidate = new Param.Builder(getFieldName("zoneCode"), Param.ParamType.STR_NORMAL.getType(), zoneCode,
                false).build();
        Param storeIdValidate = new Param.Builder(getFieldName("storeId"), Param.ParamType.STR_INTEGER.getType(), storeId,
                false).build();
        ParamValidateUtils.validateParams(zoneCodeValidate, storeIdValidate);
    }

    public String getZoneCode() {
        return zoneCode;
    }

    public void setZoneCode(String zoneCode) {
        this.zoneCode = zoneCode;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

}
