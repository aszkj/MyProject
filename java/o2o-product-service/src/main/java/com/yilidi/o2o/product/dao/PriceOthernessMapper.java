package com.yilidi.o2o.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.core.DBTablesName;
import com.yilidi.o2o.core.cache.CacheType;
import com.yilidi.o2o.core.cache.DBCacheAnnotation;
import com.yilidi.o2o.product.model.PriceOtherness;
import com.yilidi.o2o.product.service.dto.query.PriceOthernessQuery;

/**
 * 功能描述：价格差异化设置数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface PriceOthernessMapper {

	/**
	 * 保存价格差异化设置
	 * 
	 * @param record
	 *            价格差异化设置对象
	 * @return 影响的行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRICE_OTHERNESS,
			DBTablesName.Product.P_PRICE_OTHERNESS_AREA })
	Integer save(PriceOtherness record);

	/**
	 * 根据id更新状态
	 * 
	 * @param id
	 *            价格差异化ID
	 * @param status
	 *            状态 "0"无效 "1" 有效
	 * @param modifyUserId
	 *            修改的用户Id
	 * @return 影响行数
	 */
	@DBCacheAnnotation(value = CacheType.NOTIFY, tables = { DBTablesName.Product.P_PRICE_OTHERNESS })
	Integer updateStatusById(Integer id, String status, Integer modifyUserId);

	/**
	 * 根据Id查询差异化价格信息
	 * 
	 * @param id
	 *            价格差异化id
	 * @return 价格差异化对象
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRICE_OTHERNESS })
	PriceOtherness loadById(Integer id);

	/**
	 * 根据供应商Id查询价格差异化记录
	 * 
	 * @param operatorId
	 *            运营商ID
	 * @return 价格差异化列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRICE_OTHERNESS })
	PriceOtherness listByOperatorId(Integer operatorId);

	/**
	 * 根据查询条件查询价格差异化记录
	 * 
	 * @param query
	 *            查询条件对象
	 * @return 列表
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRICE_OTHERNESS })
	List<PriceOtherness> list(PriceOthernessQuery query);

	/**
	 * 根据商品id，地区编码查询差异化价格
	 * 
	 * @param productId
	 *            平台产品库产品ID
	 * @param provinceCode
	 *            省份编码
	 * @param cityCode
	 *            市编码
	 * @return 差异化价格
	 */
	@DBCacheAnnotation(value = CacheType.QUERY, tables = { DBTablesName.Product.P_PRICE_OTHERNESS })
	PriceOtherness loadByProductIdAndAreaCode(@Param("productId") Integer productId,
			@Param("provinceCode") String provinceCode, @Param("cityCode") String cityCode);
}