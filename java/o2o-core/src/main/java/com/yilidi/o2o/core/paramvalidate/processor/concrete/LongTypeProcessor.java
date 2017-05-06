package com.yilidi.o2o.core.paramvalidate.processor.concrete;

import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.paramvalidate.processor.AbstractParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean.MsgCode;

/**
 * Long类型验证处理器
 * 
 * @author chenl
 * 
 */
public class LongTypeProcessor extends AbstractParamValidateProcessor {

	private LongTypeProcessor() {
	}

	private static class LongTypeProcessorHolder {
		private static final LongTypeProcessor LONGTYPEPROCESSOR = new LongTypeProcessor();
	}

	public static LongTypeProcessor getInstance() {
		return LongTypeProcessorHolder.LONGTYPEPROCESSOR;
	}

	@Override
	protected ParamValidateMessageBean validateSpecificParamTypeRule(Param param) {
		// TODO Auto-generated method stub
		ParamValidateMessageBean msgBean = getMsgBean();
		if (!(param.getValue() instanceof Long)) {
			msgBean.setMsg("“" + param.getName() + "”" + "类型不正确").setMsgCode(MsgCode.FAILURE);
			return msgBean;
		} else {
			if ("NaN".equals(param.getValue().toString())) {
				msgBean.setMsg("“" + param.getName() + "”" + "类型不正确").setMsgCode(MsgCode.FAILURE);
				return msgBean;
			}
			try {
				Long.parseLong(param.getValue().toString());
			} catch (NumberFormatException e) {
				msgBean.setMsg("“" + param.getName() + "”" + "类型不正确").setMsgCode(MsgCode.FAILURE);
				return msgBean;
			}
		}
		msgBean.setMsgCode(MsgCode.SUCCESS);
		return msgBean;
	}

}
