package com.yilidi.o2o.system.jms.model.sms;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.model.SmsMessageModel;
import com.yilidi.o2o.core.utils.ObjectUtils;

/**
 * 订单退款短信消息
 * 
 * @author: chenlian
 * @date: 2016年6月23日 下午5:42:28
 */
public class OrderRefundSmsMessageModel extends SmsMessageModel {

    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = 4669489188783522067L;

    /**
     * 短信内容模版名称属性Key值：该值需在sms-message.properties配置文件中配置
     */
    private static final String CONTENT_TEMPLATE_NAME_PROPERTIES_KEY = "sms.order.refund.template";

    /**
     * 短信内容模版中定义的变量（退款金额）， 短信内容模版中定义的变量在不同的短信模版里可能不同，有可能没有，有可能有多个，需根据具体短信灵活定义
     */
    private static final String CONTENT_TEMPLATE_VARIABLE_REFUND_AMOUNT = "refundAmount";
    
    /**
     * 短信内容模版中定义的变量（退款工作日）， 短信内容模版中定义的变量在不同的短信模版里可能不同，有可能没有，有可能有多个，需根据具体短信灵活定义
     */
    private static final String CONTENT_TEMPLATE_VARIABLE_REFUND_DAYS = "refundDays";
    
    /**
     * 短信内容模版中定义的变量（客服热线）， 短信内容模版中定义的变量在不同的短信模版里可能不同，有可能没有，有可能有多个，需根据具体短信灵活定义
     */
    private static final String CONTENT_TEMPLATE_VARIABLE_CUST_PHONE = "custPhone";

    public OrderRefundSmsMessageModel(List<String> toUserMobileList, String... variables) {
        if (ObjectUtils.isNullOrEmpty(toUserMobileList)) {
            throw new IllegalArgumentException("参数：toUserMobileList 不能为空！");
        }
        if (variables.length != 3) {
            throw new IllegalArgumentException("请按模版中定义的变量传递参数！");
        }
        if (StringUtils.isEmpty(variables[0])) {
            throw new IllegalArgumentException("模版中定义的变量：refundAmount 不能为空！");
        }
        if (StringUtils.isEmpty(variables[1])) {
            throw new IllegalArgumentException("模版中定义的变量：refundDays 不能为空！");
        }
        if (StringUtils.isEmpty(variables[2])) {
            throw new IllegalArgumentException("模版中定义的变量：custPhone 不能为空！");
        }
        this.toUserMobileList = toUserMobileList;
        this.smsProvideType = SystemContext.SystemDomain.SMSNOTIFYPROVIDETYPE_HUAXIN;
        this.smsMsgType = SystemContext.SystemDomain.SMSNOTIFYMSGTYPE_ORDERREFUND;
        this.contentTemplateNamePropertiesKey = CONTENT_TEMPLATE_NAME_PROPERTIES_KEY;
        this.contentVariablesMap = new HashMap<String, String>();
        this.contentVariablesMap.put(CONTENT_TEMPLATE_VARIABLE_REFUND_AMOUNT, variables[0]);
        this.contentVariablesMap.put(CONTENT_TEMPLATE_VARIABLE_REFUND_DAYS, variables[1]);
        this.contentVariablesMap.put(CONTENT_TEMPLATE_VARIABLE_CUST_PHONE, variables[2]);
    }

}
