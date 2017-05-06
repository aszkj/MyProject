package com.yilidi.o2o.core.paramvalidate.state.concrete;

import com.yilidi.o2o.core.paramvalidate.processor.IParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.processor.concrete.StrDoubleProcessor;
import com.yilidi.o2o.core.paramvalidate.state.AbstractParamType;

/**
 * Double字符串类型参数
 * 
 * @author chenl
 * 
 */
public class StrDouble extends AbstractParamType {

	private StrDouble() {
	}

	private static class StrDoubleHolder {
		private static final StrDouble STRDOUBLE = new StrDouble();
	}

	public static StrDouble getInstance() {
		return StrDoubleHolder.STRDOUBLE;
	}

	@Override
	public IParamValidateProcessor getProcessor() {
		// TODO Auto-generated method stub
		return StrDoubleProcessor.getInstance();
	}

}
