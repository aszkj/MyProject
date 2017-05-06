package com.yilidi.o2o.user.service.crossdomain;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.transaction.annotation.MainTransactionAnnotation;
import com.yilidi.o2o.user.service.dto.UserDto;

/**
 * 功能描述：user跨域事务服务层接口 (供测试跨域事务功能使用，功能OK后应删除)<br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IUserCrossDomainMainService {

	/**
	 * 审核子账号
	 * 
	 * @param user
	 *            用户对象
	 * @throws UserServiceException
	 *             服务端异常
	 */
	@MainTransactionAnnotation(crossDomainTransactionName = "审核子账号")
	public void updateSubUserForAudit(UserDto user) throws UserServiceException;


}
