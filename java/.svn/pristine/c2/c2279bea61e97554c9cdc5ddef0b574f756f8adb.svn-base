package com.yilidi.o2o.report.export.order;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.exception.ReportException;
import com.yilidi.o2o.core.report.AbstractExportReport;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.service.IOrderService;
import com.yilidi.o2o.order.service.dto.SaleOrderStatisticsDto;
import com.yilidi.o2o.order.service.dto.query.SaleOrderStatisticsQuery;

/**
 * 
 * 用户销售统计->用户下单记录
 * 
 * @author: heyong
 * @date: 2015年12月2日 下午2:11:14
 * 
 */
public class OrderStatisticsByDateReportExport extends AbstractExportReport {

	protected Logger logger = Logger.getLogger(this.getClass());

	private IOrderService orderServiceHessian;

	public OrderStatisticsByDateReportExport() {
		super.reportIndividualRelativePath = "/orderstatisticsbydate";
	}

	@Override
	protected Long obtainDataCount(Object searchArgument) throws ReportException {
		try {
			SaleOrderStatisticsQuery saleOrderStatisticsQuery = (SaleOrderStatisticsQuery) searchArgument;
			return orderServiceHessian.getCountsForExportOrderStatisticsByDate(saleOrderStatisticsQuery);
		} catch (OrderServiceException e) {
			logger.error("获取需导出的总记录数出现异常", e);
			throw new ReportException(e.getMessage());
		}
	}

	@Override
	protected List<?> obtainDataList(Object searchArgument, Long startLineNum, Integer pageSize) throws ReportException {
		try {
			SaleOrderStatisticsQuery saleOrderStatisticsQuery = (SaleOrderStatisticsQuery) searchArgument;
			return orderServiceHessian.listDataForExportOrderStatisticsByDate(saleOrderStatisticsQuery, startLineNum,
					pageSize);
		} catch (OrderServiceException e) {
			logger.error("获取导出数据的List出现异常", e);
			throw new ReportException(e.getMessage());
		}
	}

	@Override
	protected int generateHead(Sheet sheet, int rowIndex) throws ReportException {
		try {
			List<Map<String, String>> headers = orderStatisticsByDateReportHeader();
			String mainTitle = "用户下单记录报表";
			rowIndex = super.writeMainTitle(sheet, rowIndex, mainTitle, headers.size() - 1);
			rowIndex = super.writeHeader(sheet, headers, rowIndex);
			return rowIndex;
		} catch (Exception e) {
			throw new ReportException("生成Excel头部信息出现异常：" + e.getMessage());
		}
	}

	@Override
	protected int generateBody(Sheet sheet, int rowIndex, List<?> dataList) throws ReportException {
		try {
			if (!ObjectUtils.isNullOrEmpty(dataList)) {
				for (int i = 0; i < dataList.size(); i++) {
					SaleOrderStatisticsDto dto = (SaleOrderStatisticsDto) dataList.get(i);
					Row row = sheet.createRow(rowIndex);
					addCell(row, 0, i + 1);
					addCell(row, 1, dto.getOrderTime());
					addCell(row, 2, dto.getUserName());
					addCell(row, 3, dto.getTotalOrderCount());
					addCell(row, 4, ArithUtils.div(dto.getTotalAmount(), StringUtils.BASE_AMOUNT, 3));
					if (!ObjectUtils.isNullOrEmpty(dto.getTotalOrderCountFromSuccess())) {
						addCell(row, 5, dto.getTotalOrderCountFromSuccess());
					} else {
						addCell(row, 5, 0);
					}
					if (!ObjectUtils.isNullOrEmpty(dto.getTotalAmountFromSuccess())) {
						addCell(row, 6, ArithUtils.div(dto.getTotalAmountFromSuccess(), StringUtils.BASE_AMOUNT, 3));
					} else {
						addCell(row, 6, 0);
					}
					if (!ObjectUtils.isNullOrEmpty(dto.getTotalOrderCountFromCancel())) {
						addCell(row, 7, dto.getTotalOrderCountFromCancel());
					} else {
						addCell(row, 7, 0);
					}
					if (!ObjectUtils.isNullOrEmpty(dto.getTotalAmountFromCancel())) {
						addCell(row, 8, ArithUtils.div(dto.getTotalAmountFromCancel(), StringUtils.BASE_AMOUNT, 3));
					} else {
						addCell(row, 8, 0);
					}
					rowIndex++;
				}
			}
			return rowIndex;
		} catch (Exception e) {
			throw new ReportException("生成Excel主体数据信息出现异常：" + e.getMessage());
		}
	}

	/**
	 * 报表头部
	 * 
	 * @return List<Map<String, String>>
	 */
	public static List<Map<String, String>> orderStatisticsByDateReportHeader() {
		List<Map<String, String>> headers = new ArrayList<Map<String, String>>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("header", "序号");
		map.put("width", "8");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "日期");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "用户账号");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "下单笔数");
		map.put("width", "15");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "下单金额(元)");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "成交笔数");
		map.put("width", "15");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "成交金额(元)");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "取消笔数");
		map.put("width", "15");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "取消金额(元)");
		map.put("width", "25");
		headers.add(map);

		return headers;
	}

	public IOrderService getOrderServiceHessian() {
		return orderServiceHessian;
	}

	public void setOrderServiceHessian(IOrderService orderServiceHessian) {
		this.orderServiceHessian = orderServiceHessian;
	}
}
