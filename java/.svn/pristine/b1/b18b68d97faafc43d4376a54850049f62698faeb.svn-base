package com.yilidi.o2o.order.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.order.model.ProductImei;

/**
 * 功能描述：商品IMEI号数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ProductImeiMapper {

	/**
	 * 保存商品串号信息
	 * 
	 * @param record
	 *            商品串号信息记录
	 * @return 影响行数
	 */
	Integer save(ProductImei record);

	/**
	 * 根据商品串号记录ID更新串号状态
	 * 
	 * @param id
	 *            记录ID
	 * @param statusCode
	 *            串号状态
	 * @return 影响行数
	 */
	Integer updateStatusById(@Param("id") Integer id, @Param("statusCode") String statusCode);

	/**
	 * 根据商品串号更新串号状态
	 * 
	 * @param imeiNo
	 *            串号
	 * @param statusCode
	 *            串号状态
	 * @return 影响行数
	 */
	Integer updateStatusByImeiNo(@Param("imeiNo") String imeiNo, @Param("statusCode") String statusCode);

	/**
	 * 根据查询条件查询串号 ，查询条件为null，则查询所有记录
	 * 
	 * @param providerId
	 *            供应商id, 取值可以为null
	 * @param saleProductId
	 *            商品id， 取值可以为null
	 * @param statusCode
	 *            串号状态， 取值可以为null
	 * @return 商品串号列表
	 */
	List<ProductImei> list(@Param("providerId") Integer providerId, @Param("saleProductId") Integer saleProductId,
			@Param("statusCode") String statusCode);

	/**
	 * 根据串号查询查询商品串号信息
	 * 
	 * @param imeiNo
	 *            串号
	 * @return 串号对象
	 */
	ProductImei loadByImeiNo(String imeiNo);

}