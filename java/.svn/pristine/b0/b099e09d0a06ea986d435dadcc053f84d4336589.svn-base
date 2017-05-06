package com.yilidi.o2o.core.paramvalidate.state.concrete;

import com.yilidi.o2o.core.paramvalidate.processor.IParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.processor.concrete.StrEmailProcessor;
import com.yilidi.o2o.core.paramvalidate.state.AbstractParamType;

/**
 * Email类型参数
 * 
 * @author chenl
 * 
 */
public class StrEmail extends AbstractParamType {

	private StrEmail() {
	}

	private static class StrEmailHolder {
		private static final StrEmail STREMAIL = new StrEmail();
	}

	public static StrEmail getInstance() {
		return StrEmailHolder.STREMAIL;
	}

	@Override
	public IParamValidateProcessor getProcessor() {
		// TODO Auto-generated method stub
		return StrEmailProcessor.getInstance();
	}

}
