package com.yilidi.o2o.order.dao;

import com.yilidi.o2o.order.model.EvaluationStatistics;

/**
 * 功能描述：交易评价结果统计数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface EvaluationStatisticsMapper {

	/**
	 * 保存统计结果
	 * 
	 * @param record
	 *            统计结果
	 * @return 影响行数
	 */
	Integer save(EvaluationStatistics record);

	/**
	 * 根据商品id更新商品的好评数
	 * 
	 * @param saleProductId
	 *            商品id
	 * @return 影响行数
	 */
	Integer updateGoodBySaleProductId(Integer saleProductId);

	/**
	 * 根据商品id更新商品的中评书
	 * 
	 * @param saleProductId
	 *            商品id
	 * @return 影响行数
	 */
	Integer updateNormalBySaleProductId(Integer saleProductId);

	/**
	 * 根据商品id跟新商品的差评数
	 * 
	 * @param saleProductId
	 *            商品id
	 * @return 影响行数
	 */
	Integer updatePoorBySaleProductId(Integer saleProductId);

	/**
	 * 根据商品id更新商品的有图评价数
	 * 
	 * @param saleProductId
	 *            商品id
	 * @return 影响行数
	 */
	Integer updateImageBySaleProductId(Integer saleProductId);

	/**
	 * 根据商品id查询评价统计结果
	 * 
	 * @param saleProductId
	 *            商品id
	 * @return 评价统计结果
	 */
	EvaluationStatistics loadBySaleProductId(Integer saleProductId);

	/**
	 * 检查是否存在指定商品id的评价记录
	 * 
	 * @param saleProductId
	 *            商品id
	 * @return 返回记录的个数
	 */
	Integer checkSaleProduct(Integer saleProductId);

}