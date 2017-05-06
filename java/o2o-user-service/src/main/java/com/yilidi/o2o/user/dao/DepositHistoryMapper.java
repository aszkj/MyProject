package com.yilidi.o2o.user.dao;

import com.yilidi.o2o.user.model.DepositHistory;
import com.yilidi.o2o.user.service.dto.query.DepositHistoryQuery;
import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;

/**
 * 功能描述：押金（保证金）历史记录数据层操作接口类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface DepositHistoryMapper {

	/**
	 * 保存保证金变化记录
	 * 
	 * @param record
	 *            保证金变化记录对象
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_DEPOSIT_HISTORY })
	Integer save(DepositHistory record);

	/**
	 * 保存保证金变化记录（缴纳保证金）
	 * 
	 * @param record
	 *            保证金变化记录对象
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_DEPOSIT_HISTORY })
	Integer saveForPayDeposit(DepositHistory record);

	/**
	 * 保存保证金变化记录（解冻保证金）
	 * 
	 * @param record
	 *            保证金变化记录对象
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_DEPOSIT_HISTORY })
	Integer saveForReleaseDeposit(DepositHistory record);

	/**
	 * 分页查询保证金变化历史
	 * 
	 * <pre>
	 * 注：该方法 使用缓存
	 * </pre>
	 * 
	 * @param depositHistoryQuery
	 * @return Page<DepositHistory>
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_DEPOSIT_HISTORY })
	Page<DepositHistory> findDepositHistories(DepositHistoryQuery depositHistoryQuery);

}