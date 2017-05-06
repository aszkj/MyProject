package com.yilidi.o2o.core.paramvalidate.processor;

import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean;

/**
 * 参数验证处理器接口
 * 
 * @author chenl
 * 
 */
public interface IParamValidateProcessor {

	public ParamValidateMessageBean process(Param param);

}
