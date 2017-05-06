package com.yilidi.o2o.appparam.seller.product;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * @Description: TODO(批量设置商品上下架)
 * @author: chenlian
 * @date: 2016年6月20日 上午9:41:47
 */
public class EnabledFlagParam extends AppBaseParam {

    private static final long serialVersionUID = -7050180119041902385L;

    private static final String SALE_PRODUCT_IDS = "saleProductIds";

    private static final String ENABLED_FLAG = "enabledFlag";

    /**
     * 上下架操作类型正则表达式
     */
    private static final String ENABLED_FLAG_PATTERN = "^(1|2)$";

    @Field("商品ID字符串")
    private String saleProductIds;

    @Field("上下架操作类型")
    private Integer enabledFlag;

    public void validateParams() {
        Param saleProductIdsValidate = new Param.Builder(getFieldName(SALE_PRODUCT_IDS),
                Param.ParamType.STR_NORMAL.getType(), saleProductIds, false).build();
        Param enabledFlagValidate = new Param.Builder(getFieldName(ENABLED_FLAG), Param.ParamType.STR_INTEGER.getType(),
                enabledFlag, false).regex(ENABLED_FLAG_PATTERN).build();
        ParamValidateUtils.validateParams(saleProductIdsValidate, enabledFlagValidate);
    }

    public String getSaleProductIds() {
        return saleProductIds;
    }

    public void setSaleProductIds(String saleProductIds) {
        this.saleProductIds = saleProductIds;
    }

    public Integer getEnabledFlag() {
        return enabledFlag;
    }

    public void setEnabledFlag(Integer enabledFlag) {
        this.enabledFlag = enabledFlag;
    }

    public static long getSerialversionuid() {
        return serialVersionUID;
    }

}
