package com.yilidi.o2o.order.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.order.model.CommissionClearup;
import com.yilidi.o2o.order.model.result.CommissionReport;

/**
 * 功能描述： 佣金结算记录 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface CommissionClearupMapper {

	/**
	 * 保存结算记录
	 * 
	 * @param record
	 *            结算记录
	 * @return 影响行数
	 */
	Integer save(CommissionClearup record);

	/**
	 * 结算（按月进行结算）
	 * 
	 * @param storeId
	 *            店铺ID
	 * @param startDate
	 *            结算开始日期
	 * @param endDate
	 *            结算结束日期
	 * @param rate
	 *            结算费率
	 * @param userId
	 *            结算用户id
	 * @return 影响行数
	 */
	Integer updateClearupMonthly(@Param("storeId") Integer storeId, @Param("startDate") Date startDate,
			@Param("endDate") Date endDate, @Param("rate") Integer rate, @Param("userId") Integer userId);

	/**
	 * 根据订单号获取结算的记录
	 * 
	 * @param saleOrderNo
	 *            订单号
	 * @return 结算记录
	 */
	List<CommissionClearup> listBySaleOrderNo(String saleOrderNo);

	/**
	 * 获取按月结算的统计记录
	 * 
	 * @param statusCode
	 *            结算状态编码
	 * @param storeId
	 *            店铺ID
	 * @param startDate
	 *            结算开始日期
	 * @param endDate
	 *            结算结束日期
	 * @return 结算统计结果
	 */
	List<CommissionReport> listClearupReport(@Param("statusCode") String statusCode,
			@Param("storeId") Integer storeId, @Param("startDate") Date startDate, @Param("endDate") Date endDate);

}