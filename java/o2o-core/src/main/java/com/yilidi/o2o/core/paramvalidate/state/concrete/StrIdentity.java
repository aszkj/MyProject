package com.yilidi.o2o.core.paramvalidate.state.concrete;

import com.yilidi.o2o.core.paramvalidate.processor.IParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.processor.concrete.StrIdentityProcessor;
import com.yilidi.o2o.core.paramvalidate.state.AbstractParamType;

/**
 * 身份证类型参数
 * 
 * @author chenl
 * 
 */
public class StrIdentity extends AbstractParamType {

	private StrIdentity() {
	}

	private static class StrIdentityHolder {
		private static final StrIdentity STRIDENTITY = new StrIdentity();
	}

	public static StrIdentity getInstance() {
		return StrIdentityHolder.STRIDENTITY;
	}

	@Override
	public IParamValidateProcessor getProcessor() {
		// TODO Auto-generated method stub
		return StrIdentityProcessor.getInstance();
	}

}
