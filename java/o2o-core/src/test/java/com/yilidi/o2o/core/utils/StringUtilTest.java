/**
 * 文件名称：StringUtilTest.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.utils;

import junit.framework.Assert;

import org.apache.log4j.Logger;
import org.junit.Test;

import com.yilidi.o2o.core.utils.StringUtils;

/**
 * 功能描述： 作者：chenl
 * 
 * 
 */
public class StringUtilTest {

    Logger logger = Logger.getLogger(this.getClass());

    /**
     * 测试将数组连接成为一个带有分隔符的字符串
     */
    @Test
    public void testJoin() {
        String[] arr = { "yyyy", "MM", "dd" };

        String jStr = StringUtils.join(arr, "-");
        logger.info(jStr);
        Assert.assertEquals("yyyy-MM-dd", jStr);

        String[] arr2 = { "yyyy" };

        String jStr2 = StringUtils.join(arr2, "-");
        logger.info(jStr2);
        Assert.assertEquals("yyyy", jStr2);
    }

    @Test
    public void testByteAndStringChange() {

        String src = "好似额ZIF SI123 W232";

        byte[] bs = StringUtils.stringToByte(src);

        logger.info(new String(bs));
        String dest = StringUtils.byteToString(bs);

        logger.info(dest);
    }

    @Test
    public void paramsTest() {
        Object[] parmas = new Object[5];

        parmas[0] = "string";
        parmas[1] = new Integer(59);
        parmas[2] = false;
        parmas[3] = null;
        parmas[4] = new Double(3.25487);

        String join = StringUtils.join(parmas, ",");

        logger.info("Join: " + join);

    }

    @Test
    public void UUIDTest() {
        String uuid = StringUtils.getUUID(true);

        logger.info("length: " + uuid.length() + ", " + uuid);

        uuid = StringUtils.getUUID(false);
        logger.info("length: " + uuid.length() + ", " + uuid);

        String str = "A0000036240EE7";
        int code = str.hashCode();

        logger.info("hashCode: " + code % 19);

        str = "A000003624173A";
        code = str.hashCode();
        logger.info("hashCode: " + code % 19);
    }

    @Test
    public void testOrderNo() {
        String orderNo = StringUtils.generateSaleOrderNo();

        logger.info("OrderNo: " + orderNo);
    }

    @Test
    public void testZH_CN() {

        String zhCn = StringUtils.randomStringCN(8);
        logger.info(zhCn);
    }

}
