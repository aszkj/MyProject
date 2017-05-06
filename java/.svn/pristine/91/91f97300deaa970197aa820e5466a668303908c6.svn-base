package com.yilidi.o2o.appparam.seller.user;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * @Description: TODO(获取合伙人首页统计信息参数)
 * @author: chenlian
 * @date: 2016年6月15日 下午12:01:54
 */
public class IndexStatParam extends AppBaseParam {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -7050180119041902385L;

    private static final String DATA_TYPE_STRING = "dataTypeString";

    /**
     * 统计数据类型字符串正则表达式
     */
    private static final String DATA_TYPE_STRING_PATTERN = "^(0|1){4}$";

    @Field("统计数据类型字符串")
    private String dataTypeString;

    public void validateParams() {
        Param dataTypeStringValidate = new Param.Builder(getFieldName(DATA_TYPE_STRING),
                Param.ParamType.STR_NORMAL.getType(), dataTypeString, false).regex(DATA_TYPE_STRING_PATTERN).build();
        ParamValidateUtils.validateParams(dataTypeStringValidate);
    }

    public String getDataTypeString() {
        return dataTypeString;
    }

    public void setDataTypeString(String dataTypeString) {
        this.dataTypeString = dataTypeString;
    }

}
