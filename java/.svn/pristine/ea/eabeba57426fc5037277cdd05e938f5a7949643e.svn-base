package com.yilidi.o2o.appparam.seller.order;

import java.util.List;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.core.utils.ObjectUtils;

/**
 * @Description: TODO(确认调货单参数)
 * @author: chenlian
 * @date: 2016年6月1日 上午10:52:51
 */
public class ConfirmAllotParam extends AppBaseParam {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -7050180119041902385L;

    private List<AllotInfoParam> allotInfo;

    public void validateParams() {
        if (ObjectUtils.isNullOrEmpty(allotInfo)) {
            throw new IllegalArgumentException("调货单产品数量列表信息不允许为空");
        }
        for (AllotInfoParam info : allotInfo) {
            info.validateParams();
            if (info.getAllotNum() <= 0) {
                throw new IllegalArgumentException("调货单产品数量必须大于0");
            }
        }

    }

    public List<AllotInfoParam> getAllotInfo() {
        return allotInfo;
    }

    public void setAllotInfo(List<AllotInfoParam> allotInfo) {
        this.allotInfo = allotInfo;
    }

}
