package com.yilidi.o2o.core.paramvalidate.state.concrete;

import com.yilidi.o2o.core.paramvalidate.processor.IParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.processor.concrete.DoubleTypeProcessor;
import com.yilidi.o2o.core.paramvalidate.state.AbstractParamType;

/**
 * Double类型参数
 * 
 * @author chenl
 * 
 */
public class DoubleType extends AbstractParamType {

	private DoubleType() {
	}

	private static class DoubleTypeHolder {
		private static final DoubleType DOUBLETYPE = new DoubleType();
	}

	public static DoubleType getInstance() {
		return DoubleTypeHolder.DOUBLETYPE;
	}

	@Override
	public IParamValidateProcessor getProcessor() {
		// TODO Auto-generated method stub
		return DoubleTypeProcessor.getInstance();
	}

}
