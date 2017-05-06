/**
 * 文件名称：PropertiesUtilTest.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.utils;

import java.util.Map;

import org.apache.log4j.Logger;
import org.junit.Test;

import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.PropertiesUtils;

/**
 * 功能描述：
 * 作者：chenl
 * 
 * 
 */
public class PropertiesUtilTest {

    private Logger logger = Logger.getLogger(PropertiesUtilTest.class);
    
    @Test
    public void testGetPropertiesToMap() {
        Map<String, String> proMap = PropertiesUtils.get("redis.properties");
        
        if (ObjectUtils.isNullOrEmpty(proMap)) {
            logger.error("error");
            return;
        }
        
        java.util.Iterator<String> it = proMap.keySet().iterator();
        while (it.hasNext()) {
            String key = it.next();
            logger.info(key + " => " + proMap.get(key));
        }
        
    }
}
