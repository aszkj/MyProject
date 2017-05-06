package com.yilidi.o2o.appparam.seller.system;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 获取类型所对应的规则或协议页面URL地址接口
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class HelpAddressParam extends AppBaseParam {
    
    private static final long serialVersionUID = 1L;
    
    @Field("类型")
    private Integer type;

    public void validateParams() {
        Param typeValidate = new Param.Builder(getFieldName("type"), Param.ParamType.STR_INTEGER.getType(), type, false)
                .build();
        ParamValidateUtils.validateParams(typeValidate);
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

}
