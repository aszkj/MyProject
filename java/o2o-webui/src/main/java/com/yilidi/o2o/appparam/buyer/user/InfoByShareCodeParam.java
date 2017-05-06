package com.yilidi.o2o.appparam.buyer.user;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 根据分享唯一标识获取分享活动信息
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class InfoByShareCodeParam extends AppBaseParam {

    private static final long serialVersionUID = -6105045282455531431L;
    @Field("分享码")
    private String shareCode;

    public void validateParams() {
        Param shareCodeValidate = new Param.Builder(getFieldName("shareCode"), Param.ParamType.STR_NORMAL.getType(),
                shareCode, false).build();
        ParamValidateUtils.validateParams(shareCodeValidate);
    }

    public String getShareCode() {
        return shareCode;
    }

    public void setShareCode(String shareCode) {
        this.shareCode = shareCode;
    }

}
