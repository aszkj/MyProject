package com.yilidi.o2o.system.jms.model.push;

import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.model.PushMessageModel;
import com.yilidi.o2o.core.utils.ObjectUtils;

/**
 * 订单接单推送消息
 * 
 * @author: chenlian
 * @date: 2016年8月8日 上午10:16:07
 */
public class OrderAcceptPushMessageModel extends PushMessageModel {

    /**
     * @Fields serialVersionUID : TODO(serialVersionUID)
     */
    private static final long serialVersionUID = 4669489188783522067L;

    /**
     * 推送内容模版名称属性Key值：该值需在push-message.properties配置文件中配置
     */
    private static final String CONTENT_TEMPLATE_NAME_PROPERTIES_KEY = "push.order.accept.template";

    /**
     * 推送内容模版中定义的变量（待接单数量）， 推送内容模版中定义的变量在不同的推送模版里可能不同，有可能没有，有可能有多个，需根据具体推送灵活定义
     */
    private static final String CONTENT_TEMPLATE_VARIABLE_FOR_ACCEPT_COUNT = "forAcceptCount";
    /**
     * 待接单语音文件名称
     */
    private static final String PUSH_FOR_ACCEPT_SOUND = "new_order_tips.wav";

    public OrderAcceptPushMessageModel(List<Integer> toUserIdList, String... variables) {
        if (ObjectUtils.isNullOrEmpty(toUserIdList)) {
            throw new IllegalArgumentException("参数：toUserIdList 不能为空！");
        }
        if (variables.length != 1) {
            throw new IllegalArgumentException("请按模版中定义的变量传递参数！");
        }
        if (StringUtils.isEmpty(variables[0])) {
            throw new IllegalArgumentException("模版中定义的变量：forAcceptCount 不能为空！");
        }
        this.toUserIdList = toUserIdList;
        this.pushProvideType = SystemContext.SystemDomain.PUSHNOTIFYPROVIDETYPE_GETUI;
        this.pushMsgType = SystemContext.SystemDomain.PUSHNOTIFYMSGTYPE_ORDERACCEPT;
        this.contentTemplateNamePropertiesKey = CONTENT_TEMPLATE_NAME_PROPERTIES_KEY;
        this.contentVariablesMap = new HashMap<String, String>();
        this.contentVariablesMap.put(CONTENT_TEMPLATE_VARIABLE_FOR_ACCEPT_COUNT, variables[0]);
        this.soundVariable = PUSH_FOR_ACCEPT_SOUND;
    }

}
