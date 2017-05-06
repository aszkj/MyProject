/**
 * 文件名称：SaleReportService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.JsonUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.dao.SaleDailyMapper;
import com.yilidi.o2o.order.model.result.SaleReport;
import com.yilidi.o2o.order.service.ISaleReportService;
import com.yilidi.o2o.order.service.dto.SaleReportDto;
import com.yilidi.o2o.order.service.dto.query.SaleReportQuery;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("saleReportService")
public class SaleReportServiceImpl extends BasicDataService implements ISaleReportService {

	public static final int WEEKDAYS = 7;

	@Autowired
	private SaleDailyMapper saleDailyMapper;

	private int week = -7;

	@Override
	public List<SaleReportDto> listSaleReportWeekly(Integer providerId) throws OrderServiceException {

		logger.debug("SaleReportService.listSaleReportWeekly => 参数provideId: " + providerId);

		List<SaleReportDto> rptDtoList = new ArrayList<SaleReportDto>();

		SaleReportQuery query = new SaleReportQuery();
		query.setProviderId(providerId);

		/**
		 * 最近7天的数据，包含当天
		 */
		Date endDate = new Date();
		Date startDate = DateUtils.addDays(endDate, week);
		query.setStartDate(startDate);
		query.setEndDate(endDate);
		List<SaleReport> weekRpt = saleDailyMapper.listSaleTrend(query);

		logger.debug("SaleReportService.listSaleReportWeekly => 最近7天的数据: " + JsonUtils.toJsonStringWithDateFormat(weekRpt));

		/**
		 * 上一个7天的数据
		 */
		endDate = startDate;
		startDate = DateUtils.addDays(endDate, week);
		query.setStartDate(startDate);
		query.setEndDate(endDate);

		List<SaleReport> lastWeekRpt = saleDailyMapper.listSaleTrend(query);

		logger.debug("SaleReportService.listSaleReportWeekly => 上一个7天的数据: "
				+ JsonUtils.toJsonStringWithDateFormat(lastWeekRpt));
		/**
		 * 没有上一周的数据
		 */
		if (0 >= lastWeekRpt.size()) {
			for (SaleReport rpt : weekRpt) {
				SaleReportDto dto = new SaleReportDto();

				dto.setDailyAmount(rpt.getTotalAmount());
				dto.setDailyQuantity(rpt.getTotalQuantity());
				dto.setLastDayAmount(0L);
				dto.setLastDayQuantity(0L);
				dto.setSaleDate(rpt.getSaleDate());
				rptDtoList.add(dto);
			}
			return rptDtoList;
		}
		/**
		 * 上一周的数据满7天
		 */
		if (WEEKDAYS <= lastWeekRpt.size()) {
			for (int i = 0; i < WEEKDAYS; i++) {
				SaleReportDto dto = new SaleReportDto();
				dto.setDailyAmount(weekRpt.get(i).getTotalAmount());
				dto.setDailyQuantity(weekRpt.get(i).getTotalQuantity());
				dto.setLastDayAmount(lastWeekRpt.get(i).getTotalAmount());
				dto.setLastDayQuantity(lastWeekRpt.get(i).getTotalQuantity());
				dto.setSaleDate(weekRpt.get(i).getSaleDate());
				rptDtoList.add(dto);
			}
			return rptDtoList;
		}

		/**
		 * 上一周数据不满7天
		 */
		int size = lastWeekRpt.size();
		int delta = WEEKDAYS - size;
		for (int i = 0; i < delta; i++) {
			SaleReportDto dto = new SaleReportDto();
			dto.setDailyAmount(weekRpt.get(i).getTotalAmount());
			dto.setDailyQuantity(weekRpt.get(i).getTotalQuantity());
			dto.setLastDayAmount(0L);
			dto.setLastDayQuantity(0L);
			dto.setSaleDate(weekRpt.get(i).getSaleDate());
			rptDtoList.add(dto);
		}
		for (int i = 0; i < size; i++) {
			SaleReportDto dto = new SaleReportDto();
			dto.setDailyAmount(weekRpt.get(i + delta).getTotalAmount());
			dto.setDailyQuantity(weekRpt.get(i + delta).getTotalQuantity());
			dto.setLastDayAmount(lastWeekRpt.get(i).getTotalAmount());
			dto.setLastDayQuantity(lastWeekRpt.get(i).getTotalQuantity());
			dto.setSaleDate(weekRpt.get(i).getSaleDate());
			rptDtoList.add(dto);
		}

		return rptDtoList;
	}

	@Override
	public List<SaleReportDto> listSaleReportTrend(SaleReportQuery query) throws OrderServiceException {

		logger.debug("SaleReportService.listSaleReportTrend => 查询参数query: " + query);

		if (ObjectUtils.isNullOrEmpty(query)) {
			logger.error("SaleReportService.listSaleReportTrend => 查询参数为null，请检查");
			throw new OrderServiceException("查询参数对象为null，请检查。");
		}

		/**
		 * 将开始时间向前提一天，在查询的使用采用的是大于开始时间
		 */
		if (null != query.getStartDate()) {
			query.setStartDate(DateUtils.addDays(query.getStartDate(), -1));
		}

		List<SaleReport> rptList = saleDailyMapper.listSaleTrend(query);

		logger.debug("SaleReportService.listSaleReportTrend => 查询结果SaleReportList: "
				+ JsonUtils.toJsonStringWithDateFormat(rptList));

		if (ObjectUtils.isNullOrEmpty(rptList)) {
			return null;
		}

		List<SaleReportDto> dtoList = new ArrayList<SaleReportDto>();
		for (SaleReport rpt : rptList) {
			SaleReportDto dto = new SaleReportDto();
			dto.setTotalAmount(rpt.getTotalAmount());
			dto.setTotalQuantity(rpt.getTotalQuantity());
			dto.setSaleDate(rpt.getSaleDate());
			dtoList.add(dto);
		}
		return dtoList;
	}

	@Override
	public List<SaleReportDto> listSaleReportDistribution(SaleReportQuery query, String reportBy)
			throws OrderServiceException {

		logger.debug("SaleReportService.listSaleReportDistribution => 查询参数query: " + query);
		logger.debug("SaleReportService.listSaleReportDistribution => 查询参数reportBy: " + reportBy);

		if (ObjectUtils.isNullOrEmpty(query)) {
			logger.error("SaleReportService.listSaleReportDistribution => 查询参数为null，请检查");
			throw new OrderServiceException("查询参数对象为null，异常终止操作。");
		}

		/**
		 * 将开始时间向前提一天，在查询的使用采用的是大于开始时间
		 */
		if (null != query.getStartDate()) {
			query.setStartDate(DateUtils.addDays(query.getStartDate(), -1));
		}

		List<SaleReport> rptList = saleDailyMapper.listSaleDistribution(query.getProductClassCode(), reportBy,
				query.getProviderId(), query.getStartDate(), query.getEndDate());

		logger.debug("SaleReportService.listSaleReportDistribution => 查询结果SaleReportList: "
				+ JsonUtils.toJsonStringWithDateFormat(rptList));

		if (ObjectUtils.isNullOrEmpty(rptList)) {
			return null;
		}

		List<SaleReportDto> dtoList = new ArrayList<SaleReportDto>();
		for (SaleReport rpt : rptList) {
			SaleReportDto dto = new SaleReportDto();
			dto.setTotalAmount(rpt.getTotalAmount());
			dto.setTotalQuantity(rpt.getTotalQuantity());
			dto.setReportBy(rpt.getReportBy());
			dtoList.add(dto);
		}
		return dtoList;
	}

}
