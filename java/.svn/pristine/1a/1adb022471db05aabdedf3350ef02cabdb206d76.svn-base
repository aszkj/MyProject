package com.yilidi.o2o.core.paramvalidate.state.concrete;

import com.yilidi.o2o.core.paramvalidate.processor.IParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.processor.concrete.StrIntegerProcessor;
import com.yilidi.o2o.core.paramvalidate.state.AbstractParamType;

/**
 * Integer字符串类型参数
 * 
 * @author chenl
 * 
 */
public class StrInteger extends AbstractParamType {

	private StrInteger() {
	}

	private static class StrIntegerHolder {
		private static final StrInteger STRINTEGER = new StrInteger();
	}

	public static StrInteger getInstance() {
		return StrIntegerHolder.STRINTEGER;
	}

	@Override
	public IParamValidateProcessor getProcessor() {
		// TODO Auto-generated method stub
		return StrIntegerProcessor.getInstance();
	}

}
