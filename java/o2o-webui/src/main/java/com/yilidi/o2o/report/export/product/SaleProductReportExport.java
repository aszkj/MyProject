package com.yilidi.o2o.report.export.product;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;

import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.exception.ReportException;
import com.yilidi.o2o.core.report.AbstractExportReport;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.service.ISaleProductService;
import com.yilidi.o2o.product.service.dto.SaleProductDto;
import com.yilidi.o2o.product.service.dto.query.SaleProductQuery;

/**
 * 
 * @Description:商品报表导出(商品报表导出)
 * @author: zxs
 * @date: 2015年11月19日 下午2:58:07
 * 
 */
public class SaleProductReportExport extends AbstractExportReport {

	protected Logger logger = Logger.getLogger(this.getClass());

	private ISaleProductService saleProductServiceHessian;

	public SaleProductReportExport() {
		super.reportIndividualRelativePath = "/product";
	}

	@Override
	protected Long obtainDataCount(Object searchArgument) throws ReportException {
		try {
			SaleProductQuery saleProductQuery = (SaleProductQuery) searchArgument;
			return saleProductServiceHessian.getCountsForExportSaleProduct(saleProductQuery);
		} catch (ProductServiceException e) {
			logger.error("获取需导出的总记录数出现异常", e);
			throw new ReportException(e.getMessage());
		}
	}

	@Override
	protected List<?> obtainDataList(Object searchArgument, Long startLineNum, Integer pageSize) throws ReportException {
		try {
			SaleProductQuery saleProductQuery = (SaleProductQuery) searchArgument;
			return saleProductServiceHessian.listDataForExportSaleProduct(saleProductQuery, startLineNum, pageSize);
		} catch (ProductServiceException e) {
			logger.error("获取导出数据的List出现异常", e);
			throw new ReportException(e.getMessage());
		}
	}

	@Override
	protected int generateHead(Sheet sheet, int rowIndex) throws ReportException {
		try {
			List<Map<String, String>> headers = saleProductReportHeader();
			String mainTitle = "商品报表";
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
					SaleProductDto saleProductDto = (SaleProductDto) dataList.get(i);
					Row row = sheet.createRow(rowIndex);
					addCell(row, 0, i + 1);
					addCell(row, 1, saleProductDto.getSaleProductName());
					addCell(row, 2, saleProductDto.getBarCode());
					addCell(row, 3, saleProductDto.getSaleProductSpec());
					addCell(row, 4, saleProductDto.getClassName());
					if (!ObjectUtils.isNullOrEmpty(saleProductDto.getPromotionalPrice())) {
						addCell(row, 5, saleProductDto.getPromotionalPrice() / 100);
					} else {
						addCell(row, 5, "");
					}
					addCell(row, 6, saleProductDto.getRetailPrice() / 100);
					addCell(row, 7, saleProductDto.getSaleStatusName());
					addCell(row, 8, saleProductDto.getHotSaleFlagName());
					addCell(row, 9, saleProductDto.getDisplayOrder());
					addCell(row, 10, saleProductDto.getSaleProductSourceName());
					rowIndex++;
				}
			}
			return rowIndex;
		} catch (Exception e) {
			throw new ReportException("生成Excel主体数据信息出现异常：" + e.getMessage());
		}
	}

	public static List<Map<String, String>> saleProductReportHeader() {
		List<Map<String, String>> headers = new ArrayList<Map<String, String>>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("header", "序号");
		map.put("width", "8");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "商品名称");
		map.put("width", "30");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "商品条形码");
		map.put("width", "30");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "商品规格");
		map.put("width", "30");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "商品分类");
		map.put("width", "15");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "平台活动价格（元）");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "零售价（元）");
		map.put("width", "25");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "是否上架");
		map.put("width", "10");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "是否热卖");
		map.put("width", "10");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "显示顺序");
		map.put("width", "10");
		headers.add(map);

		map = new HashMap<String, String>();
		map.put("header", "商品来源");
		map.put("width", "15");
		headers.add(map);

		return headers;
	}

	public ISaleProductService getSaleProductServiceHessian() {
		return saleProductServiceHessian;
	}

	public void setSaleProductServiceHessian(ISaleProductService saleProductServiceHessian) {
		this.saleProductServiceHessian = saleProductServiceHessian;
	}

}
