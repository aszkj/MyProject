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
import com.yilidi.o2o.user.service.IStoreProductSubsidyService;
import com.yilidi.o2o.user.service.dto.StoreProductSubsidyDto;
import com.yilidi.o2o.user.service.dto.query.StoreProductSubsidyQuery;

/**
 * @Description:TODO(门店账本商品补贴明细管理导出报表) 
 * @author:	llp
 * @date:	2015年12月2日 下午5:16:38 
 *
 */
public class StoreProductSubsidyReportExport extends AbstractExportReport {

	protected Logger logger = Logger.getLogger(this.getClass());
	
	/**
	 * 利用hessian协议的远程IAccountService接口（适用于大数据量，传输文件等的场景， 短连接）
	 */
	private IStoreProductSubsidyService storeProductSubsidyServiceHessian;
	
	public StoreProductSubsidyReportExport() {
		super.reportIndividualRelativePath = "/user";
	}

	@Override
	protected Long obtainDataCount(Object searchArgument) throws ReportException {
		try {
			StoreProductSubsidyQuery  query = (StoreProductSubsidyQuery) searchArgument;
			return storeProductSubsidyServiceHessian.getCountsForExportProductSubsidy(query);
		} catch (UserServiceException e) {
			logger.error("获取需导出的总记录数出现异常", e);
			throw new ReportException(e.getMessage());
		}
	}

	@Override
	protected List<?> obtainDataList(Object searchArgument, Long startLineNum, Integer pageSize) throws ReportException {
		try {
			StoreProductSubsidyQuery  query = (StoreProductSubsidyQuery) searchArgument;
			return storeProductSubsidyServiceHessian.listDataForExportProductSubsidy(query, startLineNum, pageSize);
		} catch (UserServiceException e) {
			logger.error("获取导出数据的List出现异常", e);
			throw new ReportException(e.getMessage());
		}
	}

	@Override
	protected int generateHead(Sheet sheet, int rowIndex) throws ReportException {
		try {
			List<Map<String, String>> headers = withdrawReportHeader();
			String mainTitle = "门店商品补贴明细报表";
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
				for (StoreProductSubsidyDto storeProductSubsidyDto : (List<StoreProductSubsidyDto>) dataList) {
					double baseMount = ArithUtils.convertLongTodouble(StringUtils.BASE_AMOUNT);
					Row row = sheet.createRow(rowIndex);
					addCell(row, 0, rowIndex - 1);
					addCell(row, 1, storeProductSubsidyDto.getCreateTime());
					addCell(row, 2, storeProductSubsidyDto.getStoreCode());
					addCell(row, 3, storeProductSubsidyDto.getStoreName());
					addCell(row, 4, storeProductSubsidyDto.getSaleOrderNo());
					addCell(row, 5, storeProductSubsidyDto.getProductName());
					addCell(row, 6, ArithUtils.div(ArithUtils.convertLongTodouble(storeProductSubsidyDto.getRetailPrice()),
							baseMount, 3));
					addCell(row, 7, ArithUtils.div(
							ArithUtils.convertLongTodouble(storeProductSubsidyDto.getPromotionalPrice()), baseMount, 3));
					addCell(row, 8, storeProductSubsidyDto.getProductNum());
					addCell(row, 9, ArithUtils.div(ArithUtils.convertLongTodouble(storeProductSubsidyDto.getPriceSubsidy()),
							baseMount, 3));
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
		map.put("header", "商品名称");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "采购价(元)");
		map.put("width", "20");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "商品活动价(元)");
		map.put("width", "20");
		headers.add(map);
		
		map = new HashMap<String, String>();
		map.put("header", "商品数量");
		map.put("width", "20");
		headers.add(map);
		
		map = new HashMap<String, String>();
		map.put("header", "商品差价补贴金额(元)");
		map.put("width", "25");
		headers.add(map);
		
		return headers;
	}
	
	public IStoreProductSubsidyService getStoreProductSubsidyServiceHessian() {
		return storeProductSubsidyServiceHessian;
	}

	public void setStoreProductSubsidyServiceHessian(IStoreProductSubsidyService storeProductSubsidyServiceHessian) {
		this.storeProductSubsidyServiceHessian = storeProductSubsidyServiceHessian;
	}
}
