/**
 * 文件名称：ICommissionClearupService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.order.service.dto.CommissionClearupReportDto;

/**
 * 功能描述：佣金结算接口定义 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface ICommissionClearupService {

	/**
	 * 获取按月结算的统计记录
	 * 
	 * @param statusCode
	 *            结算状态编码
	 * @param providerId
	 *            供应商id
	 * @param year
	 *            结算年份
	 * @param month
	 *            结算月份
	 * @return 结算统计结果
	 * 
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	List<CommissionClearupReportDto> listClearupMonthly(String statusCode, Integer providerId, Integer year, Integer month)
			throws OrderServiceException;

	/**
	 * 按单结算的统计记录
	 * 
	 * @param providerId
	 *            供应商id
	 * @param startDate
	 *            结算开始日期
	 * @param endDate
	 *            结算结束日期
	 * @return 结算统计结果
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	List<CommissionClearupReportDto> listClearupSingly(Integer providerId, Date startDate, Date endDate)
			throws OrderServiceException;
}
