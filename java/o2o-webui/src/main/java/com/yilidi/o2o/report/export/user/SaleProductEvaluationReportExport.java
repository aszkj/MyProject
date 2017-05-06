package com.yilidi.o2o.report.export.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.util.CellRangeAddress;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ReportException;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.report.AbstractExportReport;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.common.utils.SystemBasicDataInfoUtils;
import com.yilidi.o2o.user.service.ISaleProductEvaluationService;
import com.yilidi.o2o.user.service.dto.SaleProductEvaluationDto;
import com.yilidi.o2o.user.service.dto.StoreEvaluationDto;
import com.yilidi.o2o.user.service.dto.query.SaleProductEvaluateQuery;

/**
 * 产品评论记录报表导出
 * @author:	llp
 * @date:	2015年12月12日 下午5:12:40 
 */
public class SaleProductEvaluationReportExport extends AbstractExportReport {

	protected Logger logger = Logger.getLogger(this.getClass());

	/**
	 * 利用hessian协议的远程ISaleProductEvaluationService接口（适用于大数据量，传输文件等的场景， 短连接）
	 */
	private ISaleProductEvaluationService saleProductEvaluationServiceHessian;
	
	/**
	 * 获取SYSTEM_DICT字典表CODE的名称，工具类
	 */
	private SystemBasicDataInfoUtils systemBasicDataInfoUtils;
	
	public SaleProductEvaluationReportExport() {
		super.reportIndividualRelativePath = "/user";
	}

	@Override
	protected Long obtainDataCount(Object searchArgument) throws ReportException {
		try {
			SaleProductEvaluateQuery query = (SaleProductEvaluateQuery) searchArgument;
			return saleProductEvaluationServiceHessian.getCountsForExportSaleProductEvaluation(query);
		} catch (UserServiceException e) {
			logger.error("获取需导出的总记录数出现异常", e);
			throw new ReportException(e.getMessage());
		}
	}

	@Override
	protected List<?> obtainDataList(Object searchArgument, Long startLineNum, Integer pageSize) throws ReportException {
		try {
			SaleProductEvaluateQuery query = (SaleProductEvaluateQuery) searchArgument;
			return saleProductEvaluationServiceHessian.listDataExportSaleProductEvaluation(query, startLineNum, pageSize);
		} catch (UserServiceException e) {
			logger.error("获取导出数据的List出现异常", e);
			throw new ReportException(e.getMessage());
		}
	}

	@Override
	protected int generateHead(Sheet sheet, int rowIndex) throws ReportException {
		try {
			List<Map<String, String>> headers = withdrawReportHeader();
			String mainTitle = "产品评论记录统计报表";
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
				for (SaleProductEvaluationDto saleProductEvaluationDto : (List<SaleProductEvaluationDto>) dataList) {
					Row row = sheet.createRow(rowIndex);
					addCell(row, 0, rowIndex - 1);
					int i = -1;
					for(SaleProductEvaluationDto saleProductEvaluationDto1: (List<SaleProductEvaluationDto>)dataList ){
						if(saleProductEvaluationDto.getStoreCode().equals(saleProductEvaluationDto1.getStoreCode())){
							i++;
						}
					}
					sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex+i, 1, 1));
					sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex+i, 2, 2));
					sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex+i, 3, 3));
					sheet.addMergedRegion(new CellRangeAddress(rowIndex, rowIndex+i, 4, 4));
					addCell(row, 1, saleProductEvaluationDto.getBarCode());
					addCell(row, 2, saleProductEvaluationDto.getSaleProductName());
					addCell(row, 3, saleProductEvaluationDto.getStoreCode());
					addCell(row, 4, saleProductEvaluationDto.getStoreName());
					addCell(row, 5, saleProductEvaluationDto.getCreateTime());
					addCell(row, 6, saleProductEvaluationDto.getContent());
					addCell(row, 7, saleProductEvaluationDto.getUserName());
					addCell(row, 8, saleProductEvaluationDto.getSaleOrderNo());
					addCell(row, 9, systemBasicDataInfoUtils.getSystemDictName(
							SystemContext.UserDomain.DictType.STOREEVALUATIONANONYMITYEVAL.getValue(),
							saleProductEvaluationDto.getAnonymityEvaluate()));
					addCell(row, 10, systemBasicDataInfoUtils.getSystemDictName(
							SystemContext.UserDomain.DictType.STOREEVALUATIONSYSTEMEVAL.getValue(),
							saleProductEvaluationDto.getSystemEvaluate()));
					addCell(row, 11, systemBasicDataInfoUtils.getSystemDictName(
							SystemContext.UserDomain.DictType.STOREEVALUATIONSTATUS.getValue(),
							saleProductEvaluationDto.getShowStatus()));
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
		map.put("header", "产品编号");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "产品名称");
		map.put("width", "25");
		headers.add(map);
		
		map = new HashMap<String, String>();
		map.put("header", "店铺编码");
		map.put("width", "25");
		headers.add(map);
		
		map = new HashMap<String, String>();
		map.put("header", "店铺名称");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "评论时间");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "评论内容");
		map.put("width", "50");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "评论用户");
		map.put("width", "20");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "订单号");
		map.put("width", "20");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "是否匿名评价");
		map.put("width", "20");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "是否系统评价");
		map.put("width", "20");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "显示状态");
		map.put("width", "20");
		headers.add(map);

		return headers;
	}

	public SystemBasicDataInfoUtils getSystemBasicDataInfoUtils() {
		return systemBasicDataInfoUtils;
	}

	public void setSystemBasicDataInfoUtils(SystemBasicDataInfoUtils systemBasicDataInfoUtils) {
		this.systemBasicDataInfoUtils = systemBasicDataInfoUtils;
	}

	public ISaleProductEvaluationService getSaleProductEvaluationServiceHessian() {
		return saleProductEvaluationServiceHessian;
	}

	public void setSaleProductEvaluationServiceHessian(ISaleProductEvaluationService saleProductEvaluationServiceHessian) {
		this.saleProductEvaluationServiceHessian = saleProductEvaluationServiceHessian;
	}
}
