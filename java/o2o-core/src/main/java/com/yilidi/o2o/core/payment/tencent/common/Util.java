package com.yilidi.o2o.core.payment.tencent.common;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.util.Map;

import org.apache.log4j.Logger;

import com.thoughtworks.xstream.XStream;
import com.yilidi.o2o.core.utils.StringUtils;

/**
 * 工具类
 * 
 * @author simpson
 * 
 */
public final class Util {

    // 打log用
    private static Logger logger = Logger.getLogger(Util.class);

    private Util() {
    }

    /**
     * 通过反射的方式遍历对象的属性和属性值，方便调试
     * 
     * @param o
     *            要遍历的对象
     * @throws Exception
     *             异常
     */
    public static void reflect(Object o) throws Exception {
        Class<? extends Object> cls = o.getClass();
        Field[] fields = cls.getDeclaredFields();
        for (int i = 0; i < fields.length; i++) {
            Field f = fields[i];
            f.setAccessible(true);
            Util.log(f.getName() + " -> " + f.get(o));
        }
    }

    /**
     * 获取流入的数组
     * 
     * @param in
     *            输入流
     * @return 字节数组
     * @throws IOException
     *             io异常
     */
    public static byte[] readInput(InputStream in) throws IOException {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        int len = 0;
        byte[] buffer = new byte[1024];
        while ((len = in.read(buffer)) > 0) {
            out.write(buffer, 0, len);
        }
        out.close();
        in.close();
        return out.toByteArray();
    }

    /**
     * 输入流转字符串
     * 
     * @param is
     *            输入流
     * @return 字符串
     * @throws IOException
     *             io异常
     */
    public static String inputStreamToString(InputStream is) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        int i;
        while ((i = is.read()) != -1) {
            baos.write(i);
        }
        return baos.toString();
    }

    /**
     * 获取输入流
     * 
     * @param sInputString
     *            输入字符串
     * @return 输入流
     */
    public static InputStream getStringStream(String sInputString) {
        ByteArrayInputStream tInputStringStream = null;
        if (StringUtils.isNotBlank(sInputString)) {
            tInputStringStream = new ByteArrayInputStream(sInputString.getBytes());
        }
        return tInputStringStream;
    }

    /**
     * 获取xml中的类对象
     * 
     * @param xml
     *            xml字符串
     * @param tClass
     *            对象类
     * @return 对象
     */
    public static Object getObjectFromXML(String xml, Class<?> tClass) {
        // 将从API返回的XML数据映射到Java对象
        XStream xStreamForResponseData = new XStream();
        xStreamForResponseData.alias("xml", tClass);
        // 暂时忽略掉一些新增的字段
        xStreamForResponseData.ignoreUnknownElements();
        return xStreamForResponseData.fromXML(xml);
    }

    /**
     * 根据key获取map中的值，找不到使用默认返回值
     * 
     * @param map
     *            数据map
     * @param key
     *            key字符串
     * @param defaultValue
     *            默认值
     * @return 值
     */
    public static String getStringFromMap(Map<String, Object> map, String key, String defaultValue) {
        if (StringUtils.isEmpty(key)) {
            return defaultValue;
        }
        String result = (String) map.get(key);
        if (result == null) {
            return defaultValue;
        } else {
            return result;
        }
    }

    /**
     * 根据key获取map中的值
     * 
     * @param map
     *            数据map
     * @param key
     *            key字符串
     * @return 值
     */
    public static int getIntFromMap(Map<String, Object> map, String key) {
        if (StringUtils.isEmpty(key)) {
            return 0;
        }
        if (map.get(key) == null) {
            return 0;
        }
        return Integer.parseInt((String) map.get(key));
    }

    /**
     * 打log接口
     * 
     * @param log
     *            要打印的log字符串
     * @return 返回log
     */
    public static String log(Object log) {
        logger.info(log.toString());
        return log.toString();
    }

    /**
     * 读取本地的xml数据，一般用来自测用
     * 
     * @param localPath
     *            本地xml文件路径
     * @return 读到的xml字符串
     * @throws IOException
     *             io异常
     */
    public static String getLocalXMLString(String localPath) throws IOException {
        return Util.inputStreamToString(Util.class.getResourceAsStream(localPath));
    }

}
