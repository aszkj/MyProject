package com.yilidi.o2o.appparam.seller.order;

import com.yilidi.o2o.appparam.PageParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * @Description: TODO(调货单列表参数)
 * @author: chenlian
 * @date: 2016年6月23日 上午12:37:14
 */
public class ListAllotParam extends PageParam {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -7050180119041902385L;

    private static final String WHETHER_COMPLETE = "whetherComplete";

    /**
     * 调货单状态查询类型正则表达式
     */
    private static final String WHETHER_COMPLETE_PATTERN = "^(0|1)$";

    @Field("调货单状态查询类型")
    private Integer whetherComplete;

    public void validateParams() {
        Param whetherCompleteValidate = new Param.Builder(getFieldName(WHETHER_COMPLETE),
                Param.ParamType.INTEGER_TYPE.getType(), whetherComplete, false).regex(WHETHER_COMPLETE_PATTERN).build();
        ParamValidateUtils.validateParams(whetherCompleteValidate);
        super.validateParams();
    }

    public Integer getWhetherComplete() {
        return whetherComplete;
    }

    public void setWhetherComplete(Integer whetherComplete) {
        this.whetherComplete = whetherComplete;
    }

}
