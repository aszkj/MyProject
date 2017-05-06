package com.yilidi.o2o.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.StoreEvaluation;
import com.yilidi.o2o.user.model.StoreEvaluationScore;
import com.yilidi.o2o.user.model.combination.StoreEvaluationInfo;
import com.yilidi.o2o.user.service.dto.query.StoreEvaluateQuery;

/**
 * @Description:TODO(门店评价数据层操作接口类)
 * @author: llp
 * @date: 2015年12月7日 上午9:45:09
 */
public interface StoreEvaluationMapper {

	/**
	 * 保存门店评价
	 * 
	 * @param record 评价记录
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_STORE_EVALUATION })
	Integer save(StoreEvaluation record);

	/**
	 * 根据ID删门店评论
	 * 
	 * @param id 绑定的评论ID
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_STORE_EVALUATION })
	Integer deleteById(Integer id);
	
	/**
	 * 根据ID, 修改评论是否显示状态
	 * 
	 * @param id 绑定的评论ID
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_STORE_EVALUATION })
	Integer updateShowStatusById(StoreEvaluation record);
	
	/**
	 * 根据Id查询门店评论信息
	 * 
	 * <pre>
	 * 注：该方法 使用缓存
	 * </pre>
	 * 
	 * @param id 绑定的评论Id
	 * @return 绑定的门店评论对象
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_EVALUATION })
	StoreEvaluation loadById(Integer id);
	
	/**
	 * @Description  TODO(通过评论主键id，查询评论的详细信息) 
	 * @param id
	 * @return StoreEvaluationInfo
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_EVALUATION,
			DBTablesName.User.U_CUSTOMER, DBTablesName.User.U_USER, DBTablesName.User.U_STORE_PROFILE })
	StoreEvaluationInfo loadDetailById(Integer id);
	
	/**
	 * 根据门店id查询该门店的所有评论（前端用，暂未考虑分页查询）
	 * 
	 * @param storeId 门店id
	 * @return 门店评价列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_EVALUATION,
			DBTablesName.User.U_CUSTOMER, DBTablesName.User.U_USER, DBTablesName.User.U_STORE_PROFILE })
	List<StoreEvaluationInfo> listByStoreId(Integer storeId);
	
	/**
	 * 根据查询条件分页查询所有门店的评论明细记录
	 * 
	 * @param query 查询条件对象
	 * @return Page<StoreEvaluation>
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_EVALUATION,
			DBTablesName.User.U_CUSTOMER, DBTablesName.User.U_USER, DBTablesName.User.U_STORE_PROFILE })
	Page<StoreEvaluationInfo> findStoreEvaluations(StoreEvaluateQuery query);
	
	/**
	 * @Description TODO(分页获取导出门店评论记录报表数据)
	 * @param query
	 * @param startLineNum
	 * @param pageSize
	 * @return List<StoreEvaluationInfo> 报表导出不使用缓存
	 */
	List<StoreEvaluationInfo> listDataForExportStoreEvaluation(
			@Param("storeEvaluateQuery") StoreEvaluateQuery storeEvaluateQuery, @Param("startLineNum") Long startLineNum,
			@Param("pageSize") Integer pageSize);

	/**
	 * @Description TODO(获取报表数据的总记录数)
	 * @param query
	 * @return Long 报表导出不适用缓存
	 */
	Long getCountsForExportStoreEvaluation(StoreEvaluateQuery query);
	/**
	 * 批量保存门店评价到临时表
	 * @param record 评价记录
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_STORE_EVALUATION_TEMP })
	void batchSaveTemp(List<StoreEvaluation> list);
	/**
	 * 根据查询条件分页查询所有门店的评论明细记录
	 * 
	 * @param query 查询条件对象
	 * @return Page<StoreEvaluation>
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_EVALUATION_TEMP,
			DBTablesName.User.U_CUSTOMER, DBTablesName.User.U_USER, DBTablesName.User.U_STORE_PROFILE })
	Page<StoreEvaluationInfo> findStoreEvaluationTemps(StoreEvaluateQuery query);
	/**
	 * 根据条件查询临时表中的评论信息
	 * @param query
	 * @return
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_EVALUATION_TEMP })
	List<StoreEvaluationInfo> liststoreEvaluationTemps(StoreEvaluateQuery query);
	/**
	 * 将临时评论信息导入正式表
	 * @param storeEvaluationTemps
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_STORE_EVALUATION })
	void batchSaveTempToStandard(List<StoreEvaluationInfo> storeEvaluationTemps);
	/**
	 * 根据id将店铺评论临时表中相应数据删除
	 * @param ids
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_STORE_EVALUATION_TEMP })
	void deletestoreEvaluationTempsByIds(List<Integer> ids);
	/**
	 * 清空店铺评论临时表数据
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_STORE_EVALUATION_TEMP })
	void deleteAllStoreEvaluationTemps();
	/**
	 * 计算商家平均分
	 * @param storeId
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_EVALUATION })
	Double getAvgStoreScoreByStoreId(Integer storeId);
	/**
     * 计算全部商家评价得分平均分
     * @param storeId
     */
    @DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_STORE_EVALUATION })
    List<StoreEvaluationScore> liststoreEvaluationScores(StoreEvaluateQuery query);

}