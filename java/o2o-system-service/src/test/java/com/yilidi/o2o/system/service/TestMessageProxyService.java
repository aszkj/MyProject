/**
 * 文件名称：TestMessageProxyService.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.system.service;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.yilidi.o2o.core.EmailTypeModelClassMapping;
import com.yilidi.o2o.core.KeyValuePair;
import com.yilidi.o2o.core.SmsTypeModelClassMapping;
import com.yilidi.o2o.core.exception.SystemServiceException;
import com.yilidi.o2o.system.proxy.IMessageProxyService;

/**
 * 功能描述：
 * 
 * 作者：chenl
 * 
 * 
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring.xml" })
public class TestMessageProxyService {

    @Autowired
    private IMessageProxyService messageProxyService;

    @Test
    public void testEmailMessage() throws SystemServiceException {
        KeyValuePair<String, String> fromUserNameAndEmailInfo = new KeyValuePair<String, String>("hotcoolchen_cl",
                "hotcoolchen_cl@126.com");
        KeyValuePair<String, String> toUserNameAndEmailInfo1 = new KeyValuePair<String, String>("chenlian",
                "hotcoolchen@126.com");
        KeyValuePair<String, String> toUserNameAndEmailInfo2 = new KeyValuePair<String, String>("liulei",
                "freesky_cl@qq.com");
        List<KeyValuePair<String, String>> toUserNameAndEmailInfoList = new ArrayList<KeyValuePair<String, String>>();
        toUserNameAndEmailInfoList.add(toUserNameAndEmailInfo1);
        toUserNameAndEmailInfoList.add(toUserNameAndEmailInfo2);
        messageProxyService.sendEmail(EmailTypeModelClassMapping.REGISTER, fromUserNameAndEmailInfo,
                toUserNameAndEmailInfoList, "http://www.yilidi.com");
    }

    @Test
    public void testSmsMessage() throws SystemServiceException {
        List<String> toUserMobileList = new ArrayList<String>();
        toUserMobileList.add("18682007972");
        messageProxyService
                .systemSendSms(SmsTypeModelClassMapping.REGISTER, toUserMobileList, "chenlian", "hotcoolchen", "123456");
    }
}
