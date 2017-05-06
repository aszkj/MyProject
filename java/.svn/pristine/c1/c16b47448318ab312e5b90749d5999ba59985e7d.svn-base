package com.yilidi.o2o.appparam.buyer.product;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 抢红包参数
 * 
 * @author: chenlian
 * @date: 2016年11月11日 下午5:53:44
 */
public class GrabRedEnvelopeParam extends AppBaseParam {

    private static final long serialVersionUID = -7050180119041902385L;

    private static final String ACTIVITY_ID = "activityId";

    @Field("活动ID")
    private Integer activityId;

    public void validateParams() {
        Param activityIdValidate = new Param.Builder(getFieldName(ACTIVITY_ID), Param.ParamType.INTEGER_TYPE.getType(),
                activityId, false).build();
        ParamValidateUtils.validateParams(activityIdValidate);
    }

    public Integer getActivityId() {
        return activityId;
    }

    public void setActivityId(Integer activityId) {
        this.activityId = activityId;
    }

}
