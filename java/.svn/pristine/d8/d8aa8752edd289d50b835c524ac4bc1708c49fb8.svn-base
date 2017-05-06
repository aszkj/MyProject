package com.yilidi.o2o.appparam.buyer.product;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 根据秒杀活动ID查询活动商品列表接口请求参数
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class SecKillProdutctsParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;

    @Field("活动ID")
    private Integer actId;
    @Field("店铺ID")
    private Integer storeId;

    public void validateParams() {
        Param actIdValidate = new Param.Builder(getFieldName("actId"), Param.ParamType.STR_INTEGER.getType(), actId, false)
                .build();
        Param storeIdValidate = new Param.Builder(getFieldName("storeId"), Param.ParamType.STR_INTEGER.getType(), storeId,
                false).build();
        ParamValidateUtils.validateParams(actIdValidate, storeIdValidate);
    }

    public Integer getActId() {
        return actId;
    }

    public void setActId(Integer actId) {
        this.actId = actId;
    }

    public Integer getStoreId() {
        return storeId;
    }

    public void setStoreId(Integer storeId) {
        this.storeId = storeId;
    }

}
