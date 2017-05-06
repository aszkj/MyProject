package com.yilidi.o2o.report.export.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;

import com.yilidi.o2o.core.exception.ReportException;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.report.AbstractExportReport;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.user.service.IStoreSubsidyRecordService;
import com.yilidi.o2o.user.service.dto.StoreSubsidyRecordDto;
import com.yilidi.o2o.user.service.dto.query.StoreSubsidyRecordQuery;

/**
 * @Description:TODO(门店账本补贴(现金补贴，商品补贴，优惠券补贴，运费补贴)导出报表) 
 * @author:	llp
 * @date:	2015年11月27日 下午5:16:38 
 *
 */
public class StoreSubsidyRecordReportExport extends AbstractExportReport {

	protected Logger logger = Logger.getLogger(this.getClass());
	
	/**
	 * 利用hessian协议的远程IAccountService接口（适用于大数据量，传输文件等的场景， 短连接）
	 */
	private IStoreSubsidyRecordService storeSubsidyRecordServiceHessian;
	
	public StoreSubsidyRecordReportExport() {
		super.reportIndividualRelativePath = "/user";
	}

	@Override
	protected Long obtainDataCount(Object searchArgument) throws ReportException {
		try {
			StoreSubsidyRecordQuery  query = (StoreSubsidyRecordQuery) searchArgument;
			return storeSubsidyRecordServiceHessian.getCountsForExportStoreSubsidyRecord(query);
		} catch (UserServiceException e) {
			logger.error("获取需导出的总记录数出现异常", e);
			throw new ReportException(e.getMessage());
		}
	}

	@Override
	protected List<?> obtainDataList(Object searchArgument, Long startLineNum, Integer pageSize) throws ReportException {
		try {
			StoreSubsidyRecordQuery  query = (StoreSubsidyRecordQuery) searchArgument;
			return storeSubsidyRecordServiceHessian.listDataForExportStoreSubsidyRecord(query, startLineNum, pageSize);
		} catch (UserServiceException e) {
			logger.error("获取导出数据的List出现异常", e);
			throw new ReportException(e.getMessage());
		}
	}

	@Override
	protected int generateHead(Sheet sheet, int rowIndex) throws ReportException {
		try {
			List<Map<String, String>> headers = withdrawReportHeader();
			String mainTitle = "门店账本明细报表";
			rowIndex = super.writeMainTitle(sheet, rowIndex, mainTitle, headers.size() - 1);
			rowIndex = super.writeHeader(sheet, headers, rowIndex);
			return rowIndex;
		} catch (Exception e) {
			throw new ReportException("生成Excel头部信息出现异常：" + e.getMessage());
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	protected int generateBody(Sheet sheet, int rowIndex, List<?> dataList) throws ReportException {
		try {
			if (!ObjectUtils.isNullOrEmpty(dataList)) {
				for (StoreSubsidyRecordDto storeSubsidyRecordDto : (List<StoreSubsidyRecordDto>) dataList) {
					double baseMount = ArithUtils.convertLongTodouble(StringUtils.BASE_AMOUNT);
					Row row = sheet.createRow(rowIndex);
					addCell(row, 0, rowIndex - 1);
					addCell(row, 1, storeSubsidyRecordDto.getCreateTime());
					addCell(row, 2, storeSubsidyRecordDto.getStoreCode());
					addCell(row, 3, storeSubsidyRecordDto.getStoreName());
					addCell(row, 4, storeSubsidyRecordDto.getSaleOrderNo());
					addCell(row, 5, ArithUtils.div(ArithUtils.convertLongTodouble(storeSubsidyRecordDto.getCashSubsidy()),
							baseMount, 3));
					addCell(row, 6, ArithUtils.div(ArithUtils.convertLongTodouble(storeSubsidyRecordDto.getPriceSubsidy()),
							baseMount, 3));
					addCell(row, 7, ArithUtils.div(ArithUtils.convertLongTodouble(storeSubsidyRecordDto.getCouponSubsidy()),
							baseMount, 3));
					addCell(row, 8, ArithUtils.div(
							ArithUtils.convertLongTodouble(storeSubsidyRecordDto.getLogisticsSubsidy()), baseMount, 3));
					rowIndex++;
				}
			}
			return rowIndex;
		} catch (Exception e) {
			throw new ReportException("生成Excel主体数据信息出现异常：" + e.getMessage());
		}
	}

	public static List<Map<String, String>> withdrawReportHeader() {
		List<Map<String, String>> headers = new ArrayList<Map<String, String>>();
		Map<String, String> map = new HashMap<String, String>();

		map.put("header", "序号");
		map.put("width", "8");
		headers.add(map);
		
		map = new HashMap<String, String>();
		map.put("header", "补贴时间");
		map.put("width", "25");
		headers.add(map);
		
		map = new HashMap<String, String>();
		map.put("header", "门店编号");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "门店名称");
		map.put("width", "30");
		headers.add(map);
		
		map = new HashMap<String, String>();
		map.put("header", "订单号");
		map.put("width", "30");
		headers.add(map);
		
		map = new HashMap<String, String>();
		map.put("header", "现金补贴金额(元)");
		map.put("width", "20");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "商品补贴金额(元)");
		map.put("width", "20");
		headers.add(map);
		
		map = new HashMap<String, String>();
		map.put("header", "优惠券补贴金额");
		map.put("width", "20");
		headers.add(map);
		
		map = new HashMap<String, String>();
		map.put("header", "运费补贴金额(元)");
		map.put("width", "20");
		headers.add(map);
		
		return headers;
	}
	
	public IStoreSubsidyRecordService getStoreSubsidyRecordServiceHessian() {
		return storeSubsidyRecordServiceHessian;
	}

	public void setStoreSubsidyRecordServiceHessian(IStoreSubsidyRecordService storeSubsidyRecordServiceHessian) {
		this.storeSubsidyRecordServiceHessian = storeSubsidyRecordServiceHessian;
	}
}
