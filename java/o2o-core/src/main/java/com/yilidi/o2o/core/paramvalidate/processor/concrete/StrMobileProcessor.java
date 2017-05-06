package com.yilidi.o2o.core.paramvalidate.processor.concrete;

import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.paramvalidate.processor.AbstractParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean;

/**
 * 手机号码类型验证处理器
 * 
 * @author chenl
 * 
 */
public class StrMobileProcessor extends AbstractParamValidateProcessor {

	private static final String MOBILE_REGEX = "^13\\d{9}|14\\d{9}|15[012356789]\\d{8}|16\\d{9}|17\\d{9}|18\\d{9}$";

	private StrMobileProcessor() {
	}

	private static class StrMobileProcessorHolder {
		private static final StrMobileProcessor STRMOBILEPROCESSOR = new StrMobileProcessor();
	}

	public static StrMobileProcessor getInstance() {
		return StrMobileProcessorHolder.STRMOBILEPROCESSOR;
	}

	@Override
	protected ParamValidateMessageBean validateSpecificParamTypeRule(Param param) {
		param.setRegex(MOBILE_REGEX);
		return validateRegex(param);
	}

}
