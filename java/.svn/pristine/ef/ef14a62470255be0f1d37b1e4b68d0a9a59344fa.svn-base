package com.yilidi.o2o.core.paramvalidate.state.concrete;

import com.yilidi.o2o.core.paramvalidate.processor.IParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.processor.concrete.StrNumberProcessor;
import com.yilidi.o2o.core.paramvalidate.state.AbstractParamType;

/**
 * 数字类型参数
 * 
 * @author chenl
 * 
 */
public class StrNumber extends AbstractParamType {

	private StrNumber() {
	}

	private static class StrNumberHolder {
		private static final StrNumber STRNUMBER = new StrNumber();
	}

	public static StrNumber getInstance() {
		return StrNumberHolder.STRNUMBER;
	}

	@Override
	public IParamValidateProcessor getProcessor() {
		// TODO Auto-generated method stub
		return StrNumberProcessor.getInstance();
	}

}
