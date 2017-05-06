package com.yilidi.o2o.user.service;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.user.service.dto.AccountDetailCountDto;
import com.yilidi.o2o.user.service.dto.AccountDetailDto;
import com.yilidi.o2o.user.service.dto.AccountDto;
import com.yilidi.o2o.user.service.dto.OnlinePayDetailDto;
import com.yilidi.o2o.user.service.dto.query.AccountDetailQuery;
import com.yilidi.o2o.user.service.dto.query.CustomerBalanceQuery;

/**
 * 功能描述：Account服务层接口 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IAccountService {

	/**
	 * 添加账户
	 * 
	 * @param accountDto
	 * @throws UserServiceException
	 */
	public void save(AccountDto accountDto) throws UserServiceException;

	/**
	 * 根据ID获取账户
	 * 
	 * @param id
	 * @return AccountDto
	 * @throws UserServiceException
	 */
	public AccountDto loadById(Integer id) throws UserServiceException;

	/**
	 * 根据客户ID和账户类型获取账户
	 * 
	 * @param id
	 * @return AccountDto
	 * @throws UserServiceException
	 */
	public AccountDto loadByCustomerIdAndAccountTypeCode(Integer customerId, String accountTypeCode)
			throws UserServiceException;

	/**
	 * 根据客户ID获取该客户的所有账户信息
	 * 
	 * @param id
	 * @return List<AccountDto>
	 * @throws UserServiceException
	 */
	public List<AccountDto> listByCustomerId(Integer customerId) throws UserServiceException;

	/**
	 * 分页查询客户（买家）账户余额（只有一种现金账本：欧币）列表
	 * 
	 * @param customerBalanceQuery
	 * @return Page<AccountDto>
	 * @throws UserServiceException
	 */
	public YiLiDiPage<AccountDto> findAccountsForCustomerBalance(CustomerBalanceQuery customerBalanceQuery)
			throws UserServiceException;

	/**
	 * 修改账户（充值）
	 * 
	 * @param userId
	 * @param rechargeAmount
	 * @throws UserServiceException
	 */
	public void updateForRecharge(Integer userId, Long rechargeAmount) throws UserServiceException;

	/**
	 * 修改账户（提款）
	 * 
	 * @param userId
	 * @param withdrawAmount
	 * @return Integer 影响的行数
	 * @throws UserServiceException
	 */
	public Integer updateForWithdraw(Integer userId, Long withdrawAmount) throws UserServiceException;

	/**
	 * 修改账户（付款）
	 * 
	 * @param userId
	 * @param payOrderAmount
	 * @param orderNo
	 * @return Integer 影响的行数
	 * @throws UserServiceException
	 */
	public Integer updateForPayOrder(Integer userId, Long payOrderAmount, String orderNo) throws UserServiceException;

	/**
	 * 修改账户（退款）
	 * 
	 * @param userId
	 * @param refundAmount
	 * @param orderNo
	 * @throws UserServiceException
	 */
	public void updateForRefund(Integer userId, Long refundAmount, String orderNo) throws UserServiceException;

	/**
	 * 修改账户（调整账户余额--增加）
	 * 
	 * @param userId
	 * @param adjustAmount
	 * @throws UserServiceException
	 */
	public void updateForAdjustBalancePlus(Integer userId, Long adjustAmount) throws UserServiceException;

	/**
	 * 修改账户（调整账户余额--扣除）
	 * 
	 * @param userId
	 * @param adjustAmount
	 * @return Integer 影响的行数
	 * @throws UserServiceException
	 */
	public Integer updateForAdjustBalanceMinus(Integer userId, Long adjustAmount) throws UserServiceException;

	/**
	 * 修改账户（赔付保证金）
	 * 
	 * @param userId
	 * @param amount
	 * @return Integer 影响的行数
	 * @throws UserServiceException
	 */
	public Integer updateForConsumeDeposit(Integer userId, Long amount) throws UserServiceException;

	/**
	 * 修改账户（冻结资金）
	 * 
	 * @param userId
	 * @param amount
	 * @return Integer 影响的行数
	 * @throws UserServiceException
	 */
	public Integer updateForFreeze(Integer userId, Long amount) throws UserServiceException;

	/**
	 * 修改账户（解冻部分冻结资金）
	 * 
	 * @param userId
	 * @param amount
	 * @return Integer 影响的行数
	 * @throws UserServiceException
	 */
	public Integer updateForUnfreezePartFrozenFund(Integer userId, Long amount) throws UserServiceException;

	/**
	 * 修改账户（解冻全部冻结资金）
	 * 
	 * @param userId
	 * @throws UserServiceException
	 */
	public void updateForUnfreezeAllFrozenFund(Integer userId) throws UserServiceException;

	/**
	 * 根据用户输入的查询条件进行分页查询账户交易明细(账本支付和账本退款等操作)
	 * 
	 * @param accountDetailQuery
	 * @return Page<AccountDetailDto> YiLiDiPage
	 * @throws UserServiceException
	 */
	public YiLiDiPage<AccountDetailDto> findAccountDetails(AccountDetailQuery accountDetailQuery) throws UserServiceException;

	/**
	 * 查找买家/门店用户的在线交易明细
	 * 
	 * @param accountDetailQuery
	 * @return Page
	 * @throws UserServiceException
	 */
	public YiLiDiPage<OnlinePayDetailDto> findOnlinePayDetails(AccountDetailQuery accountDetailQuery) throws UserServiceException;
	
	/**
	 * 根据交易流水ID查询交易信息
	 * 
	 * @param id
	 * @return AccountDetailDto
	 * @throws UserServiceException
	 */
	public AccountDetailDto loadAccountDetailByDetailId(Integer id) throws UserServiceException;

	/**
	 * 根据条件分页查询 卖家(门店)账户余额管理（账户余额，现金账本，商品补贴账本，优惠券账本，物流补贴账本余额）
	 * 
	 * @param customerBalanceQuery
	 * @return Page<AccountDto>
	 * @throws UserServiceException
	 */
	public YiLiDiPage<AccountDto> findCountSellerAccountsBalance(CustomerBalanceQuery customerBalanceQuery)
			throws UserServiceException;
	
	/**
	 * 统计每个门店用户的所有补贴金额(优惠券补贴+产品差价补贴+物流补贴)
	 * @param customerId
	 * @return
	 */
	public Long countSellerTotalSubsidyBalance(Integer customerId) throws UserServiceException;
	
	/**
	 * 统计每个门店用户的所有可提现金额(现金账本+优惠券补贴+产品差价补贴)->都可以提现
	 * 
	 * @param customerId
	 * @return Long
	 */
	public Long countSellerTotalWithdrawBalance(Integer customerId) throws UserServiceException;
	
	/**
	 * 分页获取导出门店账本管理记录报表数据
	 * 
	 * @param query
	 * @param startLineNum
	 * @param pageSize
	 * @return List<AccountDto>
	 * @throws UserServiceException
	 */
	public List<AccountDto> listDataForExportSellerAccount(CustomerBalanceQuery query, Long startLineNum, Integer pageSize)
			throws UserServiceException;

	/**
	 * 获取门店账本管理报表数据的总记录数
	 * 
	 * @param query
	 * @return Long
	 * @throws UserServiceException
	 */
	public Long getCountsForExportSellerAccount(CustomerBalanceQuery query) throws UserServiceException;
	
	/**
	 * 分页获取导出买家用户账本管理记录报表数据
	 * 
	 * @param query
	 * @param startLineNum
	 * @param pageSize
	 * @return List<AccountDto>
	 * @throws UserServiceException
	 */
	public List<AccountDto> listDataForExportUserAccount(CustomerBalanceQuery query, Long startLineNum, Integer pageSize)
			throws UserServiceException;

	/**
	 * 获取买家用户账本管理报表数据的总记录数
	 * 
	 * @param query
	 * @return Long
	 * @throws UserServiceException
	 */
	public Long getCountsForExportUserAccount(CustomerBalanceQuery query) throws UserServiceException;

	/**
	 * 分页获取导出用户/门店在线支付交易明细报表数据
	 * 
	 * @param query
	 * @param startLineNum
	 * @param pageSize
	 * @return List<OnlinePayDetailDto>
	 * @throws UserServiceException
	 */
	public List<OnlinePayDetailDto> listDataForExportOnlinePayDetails(AccountDetailQuery accountDetailQuery,
			Long startLineNum, Integer pageSize) throws UserServiceException;

	/**
	 * 获取用户/门店在线支付交易明细报表数据的总记录数
	 * 
	 * @param query
	 * @return Long
	 */
	public Long getCountsForExportOnlinePayDetails(AccountDetailQuery accountDetailQuery) throws UserServiceException;

	/**
	 * 分页获取用户/门店账本交易明细记录导出报表数据
	 * 
	 * @param query
	 * @param startLineNum
	 * @param pageSize
	 * @return List<AccountDetailDto>
	 */
	public List<AccountDetailDto> listDataForExportAccountDetails(AccountDetailQuery accountDetailQuery, Long startLineNum,
			Integer pageSize) throws UserServiceException;

	/**
	 * 获取用户/门店账本交易明细记录导出报表数据的总记录数
	 * 
	 * @param query
	 * @return Long
	 */
	public Long getCountsForExportAccountDetails(AccountDetailQuery accountDetailQuery) throws UserServiceException;
	
	/**
	 * 统计每个用户/门店已使用的账本总金额(买家:欧币数量，门店：现金+商品补贴+优惠补贴+物流补贴) = 该用户的所有的订单支付金额-用户存在的订单退款金额
	 * 
	 * @param query
	 * @return Long
	 */
	public Long countsAccountDetailsAmount(AccountDetailQuery accountDetailQuery) throws UserServiceException;
	
	/**
	 * 根据条件分页查询 卖家(门店)账本收入和支出统计金额管理
	 * 账本收入：订单补贴，订单退款
	 * 账本支出：订单支付，账本提现
	 * 
	 * @param customerBalanceQuery
	 * @return YiLiDiPage <AccountDetailCountDto>
	 * @throws UserServiceException
	 */
	public YiLiDiPage<AccountDetailCountDto> findCountSellerAccountsDetail(CustomerBalanceQuery customerBalanceQuery) throws UserServiceException;
	
	/**
	 * 分页获取导门店账本交易(账本收入和账本支出)明细日志报表数据
	 * 
	 * @param query
	 * @param startLineNum
	 * @param pageSize
	 * @return List<AccountDetailCountDto> 
	 */
	public List<AccountDetailCountDto> listDataForExportCountAccountDetails(CustomerBalanceQuery customerBalanceQuery,
			Long startLineNum, Integer pageSize) throws UserServiceException;
	
	/**
	 * 获取门店账本交易(账本收入和账本支出)明细日志报表数据的总记录数
	 * 
	 * @param query
	 * @return Long
	 */
	public Long getCountsForExportCountAccountDetails(CustomerBalanceQuery customerBalanceQuery) throws UserServiceException;
	
	/**
	 * 注册成功后发放（注册有礼）奖励消息
	 * 
	 * @param query
	 * @return Long
	 */
	public void sendUserRegistAwardMessage(Integer userId, Date nowTime);

}
