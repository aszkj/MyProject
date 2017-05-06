package com.yilidi.o2o.common.session;

import com.yilidi.o2o.common.session.model.ReqAndRespAndSessionModel;

/**
 * ThreadLocal封装的ReqAndRespAndSessionModel，用于在一次上下文请求中，从拦截器到Controller的参数传递，线程隔离。
 * 
 * @author chenl
 * 
 */
public class BaseSession {

	protected static final ThreadLocal<ReqAndRespAndSessionModel> REQANDRESPANDSESSIONMODELTHREADLOCAL = new ThreadLocal<ReqAndRespAndSessionModel>();

	protected static ReqAndRespAndSessionModel getReqAndRespAndSessionModel() {
		if (null == REQANDRESPANDSESSIONMODELTHREADLOCAL.get()) {
			ReqAndRespAndSessionModel model = new ReqAndRespAndSessionModel();
			REQANDRESPANDSESSIONMODELTHREADLOCAL.set(model);
		}
		return REQANDRESPANDSESSIONMODELTHREADLOCAL.get();
	}

	protected static void removeReqAndRespAndSessionModel() {
		REQANDRESPANDSESSIONMODELTHREADLOCAL.remove();
	}

}
