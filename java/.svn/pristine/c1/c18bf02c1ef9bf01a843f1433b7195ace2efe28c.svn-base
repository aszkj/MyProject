package com.yilidi.o2o.appparam.buyer.system;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 区域字典
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class LoadAreaParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;

    /**
     * 发送验证码类型正则表达式
     */
    private static final String CAPTCHA_TYPE_PATTERN = "^(1|2|3|4)$";

    @Field("区域编码")
    private String parentAreaDictCode;

    public void validateParams() {
        Param parentAreaDictCodeValidate = new Param.Builder(getFieldName("parentAreaDictCode"),
                Param.ParamType.STR_NORMAL.getType(), parentAreaDictCode, true).build();
        ParamValidateUtils.validateParams(parentAreaDictCodeValidate);
    }

    public String getParentAreaDictCode() {
        return parentAreaDictCode;
    }

    public void setParentAreaDictCode(String parentAreaDictCode) {
        this.parentAreaDictCode = parentAreaDictCode;
    }

    public static long getSerialversionuid() {
        return serialVersionUID;
    }

}
