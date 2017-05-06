package com.yilidi.o2o.core.paramvalidate.processor.concrete;

import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.paramvalidate.processor.AbstractParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean.MsgCode;

/**
 * Integer类型验证处理器
 * 
 * @author chenl
 * 
 */
public class IntegerTypeProcessor extends AbstractParamValidateProcessor {

	private IntegerTypeProcessor() {
	}

	private static class IntegerTypeProcessorHolder {
		private static final IntegerTypeProcessor INTEGERTYPEPROCESSOR = new IntegerTypeProcessor();
	}

	public static IntegerTypeProcessor getInstance() {
		return IntegerTypeProcessorHolder.INTEGERTYPEPROCESSOR;
	}

	@Override
	protected ParamValidateMessageBean validateSpecificParamTypeRule(Param param) {
		// TODO Auto-generated method stub
		ParamValidateMessageBean msgBean = getMsgBean();
		if (!(param.getValue() instanceof Integer)) {
			msgBean.setMsg("“" + param.getName() + "“" + "类型不正确").setMsgCode(MsgCode.FAILURE);
			return msgBean;
		} else {
			if ("NaN".equals(param.getValue().toString())) {
				msgBean.setMsg("“" + param.getName() + "“" + "类型不正确").setMsgCode(MsgCode.FAILURE);
				return msgBean;
			}
			try {
				Integer.parseInt(param.getValue().toString());
			} catch (NumberFormatException e) {
				msgBean.setMsg("“" + param.getName() + "“" + "类型不正确").setMsgCode(MsgCode.FAILURE);
				return msgBean;
			}
		}
		msgBean.setMsgCode(MsgCode.SUCCESS);
		return msgBean;
	}

}
