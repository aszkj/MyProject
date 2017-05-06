package com.yilidi.o2o.report.export.order;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.exception.ReportException;
import com.yilidi.o2o.core.report.AbstractExportReport;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.SystemBasicDataUtils;
import com.yilidi.o2o.order.service.IStockOutOrderService;
import com.yilidi.o2o.order.service.dto.StockOutOrderDto;
import com.yilidi.o2o.order.service.dto.query.StockOutOrderQueryDto;

/**
 * 出库订单导出
 * 
 * @author: chenb
 * @date: 2016年6月28日 上午10:47:43
 */
public class StockOutOrderReportExport extends AbstractExportReport {

    protected Logger logger = Logger.getLogger(this.getClass());

    private IStockOutOrderService stockOutOrderServiceHessian;

    public StockOutOrderReportExport() {
        super.reportIndividualRelativePath = "/stockOutOrder";
    }

    @Override
    protected Long obtainDataCount(Object searchArgument) throws ReportException {
        try {
            StockOutOrderQueryDto stockOutOrderQueryDto = (StockOutOrderQueryDto) searchArgument;
            return stockOutOrderServiceHessian.getCountsForExportStockOutOrder(stockOutOrderQueryDto);
        } catch (OrderServiceException e) {
            logger.error("获取需导出的总记录数出现异常", e);
            throw new ReportException(e.getMessage());
        }
    }

    @Override
    protected List<?> obtainDataList(Object searchArgument, Long startLineNum, Integer pageSize) throws ReportException {
        try {
            StockOutOrderQueryDto stockOutOrderQueryDto = (StockOutOrderQueryDto) searchArgument;
            return stockOutOrderServiceHessian.listDataForExportStockOutOrder(stockOutOrderQueryDto, startLineNum, pageSize);
        } catch (OrderServiceException e) {
            logger.error("获取导出数据的List出现异常", e);
            throw new ReportException(e.getMessage());
        }
    }

    @Override
    protected int generateHead(Sheet sheet, int rowIndex) throws ReportException {
        try {
            List<Map<String, String>> headers = stockOutOrderReportHeader();
            String mainTitle = "出库单报表";
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
                    StockOutOrderDto dto = (StockOutOrderDto) dataList.get(i);
                    Row row = sheet.createRow(rowIndex);
                    addCell(row, 0, i + 1);
                    addCell(row, 1, dto.getStockOutOrderNo());
                    addCell(row, 2, dto.getStoreName());
                    addCell(row, 3, dto.getStoreCode());
                    addCell(row, 4, SystemBasicDataUtils
                            .getSystemDictName(SystemContext.UserDomain.DictType.STORETYPE.getValue(), dto.getStoreType()));
                    addCell(row, 5, dto.getStockOutCount());
                    addCell(row, 6, ArithUtils.convertToYuanStr(dto.getStockOutAmount()));
                    String createTime = "";
                    String auditTime = "";
                    if (null != dto.getCreateTime()) {
                        createTime = DateUtils.formatDateLong(dto.getCreateTime());
                    }
                    if (null != dto.getAuditTime()) {
                        auditTime = DateUtils.formatDateLong(dto.getAuditTime());
                    }
                    String orderStatusName = SystemBasicDataUtils.getSystemDictName(
                            SystemContext.OrderDomain.DictType.STOCKOUTORDERSTATUS.getValue(), dto.getOrderStatus());
                    addCell(row, 7, createTime);
                    addCell(row, 8, auditTime);
                    addCell(row, 9, orderStatusName);
                    rowIndex++;
                }
            }
            return rowIndex;
        } catch (Exception e) {
            throw new ReportException("生成Excel主体数据信息出现异常：" + e.getMessage());
        }
    }

    private static List<Map<String, String>> stockOutOrderReportHeader() {
        List<Map<String, String>> headers = new ArrayList<Map<String, String>>();
        Map<String, String> map = new HashMap<String, String>();
        map.put("header", "序号");
        map.put("width", "8");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "出库单编号");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "商户名称");
        map.put("width", "20");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "商户编号");
        map.put("width", "20");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "商家类型");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "出库数量");
        map.put("width", "15");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "出库金额(元)");
        map.put("width", "20");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "下单时间");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "审核时间");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "审核状态");
        map.put("width", "20");
        headers.add(map);
        return headers;
    }

    public IStockOutOrderService getStockOutOrderServiceHessian() {
        return stockOutOrderServiceHessian;
    }

    public void setStockOutOrderServiceHessian(IStockOutOrderService stockOutOrderServiceHessian) {
        this.stockOutOrderServiceHessian = stockOutOrderServiceHessian;
    }

}
