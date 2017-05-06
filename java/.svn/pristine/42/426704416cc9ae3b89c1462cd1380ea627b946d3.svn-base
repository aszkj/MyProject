/**
 * 文件名称：ObjectUtil.java
 * 
 * 描述： 检查对象是否为null或者集合元素个数为0
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.utils;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Collection;
import java.util.Date;
import java.util.Map;

import org.apache.log4j.Logger;

import com.simpson.utils.mapping.BeanMappingUtil;
import com.simpson.utils.mapping.core.BeanMappingException;

/**
 * 功能描述：对象工具类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public final class ObjectUtils extends org.apache.commons.lang3.ObjectUtils {

	private static Logger logger = Logger.getLogger(ObjectUtils.class);
	private static final String ERROR_STRING = "对象属性复制异常:";

	private ObjectUtils() {
	}

	/**
	 * 判断对象是否为空
	 * <p>
	 * 如果为String，则判断 null 和 "" <br />
	 * 如果为集合与MAP,则断null 和 集合中无元素 <br />
	 * 如果为数组，则判断null 和 length=0 <br />
	 * </p>
	 * 
	 * <pre>
	 * isNullOrEmpty(null) true
	 * isNullOrEmpty("") true
	 * isNullOrEmpty(list) list=null 或者 list.size() =0 返回true
	 * isNullOrEmpty(map)  map=null 或者 map.size() =0 返回true
	 * isNullOrEmpty(array)  array=null 或者 array.length =0 返回true
	 * </pre>
	 * 
	 * @param obj
	 *            待判断对象
	 * @return ture or false
	 */
	@SuppressWarnings("rawtypes")
	public static boolean isNullOrEmpty(Object obj) {
		if (obj == null) {
			return true;
		} else if (obj instanceof String && "".equals(String.valueOf(obj).trim())) {
			return true;
		} else if (obj instanceof Collection && ((Collection) obj).isEmpty()) {
			return true;
		} else if (obj instanceof Map && ((Map) obj).isEmpty()) {
			return true;
		} else if (obj instanceof Object[] && ((Object[]) obj).length == 0) {
			return true;
		} else if (obj instanceof Boolean && !((Boolean) obj)) {
			return true;
		}
		return false;
	}

	/**
	 * 将对象转换为字节数组
	 * 
	 * @param obj
	 *            待转换对象
	 * @return 对象的字节数组
	 */
	public static byte[] toByteArray(Object obj) {
		ObjectOutputStream oos = null;
		ByteArrayOutputStream baos = null;
		try {
			// 序列化
			baos = new ByteArrayOutputStream();
			oos = new ObjectOutputStream(baos);
			oos.writeObject(obj);
			byte[] bytes = baos.toByteArray();
			return bytes;
		} catch (Exception e) {
			logger.error("对象序列化字节数组异常", e);
		}
		return null;
	}

	/**
	 * 将字节数组转换为对象
	 * 
	 * @param bytes
	 *            字节数组
	 * @return 对象
	 */
	public static Object toObject(byte[] bytes) {
		ByteArrayInputStream bais = null;
		try {
			// 反序列化
			bais = new ByteArrayInputStream(bytes);
			ObjectInputStream ois = new ObjectInputStream(bais);
			return ois.readObject();
		} catch (Exception e) {
			logger.error("字节数组反序列化为对象异常", e);
		}
		return null;

	}

	/**
	 * 通过反射的形式拷贝对象的属性值（将srcObj对象的属性值拷贝到destObj对象相应的属性上）
	 * 
	 * @param srcObj
	 *            源对象
	 * @param destObj
	 *            目标对象
	 */
	public static void copyProperties(Object srcObj, Object destObj) {
		try {
			Class<?> destClazz = destObj.getClass();
			Class<?> srcClazz = srcObj.getClass();

			Field[] fields = destClazz.getDeclaredFields();
			Method[] srcMethods = srcClazz.getDeclaredMethods();
			Method[] destMethods = destClazz.getDeclaredMethods();
			Object[] paramVarArgs = null;

			for (Field f : fields) {
				String fieldName = f.getName();
				String upperName = Character.toUpperCase(fieldName.charAt(0)) + fieldName.substring(1);
				String setterName = "set" + upperName;
				String getterName = "get" + upperName;

				Method srcMethod = null;
				Method destMethod = null;
				srcMethod = getMethodByName(srcMethods, getterName);
				destMethod = getMethodByName(destMethods, setterName);

				if (srcMethod != null && destMethod != null) {
					destMethod.invoke(destObj, srcMethod.invoke(srcObj, paramVarArgs));
				}
			}
		} catch (IllegalAccessException e) {
			logger.info("对象属性复制异常-非法访问:", e);
		} catch (IllegalArgumentException e) {
			logger.info("对象属性复制异常-参数非法:", e);
		} catch (InvocationTargetException e) {
			logger.info("对象属性复制异常-回调异常:", e);
		} catch (Exception e) {
			logger.info(ERROR_STRING, e);
		}

	}

	private static Method getMethodByName(Method[] methods, String methodName) {
		for (Method m : methods) {
			if (m.getName().equals(methodName)) {
				return m;
			}
		}
		return null;
	}

	/**
	 * 将srcObj对象的属性值拷贝到targetObj对象相应的属性上
	 * 
	 * @param srcObj
	 *            源对象
	 * @param targetObj
	 *            目标对象
	 */
	public static void fastCopy(Object srcObj, Object targetObj) {
		try {
			BeanMappingUtil.mapping(srcObj, targetObj);
		} catch (BeanMappingException e) {
			logger.info(ERROR_STRING, e);
		}
	}

	/**
	 * 
	 * @Description TODO(开发修改功能时，需比较前台传过来的Dto属性值相对于原数据库中Model属性值是否有修改，如果有修改才Set值进去修改，反之则不用Set值)
	 * @param modelAttributeValue
	 *            原数据库中Model属性值
	 * @param dtoAttributeValue
	 *            前台传过来的Dto属性值
	 * @return boolean 是否有修改
	 */
	public static boolean whetherModified(Object modelAttributeValue, Object dtoAttributeValue) {
		boolean flag = false;
		if (null == modelAttributeValue) {
			if (null != dtoAttributeValue) {
				flag = true;
			}
		} else {
			if (null == dtoAttributeValue) {
				flag = true;
			} else {
				Class<?> modelAttributeClass = modelAttributeValue.getClass();
				String modelAttributeClassName = modelAttributeClass.getName();
				Class<?> dtoAttributeClass = dtoAttributeValue.getClass();
				String dtoAttributeClassName = dtoAttributeClass.getName();
				if (!dtoAttributeClassName.equals(modelAttributeClassName)) {
					throw new IllegalArgumentException("数据库表所对应的Model对象的属性类型必须与Dto对象的属性类型相同才能比较");
				}
				if (modelAttributeValue instanceof String
						&& !((String) modelAttributeValue).equals((String) dtoAttributeValue)) {
					flag = true;
				} else if (modelAttributeValue instanceof Integer
						&& ((Integer) modelAttributeValue).intValue() != ((Integer) dtoAttributeValue).intValue()) {
					flag = true;
				} else if (modelAttributeValue instanceof Long
						&& ((Long) modelAttributeValue).longValue() != ((Long) dtoAttributeValue).longValue()) {
					flag = true;
				} else if (modelAttributeValue instanceof Double
						&& ((Double) modelAttributeValue).doubleValue() != ((Double) dtoAttributeValue).doubleValue()) {
					flag = true;
				} else if (modelAttributeValue instanceof Date
						&& !DateUtils.formatDateLong((Date) modelAttributeValue).equals(
								DateUtils.formatDateLong((Date) dtoAttributeValue))) {
					flag = true;
				}
			}
		}
		return flag;
	}

}
