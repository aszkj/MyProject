package com.yilidi.o2o.appparam.buyer.user;

import com.yilidi.o2o.appparam.PageParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 附近店铺
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class StoreLocationListParam extends PageParam {

    private static final long serialVersionUID = 1L;

    @Field("纬度")
    private Double longitude;
    @Field("纬度")
    private Double latitude;

    public void validateParams() {
        Param longitudeValidate = new Param.Builder(getFieldName("longitude"), Param.ParamType.STR_DOUBLE.getType(),
                longitude, false).build();
        Param latitudeValidate = new Param.Builder(getFieldName("latitude"), Param.ParamType.STR_DOUBLE.getType(), latitude,
                false).build();
        ParamValidateUtils.validateParams(longitudeValidate, latitudeValidate);
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }
}
