package com.yilidi.o2o.appparam.buyer.user;

import com.yilidi.o2o.appparam.PageParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 用户定位列表
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class UserLocationListParam extends PageParam {
    private static final long serialVersionUID = 1L;
    @Field("纬度")
    private String longitude;
    @Field("纬度")
    private String latitude;

    public void validateParams() {
        Param longitudeValidate = new Param.Builder(getFieldName("longitude"), Param.ParamType.STR_DOUBLE.getType(),
                longitude, false).build();
        Param latitudeValidate = new Param.Builder(getFieldName("latitude"), Param.ParamType.STR_DOUBLE.getType(), latitude,
                false).build();
        ParamValidateUtils.validateParams(longitudeValidate, latitudeValidate);
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

}
