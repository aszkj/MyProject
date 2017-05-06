package com.yilidi.o2o.user.dao;

import java.util.List;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.AccountBinding;
import com.yilidi.o2o.user.model.combination.AccountBindingRelatedInfo;
import com.yilidi.o2o.user.service.dto.query.AccountBindingQuery;

/**
 * 功能描述：账户绑定数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface AccountBindingMapper {
	/**
	 * 保存账户绑定的信息（比如绑定银行卡，支付宝账户等）
	 * 
	 * @param record
	 *            绑定的账户对象
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_ACCOUNT_BINDING })
	Integer save(AccountBinding record);

	/**
	 * 根据ID删除绑定的账户记录
	 * 
	 * @param id
	 *            绑定的账户ID
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_ACCOUNT_BINDING })
	Integer deleteById(Integer id);

	/**
	 * @Description  TODO(更新用户账户绑定记录) 
	 * @param accountBinding
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_ACCOUNT_BINDING })
	Integer updateAccountBinding(AccountBinding accountBinding);
	
	/**
	 * 根据Id查询绑定的账户信息
	 * 
	 * <pre>
	 * 注：该方法 使用缓存
	 * </pre>
	 * 
	 * @param id
	 *            绑定的账户Id
	 * @return 绑定的账户对象
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_ACCOUNT_BINDING })
	AccountBinding loadById(Integer id);
	
	/**
	 * 根据账户绑定ID，查询账户绑定银行与门店信息的组合详细信息
	 * 
	 * @Description  TODO(根据账户绑定ID，查询账户绑定银行与门店信息的组合信息) 
	 * @param id
	 * @return AccountBindingRelatedInfo
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_ACCOUNT_BINDING,
			DBTablesName.User.U_CUSTOMER, DBTablesName.User.U_STORE_PROFILE })
	AccountBindingRelatedInfo loadAccountBindingDetailById(Integer id);
	
	/**
	 * 根据客户Id查询该客户下所有的绑定账户
	 * (目前：只用于门店提现使用，一个门店只能绑定一个银行卡账户)
	 * 
	 * <pre>
	 * 注：该方法 使用缓存
	 * </pre>
	 * 
	 * @param customerId
	 *            客户ID
	 * @return 绑定的账户列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_ACCOUNT_BINDING })
	List<AccountBinding> listByCustomerId(Integer customerId);
	
	/**
	 * 分页查询客户账户绑定银行卡列表
	 * 
	 * @Description  TODO(分页查询客户账户绑定银行卡列表) 
	 * @param accountBingdingQuery
	 * @return Page<AccountBindingRelatedInfo>
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_ACCOUNT_BINDING,
			DBTablesName.User.U_CUSTOMER, DBTablesName.User.U_STORE_PROFILE })
	Page<AccountBindingRelatedInfo> findAccountBindingBanks(AccountBindingQuery accountBingdingQuery);
}