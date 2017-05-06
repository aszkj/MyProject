package com.yilidi.o2o.appparam.buyer.user;

import com.yilidi.o2o.appparam.PageParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * <p>Company:Yilidi</p>
 * <p>Title:查询商品评论信息参数</p>
 * @author xiasl
 * @date 2017年2月9日
 */
public class GetEvaluationParam extends PageParam {

    private static final long serialVersionUID = 1L;
    @Field("商品ID")
    private Integer saleProductId;
    @Field("汇总信息值")
    private String summaryValue;

    public void validateParams() {
        Param saleProductIdValidate = new Param.Builder(getFieldName("saleProductId"), Param.ParamType.STR_INTEGER.getType(), saleProductId,
                false).build();
        ParamValidateUtils.validateParams(saleProductIdValidate);
        Param summaryValueValidate = new Param.Builder(getFieldName("summaryValue"), Param.ParamType.STR_NORMAL.getType(), summaryValue,
                true).build();
        ParamValidateUtils.validateParams(summaryValueValidate);
    }

	public Integer getSaleProductId() {
		return saleProductId;
	}

	public void setSaleProductId(Integer saleProductId) {
		this.saleProductId = saleProductId;
	}

    public String getSummaryValue() {
        return summaryValue;
    }

    public void setSummaryValue(String summaryValue) {
        this.summaryValue = summaryValue;
    }
    
}
