package com.yilidi.o2o.appparam.seller.user;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * @Description: TODO(店铺意见反馈参数)
 * @author: chenlian
 * @date: 2016年6月21日 上午12:18:08
 */
public class StoreFeedbackParam extends AppBaseParam {

    private static final long serialVersionUID = -7050180119041902385L;

    private static final String FEEBACK_CONTENT = "feebackContent";

    @Field("意见反馈内容")
    private String feebackContent;

    public void validateParams() {
        Param feebackContentValidate = new Param.Builder(getFieldName(FEEBACK_CONTENT),
                Param.ParamType.STR_NORMAL.getType(), feebackContent, false).maxLength(512).build();
        ParamValidateUtils.validateParams(feebackContentValidate);
    }

    public String getFeebackContent() {
        return feebackContent;
    }

    public void setFeebackContent(String feebackContent) {
        this.feebackContent = feebackContent;
    }

}
