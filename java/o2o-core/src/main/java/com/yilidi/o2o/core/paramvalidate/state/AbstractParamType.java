package com.yilidi.o2o.core.paramvalidate.state;

import com.yilidi.o2o.core.paramvalidate.processor.IParamValidateProcessor;

/**
 * 抽象参数类型类
 * 
 * @author chenl
 * 
 */
public abstract class AbstractParamType implements IParamType {

	public abstract IParamValidateProcessor getProcessor();

}
