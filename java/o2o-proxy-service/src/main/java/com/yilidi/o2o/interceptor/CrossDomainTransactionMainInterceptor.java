/**
 * 文件名称：CrossDomainTransactionMainInterceptor.java
 * 
 * 描述：
 * 
 * 修改
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.interceptor;

import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import com.yilidi.o2o.core.transaction.BaseCrossDomainTransaction;
import com.yilidi.o2o.core.transaction.annotation.MainTransactionAnnotation;
import com.yilidi.o2o.core.transaction.model.RollbackMessageModel;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.system.proxy.IMessageProxyService;

/**
 * 功能描述：跨域事务主域主事务拦截器 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class CrossDomainTransactionMainInterceptor extends BaseCrossDomainTransaction implements MethodInterceptor {

	private Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private IMessageProxyService messageProxyService;

	@Override
	public Object invoke(MethodInvocation methodInvocation) throws Throwable {
		logger.info("++++++++++++++++++++++++++++++++CrossDomainTransactionMainInterceptor is in+++++++++++++++++++++++++++++++++++++++++");
		Object result = null;
		Method method = methodInvocation.getMethod();
		if (method.isAnnotationPresent(MainTransactionAnnotation.class)) {
			MainTransactionAnnotation mainTransactionAnnotation = method.getAnnotation(MainTransactionAnnotation.class);
			String crossDomainTransactionName = mainTransactionAnnotation.crossDomainTransactionName();
			logger.info("===============================>crossDomainTransactionName : " + crossDomainTransactionName);
			CROSSDOMAINMAINTRANSACTIONNAMETHREADLOCAL.set(crossDomainTransactionName);
		}
		String crossDomainMainTransactionId = StringUtils.getUUID(true);
		logger.info("===============================>crossDomainMainTransactionId : " + crossDomainMainTransactionId);
		CROSSDOMAINMAINTRANSACTIONIDTHREADLOCAL.set(crossDomainMainTransactionId);
		try {
			result = methodInvocation.proceed();
			return result;
		} catch (Exception e) {
			logger.error(e);
			Map<String, List<RollbackMessageModel>> rollbackMessageModelListMap = getRollbackMessageModelMap();
			if (!ObjectUtils.isNullOrEmpty(rollbackMessageModelListMap)) {
				messageProxyService.sendRollbackTransactionMessage(rollbackMessageModelListMap);
			}
			throw new IllegalStateException("系统出现异常：" + e.getMessage(), e);
		} finally {
			removeCrossDomainMainTransactionId();
			removeCrossDomainMainTransactionName();
			removeRollbackMessageModelMap();
		}
	}

}
