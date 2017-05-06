package com.yilidi.o2o.core.paramvalidate.processor;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean.MsgCode;

/**
 * 抽象参数验证处理器
 * 
 * @author chenl
 * 
 */
public abstract class AbstractParamValidateProcessor implements IParamValidateProcessor {

	private static final ThreadLocal<ParamValidateMessageBean> MSGBEANTHREADLOCAL = new ThreadLocal<ParamValidateMessageBean>();

	protected ParamValidateMessageBean getMsgBean() {
		if (null == MSGBEANTHREADLOCAL.get()) {
			ParamValidateMessageBean msgBean = new ParamValidateMessageBean();
			MSGBEANTHREADLOCAL.set(msgBean);
		}
		return MSGBEANTHREADLOCAL.get();
	}

	private void removeMsgBean() {
		MSGBEANTHREADLOCAL.remove();
	}

	@Override
	public ParamValidateMessageBean process(Param param) {
		ParamValidateMessageBean msgBean = getMsgBean();
		try {
			if (null == param || null == param.getName() || null == param.getParamType() || null == param.getIsAllowEmpty()) {
				msgBean.setMsg("参数基本要素不完整，无法校验").setMsgCode(MsgCode.FAILURE);
				return msgBean;
			}
			if (param.getIsAllowEmpty()
					&& (null == param.getValue() || (param.getValue() instanceof String && "".equals(((String) param
							.getValue()))))) {
				msgBean.setMsgCode(MsgCode.SUCCESS);
				return msgBean;
			}
			msgBean = validateIsAllowEmpty(param);
			if (msgBean.getMsgCode() == MsgCode.FAILURE.getValue().intValue()) {
				return msgBean;
			}
			msgBean = validateRegex(param);
			if (msgBean.getMsgCode() == MsgCode.FAILURE.getValue().intValue()) {
				return msgBean;
			}
			msgBean = validateSpecificParamTypeRule(param);
			if (msgBean.getMsgCode() == MsgCode.FAILURE.getValue().intValue()) {
				return msgBean;
			}
			msgBean = validateMinLength(param);
			if (msgBean.getMsgCode() == MsgCode.FAILURE.getValue().intValue()) {
				return msgBean;
			}
			msgBean = validateMaxLength(param);
			if (msgBean.getMsgCode() == MsgCode.FAILURE.getValue().intValue()) {
				return msgBean;
			}
			msgBean = validateMinValue(param);
			if (msgBean.getMsgCode() == MsgCode.FAILURE.getValue().intValue()) {
				return msgBean;
			}
			msgBean = validateMaxValue(param);
			if (msgBean.getMsgCode() == MsgCode.FAILURE.getValue().intValue()) {
				return msgBean;
			}
		} catch (Exception e) {
			msgBean.setMsg("系统出现未知异常").setMsgCode(MsgCode.FAILURE);
			return msgBean;
		} finally {
			removeMsgBean();
		}
		return msgBean;
	}

	protected ParamValidateMessageBean validateIsAllowEmpty(Param param) {
		ParamValidateMessageBean msgBean = getMsgBean();
		if (!param.getIsAllowEmpty()
				&& (null == param.getValue() || (param.getValue() instanceof String && ""
						.equals(((String) param.getValue()))))) {
			msgBean.setMsg("“" + param.getName() + "”" + "不允许为空").setMsgCode(MsgCode.FAILURE);
			return msgBean;
		}
		msgBean.setMsgCode(MsgCode.SUCCESS);
		return msgBean;
	}

	protected ParamValidateMessageBean validateMinLength(Param param) {
		ParamValidateMessageBean msgBean = getMsgBean();
		if (null != param.getMinLength() && param.getValue().toString().length() < param.getMinLength().intValue()) {
			msgBean.setMsg("“" + param.getName() + "”" + "长度小于最小长度" + param.getMinLength().intValue() + "的限制").setMsgCode(
					MsgCode.FAILURE);
			return msgBean;
		}
		msgBean.setMsgCode(MsgCode.SUCCESS);
		return msgBean;
	}

	protected ParamValidateMessageBean validateMaxLength(Param param) {
		ParamValidateMessageBean msgBean = getMsgBean();
		if (null != param.getMaxLength() && param.getValue().toString().length() > param.getMaxLength().intValue()) {
			msgBean.setMsg("“" + param.getName() + "”" + "长度大于最大长度" + param.getMaxLength().intValue() + "的限制").setMsgCode(
					MsgCode.FAILURE);
			return msgBean;
		}
		msgBean.setMsgCode(MsgCode.SUCCESS);
		return msgBean;
	}

	protected ParamValidateMessageBean validateMinValue(Param param) {
		ParamValidateMessageBean msgBean = getMsgBean();
		if (null != param.getMinValue()
				&& ((param.getValue() instanceof Integer && ((Integer) param.getValue()).intValue() < param.getMinValue()
						.longValue())
						|| (param.getValue() instanceof Long && ((Long) param.getValue()).longValue() < param.getMinValue()
								.longValue()) || (param.getValue() instanceof Double && ((Double) param.getValue())
						.doubleValue() < param.getMinValue().longValue()))) {
			msgBean.setMsg("“" + param.getName() + "”" + "小于最小值" + param.getMinValue().longValue() + "的限制").setMsgCode(
					MsgCode.FAILURE);
			return msgBean;
		}
		msgBean.setMsgCode(MsgCode.SUCCESS);
		return msgBean;
	}

	protected ParamValidateMessageBean validateMaxValue(Param param) {
		ParamValidateMessageBean msgBean = getMsgBean();
		if (null != param.getMaxValue()
				&& ((param.getValue() instanceof Integer && ((Integer) param.getValue()).intValue() > param.getMaxValue()
						.longValue())
						|| (param.getValue() instanceof Long && ((Long) param.getValue()).longValue() > param.getMaxValue()
								.longValue()) || (param.getValue() instanceof Double && ((Double) param.getValue())
						.doubleValue() > param.getMaxValue().longValue()))) {
			msgBean.setMsg("“" + param.getName() + "”" + "大于最大值" + param.getMaxValue().longValue() + "的限制").setMsgCode(
					MsgCode.FAILURE);
			return msgBean;
		}
		msgBean.setMsgCode(MsgCode.SUCCESS);
		return msgBean;
	}

	protected ParamValidateMessageBean validateRegex(Param param) {
		ParamValidateMessageBean msgBean = getMsgBean();
		if (null != param.getRegex() && !"".equals(param.getRegex())) {
			Pattern pattern = Pattern.compile(param.getRegex());
			Matcher matcher = pattern.matcher(param.getValue().toString());
			if (!matcher.matches()) {
				msgBean.setMsg("“" + param.getName() + "”" + "格式非法").setMsgCode(MsgCode.FAILURE);
				return msgBean;
			}
		}
		msgBean.setMsgCode(MsgCode.SUCCESS);
		return msgBean;
	}

	protected abstract ParamValidateMessageBean validateSpecificParamTypeRule(Param param);
}
