package com.yilidi.o2o.core.paramvalidate.processor.concrete;

import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.paramvalidate.processor.AbstractParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean;

/**
 * Email类型验证处理器
 * 
 * @author chenl
 * 
 */
public class StrEmailProcessor extends AbstractParamValidateProcessor {

	private static final String EMAIL_REGEX = "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$";

	private StrEmailProcessor() {
	}

	private static class StrEmailProcessorHolder {
		private static final StrEmailProcessor STREMAILPROCESSOR = new StrEmailProcessor();
	}

	public static StrEmailProcessor getInstance() {
		return StrEmailProcessorHolder.STREMAILPROCESSOR;
	}

	@Override
	protected ParamValidateMessageBean validateSpecificParamTypeRule(Param param) {
		param.setRegex(EMAIL_REGEX);
		return validateRegex(param);
	}

}
