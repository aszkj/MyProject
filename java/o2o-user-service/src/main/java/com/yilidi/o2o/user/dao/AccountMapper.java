package com.yilidi.o2o.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.user.model.Account;
import com.yilidi.o2o.user.model.combination.AccountRelatedInfo;
import com.yilidi.o2o.user.service.dto.query.CustomerBalanceQuery;

/**
 * 功能描述：账户信息数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface AccountMapper {

	/**
	 * 保存账户信息
	 * 
	 * @param record
	 *            账户记录对象
	 * @return 影响的行数
	 */
	Integer save(Account record);

	/**
	 * 根据Id更新账户信息
	 * 
	 * @param record
	 *            账户信息
	 * @return 影响的行数
	 */
	Integer updateByIdSelective(Account record);

	/**
	 * 根据ID调整账户余额（增加）
	 * 
	 * @param id
	 *            账户Id
	 * @param modifyUserId
	 *            操作用户Id
	 * @param delta
	 *            调整额大小
	 * @return 影响行数
	 */
	Integer updateBalanceIncreaseById(@Param("id") Integer id, @Param("modifyUserId") Integer modifyUserId,
			@Param("delta") Long delta);

	/**
	 * 根据ID调整账户余额（扣除）
	 * 
	 * @param id
	 *            账户Id
	 * @param modifyUserId
	 *            操作用户Id
	 * @param delta
	 *            调整额大小
	 * @return 影响行数
	 */
	Integer updateBalanceDecreaseById(@Param("id") Integer id, @Param("modifyUserId") Integer modifyUserId,
			@Param("delta") Long delta);

	/**
	 * 根据Id解冻账户金额（解冻所有的冻结金额，增加到余额中）
	 * 
	 * @param id
	 *            账户Id
	 * @param modifyUserId
	 *            操作用户Id
	 * @return 影响行数
	 */
	Integer updateUnFreezeAllById(@Param("id") Integer id, @Param("modifyUserId") Integer modifyUserId);

	/**
	 * 根据Id解冻账户金额（解冻部分的冻结金额，增加到余额中）
	 * 
	 * @param id
	 *            账户Id
	 * @param modifyUserId
	 *            操作用户Id
	 * @param delta
	 *            需要解冻的金额
	 * @return 影响行数
	 */
	Integer updateUnFreezePartById(@Param("id") Integer id, @Param("modifyUserId") Integer modifyUserId,
			@Param("delta") Long delta);

	/**
	 * 根据Id冻结账户金额
	 * 
	 * @param id
	 *            账户Id
	 * @param modifyUserId
	 *            操作用户Id
	 * @param delta
	 *            需要冻结的金额
	 * @return 影响的行数
	 */
	Integer updateFreezeById(@Param("id") Integer id, @Param("modifyUserId") Integer modifyUserId, @Param("delta") Long delta);

	/**
	 * 修改账户（赔付保证金）
	 * 
	 * @param id
	 *            账户Id
	 * @param modifyUserId
	 *            操作用户Id
	 * @param delta
	 *            需要赔付的金额
	 * @return 影响的行数
	 */
	Integer updateForConsumeDeposit(@Param("id") Integer id, @Param("modifyUserId") Integer modifyUserId,
			@Param("delta") Long delta);

	/**
	 * 根据ID查询账户信息
	 * 
	 * @param id
	 *            账户Id
	 * @return 账户对象
	 */
	Account loadById(Integer id);

	/**
	 * 根据客户Id查询账户信息
	 * 
	 * @param customerId
	 *            客户ID
	 * @return 账户信息列表
	 */
	List<Account> listByCustomerId(Integer customerId);

	/**
	 * 根据客户id和账户类型查询账户信息
	 * 
	 * @param customerId
	 *            客户id
	 * @param typeCode
	 *            账户类型编码
	 * @return 账户对象
	 */
	Account loadByCustomerIdAndAccountTypeCode(@Param("customerId") Integer customerId, @Param("typeCode") String typeCode);

	/**
	 * 分页查询客户（买家）账户余额信息列表
	 * 
	 * @param customerBalanceQuery
	 * @return Page<AccountRelatedInfo>
	 */
	Page<AccountRelatedInfo> findAccountsForCustomerBalance(CustomerBalanceQuery customerBalanceQuery);
	
	/**
	 * 分页查询门店客户账户余额统计（门店账户余额，商品补贴余额，优惠补贴余额，物流补贴金额）列表
	 * 
	 * @param customerBalanceQuery
	 * @return Page<AccountRelatedInfo>
	 */
	Page<AccountRelatedInfo> findCountSellerAccountsBalance(CustomerBalanceQuery customerBalanceQuery);

	/**
	 * 统计每个门店用户的所有补贴金额(优惠券补贴+产品差价补贴+物流补贴)
	 * @param customerId
	 * @return
	 */
	Long countSellerTotalSubsidyBalance(Integer customerId);
	
	/**
	 * 统计每个门店用户的所有可提现金额(现金账本+优惠券补贴+产品差价补贴)->都可以提现
	 * @param customerId
	 * @return
	 */
	Long countSellerTotalWithdrawBalance(Integer customerId);
	
	/**
	 * @Description TODO(分页获取导出门店账本管理记录报表数据)
	 * @param query
	 * @param startLineNum
	 * @param pageSize
	 * @return List<AccountRelatedInfo>
	 * 报表导出不适用缓存
	 */
	List<AccountRelatedInfo> listDataForExportSellerAccount(
			@Param("customerBalanceQuery") CustomerBalanceQuery customerBalanceQuery,
			@Param("startLineNum") Long startLineNum, @Param("pageSize") Integer pageSize);

	/**
	 * @Description TODO(获取报表数据的总记录数)
	 * @param query
	 * @return Long 报表导出不适用缓存
	 */
	Long getCountsForExportSellerAccount(CustomerBalanceQuery customerBalanceQuery);
	
	/**
	 * @Description TODO(分页获取导出买家用户账本管理记录报表数据)
	 * @param query
	 * @param startLineNum
	 * @param pageSize
	 * @return List<AccountRelatedInfo> 报表导出不适用缓存
	 */
	List<AccountRelatedInfo> listDataForExportUserAccount(
			@Param("customerBalanceQuery") CustomerBalanceQuery customerBalanceQuery,
			@Param("startLineNum") Long startLineNum, @Param("pageSize") Integer pageSize);

	/**
	 * @Description TODO(获取买家账本报表数据的总记录数)
	 * @param query
	 * @return Long 报表导出不适用缓存
	 */
	Long getCountsForExportUserAccount(CustomerBalanceQuery customerBalanceQuery);

}