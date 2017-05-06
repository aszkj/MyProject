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
import com.yilidi.o2o.product.service.dto.SaleProductAppDto;
import com.yilidi.o2o.product.service.dto.query.SaleProductQuery;

/**
 * 商品库存报表导出
 * 
 * @author: chenb
 * @date: 2016年6月27日 上午10:51:52
 */
public class SaleProductInventoryReportExport extends AbstractExportReport {

    protected Logger logger = Logger.getLogger(this.getClass());

    private ISaleProductService saleProductServiceHessian;

    /**
     * 构造方法初始化
     */
    public SaleProductInventoryReportExport() {
        super.reportIndividualRelativePath = "/saleproduct/inventory";
    }

    @Override
    protected Long obtainDataCount(Object searchArgument) throws ReportException {
        try {
            SaleProductQuery saleProductQuery = (SaleProductQuery) searchArgument;
            return saleProductServiceHessian.getCountsForExportSaleProductInventory(saleProductQuery);
        } catch (ProductServiceException e) {
            logger.error("获取需导出的总记录数出现异常", e);
            throw new ReportException(e.getMessage());
        }
    }

    @Override
    protected List<?> obtainDataList(Object searchArgument, Long startLineNum, Integer pageSize) throws ReportException {
        try {
            SaleProductQuery saleProductQuery = (SaleProductQuery) searchArgument;
            return saleProductServiceHessian.listDataForExportSaleProductInventory(saleProductQuery, startLineNum, pageSize);
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
                    SaleProductAppDto saleProductDto = (SaleProductAppDto) dataList.get(i);
                    Row row = sheet.createRow(rowIndex);
                    addCell(row, 0, i + 1);
                    addCell(row, 1, saleProductDto.getSaleProductName());
                    addCell(row, 2, saleProductDto.getBarCode());
                    String saleProductSpec = "";
                    String statusName = "";
                    if (null != saleProductDto.getSaleProductProfileDto()) {
                        saleProductSpec = saleProductDto.getSaleProductProfileDto().getSaleProductSpec();
                        statusName = saleProductDto.getSaleProductProfileDto().getSaleStatusName();
                    }
                    addCell(row, 3, saleProductSpec);
                    addCell(row, 4, saleProductDto.getProductClassName());
                    addCell(row, 5, statusName);
                    addCell(row, 6, saleProductDto.getStoreCode());
                    addCell(row, 7, saleProductDto.getStoreName());
                    addCell(row, 8, saleProductDto.getStoreTypeName());
                    addCell(row, 9, saleProductDto.getRemainCount());
                    addCell(row, 10, saleProductDto.getOrderCount());
                    rowIndex++;
                }
            }
            return rowIndex;
        } catch (Exception e) {
            throw new ReportException("生成Excel主体数据信息出现异常：" + e.getMessage());
        }
    }

    /**
     * 获取头部信息
     */
    private static List<Map<String, String>> saleProductReportHeader() {
        List<Map<String, String>> headers = new ArrayList<Map<String, String>>();
        Map<String, String> map = new HashMap<String, String>();
        map.put("header", "序号");
        map.put("width", "8");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "产品名称");
        map.put("width", "30");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "产品条形码");
        map.put("width", "30");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "产品规格");
        map.put("width", "30");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "产品分类");
        map.put("width", "30");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "是否上下架");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "商家编码");
        map.put("width", "30");
        headers.add(map);
        
        map = new HashMap<String, String>();
        map.put("header", "商家名称");
        map.put("width", "30");
        headers.add(map);
        
        map = new HashMap<String, String>();
        map.put("header", "商家类型");
        map.put("width", "30");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "剩余库存");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "已订购数量");
        map.put("width", "25");
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
