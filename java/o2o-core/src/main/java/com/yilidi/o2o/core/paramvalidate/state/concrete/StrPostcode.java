package com.yilidi.o2o.core.paramvalidate.state.concrete;

import com.yilidi.o2o.core.paramvalidate.processor.IParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.processor.concrete.StrPostcodeProcessor;
import com.yilidi.o2o.core.paramvalidate.state.AbstractParamType;

/**
 * 邮编类型参数
 * 
 * @author chenl
 * 
 */
public class StrPostcode extends AbstractParamType {

	private StrPostcode() {
	}

	private static class StrPostcodeHolder {
		private static final StrPostcode STRPOSTCODE = new StrPostcode();
	}

	public static StrPostcode getInstance() {
		return StrPostcodeHolder.STRPOSTCODE;
	}

	@Override
	public IParamValidateProcessor getProcessor() {
		// TODO Auto-generated method stub
		return StrPostcodeProcessor.getInstance();
	}

}
