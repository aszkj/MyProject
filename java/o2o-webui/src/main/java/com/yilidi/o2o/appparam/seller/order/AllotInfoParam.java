package com.yilidi.o2o.appparam.seller.order;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * @Description: TODO(调货单产品数量列表信息参数)
 * @author: chenlian
 * @date: 2016年6月1日 上午10:52:51
 */
public class AllotInfoParam extends AppBaseParam {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -7050180119041902385L;

    private static final String SALE_PRODUCT_ID = "saleProductId";

    private static final String ALLOT_NUM = "allotNum";

    @Field("商品ID")
    private Integer saleProductId;

    @Field("调货数量")
    private Integer allotNum;

    public void validateParams() {
        Param saleProductIdValidate = new Param.Builder(getFieldName(SALE_PRODUCT_ID),
                Param.ParamType.STR_INTEGER.getType(), saleProductId, false).build();
        Param allotNumValidate = new Param.Builder(getFieldName(ALLOT_NUM), Param.ParamType.STR_INTEGER.getType(), allotNum,
                false).build();
        ParamValidateUtils.validateParams(saleProductIdValidate, allotNumValidate);
    }

    public Integer getSaleProductId() {
        return saleProductId;
    }

    public void setSaleProductId(Integer saleProductId) {
        this.saleProductId = saleProductId;
    }

    public Integer getAllotNum() {
        return allotNum;
    }

    public void setAllotNum(Integer allotNum) {
        this.allotNum = allotNum;
    }

}
