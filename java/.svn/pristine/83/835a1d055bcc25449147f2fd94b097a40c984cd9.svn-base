package com.yilidi.o2o.appparam.seller.order;

import com.yilidi.o2o.appparam.PageParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * @Description: TODO(铂金会员统计详细信息参数)
 * @author: chenlian
 * @date: 2016年6月20日 下午7:19:14
 */
public class VipUserDetailParam extends PageParam {

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
        super.validateParams();
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
