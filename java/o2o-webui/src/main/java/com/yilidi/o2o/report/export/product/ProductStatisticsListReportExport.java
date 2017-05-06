package com.yilidi.o2o.report.export.product;

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
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.service.IOrderService;
import com.yilidi.o2o.order.service.dto.SaleProductStatisticsInfoDto;
import com.yilidi.o2o.order.service.dto.query.SaleProductStatisticsQuery;

/**
 * 商品销售统计
 * 
 * @author: heyong
 * @date: 2015年12月3日 下午3:22:40
 * 
 */
public class ProductStatisticsListReportExport extends AbstractExportReport {

	protected Logger logger = Logger.getLogger(this.getClass());

	private IOrderService orderServiceHessian;

	public ProductStatisticsListReportExport() {
		super.reportIndividualRelativePath = "/productstatisticslist";
	}

	@Override
	protected Long obtainDataCount(Object searchArgument) throws ReportException {
		try {
			SaleProductStatisticsQuery saleProductStatisticsQuery = (SaleProductStatisticsQuery) searchArgument;
			return orderServiceHessian.getCountsForExportProductStatisticsList(saleProductStatisticsQuery);
		} catch (OrderServiceException e) {
			logger.error("获取需导出的总记录数出现异常", e);
			throw new ReportException(e.getMessage());
		}
	}

	@Override
	protected List<?> obtainDataList(Object searchArgument, Long startLineNum, Integer pageSize) throws ReportException {
		try {
			SaleProductStatisticsQuery saleProductStatisticsQuery = (SaleProductStatisticsQuery) searchArgument;
			return orderServiceHessian.listDataForExportProductStatisticsList(saleProductStatisticsQuery, startLineNum,
					pageSize);
		} catch (OrderServiceException e) {
			logger.error("获取导出数据的List出现异常", e);
			throw new ReportException(e.getMessage());
		}
	}

	@Override
	protected int generateHead(Sheet sheet, int rowIndex) throws ReportException {
		try {
			List<Map<String, String>> headers = productStatisticsListReportHeader();
			String mainTitle = "商品销售统计报表";
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
					SaleProductStatisticsInfoDto dto = (SaleProductStatisticsInfoDto) dataList.get(i);
					Row row = sheet.createRow(rowIndex);
					addCell(row, 0, i + 1);
					addCell(row, 1, dto.getStoreCode());
					addCell(row, 2, dto.getStoreName());
					addCell(row, 3, dto.getBarCode());
					addCell(row, 4, dto.getProductName());
					addCell(row, 5, dto.getOrderCount());
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
	public static List<Map<String, String>> productStatisticsListReportHeader() {
		List<Map<String, String>> headers = new ArrayList<Map<String, String>>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("header", "序号");
		map.put("width", "8");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "门店编号");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "门店名称");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "商品条形码");
		map.put("width", "20");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "商品名称");
		map.put("width", "20");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "下单数量");
		map.put("width", "15");
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
