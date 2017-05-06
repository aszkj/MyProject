package com.yilidi.o2o.core.paramvalidate.processor.concrete;

import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.paramvalidate.processor.AbstractParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean.MsgCode;

/**
 * Double字符串类型验证处理器
 * 
 * @author chenl
 * 
 */
public class StrDoubleProcessor extends AbstractParamValidateProcessor {

	private StrDoubleProcessor() {
	}

	private static class StrDoubleProcessorHolder {
		private static final StrDoubleProcessor STRDOUBLEPROCESSOR = new StrDoubleProcessor();
	}

	public static StrDoubleProcessor getInstance() {
		return StrDoubleProcessorHolder.STRDOUBLEPROCESSOR;
	}

	@Override
	protected ParamValidateMessageBean validateSpecificParamTypeRule(Param param) {
		// TODO Auto-generated method stub
		ParamValidateMessageBean msgBean = getMsgBean();
		try {
			Double.valueOf(param.getValue().toString());
			msgBean.setMsgCode(MsgCode.SUCCESS);
			return msgBean;
		} catch (Exception e) {
			msgBean.setMsg("“" + param.getName() + "“" + "类型不正确或超出长整型的取值范围").setMsgCode(MsgCode.FAILURE);
			return msgBean;
		}
	}

}
