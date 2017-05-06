/**
 * 文件名称：EncryptUtilTest.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.utils;

import java.io.UnsupportedEncodingException;

import junit.framework.Assert;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.log4j.Logger;
import org.junit.Test;

/**
 * 功能描述：
 * 作者：chenl
 * 
 * 
 */
public class EncryptUtilTest {

    private Logger logger = Logger.getLogger(EncryptUtilTest.class);
    @Test
    public void testMD5Crypt() throws UnsupportedEncodingException {
        
        String srcStr = "o2o_yilidi_999";
        String desStr = EncryptUtils.md5Crypt(srcStr);
       
        String expected = "C5AE9FE5595EA587F9899B02BFE40F8E";
        // 加密后： AE2A0CE318760F939751C31840BA0A3D
        //C5AE9FE5595EA587F9899B02BFE40F8E
        Assert.assertEquals(expected, desStr);
        
        logger.info("admin!@# => " + EncryptUtils.md5Crypt("admin!@#"));
        logger.info("admin => " + EncryptUtils.md5Crypt("admin"));
        
    }
    
    @Test
    public void testDES() {
        String srcStr = "admin!@#";
        
        String encode = EncryptUtils.desEncrypt(srcStr);
        String decode = EncryptUtils.desDecrypt(encode);
        
        logger.info("encode: " + encode);
        
        Assert.assertEquals(srcStr, decode);
    }
    
    @Test
    public void testBase64() {
        String srcStr = "admin!@#"; //"o2o_yilidi_999_中文_</>*#";
        String encode = EncryptUtils.base64Encode(srcStr);
        String decode = EncryptUtils.base64Decode(encode);
        
        logger.info("encode: " + encode);
        Assert.assertEquals(srcStr, decode);
    }
    
    @Test
    public void testMD5() {
    	String srcStr = "admin";
    	String encode = EncryptUtils.md5Crypt(srcStr);
        
        logger.info("encode: " + DigestUtils.md5Hex("kingapex"));
    }
}
