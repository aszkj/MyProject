package com.yilidi.o2o.appparam.seller.user;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * @Description: TODO(修改店铺详细信息参数)
 * @author: chenlian
 * @date: 2016年6月20日 下午4:21:22
 */
public class UpdateStoreInfoParam extends AppBaseParam {

    private static final long serialVersionUID = -7050180119041902385L;

    private static final String STORE_NAME = "storeName";

    private static final String BEGIN_BUSINESS_HOUR = "beginBusinessHour";

    private static final String END_BUSINESS_HOUR = "endBusinessHour";

    private static final String DEDUCE_TRANS_COST_AMOUNT = "deduceTransCostAmount";

    private static final String TRANS_COST_AMOUNT = "transCostAmount";

    private static final String HOTLINE = "hotline";

    private static final String STORE_STATUS = "storeStatus";

    private static final String STORE_STATUS_PATTERN = "^(0|1)$";

    @Field("店铺名称")
    private String storeName;

    @Field("开始营业时间")
    private String beginBusinessHour;

    @Field("结束营业时间")
    private String endBusinessHour;

    @Field("店铺满多少免运费")
    private Long deduceTransCostAmount;

    @Field("店铺运费")
    private Long transCostAmount;

    @Field("店铺热线")
    private String hotline;

    @Field("店铺状态")
    private Integer storeStatus;

    public void validateParams() {
        Param storeNameValidate = new Param.Builder(getFieldName(STORE_NAME), Param.ParamType.STR_NORMAL.getType(),
                storeName, true).build();
        Param beginBusinessHourValidate = new Param.Builder(getFieldName(BEGIN_BUSINESS_HOUR),
                Param.ParamType.STR_NORMAL.getType(), beginBusinessHour, true).build();
        Param endBusinessHourValidate = new Param.Builder(getFieldName(END_BUSINESS_HOUR),
                Param.ParamType.STR_NORMAL.getType(), endBusinessHour, true).build();
        Param deduceTransCostAmountValidate = new Param.Builder(getFieldName(DEDUCE_TRANS_COST_AMOUNT),
                Param.ParamType.LONG_TYPE.getType(), deduceTransCostAmount, true).build();
        Param transCostAmountValidate = new Param.Builder(getFieldName(TRANS_COST_AMOUNT),
                Param.ParamType.LONG_TYPE.getType(), transCostAmount, true).build();
        Param hotlineValidate = new Param.Builder(getFieldName(HOTLINE), Param.ParamType.STR_NORMAL.getType(), hotline, true)
                .build();
        Param storeStatusValidate = new Param.Builder(getFieldName(STORE_STATUS), Param.ParamType.INTEGER_TYPE.getType(),
                storeStatus, true).regex(STORE_STATUS_PATTERN).build();
        ParamValidateUtils.validateParams(storeNameValidate, beginBusinessHourValidate, endBusinessHourValidate,
                deduceTransCostAmountValidate, transCostAmountValidate, hotlineValidate, storeStatusValidate);
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public String getBeginBusinessHour() {
        return beginBusinessHour;
    }

    public void setBeginBusinessHour(String beginBusinessHour) {
        this.beginBusinessHour = beginBusinessHour;
    }

    public String getEndBusinessHour() {
        return endBusinessHour;
    }

    public void setEndBusinessHour(String endBusinessHour) {
        this.endBusinessHour = endBusinessHour;
    }

    public Long getDeduceTransCostAmount() {
        return deduceTransCostAmount;
    }

    public void setDeduceTransCostAmount(Long deduceTransCostAmount) {
        this.deduceTransCostAmount = deduceTransCostAmount;
    }

    public Long getTransCostAmount() {
        return transCostAmount;
    }

    public void setTransCostAmount(Long transCostAmount) {
        this.transCostAmount = transCostAmount;
    }

    public String getHotline() {
        return hotline;
    }

    public void setHotline(String hotline) {
        this.hotline = hotline;
    }

    public Integer getStoreStatus() {
        return storeStatus;
    }

    public void setStoreStatus(Integer storeStatus) {
        this.storeStatus = storeStatus;
    }

}
