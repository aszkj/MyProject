package com.yilidi.o2o.controller.common;

import com.yilidi.o2o.common.session.holder.YiLiDiSessionHolder;
import com.yilidi.o2o.common.session.model.YiLiDiSession;

/**
 * 
 * @Description:TODO(运营中心Controller的基类)
 * @author: chenlian
 * @date: 2015年10月27日 下午6:31:03
 * 
 */
public class OperationBaseController extends BaseController {

	/**
	 * 
	 * @Description TODO(获取用户ID)
	 * @return Integer
	 */
	protected Integer getUserId() {
		YiLiDiSession session = YiLiDiSessionHolder.getSession();
		return null == session.getAttribute("userId_operation") ? null : (Integer) session.getAttribute("userId_operation");
	}

	/**
	 * 
	 * @Description TODO(获取用户名)
	 * @return String
	 */
	protected String getUserName() {
		YiLiDiSession session = YiLiDiSessionHolder.getSession();
		return null == session.getAttribute("userName_operation") ? null : (String) session
				.getAttribute("userName_operation");
	}

	/**
	 * 
	 * @Description TODO(获取主用户ID)
	 * @return Integer
	 */
	protected Integer getMasterUserId() {
		YiLiDiSession session = YiLiDiSessionHolder.getSession();
		return null == session.getAttribute("masterUserId_operation") ? (Integer) session
				.getAttribute("masterUserId_operation") : null;
	}

}
