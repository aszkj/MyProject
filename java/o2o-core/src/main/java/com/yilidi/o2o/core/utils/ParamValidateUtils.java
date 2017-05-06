package com.yilidi.o2o.core.utils;

import com.yilidi.o2o.core.paramvalidate.ParamValidateMessageBean;
import com.yilidi.o2o.core.paramvalidate.ParamValidator;
import com.yilidi.o2o.core.paramvalidate.build.Param;

/**
 * @Description: TODO(参数验证工具类)
 * @author: chenlian
 * @date: 2016年6月3日 上午10:10:45
 */
public class ParamValidateUtils {

    /**
     * @Description TODO(参数验证)
     * @param params
     */
    public static void validateParams(Param... params) {
        if (!ObjectUtils.isNullOrEmpty(params)) {
            String msg = null;
            for (Param param : params) {
                ParamValidateMessageBean mb = ParamValidator.validate(param);
                if (null != mb && mb.getMsgCode() == ParamValidateMessageBean.MsgCode.FAILURE.getValue().intValue()) {
                    msg = mb.getMsg();
                    break;
                }
            }
            if (!StringUtils.isEmpty(msg)) {
                throw new IllegalArgumentException(msg);
            }
        }
    }

}
