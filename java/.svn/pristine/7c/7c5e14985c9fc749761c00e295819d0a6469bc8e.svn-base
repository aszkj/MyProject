package com.yilidi.o2o.core.sequence;

import java.util.concurrent.CountDownLatch;

import org.apache.log4j.Logger;

/**
 * 测试全局ID生成器（模拟多线程访问Service层，看是否有线程安全问题）
 * 
 * @author chenl
 * 
 */
public class TestIDGenerator implements Runnable {

	private static final Logger LOGGER = Logger.getLogger(IDGenerator.class);

	private static final int THREADCOUNT = 1000;

	private static final CountDownLatch COUNTDOWNLANTCH = new CountDownLatch(THREADCOUNT);

	private IDGenerator generator = new IDGenerator();

	@Override
	public void run() {
		generator.generate("SALE_ORDER_ID_SEQUENCE");
		COUNTDOWNLANTCH.countDown();
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		Long time1 = System.currentTimeMillis();
		// 将该行从for循环中提出来是为了模拟单例的情况，正好符合高并发时对Service的访问。
		TestIDGenerator testIDGenerator = new TestIDGenerator();
		for (int i = 0; i < THREADCOUNT; i++) {
			Thread thread = new Thread(testIDGenerator);
			thread.start();
		}
		try {
			COUNTDOWNLANTCH.await();
			Long time2 = System.currentTimeMillis();
			// 生成1000个ID，本机测试结果：INNODB +++> 14 -- 16秒之间
			// 生成1000个ID，本机测试结果：MyISAM +++> 10 -- 12秒之间
			LOGGER.info("================================> time2 - time1 : " + (time2 - time1));
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

}
