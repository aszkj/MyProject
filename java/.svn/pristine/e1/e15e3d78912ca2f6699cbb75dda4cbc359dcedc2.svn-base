package com.yilidi.o2o.core.paramvalidate.state.concrete;

import com.yilidi.o2o.core.paramvalidate.processor.IParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.processor.concrete.LongTypeProcessor;
import com.yilidi.o2o.core.paramvalidate.state.AbstractParamType;

/**
 * Long类型参数
 * 
 * @author chenl
 * 
 */
public class LongType extends AbstractParamType {

	private LongType() {
	}

	private static class LongTypeHolder {
		private static final LongType LONGTYPE = new LongType();
	}

	public static LongType getInstance() {
		return LongTypeHolder.LONGTYPE;
	}

	@Override
	public IParamValidateProcessor getProcessor() {
		// TODO Auto-generated method stub
		return LongTypeProcessor.getInstance();
	}

}
