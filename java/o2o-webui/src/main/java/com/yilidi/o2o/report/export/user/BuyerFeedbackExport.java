package com.yilidi.o2o.report.export.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;

import com.yilidi.o2o.common.utils.SystemBasicDataInfoUtils;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ReportException;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.report.AbstractExportReport;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.user.service.IBuyerFeedbackService;
import com.yilidi.o2o.user.service.dto.BuyerFeedbackDto;
import com.yilidi.o2o.user.service.dto.query.BuyerFeedbackQueryDto;

/**
 * @Description:TODO(用户提现申请记录报表导出)
 * @author: llp
 * @date: 2015年11月27日 下午5:15:26
 *
 */
public class BuyerFeedbackExport extends AbstractExportReport {

    protected Logger logger = Logger.getLogger(this.getClass());

    private IBuyerFeedbackService buyerFeedbackServiceHessian;

    /**
     * 获取SYSTEM_DICT字典表CODE的名称，工具类
     */
    private SystemBasicDataInfoUtils systemBasicDataInfoUtils;

    public BuyerFeedbackExport() {
        super.reportIndividualRelativePath = "/feedback";
    }

    @Override
    protected Long obtainDataCount(Object searchArgument) throws ReportException {
        try {
            BuyerFeedbackQueryDto buyerFeedbackQueryDto = (BuyerFeedbackQueryDto) searchArgument;
            return buyerFeedbackServiceHessian.getCountsForExportBuyerFeedback(buyerFeedbackQueryDto);
        } catch (UserServiceException e) {
            logger.error("获取需导出的总记录数出现异常", e);
            throw new ReportException(e.getMessage());
        }
    }

    @Override
    protected List<?> obtainDataList(Object searchArgument, Long startLineNum, Integer pageSize) throws ReportException {
        try {
            BuyerFeedbackQueryDto buyerFeedbackQueryDto = (BuyerFeedbackQueryDto) searchArgument;
            return buyerFeedbackServiceHessian.listDataForExportBuyerFeedback(buyerFeedbackQueryDto, startLineNum, pageSize);
        } catch (UserServiceException e) {
            logger.error("获取导出数据的List出现异常", e);
            throw new ReportException(e.getMessage());
        }
    }

    @Override
    protected int generateHead(Sheet sheet, int rowIndex) throws ReportException {
        try {
            List<Map<String, String>> headers = withdrawReportHeader();
            String mainTitle = "买家反馈表";
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
                String[] contentClassifys = null;
                for (BuyerFeedbackDto buyerFeedbackDto : (List<BuyerFeedbackDto>) dataList) {
                    Row row = sheet.createRow(rowIndex);
                    addCell(row, 0, rowIndex - 1);
                    addCell(row, 1, buyerFeedbackDto.getUserMobile());
                    addCell(row, 2, buyerFeedbackDto.getSubmitTime());
                    addCell(row, 3, buyerFeedbackDto.getContent());
                    addCell(row, 4,
                            systemBasicDataInfoUtils.getSystemDictName(
                                    SystemContext.UserDomain.DictType.FEEDBACKSTATIS.getValue(),
                                    buyerFeedbackDto.getOperateStatus()));
                    addCell(row, 5, buyerFeedbackDto.getOperateTime());
                    addCell(row, 6, buyerFeedbackDto.getOperateName());
                    if (!StringUtils.isEmpty(buyerFeedbackDto.getContentClassify())) {
                        contentClassifys = buyerFeedbackDto.getContentClassify().split(",");
                        StringBuilder contentClassifyStr = new StringBuilder("");
                        for (String contentClassify : contentClassifys) {
                            contentClassifyStr.append(systemBasicDataInfoUtils.getSystemDictName(
                                    SystemContext.UserDomain.DictType.FEEDBACKTYPE.getValue(), contentClassify) + " ");
                        }
                        addCell(row, 7, contentClassifyStr.toString());
                    } else {
                        addCell(row, 7, "");
                    }
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
        map.put("width", "10");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "用户手机号");
        map.put("width", "30");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "提交时间");
        map.put("width", "30");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "内容");
        map.put("width", "30");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "处理状态");
        map.put("width", "30");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "处理时间");
        map.put("width", "30");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "处理人");
        map.put("width", "30");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "内容归类");
        map.put("width", "50");
        headers.add(map);

        return headers;
    }

    public IBuyerFeedbackService getBuyerFeedbackServiceHessian() {
        return buyerFeedbackServiceHessian;
    }

    public void setBuyerFeedbackServiceHessian(IBuyerFeedbackService buyerFeedbackServiceHessian) {
        this.buyerFeedbackServiceHessian = buyerFeedbackServiceHessian;
    }

    public SystemBasicDataInfoUtils getSystemBasicDataInfoUtils() {
        return systemBasicDataInfoUtils;
    }

    public void setSystemBasicDataInfoUtils(SystemBasicDataInfoUtils systemBasicDataInfoUtils) {
        this.systemBasicDataInfoUtils = systemBasicDataInfoUtils;
    }

}
