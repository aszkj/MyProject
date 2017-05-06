package com.yilidi.o2o.core.paramvalidate.processor.decorate;

import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.paramvalidate.processor.IParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean.MsgCode;

/**
 * 参数验证处理器抽象装饰类
 * 
 * @author chenl
 * 
 */
public abstract class AbstractDecorativeParamValidateProcessor implements IParamValidateProcessor {

	private IParamValidateProcessor processor;

	public AbstractDecorativeParamValidateProcessor(IParamValidateProcessor processor) {
		super();
		this.processor = processor;
	}

	@Override
	public ParamValidateMessageBean process(Param param) {
		ParamValidateMessageBean msgBean = processor.process(param);
		if (null != msgBean && msgBean.getMsgCode() == MsgCode.SUCCESS.getValue().intValue()) {
			msgBean = decorate(param);
		}
		return msgBean;
	}

	protected abstract ParamValidateMessageBean decorate(Param param);

	public IParamValidateProcessor getProcessor() {
		return processor;
	}

}
