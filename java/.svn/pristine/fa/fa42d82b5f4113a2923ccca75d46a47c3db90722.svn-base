package com.yilidi.o2o.order.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.order.model.ImpressionStatistics;

/**
 * 功能描述：商品印象评价统计结果数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ImpressionStatisticsMapper {

	/**
	 * 保存印象统计结果
	 * 
	 * @param record
	 *            统计结果
	 * @return 影响行数
	 */
	Integer save(ImpressionStatistics record);

	/**
	 * 根据商品id和标签编码更新该标签的统计结果
	 * 
	 * @param saleProductId
	 *            商品id
	 * @param labelCode
	 *            标签编码
	 * @return 影响行数
	 */
	Integer updateBySaleProductId(@Param("saleProductId") Integer saleProductId, @Param("labelCode") String labelCode);

	/**
	 * 根据商品id查询该商品的印象统计结果
	 * 
	 * @param saleProductId
	 *            商品id
	 * @return 印象统计结果列表
	 */
	List<ImpressionStatistics> listBySaleProductId(Integer saleProductId);

	/**
	 * 检查该商品和labelcode是否已经存在印象统计记录
	 * 
	 * @param saleProductId
	 *            商品id
	 * @param labelCode
	 *            标签编码
	 * @return 返回记录个数
	 */
	Integer checkSaleProduct(@Param("saleProductId") Integer saleProductId, @Param("labelCode") String labelCode);
}