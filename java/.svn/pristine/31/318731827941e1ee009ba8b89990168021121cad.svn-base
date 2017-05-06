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
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.product.service.IProductService;
import com.yilidi.o2o.product.service.dto.ProductDto;
import com.yilidi.o2o.product.service.dto.query.ProductQuery;

/**
 * 
 * 产品报表导出(产品报表导出)
 * 
 * @author: zxs
 * @date: 2015年11月19日 下午2:58:07
 * 
 */
public class ProductReportExport extends AbstractExportReport {

    protected Logger logger = Logger.getLogger(this.getClass());

    private IProductService productServiceHessian;

    public ProductReportExport() {
        super.reportIndividualRelativePath = "/product";
    }

    @Override
    protected Long obtainDataCount(Object searchArgument) throws ReportException {
        try {
            ProductQuery productQuery = (ProductQuery) searchArgument;
            return productServiceHessian.getCountsForExportProduct(productQuery);
        } catch (ProductServiceException e) {
            logger.error("获取需导出的总记录数出现异常", e);
            throw new ReportException(e.getMessage());
        }
    }

    @Override
    protected List<?> obtainDataList(Object searchArgument, Long startLineNum, Integer pageSize) throws ReportException {
        try {
            ProductQuery productQuery = (ProductQuery) searchArgument;
            productQuery.setOrder("CREATETIME");
            productQuery.setSort("DESC");
            return productServiceHessian.listDataForExportProduct(productQuery, startLineNum, pageSize);
        } catch (ProductServiceException e) {
            logger.error("获取导出数据的List出现异常", e);
            throw new ReportException(e.getMessage());
        }
    }

    @Override
    protected int generateHead(Sheet sheet, int rowIndex) throws ReportException {
        try {
            List<Map<String, String>> headers = ProductReportHeader();
            String mainTitle = "产品报表";
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
                    ProductDto productDto = (ProductDto) dataList.get(i);
                    Row row = sheet.createRow(rowIndex);
                    addCell(row, 0, productDto.getProductName());
                    addCell(row, 1, productDto.getBarCode());
                    addCell(row, 2, productDto.getClassName());
                    addCell(row, 3, productDto.getProductSpec());
                    addCell(row, 4, ArithUtils.div(ArithUtils.convertLongTodouble(productDto.getCostPrice()), 1000, 3));
                    addCell(row, 5, ArithUtils.div(ArithUtils.convertLongTodouble(productDto.getRetailPrice()), 1000, 3));
                    if (!ObjectUtils.isNullOrEmpty(productDto.getPromotionalPrice())) {
                        addCell(row, 6,
                                ArithUtils.div(ArithUtils.convertLongTodouble(productDto.getPromotionalPrice()), 1000, 3));
                    } else {
                        addCell(row, 6, "");
                    }
                    if (!ObjectUtils.isNullOrEmpty(productDto.getCommissionPrice())) {
                        addCell(row, 7,
                                ArithUtils.div(ArithUtils.convertLongTodouble(productDto.getCommissionPrice()), 1000, 3));
                    } else {
                        addCell(row, 7, "");
                    }
                    if (!ObjectUtils.isNullOrEmpty(productDto.getVipCommissionPrice())) {
                        addCell(row, 8,
                                ArithUtils.div(ArithUtils.convertLongTodouble(productDto.getVipCommissionPrice()), 1000, 3));
                    } else {
                        addCell(row, 8, "");
                    }
                    addCell(row, 9, productDto.getSaleStatusName());
                    addCell(row, 10, productDto.getCreateTime());
                    addCell(row, 11, productDto.getDisplayOrder());
                    rowIndex++;
                }
            }
            return rowIndex;
        } catch (Exception e) {
            String message = "生成Excel主体数据信息出现异常";
            logger.error(message, e);
            throw new ReportException(message);
        }
    }

    public static List<Map<String, String>> ProductReportHeader() {
        List<Map<String, String>> headers = new ArrayList<Map<String, String>>();
        Map<String, String> map = new HashMap<String, String>();
        map.put("header", "产品名称");
        map.put("width", "30");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "产品条形码");
        map.put("width", "30");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "产品分类");
        map.put("width", "15");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "产品规格");
        map.put("width", "30");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "采购价（元）");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "普通会员售价（元）");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "VIP会员售价（元）");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "普通会员返款（元）");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "VIP会员返款（元）");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "是否上架");
        map.put("width", "10");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "创建时间");
        map.put("width", "30");
        headers.add(map);
        
        map = new HashMap<String, String>();
        map.put("header", "显示顺序");
        map.put("width", "10");
        headers.add(map);

        return headers;
    }

    public IProductService getProductServiceHessian() {
        return productServiceHessian;
    }

    public void setProductServiceHessian(IProductService productServiceHessian) {
        this.productServiceHessian = productServiceHessian;
    }

}
