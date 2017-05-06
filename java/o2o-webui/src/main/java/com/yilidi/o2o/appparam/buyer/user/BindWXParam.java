package com.yilidi.o2o.appparam.buyer.user;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 绑定微信接收参数
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class BindWXParam extends AppBaseParam {

    private static final long serialVersionUID = -795198841227142616L;
    private static final String TRADETYPE_PATTERN = "^(APP|JSAPI)$";
    @Field("微信第三方登录标识码")
    private String code;
    @Field("登录类型")
    private String tradeType;

    public void validateParams() {
        Param codeParam = new Param.Builder(getFieldName("code"), Param.ParamType.STR_NORMAL.getType(), code, false).build();
        if (ObjectUtils.isNullOrEmpty(tradeType)) {
            tradeType = "APP";
        }
        Param tradeTypeparam = new Param.Builder(getFieldName("tradeType"), Param.ParamType.STR_NORMAL.getType(), tradeType,
                false).regex(TRADETYPE_PATTERN).build();
        ParamValidateUtils.validateParams(codeParam, tradeTypeparam);
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getTradeType() {
        return tradeType;
    }

    public void setTradeType(String tradeType) {
        this.tradeType = tradeType;
    }

}
