package com.yilidi.o2o.system.jms.model.email;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.yilidi.o2o.core.KeyValuePair;
import com.yilidi.o2o.core.model.EmailMessageModel;
import com.yilidi.o2o.core.utils.ObjectUtils;

/**
 * 
 * @Description:TODO(注册发送Email消息实体)
 * @author: chenlian
 * @date: 2015年10月29日 下午7:28:30
 * 
 */
public class RegisterEmailMessageModel extends EmailMessageModel {

    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = 8065574219540452466L;

    /**
     * 邮件主题属性Key值：该值需在config.properties配置文件中配置
     */
    private static final String TITLE_PROPERTIES_KEY = "mail.register.subject";

    /**
     * 邮件内容模版名称属性Key值：该值需在config.properties配置文件中配置
     */
    private static final String CONTENT_TEMPLATE_NAME_PROPERTIES_KEY = "mail.register.template";

    /**
     * 邮件内容模版中定义的变量（激活链接）， 邮件内容模版中定义的变量在不同的Email模版里可能不同，有可能没有，有可能有多个，须根据具体邮件灵活定义，此处为注册时所发的邮件，仅需“激活链接”这个变量就行
     */
    private static final String CONTENT_TEMPLATE_VARIABLE_ACTIVATION_LINK = "activationLink";

    /**
     * @Title: RegisterEmailMessageModel
     * @Description: TODO(私有构造方法，防止误用)
     * @param: @param fromUserNameAndEmailInfo
     * @param: @param toUserNameAndEmailInfoList
     * @param: @param variables
     * @throws
     */
    private RegisterEmailMessageModel(KeyValuePair<String, String> fromUserNameAndEmailInfo,
            List<KeyValuePair<String, String>> toUserNameAndEmailInfoList, String... variables) {
        if (null == fromUserNameAndEmailInfo) {
            throw new IllegalArgumentException("参数：fromUserNameAndEmailInfo 不能为空！");
        }
        if (ObjectUtils.isNullOrEmpty(toUserNameAndEmailInfoList)) {
            throw new IllegalArgumentException("参数：toUserNameAndEmailInfoList 不能为空！");
        }
        if (variables.length != 1) {
            throw new IllegalArgumentException("请按模版中定义的变量传递参数！");
        }
        if (StringUtils.isEmpty(variables[0])) {
            throw new IllegalArgumentException("模版中定义的变量：activationLink 不能为空！");
        }
        this.fromUserNameAndEmailInfo = fromUserNameAndEmailInfo;
        this.toUserNameAndEmailInfoList = toUserNameAndEmailInfoList;
        this.titlePropertiesKey = TITLE_PROPERTIES_KEY;
        this.contentTemplateNamePropertiesKey = CONTENT_TEMPLATE_NAME_PROPERTIES_KEY;
        this.contentVariablesMap = new HashMap<String, String>();
        this.contentVariablesMap.put(CONTENT_TEMPLATE_VARIABLE_ACTIVATION_LINK, variables[0]);
    }

}
