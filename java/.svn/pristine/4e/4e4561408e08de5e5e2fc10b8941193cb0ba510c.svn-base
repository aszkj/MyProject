package com.yilidi.o2o.system.jms.model.sms;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.model.SmsMessageModel;
import com.yilidi.o2o.core.utils.ObjectUtils;

/**
 * @Description: TODO(重置密码消息Model)
 * @author: chenlian
 * @date: 2016年6月12日 下午5:45:34
 */
public class ResetPwdSmsMessageModel extends SmsMessageModel {

    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = 4669489188783522067L;

    /**
     * 短信内容模版名称属性Key值：该值需在sms-message.properties配置文件中配置
     */
    private static final String CONTENT_TEMPLATE_NAME_PROPERTIES_KEY = "sms.forgetpwd.template";

    /**
     * 短信内容模版中定义的变量（验证码）， 短信内容模版中定义的变量在不同的短信模版里可能不同，有可能没有，有可能有多个，需根据具体短信灵活定义
     */
    private static final String CONTENT_TEMPLATE_VARIABLE_CAPTCHA = "captcha";

    public ResetPwdSmsMessageModel(List<String> toUserMobileList, String... variables) {
        if (ObjectUtils.isNullOrEmpty(toUserMobileList)) {
            throw new IllegalArgumentException("参数：toUserMobileList 不能为空！");
        }
        if (variables.length != 1) {
            throw new IllegalArgumentException("请按模版中定义的变量传递参数！");
        }
        if (StringUtils.isEmpty(variables[0])) {
            throw new IllegalArgumentException("模版中定义的变量：captcha 不能为空！");
        }
        this.toUserMobileList = toUserMobileList;
        this.smsProvideType = SystemContext.SystemDomain.SMSNOTIFYPROVIDETYPE_HUAXIN;
        this.smsMsgType = SystemContext.SystemDomain.SMSNOTIFYMSGTYPE_RESETPWD;
        this.contentTemplateNamePropertiesKey = CONTENT_TEMPLATE_NAME_PROPERTIES_KEY;
        this.contentVariablesMap = new HashMap<String, String>();
        this.contentVariablesMap.put(CONTENT_TEMPLATE_VARIABLE_CAPTCHA, variables[0]);
    }
}
