package com.yilidi.o2o.appparam.buyer.system;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 微信SDK获取签名相关参数
 */
public class WXSdkParam extends AppBaseParam {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5059274929041902385L;

	@Field("地址信息")
	private String url;

	@Override
	public void validateParams() {
		Param validate = new Param.Builder(getFieldName("url"), Param.ParamType.STR_NORMAL.getType(), url, false).build();
		ParamValidateUtils.validateParams(validate);
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

}
