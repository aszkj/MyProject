package com.yilidi.o2o.appparam.seller.order;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * @Description: TODO(获取统计汇总信息参数)
 * @author: chenlian
 * @date: 2016年6月20日 下午5:25:07
 */
public class SummerizeInfoParam extends AppBaseParam {

    private static final long serialVersionUID = -7050180119041902385L;

    private static final String BEGIN_TIME = "beginTime";

    private static final String END_TIME = "endTime";

    @Field("开始统计时间")
    private String beginTime;

    @Field("结束统计时间")
    private String endTime;

    public void validateParams() {
        Param beginTimeValidate = new Param.Builder(getFieldName(BEGIN_TIME), Param.ParamType.STR_NORMAL.getType(),
                beginTime, false).build();
        Param endTimeValidate = new Param.Builder(getFieldName(END_TIME), Param.ParamType.STR_NORMAL.getType(), endTime,
                false).build();
        ParamValidateUtils.validateParams(beginTimeValidate, endTimeValidate);
    }

    public String getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(String beginTime) {
        this.beginTime = beginTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

}
