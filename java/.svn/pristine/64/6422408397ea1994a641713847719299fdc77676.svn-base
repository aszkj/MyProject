package com.yilidi.o2o.core.paramvalidate.processor.concrete;

import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.paramvalidate.processor.AbstractParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean.MsgCode;

/**
 * Long字符串类型验证处理器
 * 
 * @author chenl
 * 
 */
public class StrLongProcessor extends AbstractParamValidateProcessor {

	private StrLongProcessor() {
	}

	private static class StrLongProcessorHolder {
		private static final StrLongProcessor STRLONGPROCESSOR = new StrLongProcessor();
	}

	public static StrLongProcessor getInstance() {
		return StrLongProcessorHolder.STRLONGPROCESSOR;
	}

	@Override
	protected ParamValidateMessageBean validateSpecificParamTypeRule(Param param) {
		// TODO Auto-generated method stub
		ParamValidateMessageBean msgBean = getMsgBean();
		try {
			Long.valueOf(param.getValue().toString());
			msgBean.setMsgCode(MsgCode.SUCCESS);
			return msgBean;
		} catch (Exception e) {
			msgBean.setMsg("“" + param.getName() + "“" + "类型不正确或超出长整型的取值范围").setMsgCode(MsgCode.FAILURE);
			return msgBean;
		}
	}

}
