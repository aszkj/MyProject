package com.yilidi.o2o.core.paramvalidate.processor.concrete;

import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.paramvalidate.processor.AbstractParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean;

/**
 * 座机号码类型验证处理器
 * 
 * @author chenl
 * 
 */
public class StrPhoneProcessor extends AbstractParamValidateProcessor {

	private static final String PHONE_REGEX = "^(\\d{3,4}\\-?)?\\d{7,8}$";

	private StrPhoneProcessor() {
	}

	private static class StrPhoneProcessorHolder {
		private static final StrPhoneProcessor STRPHONEPROCESSOR = new StrPhoneProcessor();
	}

	public static StrPhoneProcessor getInstance() {
		return StrPhoneProcessorHolder.STRPHONEPROCESSOR;
	}

	@Override
	protected ParamValidateMessageBean validateSpecificParamTypeRule(Param param) {
		param.setRegex(PHONE_REGEX);
		return validateRegex(param);
	}

}
