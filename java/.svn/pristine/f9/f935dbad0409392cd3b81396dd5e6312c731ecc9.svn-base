package com.yilidi.o2o.core.paramvalidate.state.concrete;

import com.yilidi.o2o.core.paramvalidate.processor.IParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.processor.concrete.IntegerTypeProcessor;
import com.yilidi.o2o.core.paramvalidate.state.AbstractParamType;

/**
 * Integer类型参数
 * 
 * @author chenl
 * 
 */
public class IntegerType extends AbstractParamType {

	private IntegerType() {
	}

	private static class IntegerTypeHolder {
		private static final IntegerType INTEGERTYPE = new IntegerType();
	}

	public static IntegerType getInstance() {
		return IntegerTypeHolder.INTEGERTYPE;
	}

	@Override
	public IParamValidateProcessor getProcessor() {
		// TODO Auto-generated method stub
		return IntegerTypeProcessor.getInstance();
	}

}
