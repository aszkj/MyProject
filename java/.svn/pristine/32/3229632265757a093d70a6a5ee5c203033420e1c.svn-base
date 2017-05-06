package com.yilidi.o2o.core.paramvalidate.processor.concrete;

import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.paramvalidate.processor.AbstractParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean;

/**
 * 邮编类型验证处理器
 * 
 * @author chenl
 * 
 */
public class StrPostcodeProcessor extends AbstractParamValidateProcessor {

	private static final String POSTCODE_REGEX = "[1-9]\\d{5}(?!\\d)";

	private StrPostcodeProcessor() {
	}

	private static class StrPostcodeProcessorHolder {
		private static final StrPostcodeProcessor STRPOSTCODEPROCESSOR = new StrPostcodeProcessor();
	}

	public static StrPostcodeProcessor getInstance() {
		return StrPostcodeProcessorHolder.STRPOSTCODEPROCESSOR;
	}

	@Override
	protected ParamValidateMessageBean validateSpecificParamTypeRule(Param param) {
		param.setRegex(POSTCODE_REGEX);
		return validateRegex(param);
	}

}
