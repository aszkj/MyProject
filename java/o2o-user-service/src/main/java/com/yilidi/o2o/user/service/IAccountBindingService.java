package com.yilidi.o2o.user.service;

import java.util.List;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.user.service.dto.AccountBindingDto;
import com.yilidi.o2o.user.service.dto.query.AccountBindingQuery;

/**
 * 功能描述：AccountBinding服务层接口 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IAccountBindingService {

	/**
	 * 添加客户绑定账户信息
	 * 
	 * @param accountBindingDto
	 * @throws UserServiceException
	 */
	public void save(AccountBindingDto accountBindingDto) throws UserServiceException;

	/**
	 * 根据ID删除客户绑定账户信息
	 * 
	 * @param id
	 */
	public void deleteById(Integer id) throws UserServiceException;

	/**
	 * @Description  TODO(修改用户账号绑定) 
	 * @param accountBindingDto
	 * @throws UserServiceException
	 */
	public void updateAccountBinding(AccountBindingDto accountBindingDto) throws UserServiceException;
	
	/**
	 * 根据ID获取客户绑定账户信息
	 * 
	 * @param id
	 * @return AccountBindingDto
	 * @throws UserServiceException
	 */
	public AccountBindingDto loadById(Integer id) throws UserServiceException;

	/**
	 * 根据客户Id查询该客户下所有的绑定账户
	 * (目前：只用于门店提现使用，一个门店只能绑定一个银行卡账户)
	 * 
	 * @param customerId
	 * @return List<AccountBindingDto>
	 */
	public List<AccountBindingDto> listByCustomerId(Integer customerId) throws UserServiceException;
	
	/**
	 * 根据账户绑定ID，查询账户绑定银行与门店信息的组合信息
	 * 
	 * @Description  TODO(根据账户绑定ID，查询账户绑定银行与门店信息的组合信息) 
	 * @param id
	 * @return
	 */
	public AccountBindingDto loadAccountBindingDetailById(Integer id) throws UserServiceException;
	
	/**
	 * 分页查询客户账户绑定银行卡列表
	 * 
	 * @Description  TODO(分页查询客户账户绑定银行卡列表) 
	 * @param accountBindingQuery
	 * @return 分页数据
	 */
	public YiLiDiPage<AccountBindingDto> findAccountBindingBanks(AccountBindingQuery accountBingdingQuery) throws UserServiceException;
}
