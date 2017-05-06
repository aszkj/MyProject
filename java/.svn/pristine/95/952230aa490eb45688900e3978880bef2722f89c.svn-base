package com.yilidi.o2o.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.AccountDetail;
import com.yilidi.o2o.user.model.combination.AccountDetailCountInfo;
import com.yilidi.o2o.user.model.combination.AccountDetailRelatedInfo;
import com.yilidi.o2o.user.service.dto.query.AccountDetailQuery;
import com.yilidi.o2o.user.service.dto.query.CustomerBalanceQuery;

/**
 * 功能描述：账户明细数据层操作接口类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface AccountDetailMapper {

	/**
	 * 插入一条记录
	 * 
	 * @param record
	 *            账户明细对象
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_ACCOUNT_DETAIL })
	Integer save(AccountDetail record);

	/**
	 * 根据id查询明细信息
	 * 
	 * <pre>
	 * 注：该方法 使用缓存
	 * </pre>
	 * 
	 * @param id
	 *            明细Id
	 * @return 明细对象
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_ACCOUNT_DETAIL })
	AccountDetail loadById(Integer id);

	/**
	 * 根据用户输入的查询条件进行分页查询账户交易明细(分账本支付和退款等操作)
	 * @param query
	 * @return Page<AccountDetailRelatedInfo>
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_ACCOUNT_DETAIL, DBTablesName.User.U_USER,
			DBTablesName.User.U_CUSTOMER, DBTablesName.User.U_STORE_PROFILE })
	Page<AccountDetailRelatedInfo> findAccountDetails(AccountDetailQuery query);
	
	/**
	 * @Description TODO(分页获取导用户账本交易(账本支付和账本退款)明细日志报表数据)
	 * @param query
	 * @param startLineNum
	 * @param pageSize
	 * @return List<AccountDetailRelatedInfo>
	 * 报表导出不适用缓存
	 */
	List<AccountDetailRelatedInfo> listDataForExportAccountDetails(
			@Param("accountDetailQuery") AccountDetailQuery accountDetailQuery,
			@Param("startLineNum") Long startLineNum,
			@Param("pageSize") Integer pageSize);
	
	/**
	 * @Description TODO(获取用户账本交易明细报表数据的总记录数)
	 * @param query
	 * @return Long 报表导出不适用缓存
	 */
	Long getCountsForExportAccountDetails(AccountDetailQuery accountDetailQuery);
	
	/**
	 * @Description TODO(统计每个用户/门店账本(资金变化状态：订单支付和订单退款等状态)总金额，(买家:欧币数量，门店：现金+商品补贴+优惠补贴+物流补贴))
	 * @param query
	 * @return Long 报表导出不适用缓存
	 */
	Long countsAccountDetailsAmount(AccountDetailQuery accountDetailQuery);
	
	/**
	 * 根据条件分页查询 卖家(门店)账本收入和支出统计金额管理
	 * 账本收入：订单补贴，订单退款
	 * 账本支出：订单支付，账本提现
	 * @param customerBalanceQuery
	 * @return Page <AccountDetailCountInfo>
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_SUBSIDY_RECORD,
			DBTablesName.User.U_CUSTOMER, DBTablesName.User.U_STORE_PROFILE })
	Page<AccountDetailCountInfo> findCountSellerAccountsDetail(CustomerBalanceQuery customerBalanceQuery);
	
	/**
	 * @Description TODO(分页获取导门店账本交易(账本收入和账本支出)明细日志报表数据)
	 * @param query
	 * @param startLineNum
	 * @param pageSize
	 * @return List<AccountDetailCountInfo> 报表导出不适用缓存
	 */
	List<AccountDetailCountInfo> listDataForExportCountAccountDetails(
			@Param("customerBalanceQuery") CustomerBalanceQuery customerBalanceQuery,
			@Param("startLineNum") Long startLineNum, @Param("pageSize") Integer pageSize);
	
	/**
	 * @Description TODO(获取门店账本交易(账本收入和账本支出)明细日志报表数据的总记录数)
	 * @param query
	 * @return Long 报表导出不适用缓存
	 */
	Long getCountsForExportCountAccountDetails(CustomerBalanceQuery customerBalanceQuery);

}