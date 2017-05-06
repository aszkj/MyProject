package com.yilidi.o2o.core.transaction;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yilidi.o2o.core.service.BaseService;
import com.yilidi.o2o.core.transaction.model.RollbackMessageModel;

/**
 * 功能描述：回滚事务基类，被主域主事务拦截器和子域分事务拦截器继承，由于该两种拦截器在一次请求的过程中是在同一个JVM的同一个线程里运行的，因此可以用ThreadLocal来保存同一个线程里上下文的公用参数。<br/>
 * 
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class BaseCrossDomainTransaction extends BaseService {

	protected static final ThreadLocal<String> CROSSDOMAINMAINTRANSACTIONIDTHREADLOCAL = new ThreadLocal<String>();

	protected static final ThreadLocal<String> CROSSDOMAINMAINTRANSACTIONNAMETHREADLOCAL = new ThreadLocal<String>();

	protected static final ThreadLocal<Map<String, List<RollbackMessageModel>>> ROLLBACKMESSAGEMODELMAPTHREADLOCAL = new ThreadLocal<Map<String, List<RollbackMessageModel>>>();

	protected static String getCrossDomainMainTransactionId() {
		if (null == CROSSDOMAINMAINTRANSACTIONIDTHREADLOCAL.get()) {
			CROSSDOMAINMAINTRANSACTIONIDTHREADLOCAL.set(new String());
		}
		return CROSSDOMAINMAINTRANSACTIONIDTHREADLOCAL.get();
	}

	protected static void removeCrossDomainMainTransactionId() {
		CROSSDOMAINMAINTRANSACTIONIDTHREADLOCAL.remove();
	}

	protected static String getCrossDomainMainTransactionName() {
		if (null == CROSSDOMAINMAINTRANSACTIONNAMETHREADLOCAL.get()) {
			CROSSDOMAINMAINTRANSACTIONNAMETHREADLOCAL.set(new String());
		}
		return CROSSDOMAINMAINTRANSACTIONNAMETHREADLOCAL.get();
	}

	protected static void removeCrossDomainMainTransactionName() {
		CROSSDOMAINMAINTRANSACTIONNAMETHREADLOCAL.remove();
	}

	protected static Map<String, List<RollbackMessageModel>> getRollbackMessageModelMap() {
		if (null == ROLLBACKMESSAGEMODELMAPTHREADLOCAL.get()) {
			Map<String, List<RollbackMessageModel>> map = new HashMap<String, List<RollbackMessageModel>>();
			ROLLBACKMESSAGEMODELMAPTHREADLOCAL.set(map);
		}
		return ROLLBACKMESSAGEMODELMAPTHREADLOCAL.get();
	}

	protected static void removeRollbackMessageModelMap() {
		ROLLBACKMESSAGEMODELMAPTHREADLOCAL.remove();
	}

}
