package com.yilidi.o2o.core.paramvalidate.state.concrete;

import com.yilidi.o2o.core.paramvalidate.processor.IParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.processor.concrete.StrPhoneProcessor;
import com.yilidi.o2o.core.paramvalidate.state.AbstractParamType;

/**
 * 座机号码类型参数
 * 
 * @author chenl
 * 
 */
public class StrPhone extends AbstractParamType {

	private StrPhone() {
	}

	private static class StrPhoneHolder {
		private static final StrPhone STRPHONE = new StrPhone();
	}

	public static StrPhone getInstance() {
		return StrPhoneHolder.STRPHONE;
	}

	@Override
	public IParamValidateProcessor getProcessor() {
		// TODO Auto-generated method stub
		return StrPhoneProcessor.getInstance();
	}

}
