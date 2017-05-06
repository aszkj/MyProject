package com.yilidi.o2o.appparam.seller.system;

import com.yilidi.o2o.appparam.PageParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

public class SystemMessageParam extends PageParam{
	private static final long serialVersionUID = 1L;
	
	@Field("字典对应的值")
	private Integer typeValue;

	public void validateParams() {
		Param typeValidate = new Param.Builder(getFieldName("typeValue"), Param.ParamType.STR_INTEGER.getType(), typeValue, false)
				.build();
		ParamValidateUtils.validateParams(typeValidate);
	}

	public Integer getTypeValue() {
		return typeValue;
	}

	public void setTypeValue(Integer typeValue) {
		this.typeValue = typeValue;
	}

}
