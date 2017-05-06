package com.yilidi.o2o.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.log4j.Logger;

import com.yilidi.o2o.file.RemoteFileDeleteServer;
import com.yilidi.o2o.file.RemoteFileDuplicateServer;

/**
 * 
 * @Description:TODO(远程文件操作监听器，实现ServletContextListener，当Web容器启动时开启文件复制、文件删除等文件相关操作服务端线程。)
 * @author: chenlian
 * @date: 2015年11月20日 下午12:21:13
 * 
 */
public class RemoteFileOperateListener implements ServletContextListener {

	private Logger logger = Logger.getLogger(RemoteFileOperateListener.class.getName());

	/**
	 * 远程文件复制服务端监听端口
	 */
	private static final int REMOTEFILEDUPLICATESERVERPORT = 8888;

	/**
	 * 远程文件删除服务端监听端口
	 */
	private static final int REMOTEFILEDELETESERVERPORT = 8889;

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		try {
			// 单独利用一个线程来启动远程文件复制服务端，与Web容器启动的主线程隔离开。
			Thread duplicateThread = new Thread(new Runnable() {
				public void run() {
					try {
						new RemoteFileDuplicateServer(REMOTEFILEDUPLICATESERVERPORT).run();
					} catch (Exception e) {
						logger.error(e.getMessage());
						throw new IllegalStateException("远程文件复制服务端出现系统异常", e);
					}
				}
			});
			duplicateThread.start();
			// 单独利用一个线程来启动远程文件删除服务端，与Web容器启动的主线程隔离开。
			Thread deleteThread = new Thread(new Runnable() {
				public void run() {
					try {
						new RemoteFileDeleteServer(REMOTEFILEDELETESERVERPORT).run();
					} catch (Exception e) {
						logger.error(e.getMessage());
						throw new IllegalStateException("远程文件删除服务端出现系统异常", e);
					}
				}
			});
			deleteThread.start();
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new IllegalStateException("系统出现异常", e);
		}
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		// TODO Auto-generated method stub

	}

}
