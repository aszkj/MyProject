package com.yilidi.o2o.appparam.buyer.system;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 获取轮播广告
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class GetImageRotateParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;

    @Field("广告类别")
    private String type;

    public void validateParams() {
        Param typeValidate = new Param.Builder(getFieldName("type"), Param.ParamType.STR_NORMAL.getType(), type, false)
                .build();
        ParamValidateUtils.validateParams(typeValidate);
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

}
