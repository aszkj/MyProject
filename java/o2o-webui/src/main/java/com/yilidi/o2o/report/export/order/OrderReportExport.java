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
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.service.IOrderService;
import com.yilidi.o2o.order.service.dto.SaleOrderInfoDto;
import com.yilidi.o2o.order.service.dto.query.SaleOrderQueryDto;

/**
 * 
 * 订单导出
 * 
 * @author: heyong
 * @date: 2015年12月1日 下午2:44:59
 * 
 */
public class OrderReportExport extends AbstractExportReport {

    protected Logger logger = Logger.getLogger(this.getClass());

    private IOrderService orderServiceHessian;

    public OrderReportExport() {
        super.reportIndividualRelativePath = "/order";
    }

    @Override
    protected Long obtainDataCount(Object searchArgument) throws ReportException {
        try {
            SaleOrderQueryDto saleOrderQuery = (SaleOrderQueryDto) searchArgument;
            return orderServiceHessian.getCountsForExportOrder(saleOrderQuery);
        } catch (OrderServiceException e) {
            logger.error("获取需导出的总记录数出现异常", e);
            throw new ReportException(e.getMessage());
        }
    }

    @Override
    protected List<?> obtainDataList(Object searchArgument, Long startLineNum, Integer pageSize) throws ReportException {
        try {
            SaleOrderQueryDto saleOrderQuery = (SaleOrderQueryDto) searchArgument;
            return orderServiceHessian.listDataForExportOrder(saleOrderQuery, startLineNum, pageSize);
        } catch (OrderServiceException e) {
            logger.error("获取导出数据的List出现异常", e);
            throw new ReportException(e.getMessage());
        }
    }

    @Override
    protected int generateHead(Sheet sheet, int rowIndex) throws ReportException {
        try {
            List<Map<String, String>> headers = OrderReportHeader();
            String mainTitle = "订单报表";
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
                    SaleOrderInfoDto dto = (SaleOrderInfoDto) dataList.get(i);
                    Row row = sheet.createRow(rowIndex);
                    addCell(row, 0, i + 1);
                    addCell(row, 1, dto.getSaleOrderNo());
                    addCell(row, 2, dto.getStoreName());
                    addCell(row, 3, dto.getUserName());
                    addCell(row, 4, dto.getConsigneeUserName());
                    addCell(row, 5, dto.getAddressDetail());
                    addCell(row, 6, dto.getPhoneNo());
                    addCell(row, 7, ArithUtils.div(dto.getTotalAmount(), StringUtils.BASE_AMOUNT, 3));
                    addCell(row, 8, dto.getCreateTime());
                    addCell(row, 9, dto.getPayTime() == null ? "---" : dto.getPayTime());
                    addCell(row, 10, dto.getPayTypeName());
                    addCell(row, 11, dto.getPayPlatformName());
                    addCell(row, 12, dto.getStatusName());
                    addCell(row, 13, dto.getChannelName());
                    rowIndex++;
                }
            }
            return rowIndex;
        } catch (Exception e) {
            throw new ReportException("生成Excel主体数据信息出现异常：" + e.getMessage());
        }
    }

    public static List<Map<String, String>> OrderReportHeader() {
        List<Map<String, String>> headers = new ArrayList<Map<String, String>>();
        Map<String, String> map = new HashMap<String, String>();
        map.put("header", "序号");
        map.put("width", "8");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "订单编号");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "门店名称");
        map.put("width", "20");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "会员账号");
        map.put("width", "20");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "收货人姓名");
        map.put("width", "15");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "收货人地址");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "收货人联系方式");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "订单金额(元)");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "下单时间");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "支付时间");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "支付方式");
        map.put("width", "10");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "支付平台");
        map.put("width", "15");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "订单状态");
        map.put("width", "15");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "订单来源");
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
