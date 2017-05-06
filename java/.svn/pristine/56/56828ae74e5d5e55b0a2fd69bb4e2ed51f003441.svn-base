package com.yilidi.o2o.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.OnlinePayDetail;
import com.yilidi.o2o.user.model.combination.OnlinePayDetailRelatedInfo;
import com.yilidi.o2o.user.service.dto.query.AccountDetailQuery;

/**
 * @Description:TODO(用户在线交易明细数据层操作接口类 )
 * @author: llp
 * @date: 2015年12月2日 下午4:44:54
 */
public interface OnlinePayDetailMapper {

	/**
	 * 插入一条在线交易明细记录
	 * @param record 在线交易明细对象
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_ONLINE_PLAY_LOG })
	Integer save(OnlinePayDetail record);

	/**
	 * 根据id查询在线交易明细信息
	 * <pre>
	 * 注：该方法 使用缓存
	 * </pre>
	 * @param id 明细Id
	 * @return 明细对象
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_ONLINE_PLAY_LOG })
	OnlinePayDetail loadById(Integer id);

	/**
	 * 根据用户输入的查询条件进行分页查询在线交易明细(在线支付和退款等操作)
	 * @param query
	 * @return Page<OnlinePayDetailRelatedInfo>
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_ONLINE_PLAY_LOG, DBTablesName.User.U_USER,
			DBTablesName.User.U_CUSTOMER, DBTablesName.User.U_STORE_PROFILE })
	Page<OnlinePayDetailRelatedInfo> findOnlinePayDetails(AccountDetailQuery query);

	/**
	 * @Description TODO(分页获取导用户在线支付交易明细日志报表数据)
	 * @param query
	 * @param startLineNum
	 * @param pageSize
	 * @return List<OnlinePayDetailRelatedInfo> 报表导出不适用缓存
	 */
	List<OnlinePayDetailRelatedInfo> listDataForExportOnlinePayDetails(
			@Param("accountDetailQuery") AccountDetailQuery accountDetailQuery, @Param("startLineNum") Long startLineNum,
			@Param("pageSize") Integer pageSize);

	/**
	 * @Description TODO(获取用户在线支付交易明细报表数据的总记录数)
	 * @param query
	 * @return Long 报表导出不适用缓存
	 */
	Long getCountsForExportOnlinePayDetails(AccountDetailQuery accountDetailQuery);
}