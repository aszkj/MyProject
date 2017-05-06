package com.yilidi.o2o.core.paramvalidate.processor.concrete;

import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.paramvalidate.processor.AbstractParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean;

/**
 * 普通字符串类型验证处理器
 * 
 * @author chenl
 * 
 */
public class StrNormalProcessor extends AbstractParamValidateProcessor {

	private StrNormalProcessor() {
	}

	private static class StrNormalProcessorHolder {
		private static final StrNormalProcessor STRNORMALPROCESSOR = new StrNormalProcessor();
	}

	public static StrNormalProcessor getInstance() {
		return StrNormalProcessorHolder.STRNORMALPROCESSOR;
	}

	@Override
	protected ParamValidateMessageBean validateSpecificParamTypeRule(Param param) {
		ParamValidateMessageBean msgBean = getMsgBean();
		return msgBean;
	}

}
