package com.yilidi.o2o.appparam.seller.product;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 根据类型查询品牌列表信息参数
 * <p>Company:Yilidi</p>
 * <p>Title:</p>
 * @author xiasl
 * @date 2017年1月9日
 */
public class GetBrandTypeParam extends AppBaseParam {
    private static final long serialVersionUID = -7050180119041902385L;

    @Field("是否热门")
    private String type;

    public void validateParams() {
        Param parentClassCodeValidate = new Param.Builder(getFieldName("type"),
                Param.ParamType.STR_NORMAL.getType(), type, false).build();
        ParamValidateUtils.validateParams(parentClassCodeValidate);
    }

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}
