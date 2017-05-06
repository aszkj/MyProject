/**
 * 文件名称：ISaleReportService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service;

import java.util.List;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.order.service.dto.SaleReportDto;
import com.yilidi.o2o.order.service.dto.query.SaleReportQuery;

/**
 * 功能描述：销售报表服务接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ISaleReportService {

	/**
	 * /** 根据供应商（卖家）获取最近一周的商品销量数据
	 * 
	 * @param providerId
	 *            供应商id 可以为null
	 * @return 销售数据
	 * @throws OrderServiceException
	 *             服务异常
	 */

	List<SaleReportDto> listSaleReportWeekly(Integer providerId) throws OrderServiceException;

	/**
	 * 获取销量趋势数据
	 * 
	 * @param query
	 *            查询条件
	 * @return 销量数据
	 * @throws OrderServiceException
	 *             服务异常
	 */
	List<SaleReportDto> listSaleReportTrend(SaleReportQuery query) throws OrderServiceException;;

	/**
	 * 获取商品的销量分布
	 * 
	 * @param query
	 *            查询条件对象
	 * @param reportBy
	 *            分布类型，如果为null，则默认按供应商进行统计分布(使用SaleReportDto中的ReportBy的变量传入参数)
	 * @return 销量数据
	 * @throws OrderServiceException
	 *             服务异常
	 */
	List<SaleReportDto> listSaleReportDistribution(SaleReportQuery query, String reportBy) throws OrderServiceException;;

}
