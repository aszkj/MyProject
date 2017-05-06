package com.yilidi.o2o.core.paramvalidate;

import java.util.List;

import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.paramvalidate.state.ParamTypeManager;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean.MsgCode;

/**
 * 参数验证工具类
 * 
 * @author chenl
 * 
 */
public class ParamValidator {

	public static ParamValidateMessageBean validate(Param param) {
		ParamValidateMessageBean mb = new ParamValidateMessageBean();
		if (null == param) {
			mb.setMsg("没有需要验证的参数").setMsgCode(MsgCode.FAILURE);
			return mb;
		}
		ParamTypeManager paramTypeManager = new ParamTypeManager(param.getParamType());
		ParamValidateMessageBean msgBean = paramTypeManager.getParamValidateProcessor().process(param);
		if (null != msgBean && msgBean.getMsgCode() == MsgCode.FAILURE.getValue().intValue()) {
			return msgBean;
		}
		mb.setMsg("参数验证成功").setMsgCode(MsgCode.SUCCESS);
		return mb;
	}

	public static ParamValidateMessageBean validateForList(List<Param> paramList) {

		ParamValidateMessageBean mb = new ParamValidateMessageBean();
		if (null == paramList || paramList.isEmpty()) {
			mb.setMsg("没有需要验证的参数").setMsgCode(MsgCode.FAILURE);
			return mb;
		}
		StringBuilder errorInfo = new StringBuilder("");
		for (Param param : paramList) {
			ParamTypeManager paramTypeManager = new ParamTypeManager(param.getParamType());
			ParamValidateMessageBean msgBean = paramTypeManager.getParamValidateProcessor().process(param);
			if (null != msgBean && msgBean.getMsgCode() == MsgCode.FAILURE.getValue().intValue()) {
				errorInfo.append(msgBean.getMsg()).append("</br>");
			}
		}
		if (!"".equals(errorInfo.toString())) {
			mb.setMsg(errorInfo.toString().substring(0, errorInfo.toString().lastIndexOf("</br>"))).setMsgCode(
					MsgCode.FAILURE);
			return mb;
		}
		mb.setMsg("参数验证成功").setMsgCode(MsgCode.SUCCESS);
		return mb;
	}

}
