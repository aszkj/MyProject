/**
 * 文件名称：PropertiesUtil.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.utils;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.apache.log4j.Logger;

import com.yilidi.o2o.core.CommonConstants;

/**
 * 功能描述：属性文件读取工具 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public final class PropertiesUtils {

	private static Logger logger = Logger.getLogger(PropertiesUtils.class);

	private PropertiesUtils() {
	}

	/**
	 * 获取properties文件属性
	 * 
	 * @param propertiesName
	 *            资源文件名称
	 * @return 返回 Map 类型的数据结果
	 */
	public static Map<String, String> get(String propertiesName) {
		Map<String, String> map = new HashMap<String, String>();
		Properties properties = new Properties();
		InputStream inputStream = null;
		try {
			inputStream = PropertiesUtils.class.getClassLoader().getResourceAsStream(propertiesName);
			properties.load(new InputStreamReader(inputStream, CommonConstants.UTF_8));
		} catch (IOException e) {
			logger.error(e);
		}
		for (Object key : properties.keySet()) {
			String property = (String) key;
			String proValue = properties.getProperty(property);
			map.put(property, proValue);
		}
		if (inputStream != null) {
			try {
				inputStream.close();
			} catch (IOException e) {
				logger.error(e);
			}
		}
		return map;
	}
}
