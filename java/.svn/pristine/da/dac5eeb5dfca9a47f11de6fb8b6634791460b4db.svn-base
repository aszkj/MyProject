package com.yilidi.o2o.appparam.seller.order;

import java.util.List;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * @Description: TODO(生成调货单参数)
 * @author: chenlian
 * @date: 2016年6月1日 上午10:52:51
 */
public class CreateAllotParam extends AppBaseParam {
    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = -7050180119041902385L;

    private static final String ALLOT_NOTE = "allotNote";

    private List<AllotInfoParam> allotInfo;

    @Field("调货单备注")
    private String allotNote;

    public void validateParams() {
        Param allotNoteValidate = new Param.Builder(getFieldName(ALLOT_NOTE), Param.ParamType.STR_NORMAL.getType(),
                allotNote, true).build();
        ParamValidateUtils.validateParams(allotNoteValidate);
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

    public String getAllotNote() {
        return allotNote;
    }

    public void setAllotNote(String allotNote) {
        this.allotNote = allotNote;
    }

    public List<AllotInfoParam> getAllotInfo() {
        return allotInfo;
    }

    public void setAllotInfo(List<AllotInfoParam> allotInfo) {
        this.allotInfo = allotInfo;
    }

}
