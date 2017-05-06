package com.yilidi.o2o.user.dao;

import java.util.List;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.AccountTypeInfo;

/**
 * 功能描述：账户类型数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface AccountTypeInfoMapper {
	/**
	 * 保存账户类型信息
	 * 
	 * @param record
	 *            账户类型实体对象
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_ACCOUNT_TYPE_INFO })
	Integer save(AccountTypeInfo record);

	/**
	 * 根据账户信息Id更新
	 * 
	 * @param record
	 *            账户对象
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_ACCOUNT_TYPE_INFO })
	Integer updateByIdSelective(AccountTypeInfo record);

	/**
	 * 根据ID加载账户类型信息
	 * 
	 * <pre>
	 * 注：该方法 使用缓存
	 * </pre>
	 * 
	 * @param id
	 *            账户类型id
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_ACCOUNT_TYPE_INFO })
	AccountTypeInfo loadById(Integer id);

	/**
	 * 查询所有的账户信息
	 * 
	 * <pre>
	 * 注：该方法 使用缓存
	 * </pre>
	 * 
	 * @return 账户信息列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_ACCOUNT_TYPE_INFO })
	List<AccountTypeInfo> list();

}