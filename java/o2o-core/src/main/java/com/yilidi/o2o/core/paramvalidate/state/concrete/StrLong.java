package com.yilidi.o2o.core.paramvalidate.state.concrete;

import com.yilidi.o2o.core.paramvalidate.processor.IParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.processor.concrete.StrLongProcessor;
import com.yilidi.o2o.core.paramvalidate.state.AbstractParamType;

/**
 * Long字符串类型参数
 * 
 * @author chenl
 * 
 */
public class StrLong extends AbstractParamType {

	private StrLong() {
	}

	private static class StrLongHolder {
		private static final StrLong STRLONG = new StrLong();
	}

	public static StrLong getInstance() {
		return StrLongHolder.STRLONG;
	}

	@Override
	public IParamValidateProcessor getProcessor() {
		// TODO Auto-generated method stub
		return StrLongProcessor.getInstance();
	}

}
