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
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.user.service.ICommunityService;
import com.yilidi.o2o.user.service.dto.CommunityStoreRelatedDto;
import com.yilidi.o2o.user.service.dto.query.CommunityStoreRelatedQuery;

/**
 * 商家导出
 * 
 * @author: chenlian
 * @date: 2016年7月5日 上午9:57:07
 */
public class StoreReportExport extends AbstractExportReport {

    protected Logger logger = Logger.getLogger(this.getClass());

    private ICommunityService communityServiceHessian;

    public StoreReportExport() {
        super.reportIndividualRelativePath = "/store";
    }

    @Override
    protected Long obtainDataCount(Object searchArgument) throws ReportException {
        try {
            CommunityStoreRelatedQuery communityStoreRelatedQuery = (CommunityStoreRelatedQuery) searchArgument;
            return communityServiceHessian.getCountsForExportStore(communityStoreRelatedQuery);
        } catch (UserServiceException e) {
            logger.error("获取需导出的总记录数出现异常", e);
            throw new ReportException(e.getMessage());
        }
    }

    @Override
    protected List<?> obtainDataList(Object searchArgument, Long startLineNum, Integer pageSize) throws ReportException {
        try {
            CommunityStoreRelatedQuery communityStoreRelatedQuery = (CommunityStoreRelatedQuery) searchArgument;
            return communityServiceHessian.listDataForExportStore(communityStoreRelatedQuery, startLineNum, pageSize);
        } catch (UserServiceException e) {
            logger.error("获取导出数据的List出现异常", e);
            throw new ReportException(e.getMessage());
        }
    }

    @Override
    protected int generateHead(Sheet sheet, int rowIndex) throws ReportException {
        try {
            List<Map<String, String>> headers = StoreReportHeader();
            String mainTitle = "商家信息报表";
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
                    CommunityStoreRelatedDto dto = (CommunityStoreRelatedDto) dataList.get(i);
                    Row row = sheet.createRow(rowIndex);
                    addCell(row, 0, i + 1);
                    addCell(row, 1, dto.getStoreCode());
                    addCell(row, 2, dto.getStoreName());
                    addCell(row, 3, dto.getContact());
                    addCell(row, 4, dto.getStoreTypeName() == null ? "---" : dto.getStoreTypeName());
                    addCell(row, 5, dto.getMobile());
                    addCell(row, 6, dto.getAddressDetail());
                    addCell(row, 7, dto.getCityCode() + "-" + dto.getCountyCode());
                    addCell(row, 8, dto.getStoreStatusName());
                    rowIndex++;
                }
            }
            return rowIndex;
        } catch (Exception e) {
            throw new ReportException("生成Excel主体数据信息出现异常：" + e.getMessage());
        }
    }

    public static List<Map<String, String>> StoreReportHeader() {
        List<Map<String, String>> headers = new ArrayList<Map<String, String>>();
        Map<String, String> map = new HashMap<String, String>();
        map.put("header", "序号");
        map.put("width", "8");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "商家编码");
        map.put("width", "20");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "商家名称");
        map.put("width", "30");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "联系人");
        map.put("width", "30");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "商家类型");
        map.put("width", "20");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "服务热线");
        map.put("width", "20");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "商家地址");
        map.put("width", "50");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "所在地区");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "营业状态");
        map.put("width", "15");
        headers.add(map);

        return headers;
    }

    public ICommunityService getCommunityServiceHessian() {
        return communityServiceHessian;
    }

    public void setCommunityServiceHessian(ICommunityService communityServiceHessian) {
        this.communityServiceHessian = communityServiceHessian;
    }
}
