package com.yilidi.o2o.appparam.buyer.system;

import org.springframework.util.StringUtils;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 获取类型所对应的规则或协议页面URL地址接口
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class GetTypeUrlParam extends AppBaseParam {
    
    private static final long serialVersionUID = 1L;
    
    @Field("H5页面类型")
    private Integer type;
    
    @Field("H5页面类型编码")
    private String typeCode;

    public void validateParams() {
        if (ObjectUtils.isNullOrEmpty(type) && StringUtils.isEmpty(typeCode)) {
            throw new ProductServiceException("H5页面类型type与H5页面类型编码typeCode不能同时为空");
        }
        Param typeValidate = new Param.Builder(getFieldName("type"), Param.ParamType.STR_INTEGER.getType(), type, true)
                .build();
        Param typeCodeValidate = new Param.Builder(getFieldName("typeCode"), Param.ParamType.STR_NORMAL.getType(), typeCode, true)
        .build();
        ParamValidateUtils.validateParams(typeValidate,typeCodeValidate);
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
    }

}
