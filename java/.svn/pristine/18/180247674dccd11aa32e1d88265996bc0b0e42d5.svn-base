package com.yilidi.o2o.appparam.buyer.user;

import java.io.Serializable;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

public class BuyerFeedbackParam extends AppBaseParam implements Serializable {

    /**
     * @Fields serialVersionUID
     */
    private static final long serialVersionUID = 1L;
    @Field("反馈内容")
    private String content;

    @Override
    public void validateParams() {
        Param contentValidate = new Param.Builder(getFieldName("content"), Param.ParamType.STR_NORMAL.getType(), content,
                false).maxLength(512).build();
        ParamValidateUtils.validateParams(contentValidate);
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

}
