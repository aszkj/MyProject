package com.yilidi.o2o.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.user.model.SaleProductEvaluation;
import com.yilidi.o2o.user.model.combination.SaleProductEvaluationInfo;
import com.yilidi.o2o.user.service.dto.SaleProductEvaluationDto;
import com.yilidi.o2o.user.service.dto.query.SaleProductEvaluateQuery;

/**
 * @Description:TODO(商品评价数据层操作接口类 )
 * @author: llp
 * @date: 2015年12月7日 上午9:46:24
 */
public interface SaleProductEvaluationMapper {

	/**
	 * 保存产品评价
	 * 
	 * @param record
	 *            评价记录
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_SALEPRODUCT_EVALUATION })
	Integer save(SaleProductEvaluation record);

	/**
	 * 根据ID删除产品评论
	 * 
	 * @param id
	 *            绑定的评论ID
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_SALEPRODUCT_EVALUATION })
	Integer deleteById(Integer id);

	/**
	 * 根据ID, 修改评论是否显示状态
	 * 
	 * @param id
	 *            绑定的评论ID
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_SALEPRODUCT_EVALUATION })
	Integer updateShowStatusById(SaleProductEvaluation record);

	/**
	 * @Description TODO(根据Id查询产品评论信息)
	 * @param id
	 * @return SaleProductEvaluation
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_SALEPRODUCT_EVALUATION })
	SaleProductEvaluation loadById(Integer id);

	/**
	 * @Description TODO(通过评论主键id，查询评论的详细信息)
	 * @param id
	 * @return SaleProductEvaluationInfo
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_SALEPRODUCT_EVALUATION,
			DBTablesName.User.U_CUSTOMER,  DBTablesName.User.U_STORE_PROFILE })
	SaleProductEvaluationInfo loadDetailById(Integer id);

	/**
	 * 根据门店id查询该商品的所有评论（前端用，暂未考虑分页查询）
	 * 
	 * @param saleProductId
	 *            商品id
	 * @return 商品评价列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.User.U_SALEPRODUCT_EVALUATION,
			DBTablesName.User.U_CUSTOMER,  DBTablesName.User.U_STORE_PROFILE })
	List<SaleProductEvaluationInfo> listBySaleProductId(Integer saleProductId);

	/**
	 * 根据查询条件分页查询所有商品的评论明细记录
	 * 
	 * @param query
	 *            查询条件对象
	 * @return Page<SaleProductEvaluationInfo>
	 */
	Page<SaleProductEvaluationInfo> findSaleProductEvaluations(SaleProductEvaluateQuery query);

	/**
	 * @Description TODO(分页获取导出产品评论记录报表数据)
	 * @param query
	 * @param startLineNum
	 * @param pageSize
	 * @return List<SaleProductEvaluationInfo>
	 * 报表导出不使用缓存
	 */
	List<SaleProductEvaluationInfo> listDataForExportSaleProductEvaluation(
			@Param("saleProductEvaluateQuery") SaleProductEvaluateQuery saleProductEvaluateQuery,
			@Param("startLineNum") Long startLineNum, @Param("pageSize") Integer pageSize);

	/**
	 * @Description TODO(获取报表数据的总记录数)
	 * @param query
	 * @return Long
	 * 报表导出不适用缓存
	 */
	Long getCountsForExportSaleProductEvaluation(SaleProductEvaluateQuery query);
	/**
	 * 
	 * @param query
	 * @return
	 */
	/**
	 * 根据查询条件分页查询所有商品的临时评论明细记录
	 * 
	 * @param query
	 *            查询条件对象
	 * @return Page<SaleProductEvaluationInfo>
	 */
	Page<SaleProductEvaluationInfo> findSaleProductEvaluationsTemps(SaleProductEvaluateQuery query);
	/**
	 * 清空全部临时商品评论库信息
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_SALEPRODUCT_EVALUATION_TEMP })
	void deleteAllSaleProductEvaluationTemps();
	/**
	 * 批量保存商品评价到临时表
	 * @param record 评价记录
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_SALEPRODUCT_EVALUATION_TEMP })
	void batchSaveTemp(List<SaleProductEvaluationDto> list);
	/**
	 * 根据条件查询临时表中的评论信息
	 * @param query
	 * @return
	 */
	List<SaleProductEvaluationInfo> listSaleProductEvaluationTemps(SaleProductEvaluateQuery query);
	/**
	 * 将临时评论信息导入正式表
	 * @param storeEvaluationTemps
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_STORE_EVALUATION })
	void batchSaveTempToStandard(List<SaleProductEvaluationInfo> saleProductEvaluationTemps);
	/**
	 * 根据id将店铺评论临时表中相应数据删除
	 * @param ids
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.User.U_STORE_EVALUATION_TEMP })
	void deleteSaleProductEvaluationTempsByIds(List<Integer> ids);
	
}