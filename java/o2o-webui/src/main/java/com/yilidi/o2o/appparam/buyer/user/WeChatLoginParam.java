package com.yilidi.o2o.appparam.buyer.user;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 微信第三方登录
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class WeChatLoginParam extends AppBaseParam {
	private static final long serialVersionUID = -7050180119041902385L;
	@Field("code")
	private String code;

	private String tradeType; // 登录方式，APP或者JSAPI

	public void validateParams() {
		Param codeValidate = new Param.Builder(getFieldName("code"), Param.ParamType.STR_NORMAL.getType(), code, false)
				.build();
		ParamValidateUtils.validateParams(codeValidate);
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getTradeType() {
		return tradeType;
	}

	public void setTradeType(String tradeType) {
		this.tradeType = tradeType;
	}

}
