/**
 * 文件名称：ObjectUtilTest.java
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
import java.util.List;

import org.apache.log4j.Logger;
import org.junit.Test;

import com.yilidi.o2o.core.model.Address;
import com.yilidi.o2o.core.model.NewPerson;
import com.yilidi.o2o.core.model.Person;
import com.yilidi.o2o.core.model.PersonDto;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;

/**
 * 功能描述：
 * 
 * 作者：chenl
 * 
 * 
 */
public class ObjectUtilTest {

	private static Logger logger = Logger.getLogger(StringUtils.class);

	@Test
	public void testObjectAndBytes() {

		List<Address> list = new ArrayList<Address>();
		list.add(new Address(1, "大红123"));
		list.add(new Address(2, "提供234"));

		byte[] b = ObjectUtils.toByteArray(list);

		logger.info(new String(b));

		logger.info("=======================================");

		@SuppressWarnings("unchecked")
		List<Address> listAddr = (List<Address>) ObjectUtils.toObject(b);
		logger.info(listAddr.get(0).getId());
		logger.info(listAddr.get(1).getAddress());
	}

	@Test
	public void testCopyProperties() {
		int count = 1000000; // 100万次 1秒

		long startTime = System.currentTimeMillis();
		for (int i = 0; i < count; i++) {
			Person p = new Person(i, "wukong", "321456", "悟空", new Date(),
					"139856745895", "wukong@di.com", 287232423L, "1");
			PersonDto pDto = new PersonDto();
			ObjectUtils.fastCopy(p, pDto);
		}

		long endTime = System.currentTimeMillis();

		logger.info("Properties复制 耗时： " + (endTime - startTime) / 1000);
	}

	@Test
	public void testCopyProperties2() {
		Person p = new Person(5, "wukong", "321456", "悟空", new Date(),
				"139856745895", "wukong@di.com", 287232423L, "1");
		
		PersonDto pDto = new PersonDto();
		ObjectUtils.fastCopy(p, pDto);

		logger.info("age: " + pDto.getAge());
		logger.info("userName: " + pDto.getUsername());

		NewPerson np = new NewPerson();
		np.setAge(33);
		
		ObjectUtils.fastCopy(np, pDto);

		logger.info("age: " + pDto.getAge());
		logger.info("userName: " + pDto.getUsername());

	}
}
