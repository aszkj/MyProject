/**
 * 文件名称：JsonUtilTest.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.utils;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.junit.Before;
import org.junit.Test;

import com.yilidi.o2o.core.model.Address;
import com.yilidi.o2o.core.model.User;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;

/**
 * 功能描述：jsonUtil类的测试
 * 
 * @author : chenl
 * 
 */
public class JsonUtilTest {

    private static Logger logger = Logger.getLogger(JsonUtilTest.class);
    User user = null;
    Address address = null;

    List<User> users = new ArrayList<User>();

    @Before
    public void setUp() {

        address = new Address(1, "深南大道123号");
        user = new User(1, "曹操", new Date(), address);

        for (int i = 5; i < 10; i++) {
            User u = new User(i, "曹操" + i, new Date(), address);
            users.add(u);
        }
    }

    @Test
    public void testParserToList() {

        String jsonStr = "[{'address':{'address':'深南大道123号','id':1},'birthDay':1413263066937,'id':5,'userName':'曹操5'},"
                + "{'address':{'$ref':'$[0].address'},'birthDay':1413263066937,'id':6,'userName':'曹操6'},"
                + "{'address':{'$ref':'$[0].address'},'birthDay':1413263066937,'id':7,'userName':'曹操7'},"
                + "{'address':{'$ref':'$[0].address'},'birthDay':1413263066937,'id':8,'userName':'曹操8'},"
                + "{'address':{'$ref':'$[0].address'},'birthDay':1413263066937,'id':9,'userName':'曹操9'}]";

        List<User> list = JsonUtils.parserToList(jsonStr, User.class);

        if (ObjectUtils.isNullOrEmpty(list)) {
            logger.error("error!");
        }
        for (User u : list) {
            logger.info(u.getAddress().getAddress());
            logger.info(u);
        }
    }

    @Test
    public void testParserToMap() {
        Map<String, List<User>> map = new HashMap<String, List<User>>();

        User user1 = new User(1, "曹操", new Date(), address);

        Address address1 = new Address(3, "深南大道2654号");
        User user2 = new User(2, "刘备", new Date(), address1);

        List<User> list = new ArrayList<User>();
        list.add(user1);
        list.add(user2);
        map.put("users", list);

        logger.info(map);

        String json = JsonUtils.toJsonStringWithDateFormat(map);

        Map<String, Object> uMap = JsonUtils.parserToMap(json);
        
        logger.info(uMap.get("users"));
    }

}
