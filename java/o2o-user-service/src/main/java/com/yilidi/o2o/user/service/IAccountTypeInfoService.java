package com.yilidi.o2o.user.service;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.user.service.dto.AccountTypeInfoDto;

/**
 * 功能描述：AccountTypeInfo服务层接口 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IAccountTypeInfoService {

	/**
	 * 添加账户类型信息
	 * 
	 * @param accountTypeInfoDto
	 * @throws UserServiceException
	 */
	public void saveAccountTypeInfo(AccountTypeInfoDto accountTypeInfoDto) throws UserServiceException;

	/**
	 * 修改账户类型信息
	 * 
	 * @param accountTypeInfoDto
	 * @throws UserServiceException
	 */
	public void updateAccountTypeInfo(AccountTypeInfoDto accountTypeInfoDto) throws UserServiceException;

	/**
	 * 根据ID获取账户类型信息
	 * 
	 * @param id
	 * @return AccountTypeInfoDto
	 * @throws UserServiceException
	 */
	public AccountTypeInfoDto loadAccountTypeInfoById(Integer id) throws UserServiceException;

}
