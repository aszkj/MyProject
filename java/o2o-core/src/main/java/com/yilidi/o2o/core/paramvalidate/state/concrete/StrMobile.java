package com.yilidi.o2o.core.paramvalidate.state.concrete;

import com.yilidi.o2o.core.paramvalidate.processor.IParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.processor.concrete.StrMobileProcessor;
import com.yilidi.o2o.core.paramvalidate.state.AbstractParamType;

/**
 * 手机号码类型参数
 * 
 * @author chenl
 * 
 */
public class StrMobile extends AbstractParamType {

	private StrMobile() {
	}

	private static class StrMobileHolder {
		private static final StrMobile STRMOBILE = new StrMobile();
	}

	public static StrMobile getInstance() {
		return StrMobileHolder.STRMOBILE;
	}

	@Override
	public IParamValidateProcessor getProcessor() {
		// TODO Auto-generated method stub
		return StrMobileProcessor.getInstance();
	}

}
