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
import com.yilidi.o2o.order.service.IPurchaseOrderService;
import com.yilidi.o2o.order.service.dto.PurchaseOrderAddressDto;
import com.yilidi.o2o.order.service.dto.PurchaseOrderDto;
import com.yilidi.o2o.order.service.dto.query.PurchaseOrderQueryDto;

/**
 * 采购订单导出
 * 
 * @author: chenb
 * @date: 2016年6月28日 上午10:47:43
 */
public class PurchaseOrderReportExport extends AbstractExportReport {

    protected Logger logger = Logger.getLogger(this.getClass());

    private IPurchaseOrderService purchaseOrderServiceHessian;

    public PurchaseOrderReportExport() {
        super.reportIndividualRelativePath = "/purchaseOrder";
    }

    @Override
    protected Long obtainDataCount(Object searchArgument) throws ReportException {
        try {
            PurchaseOrderQueryDto purchaseOrderQueryDto = (PurchaseOrderQueryDto) searchArgument;
            return purchaseOrderServiceHessian.getCountsForExportPurchaseOrder(purchaseOrderQueryDto);
        } catch (OrderServiceException e) {
            logger.error("获取需导出的总记录数出现异常", e);
            throw new ReportException(e.getMessage());
        }
    }

    @Override
    protected List<?> obtainDataList(Object searchArgument, Long startLineNum, Integer pageSize) throws ReportException {
        try {
            PurchaseOrderQueryDto purchaseOrderQueryDto = (PurchaseOrderQueryDto) searchArgument;
            return purchaseOrderServiceHessian.listDataForExportPurchaseOrder(purchaseOrderQueryDto, startLineNum, pageSize);
        } catch (OrderServiceException e) {
            logger.error("获取导出数据的List出现异常", e);
            throw new ReportException(e.getMessage());
        }
    }

    @Override
    protected int generateHead(Sheet sheet, int rowIndex) throws ReportException {
        try {
            List<Map<String, String>> headers = purchaseOrderReportHeader();
            String mainTitle = "采购单报表";
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
                    PurchaseOrderDto dto = (PurchaseOrderDto) dataList.get(i);
                    Row row = sheet.createRow(rowIndex);
                    addCell(row, 0, i + 1);
                    addCell(row, 1, dto.getPurchaseOrderNo());
                    addCell(row, 2, dto.getStoreName());
                    addCell(row, 3, dto.getStoreCode());
                    addCell(row, 4, dto.getPurchaseCount());
                    addCell(row, 5, ArithUtils.convertToYuanStr(dto.getPurchaseAmount()));
                    PurchaseOrderAddressDto purchaseOrderAddressDto = dto.getPurchaseOrderAddressDto();
                    String addressDetail = "";
                    String phoneNo = "";
                    if (null != purchaseOrderAddressDto) {
                        addressDetail = purchaseOrderAddressDto.getAddressDetail();
                        phoneNo = purchaseOrderAddressDto.getPhoneNo();
                    }
                    addCell(row, 6, addressDetail);
                    addCell(row, 7, phoneNo);
                    String createTime = "";
                    String auditTime = "";
                    if (null != dto.getCreateTime()) {
                        createTime = DateUtils.formatDateLong(dto.getCreateTime());
                    }
                    if (null != dto.getAuditTime()) {
                        auditTime = DateUtils.formatDateLong(dto.getAuditTime());
                    }
                    String orderStatusName = SystemBasicDataUtils.getSystemDictName(
                            SystemContext.OrderDomain.DictType.PURCHASEORDERSTATUS.getValue(), dto.getOrderStatus());
                    addCell(row, 8, createTime);
                    addCell(row, 9, auditTime);
                    addCell(row, 10, orderStatusName);
                    rowIndex++;
                }
            }
            return rowIndex;
        } catch (Exception e) {
            throw new ReportException("生成Excel主体数据信息出现异常：" + e.getMessage());
        }
    }

    private static List<Map<String, String>> purchaseOrderReportHeader() {
        List<Map<String, String>> headers = new ArrayList<Map<String, String>>();
        Map<String, String> map = new HashMap<String, String>();
        map.put("header", "序号");
        map.put("width", "8");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "采购单编号");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "微仓名称");
        map.put("width", "20");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "微仓编号");
        map.put("width", "20");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "采购数量");
        map.put("width", "15");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "采购金额");
        map.put("width", "20");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "收货人地址");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "收货人手机号");
        map.put("width", "25");
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

    public IPurchaseOrderService getPurchaseOrderServiceHessian() {
        return purchaseOrderServiceHessian;
    }

    public void setPurchaseOrderServiceHessian(IPurchaseOrderService purchaseOrderServiceHessian) {
        this.purchaseOrderServiceHessian = purchaseOrderServiceHessian;
    }
}
