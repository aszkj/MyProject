package com.yilidi.o2o.order.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.order.model.SaleDaily;
import com.yilidi.o2o.order.model.result.SaleReport;
import com.yilidi.o2o.order.service.dto.query.SaleReportQuery;

/**
 * 功能描述： 商品每日的销量记录数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SaleDailyMapper {

	/**
	 * 保存销售记录
	 * 
	 * @param record
	 *            销售记录
	 * @return 影响行数
	 */
	Integer save(SaleDaily record);

	/**
	 * 根据订单号删除销售记录
	 * 
	 * @param saleOrderNo
	 *            订单号
	 * @return 影响行数
	 */
	Integer deleteBySaleOrderNo(String saleOrderNo);

	/**
	 * 统计销售趋势
	 * 
	 * @param query
	 *            查询条件
	 * @return 销售趋势列表
	 */
	List<SaleReport> listSaleTrend(SaleReportQuery query);

	/**
	 * 商品销量分布
	 * 
	 * @param productClassCode
	 *            商品类型编码
	 * @param reportBy
	 *            统计类型
	 * @param storeId
	 *            店铺ID
	 * @param startDate
	 *            查询的开始时间
	 * @param endDate
	 *            查询的结束时间
	 * @return 销售列表
	 */
	List<SaleReport> listSaleDistribution(@Param("productClassCode") String productClassCode,
			@Param("reportBy") String reportBy, @Param("storeId") Integer storeId, @Param("startDate") Date startDate,
			@Param("endDate") Date endDate);

}