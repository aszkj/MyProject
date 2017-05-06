/**
 * 文件名称：JsonUtil.java
 * 
 * 描述：JSON转换工具类
 * 
 *
 * BugId: 无
 * 修改内容：
 */
package com.yilidi.o2o.core.utils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.yilidi.o2o.core.CommonConstants;

/**
 * 功能描述：JSON转换工具类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public final class JsonUtils {

	private JsonUtils() {
	}

	/**
	 * 将对象转换为json字符串
	 * 
	 * @param obj
	 *            待转换的对象
	 * @return json字符串，为空的属性也显示出来。
	 */
	public static String toJsonString(Object obj) {
		if (null == obj) {
			return null;
		}
		return JSON.toJSONString(obj, SerializerFeature.WriteMapNullValue);
	}

	/**
	 * 将对象转换为json字符串, 并将时间字段进行格式化
	 * 
	 * @param obj
	 *            待转换的对象
	 * @param dateFormat
	 *            时间格式，若该字段为null，将使用默认的格式 "yyyy-MM-dd HH:mm:ss"
	 * @return 转换后的json字符串，为空的属性也显示出来。
	 */
	public static String toJsonStringWithDateFormat(Object obj, String dateFormat) {
		if (null == obj) {
			return null;
		}
		if (ObjectUtils.isNullOrEmpty(dateFormat)) {
			return JSON.toJSONStringWithDateFormat(obj, CommonConstants.DATE_FORMAT_CURRENTTIME,
					SerializerFeature.WriteMapNullValue);
		} else {
			return JSON.toJSONStringWithDateFormat(obj, dateFormat, SerializerFeature.WriteMapNullValue);
		}
	}

	/**
	 * 将对象转换为json字符串, 并将时间字段进行格式化为yyyy-MM-dd HH:mm:ss格式
	 * 
	 * @param obj
	 *            待转换的对象
	 * @return 转换后的json字符串
	 */
	public static String toJsonStringWithDateFormat(Object obj) {
		return toJsonStringWithDateFormat(obj, CommonConstants.DATE_FORMAT_CURRENTTIME);
	}

	/**
	 * 将对象转换为json字符串(将中文转换为unicode编码以兼容IE6同时将时间字段格式化)
	 * 
	 * @param obj
	 *            待转换的对象
	 * @return 转换后的json字符串
	 */
	public static String toJsonWithChineseToUnicode(Object obj) {
		if (null == obj) {
			return null;
		}
		return JSON.toJSONStringWithDateFormat(obj, CommonConstants.DATE_FORMAT_CURRENTTIME,
				SerializerFeature.BrowserCompatible);
	}

	/**
	 * 将对象转换为json字符串(关闭引用检测和生成)
	 * 
	 * @param obj
	 *            待转换的字符串
	 * @return 转换后的json字符串
	 */
	public static String toJsonWithNoRefrenceDetect(Object obj) {

		if (null == obj) {
			return null;
		}
		return JSON.toJSONStringWithDateFormat(obj, CommonConstants.DATE_FORMAT_CURRENTTIME,
				SerializerFeature.DisableCircularReferenceDetect);
	}

	/**
	 * 将json字符串转换为list对象
	 * 
	 * <pre>
	 * 使用方法：<br />
	 * List<User> list = JsonUtil.parserToList(jsonStr, User.class);
	 * </pre>
	 * 
	 * @param jsonStr
	 *            待转换的json字符串
	 * @param clazz
	 *            对象类型
	 * @param <T>
	 *            对象类型标识
	 * @return List<T> 转换后的list对象
	 */
	public static <T> List<T> parserToList(String jsonStr, Class<T> clazz) {
		if (null == jsonStr) {
			return null;
		}
		return JSON.parseArray(jsonStr, clazz);
	}

	/**
	 * 将json对象转换为Map
	 * 
	 * @param jsonStr
	 *            待转换的json字符串
	 * @return map对象
	 */
	public static Map<String, Object> parserToMap(String jsonStr) {
		if (null == jsonStr) {
			return null;
		}

		Map<String, Object> map = new HashMap<String, Object>();
		// 最外层解析
		JSONObject json = JSON.parseObject(jsonStr);

		for (Object k : json.keySet()) {
			Object v = json.get(k);
			// 如果内层还是数组的话，继续解析
			if (v instanceof JSONArray) {
				List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
				Iterator<Object> it = ((JSONArray) v).iterator();
				while (it.hasNext()) {
					JSONObject json2 = (JSONObject) it.next();
					list.add(parserToMap(json2.toString()));
				}
				map.put(k.toString(), list);
			} else {
				map.put(k.toString(), v);
			}
		}
		return map;
	}

	/**
	 * 将Json字符串解析程Map对象(只支持Map<String,T> 和 Map<String, List<T>) 类型的转换)
	 * 
	 * <pre>
	 *  该方法目前只支持两种类型的json到map的转换，
	 *  (1) Map key为字符串，Value为一个非集合类型对象
	 *  (2) Map key为字符串， Value为一个List类型，list中存放非集合类型对象
	 *  如果为更为负责的集合对象，请使用parserToMap方法，得到后在分别进行转换
	 *  例如：
	 *      Map<String, User>, Map<String, List<User>)
	 *  使用方法：
	 *      Map<String, User> map = parserToMap2(jsonStr, User.class);
	 *          User u = (User)map.get(key);
	 *      Map<String, Integer> map = parserToMap2(jsonStr, Integer.class);
	 *          Integer num = (Integer)map.get(key);
	 *      Map<String, String> map = parserToMap2(jsonStr, String.class);
	 *          String name = (String)map.get(key);
	 *      
	 *      Map<String, List<User>> map = parserToMap2(jsonStr, User.class);
	 *          List<User> users = (List<User>)map.get(key);
	 *      Map<String, List<Integer>> map = parserToMap2(jsonStr, Integer.class);
	 *          List<Integer> nums = (List<Integer>)map.get(key);
	 * </pre>
	 * 
	 * @param jsonStr
	 *            待转换的字符串
	 * @param clazz
	 *            集合中的元素 类 型
	 * @param <T>
	 *            泛型
	 * @return Map集合
	 */
	public static <T> Map<String, Object> parserToMap2(String jsonStr, Class<T> clazz) {
		if (null == jsonStr) {
			return null;
		}

		Map<String, Object> map = new HashMap<String, Object>();
		// 最外层解析
		JSONObject json = JSON.parseObject(jsonStr);

		for (Object k : json.keySet()) {
			Object v = json.get(k);
			String vStr = v.toString();

			// 如果内层还是数组的话，继续解析
			if (v instanceof JSONArray) {
				List<T> list = new ArrayList<T>();
				list = JsonUtils.parserToList(vStr, clazz);
				map.put(k.toString(), list);
			} else {
				// 转换为对象
				T obj = JSON.parseObject(vStr, clazz);
				map.put(k.toString(), obj);
			}
		}
		return map;
	}

	/**
	 * 将json字符串转换为JsonArray对象
	 * 
	 * @param jsonStr
	 *            json字符串
	 * @return 转换后的JSONArray
	 */
	public static JSONArray parserToJsonArray(String jsonStr) {
		if (null == jsonStr) {
			return null;
		}
		return JSON.parseArray(jsonStr);
	}

	/**
	 * 将json字符串转换为对象
	 * 
	 * <pre>
	 * 使用方法：<br />
	 * User user = JsonUtil.parseObject(jsonStr, User.class);
	 * </pre>
	 * 
	 * @param jsonStr
	 *            json字符串
	 * @param clazz
	 *            对象类型
	 * @param <T>
	 *            返回对象类型
	 * @return 转换后的对象
	 */
	public static <T> T parseObject(String jsonStr, Class<T> clazz) {
		if (null == jsonStr) {
			return null;
		}
		return JSON.parseObject(jsonStr, clazz);
	}

	/**
	 * 将json字符串转换为JSONObject对象
	 * 
	 * @param jsonStr
	 *            json字符串
	 * @return 转换后的JSONObject
	 */
	public static JSONObject parseObject(String jsonStr) {
		if (null == jsonStr) {
			return null;
		}
		return JSON.parseObject(jsonStr);
	}

	/**
	 * 将JSONObject对象转换为Java对象
	 * 
	 * <pre>
	 * 使用方法：<br />
	 * User user = JsonUtil.parseObject(jsonStr, User.class);
	 * </pre>
	 * 
	 * @param jsonObject
	 *            JSONObject对象
	 * @param clazz
	 *            对象类型
	 * @param <T>
	 *            返回对象类型
	 * @return 转换后的对象
	 */
	public static <T> T parseObject(JSONObject jsonObject, Class<T> clazz) {
		if (null == jsonObject) {
			return null;
		}
		return JSONObject.toJavaObject(jsonObject, clazz);
	}

}
