package com.yilidi.o2o.core.paramvalidate.state;

import com.yilidi.o2o.core.paramvalidate.processor.IParamValidateProcessor;

/**
 * 参数类型管理器
 * 
 * @author chenl
 * 
 */
public class ParamTypeManager {

	private IParamType paramType;

	public ParamTypeManager(IParamType paramType) {
		super();
		this.paramType = paramType;
	}

	public IParamValidateProcessor getParamValidateProcessor() {
		return paramType.getProcessor();
	}

}
