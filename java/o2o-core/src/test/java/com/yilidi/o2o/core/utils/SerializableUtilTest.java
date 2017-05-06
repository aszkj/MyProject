/**
 * 文件名称：SerializableUtilTest.java
 * 
 * 描述：
 * 
 *
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.core.utils;

import org.apache.log4j.Logger;
import org.junit.Test;

import com.yilidi.o2o.core.model.Address;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.SerializableUtils;

/**
 * 功能描述：
 * 
 * 作者：chenl
 * 
 * 
 */
public class SerializableUtilTest {

	Logger logger = Logger.getLogger(this.getClass());

	@Test
	public void testSerializable() {

		long startTime = System.currentTimeMillis();

		int count = 10000;

		logger.info("java io serializable and deSerializable");
		for (int i = 0; i < count; i++) {
			Address add = new Address(1, "大红123" + i);
			byte[] bs = ObjectUtils.toByteArray(add);

			Object obj = ObjectUtils.toObject(bs);
		}

		long endTime = System.currentTimeMillis();
		logger.info("========= 耗时: " + (endTime - startTime) / 1000 + " 秒=================");

		logger.info("Kryo serializable and deSerializable");

		startTime = System.currentTimeMillis();

		for (int i = 0; i < count; i++) {
			Address add = new Address(1, "大红123" + i);
			byte[] bs = SerializableUtils.write(add);

			Object obj = SerializableUtils.read(bs);
		}

		logger.info("============ 耗时: " + (endTime - startTime) / 1000 + " 秒====================");

	}

}
