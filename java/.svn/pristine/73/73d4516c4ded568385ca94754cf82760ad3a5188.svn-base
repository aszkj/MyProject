package com.yilidi.o2o.core.paramvalidate.state.concrete;

import com.yilidi.o2o.core.paramvalidate.processor.IParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.processor.concrete.StrChineseProcessor;
import com.yilidi.o2o.core.paramvalidate.state.AbstractParamType;

/**
 * 中文类型参数
 * 
 * @author chenl
 * 
 */
public class StrChinese extends AbstractParamType {

	private StrChinese() {
	}

	private static class StrChineseHolder {
		private static final StrChinese STRCHINESE = new StrChinese();
	}

	public static StrChinese getInstance() {
		return StrChineseHolder.STRCHINESE;
	}

	@Override
	public IParamValidateProcessor getProcessor() {
		// TODO Auto-generated method stub
		return StrChineseProcessor.getInstance();
	}

}
