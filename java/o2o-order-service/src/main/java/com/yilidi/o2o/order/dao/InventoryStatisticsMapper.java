package com.yilidi.o2o.order.dao;

import java.util.HashMap;
import java.util.List;

import com.yilidi.o2o.order.model.SaleInventoryStatistics;
import com.yilidi.o2o.order.service.dto.query.SaleReportQuery;

/**
 * 功能描述：库存统计数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface InventoryStatisticsMapper {

	/**
	 * 保存统计结果
	 * 
	 * @param record
	 *            统计结果
	 * @return 影响行数
	 */
	Integer save(SaleInventoryStatistics record);

	/**
	 * 根据查询条件统计库存报表信息
	 * 
	 * @param query
	 *            查询条件对象
	 * @return 库存报表信息
	 */
	List<HashMap<String, Object>> listReport(SaleReportQuery query);

}