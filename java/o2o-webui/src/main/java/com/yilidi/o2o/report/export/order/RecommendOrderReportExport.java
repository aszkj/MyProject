package com.yilidi.o2o.report.export.order;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;

import com.yilidi.o2o.core.exception.ReportException;
import com.yilidi.o2o.core.report.AbstractExportReport;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.service.IOrderService;
import com.yilidi.o2o.order.service.dto.RecommendOrderInfoDto;
import com.yilidi.o2o.order.service.dto.query.RecommendOrderInfoQueryDto;

/**
 * 推荐订单相关信息报表导出
 * 
 * @author: chenlian
 * @date: 2016年8月12日 上午5:21:35
 */
public class RecommendOrderReportExport extends AbstractExportReport {

    protected Logger logger = Logger.getLogger(this.getClass());

    private IOrderService orderServiceHessian;

    public RecommendOrderReportExport() {
        super.reportIndividualRelativePath = "/recommendorder";
    }

    @Override
    protected Long obtainDataCount(Object searchArgument) throws ReportException {
        try {
            RecommendOrderInfoQueryDto recommendOrderInfoQueryDto = (RecommendOrderInfoQueryDto) searchArgument;
            if (!StringUtils.isEmpty(recommendOrderInfoQueryDto.getStartRegisterTime())) {
                recommendOrderInfoQueryDto.setStartRegisterDate(DateUtils.getSpecificStartDate(recommendOrderInfoQueryDto
                        .getStartRegisterTime()));
            }
            if (!StringUtils.isEmpty(recommendOrderInfoQueryDto.getEndRegisterTime())) {
                recommendOrderInfoQueryDto.setEndRegisterDate(DateUtils.getSpecificEndDate(recommendOrderInfoQueryDto
                        .getEndRegisterTime()));
            }
            return orderServiceHessian.getCountsForExportRecommendOrder(recommendOrderInfoQueryDto);
        } catch (Exception e) {
            logger.error("获取需导出的总记录数出现异常", e);
            throw new ReportException(e.getMessage());
        }
    }

    @Override
    protected List<?> obtainDataList(Object searchArgument, Long startLineNum, Integer pageSize) throws ReportException {
        try {
            RecommendOrderInfoQueryDto recommendOrderInfoQueryDto = (RecommendOrderInfoQueryDto) searchArgument;
            if (!StringUtils.isEmpty(recommendOrderInfoQueryDto.getStartRegisterTime())) {
                recommendOrderInfoQueryDto.setStartRegisterDate(DateUtils.getSpecificStartDate(recommendOrderInfoQueryDto
                        .getStartRegisterTime()));
            }
            if (!StringUtils.isEmpty(recommendOrderInfoQueryDto.getEndRegisterTime())) {
                recommendOrderInfoQueryDto.setEndRegisterDate(DateUtils.getSpecificEndDate(recommendOrderInfoQueryDto
                        .getEndRegisterTime()));
            }
            return orderServiceHessian.listDataForExportRecommendOrder(recommendOrderInfoQueryDto, startLineNum, pageSize);
        } catch (Exception e) {
            logger.error("获取导出数据的List出现异常", e);
            throw new ReportException(e.getMessage());
        }
    }

    @Override
    protected int generateHead(Sheet sheet, int rowIndex) throws ReportException {
        try {
            List<Map<String, String>> headers = OrderReportHeader();
            String mainTitle = "推广佣金结算报表";
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
                    RecommendOrderInfoDto dto = (RecommendOrderInfoDto) dataList.get(i);
                    Row row = sheet.createRow(rowIndex);
                    addCell(row, 0, i + 1);
                    addCell(row, 1, dto.getRecommendRealName());
                    addCell(row, 2, dto.getRecommendMobile());
                    addCell(row, 3, dto.getInvitationCode());
                    addCell(row, 4, dto.getBuyerMobile());
                    addCell(row, 5, dto.getBuyerRegisterTime() == null ? "---" : dto.getBuyerRegisterTime());
                    addCell(row, 6, dto.getSaleOrderNo());
                    addCell(row, 7, ArithUtils.div(dto.getSaleOrderAmount(), StringUtils.BASE_AMOUNT, 3));
                    addCell(row, 8, dto.getSaleOrderStatusName());
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
        map.put("header", "推广人");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "手机号码");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "推荐码");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "用户手机号");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "注册时间");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "订单编号");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "订单金额(元)");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "订单状态");
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
