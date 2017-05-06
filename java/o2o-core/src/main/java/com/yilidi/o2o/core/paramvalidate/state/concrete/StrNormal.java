package com.yilidi.o2o.core.paramvalidate.state.concrete;

import com.yilidi.o2o.core.paramvalidate.processor.IParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.processor.concrete.StrNormalProcessor;
import com.yilidi.o2o.core.paramvalidate.processor.decorate.concrete.FilterSpecialCharacterProcessor;
import com.yilidi.o2o.core.paramvalidate.state.AbstractParamType;

/**
 * 普通字符串类型参数
 * 
 * @author chenl
 * 
 */
public class StrNormal extends AbstractParamType {

	private StrNormal() {
	}

	private static class StrNormalHolder {
		private static final StrNormal STRNORMAL = new StrNormal();
	}

	public static StrNormal getInstance() {
		return StrNormalHolder.STRNORMAL;
	}

	@Override
	public IParamValidateProcessor getProcessor() {
		// TODO Auto-generated method stub
		return new FilterSpecialCharacterProcessor(StrNormalProcessor.getInstance());
	}

}
