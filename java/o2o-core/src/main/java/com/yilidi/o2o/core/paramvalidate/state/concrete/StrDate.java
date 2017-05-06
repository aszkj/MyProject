package com.yilidi.o2o.core.paramvalidate.state.concrete;

import com.yilidi.o2o.core.paramvalidate.processor.IParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.processor.concrete.StrDateProcessor;
import com.yilidi.o2o.core.paramvalidate.state.AbstractParamType;

/**
 * 日期类型参数
 * 
 * @author chenl
 * 
 */
public class StrDate extends AbstractParamType {

	private StrDate() {
	}

	private static class StrDateHolder {
		private static final StrDate STRDATE = new StrDate();
	}

	public static StrDate getInstance() {
		return StrDateHolder.STRDATE;
	}

	@Override
	public IParamValidateProcessor getProcessor() {
		// TODO Auto-generated method stub
		return StrDateProcessor.getInstance();
	}

}
