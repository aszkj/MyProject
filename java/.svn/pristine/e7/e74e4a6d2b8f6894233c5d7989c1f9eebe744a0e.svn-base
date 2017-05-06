package com.yilidi.o2o.order.dao;

import java.util.List;

import com.yilidi.o2o.order.model.TradeEvaluation;

/**
 * 功能描述：交易评价数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface TradeEvaluationMapper {

	/**
	 * 保存交易评价
	 * 
	 * @param record
	 *            评价记录
	 * @return 影响行数
	 */
	Integer save(TradeEvaluation record);

	/**
	 * 根据商品id查询该商品的交易评价
	 * 
	 * @param saleProductId
	 *            商品id
	 * @return 交易评价列表
	 */
	List<TradeEvaluation> listBySaleProductId(Integer saleProductId);

}