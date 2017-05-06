package com.yilidi.o2o.core.paramvalidate.processor.decorate.concrete;

import java.util.StringTokenizer;

import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.paramvalidate.processor.IParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.processor.decorate.AbstractDecorativeParamValidateProcessor;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean;
import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean.MsgCode;

/**
 * 过滤特殊字符验证处理器，属于装饰验证
 * 
 * @author chenl
 * 
 */
public class FilterSpecialCharacterProcessor extends AbstractDecorativeParamValidateProcessor {

	// 不完善(需规定哪些是属于特殊字符)，特殊字符的处理有待商讨(是进行转义替换还是直接报错提示不允许)
	private static final String STR_SPECIAL_CHARACTER = "<script";

	public FilterSpecialCharacterProcessor(IParamValidateProcessor processor) {
		super(processor);
	}

	@Override
	protected ParamValidateMessageBean decorate(Param param) {
		ParamValidateMessageBean msgBean = new ParamValidateMessageBean();
		msgBean.setMsgCode(MsgCode.SUCCESS);
		if (null != param && param.getValue() instanceof String && !"".equals(((String) param.getValue()))) {
			Boolean flag = true;
			if (!STR_SPECIAL_CHARACTER.contains(",")) {
				if (((String) param.getValue()).toLowerCase().contains(STR_SPECIAL_CHARACTER.toLowerCase())) {
					msgBean.setMsg(param.getName() + "含有特殊字符").setMsgCode(MsgCode.FAILURE);
					flag = false;
				}
			} else {
				StringTokenizer st = new StringTokenizer(STR_SPECIAL_CHARACTER, ",");
				while (st.hasMoreTokens()) {
					if (((String) param.getValue()).toLowerCase().contains(st.nextToken().toLowerCase())) {
						msgBean.setMsg(param.getName() + "含有特殊字符").setMsgCode(MsgCode.FAILURE);
						flag = false;
						break;
					}
				}
			}
			if (flag) {
				msgBean.setMsgCode(MsgCode.SUCCESS);
			}
		}
		return msgBean;
	}

}
