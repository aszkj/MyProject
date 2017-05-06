package com.yilidi.o2o.core.paramvalidate.processor.concrete;

import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.paramvalidate.processor.AbstractParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean;

/**
 * 数字类型验证处理器
 * 
 * @author chenl
 * 
 */
public class StrNumberProcessor extends AbstractParamValidateProcessor {

	private static final String NUMBER_REGEX = "^[0-9]*$";

	private StrNumberProcessor() {
	}

	private static class StrNumberProcessorHolder {
		private static final StrNumberProcessor STRNUMBERPROCESSOR = new StrNumberProcessor();
	}

	public static StrNumberProcessor getInstance() {
		return StrNumberProcessorHolder.STRNUMBERPROCESSOR;
	}

	@Override
	protected ParamValidateMessageBean validateSpecificParamTypeRule(Param param) {
		param.setRegex(NUMBER_REGEX);
		return validateRegex(param);
	}

}
