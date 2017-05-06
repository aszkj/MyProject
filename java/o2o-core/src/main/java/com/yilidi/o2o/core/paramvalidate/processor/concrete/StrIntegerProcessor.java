package com.yilidi.o2o.core.paramvalidate.processor.concrete;

import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.paramvalidate.processor.AbstractParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean.MsgCode;

/**
 * Integer字符串类型验证处理器
 * 
 * @author chenl
 * 
 */
public class StrIntegerProcessor extends AbstractParamValidateProcessor {

	private StrIntegerProcessor() {
	}

	private static class StrIntegerProcessorHolder {
		private static final StrIntegerProcessor STRINTEGERPROCESSOR = new StrIntegerProcessor();
	}

	public static StrIntegerProcessor getInstance() {
		return StrIntegerProcessorHolder.STRINTEGERPROCESSOR;
	}

	@Override
	protected ParamValidateMessageBean validateSpecificParamTypeRule(Param param) {
		// TODO Auto-generated method stub
		ParamValidateMessageBean msgBean = getMsgBean();
		try {
			Integer.valueOf(param.getValue().toString());
			msgBean.setMsgCode(MsgCode.SUCCESS);
			return msgBean;
		} catch (Exception e) {
			msgBean.setMsg("“" + param.getName() + "“" + "类型不正确或超出整型的取值范围").setMsgCode(MsgCode.FAILURE);
			return msgBean;
		}
	}

}
