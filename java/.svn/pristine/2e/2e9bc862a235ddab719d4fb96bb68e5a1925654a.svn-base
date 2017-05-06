package com.yilidi.o2o.core.paramvalidate.processor.concrete;

import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.paramvalidate.processor.AbstractParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean.MsgCode;

/**
 * Double类型验证处理器
 * 
 * @author chenl
 * 
 */
public class DoubleTypeProcessor extends AbstractParamValidateProcessor {

	private DoubleTypeProcessor() {
	}

	private static class DoubleTypeProcessorHolder {
		private static final DoubleTypeProcessor DOUBLETYPEPROCESSOR = new DoubleTypeProcessor();
	}

	public static DoubleTypeProcessor getInstance() {
		return DoubleTypeProcessorHolder.DOUBLETYPEPROCESSOR;
	}

	@Override
	protected ParamValidateMessageBean validateSpecificParamTypeRule(Param param) {
		// TODO Auto-generated method stub
		ParamValidateMessageBean msgBean = getMsgBean();
		if (!(param.getValue() instanceof Double)) {
			msgBean.setMsg("“" + param.getName() + "”" + "类型不正确").setMsgCode(MsgCode.FAILURE);
			return msgBean;
		} else {
			if (((Double) param.getValue()).isNaN()) {
				msgBean.setMsg("“" + param.getName() + "”" + "类型不正确").setMsgCode(MsgCode.FAILURE);
				return msgBean;
			}
			try {
				Double.parseDouble(param.getValue().toString());
			} catch (NumberFormatException e) {
				msgBean.setMsg("“" + param.getName() + "”" + "类型不正确").setMsgCode(MsgCode.FAILURE);
				return msgBean;
			}
		}
		msgBean.setMsgCode(MsgCode.SUCCESS);
		return msgBean;
	}

}
