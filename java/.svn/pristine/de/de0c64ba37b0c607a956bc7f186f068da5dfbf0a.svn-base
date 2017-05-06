package com.yilidi.o2o.appparam.buyer.product;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 查询首页正在活动的秒杀活动信息接口请求参数
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class ActivitySecKillInfoParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;

    @Field("店铺ID")
    private Integer storeId;

    public void validateParams() {
        Param storeIdValidate = new Param.Builder(getFieldName("storeId"), Param.ParamType.STR_INTEGER.getType(), storeId,
                false).build();
        ParamValidateUtils.validateParams(storeIdValidate);
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

}
