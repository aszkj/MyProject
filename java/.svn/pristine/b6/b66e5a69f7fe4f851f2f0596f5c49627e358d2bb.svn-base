/**
 * 文件名称：CrossDomainTransactionSubInterceptor.java
 * 
 * 描述：
 * 
 * 修改
 * BugId: <修改单号>
 * 修改内容：
 */
package com.yilidi.o2o.interceptor;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.yilidi.o2o.core.model.JmsMessageModel;
import com.yilidi.o2o.core.transaction.BaseCrossDomainTransaction;
import com.yilidi.o2o.core.transaction.annotation.RollbackTransactionAnnotation;
import com.yilidi.o2o.core.transaction.model.RollbackMessageModel;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;

/**
 * 功能描述：跨域事务子域分事务拦截器 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public class CrossDomainTransactionSubInterceptor extends BaseCrossDomainTransaction implements MethodInterceptor {

	private Logger logger = Logger.getLogger(this.getClass());

	@Override
	public Object invoke(MethodInvocation methodInvocation) throws Throwable {
		logger.info("++++++++++++++++++++++++++++++++CrossDomainTransactionSubInterceptor is in+++++++++++++++++++++++++++++++++++++++++");
		Object result = null;
		try {
			Method method = methodInvocation.getMethod();
			if (method.isAnnotationPresent(RollbackTransactionAnnotation.class)) {
				RollbackTransactionAnnotation rollbackTransactionAnnotation = method
						.getAnnotation(RollbackTransactionAnnotation.class);
				String rollbackMessageProducerBeanName = rollbackTransactionAnnotation.rollbackMessageProducerBeanName();
				logger.info("===============================>rollbackMessageProducerBeanName : "
						+ rollbackMessageProducerBeanName);
				result = methodInvocation.proceed();
				logger.info("===============================>result : " + JsonUtils.toJsonStringWithDateFormat(result));
				if (result instanceof JmsMessageModel) {
					String crossDomainMainTransactionId = getCrossDomainMainTransactionId();
					logger.info("===============================>crossDomainMainTransactionId : "
							+ crossDomainMainTransactionId);
					if (StringUtils.isEmpty(crossDomainMainTransactionId)) {
						throw new IllegalStateException("无法获取跨域事务的主域主事务ID！");
					}
					Map<String, List<RollbackMessageModel>> rollbackMessageModelListMap = getRollbackMessageModelMap();
					RollbackMessageModel rollbackMessageModel = new RollbackMessageModel();
					rollbackMessageModel.setProducerBeanName(rollbackMessageProducerBeanName);
					JmsMessageModel jmsMessageModel = (JmsMessageModel) result;
					jmsMessageModel.setCrossDomainTransactionId(getCrossDomainMainTransactionId());
					jmsMessageModel.setCrossDomainTransactionName(getCrossDomainMainTransactionName());
					rollbackMessageModel.setJmsMessageModel(jmsMessageModel);
					Map<String, List<RollbackMessageModel>> map = null;
					List<RollbackMessageModel> list = null;
					if (ObjectUtils.isNullOrEmpty(rollbackMessageModelListMap)) {
						map = new HashMap<String, List<RollbackMessageModel>>();
						list = new ArrayList<RollbackMessageModel>();
					} else {
						map = rollbackMessageModelListMap;
						list = rollbackMessageModelListMap.get(crossDomainMainTransactionId);
					}
					list.add(rollbackMessageModel);
					map.put(crossDomainMainTransactionId, list);
					ROLLBACKMESSAGEMODELMAPTHREADLOCAL.set(map);
				} else {
					throw new IllegalArgumentException("跨域事务中，子域分事务正向接口的返回值必须为JmsMessageModel类型！");
				}
			} else {
				throw new IllegalStateException("跨域事务中，子域分事务正向接口必须配置RollbackTransactionAnnotation注解！");
			}
			return result;
		} catch (Exception e) {
			logger.error(e);
			throw new RuntimeException("系统出现异常：" + e.getMessage(), e);
		}
	}
}
