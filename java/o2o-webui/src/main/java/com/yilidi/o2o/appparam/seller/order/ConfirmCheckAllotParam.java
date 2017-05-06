package com.yilidi.o2o.appparam.seller.order;

import java.util.List;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * @Description: TODO(调货单确认参数)
 * @author: chenlian
 * @date: 2016年6月1日 上午10:52:51
 */
public class ConfirmCheckAllotParam extends AppBaseParam {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -7050180119041902385L;

    private static final String ALLOT_ORDER_NO = "allotOrderNo";

    @Field("调货单编号")
    private String allotOrderNo;

    private List<AllotInfoParam> allotInfo;

    public void validateParams() {
        Param allotOrderNoValidate = new Param.Builder(getFieldName(ALLOT_ORDER_NO), Param.ParamType.STR_NORMAL.getType(),
                allotOrderNo, false).build();
        ParamValidateUtils.validateParams(allotOrderNoValidate);
        if (ObjectUtils.isNullOrEmpty(allotInfo)) {
            throw new IllegalArgumentException("调货单产品数量列表信息不允许为空");
        }
        for (AllotInfoParam info : allotInfo) {
            info.validateParams();
            if (info.getAllotNum() < 0) {
                throw new IllegalArgumentException("调货单确认产品数量必须大于或等于0");
            }
        }
    }

    public String getAllotOrderNo() {
        return allotOrderNo;
    }

    public void setAllotOrderNo(String allotOrderNo) {
        this.allotOrderNo = allotOrderNo;
    }

    public List<AllotInfoParam> getAllotInfo() {
        return allotInfo;
    }

    public void setAllotInfo(List<AllotInfoParam> allotInfo) {
        this.allotInfo = allotInfo;
    }

}
