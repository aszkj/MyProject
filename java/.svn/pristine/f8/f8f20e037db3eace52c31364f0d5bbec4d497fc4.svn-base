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
import com.yilidi.o2o.order.service.dto.AllVolumeStatisticsInfoDto;
import com.yilidi.o2o.order.service.dto.query.AllVolumeStatisticsQuery;

/**
 * 
 * 门店销售统计->下单
 * 
 * @author: heyong
 * @date: 2015年12月3日 下午2:29:17
 * 
 */
public class StoreVolumeListForDayReportExport extends AbstractExportReport {

	protected Logger logger = Logger.getLogger(this.getClass());

	private IOrderService orderServiceHessian;

	private String storeCode;

	private String storeName;

	public StoreVolumeListForDayReportExport() {
		super.reportIndividualRelativePath = "/storevolumelistforday";
	}

	@Override
	protected Long obtainDataCount(Object searchArgument) throws ReportException {
		try {
			AllVolumeStatisticsQuery allVolumeStatisticsQuery = (AllVolumeStatisticsQuery) searchArgument;
			storeCode = allVolumeStatisticsQuery.getStoreCode();
			storeName = allVolumeStatisticsQuery.getStoreName();
			return orderServiceHessian.getCountsForExportStoreVolumeListForDay(allVolumeStatisticsQuery);
		} catch (OrderServiceException e) {
			logger.error("获取需导出的总记录数出现异常", e);
			throw new ReportException(e.getMessage());
		}
	}

	@Override
	protected List<?> obtainDataList(Object searchArgument, Long startLineNum, Integer pageSize) throws ReportException {
		try {
			AllVolumeStatisticsQuery allVolumeStatisticsQuery = (AllVolumeStatisticsQuery) searchArgument;
			return orderServiceHessian.listDataForExportStoreVolumeListForDay(allVolumeStatisticsQuery, startLineNum,
					pageSize);
		} catch (OrderServiceException e) {
			logger.error("获取导出数据的List出现异常", e);
			throw new ReportException(e.getMessage());
		}
	}

	@Override
	protected int generateHead(Sheet sheet, int rowIndex) throws ReportException {
		try {
			List<Map<String, String>> headers = storeVolumeListForDayReportHeader();
			String mainTitle = "门店下单记录报表";
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
					AllVolumeStatisticsInfoDto dto = (AllVolumeStatisticsInfoDto) dataList.get(i);
					Row row = sheet.createRow(rowIndex);
					addCell(row, 0, i + 1);
					addCell(row, 1, dto.getOrderTime());
					addCell(row, 2, storeCode);
					addCell(row, 3, storeName);
					if (!ObjectUtils.isNullOrEmpty(dto.getCashSubsidy())) {
						addCell(row, 4, ArithUtils.div(dto.getCashSubsidy(), StringUtils.BASE_AMOUNT, 3));
					} else {
						addCell(row, 4, 0);
					}
					if (!ObjectUtils.isNullOrEmpty(dto.getPriceSubsidy())) {
						addCell(row, 5, ArithUtils.div(dto.getPriceSubsidy(), StringUtils.BASE_AMOUNT, 3));
					} else {
						addCell(row, 5, 0);
					}
					if (!ObjectUtils.isNullOrEmpty(dto.getCouponSubsidy())) {
						addCell(row, 6, ArithUtils.div(dto.getCouponSubsidy(), StringUtils.BASE_AMOUNT, 3));
					} else {
						addCell(row, 6, 0);
					}
					if (!ObjectUtils.isNullOrEmpty(dto.getLogisticsSubsidy())) {
						addCell(row, 7, ArithUtils.div(dto.getLogisticsSubsidy(), StringUtils.BASE_AMOUNT, 3));
					} else {
						addCell(row, 7, 0);
					}
					addCell(row, 8, dto.getTotalOrderCount());
					addCell(row, 9, ArithUtils.div(dto.getTotalAmount(), StringUtils.BASE_AMOUNT, 3));
					if (!ObjectUtils.isNullOrEmpty(dto.getTotalOrderCountFromSuccess())) {
						addCell(row, 10, dto.getTotalOrderCountFromSuccess());
					} else {
						addCell(row, 10, 0);
					}
					if (!ObjectUtils.isNullOrEmpty(dto.getTotalAmountFromSuccess())) {
						addCell(row, 11, ArithUtils.div(dto.getTotalAmountFromSuccess(), StringUtils.BASE_AMOUNT, 3));
					} else {
						addCell(row, 11, 0);
					}
					if (!ObjectUtils.isNullOrEmpty(dto.getTotalUserCountFromSuccess())) {
						addCell(row, 12, dto.getTotalUserCountFromSuccess());
					} else {
						addCell(row, 12, 0);
					}
					if (!ObjectUtils.isNullOrEmpty(dto.getTotalOrderCountFromCancel())) {
						addCell(row, 13, dto.getTotalOrderCountFromCancel());
					} else {
						addCell(row, 13, 0);
					}
					if (!ObjectUtils.isNullOrEmpty(dto.getTotalAmountFromCancel())) {
						addCell(row, 14, ArithUtils.div(dto.getTotalAmountFromCancel(), StringUtils.BASE_AMOUNT, 3));
					} else {
						addCell(row, 14, 0);
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
	public static List<Map<String, String>> storeVolumeListForDayReportHeader() {
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
		map.put("header", "门店编号");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "门店名称");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "订单补贴(元)");
		map.put("width", "15");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "商品差价补贴(元)");
		map.put("width", "20");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "优惠补贴(元)");
		map.put("width", "15");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "运费补贴(元)");
		map.put("width", "15");
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
		map.put("header", "成交用户数");
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
