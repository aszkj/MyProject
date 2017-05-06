package com.yilidi.o2o.core.paramvalidate.processor.concrete;

import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.paramvalidate.processor.AbstractParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean;

/**
 * 中文类型验证处理器
 * 
 * @author chenl
 * 
 */
public class StrChineseProcessor extends AbstractParamValidateProcessor {

	private static final String CHINESE_REGEX = "[\u4e00-\u9fa5]+";

	private StrChineseProcessor() {
	}

	private static class StrChineseProcessorHolder {
		private static final StrChineseProcessor STRCHINESEPROCESSOR = new StrChineseProcessor();
	}

	public static StrChineseProcessor getInstance() {
		return StrChineseProcessorHolder.STRCHINESEPROCESSOR;
	}

	@Override
	protected ParamValidateMessageBean validateSpecificParamTypeRule(Param param) {
		param.setRegex(CHINESE_REGEX);
		return validateRegex(param);
	}

}
