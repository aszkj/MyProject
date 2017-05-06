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
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.UserDto;
import com.yilidi.o2o.user.service.dto.query.UserQuery;

/**
 * @Description:TODO(买家用户导出数据报表)
 * @author: llp
 * @date: 2015年12月1日 上午11:43:31
 * 
 */
public class BuyerUserReportExport extends AbstractExportReport {

    protected Logger logger = Logger.getLogger(this.getClass());

    /**
     * 利用hessian协议的远程IUserService接口（适用于大数据量，传输文件等的场景， 短连接）
     */
    private IUserService userServiceHessian;

    /**
     * 获取SYSTEM_DICT字典表CODE的名称，工具类
     */
    private SystemBasicDataInfoUtils systemBasicDataInfoUtils;

    public BuyerUserReportExport() {
        super.reportIndividualRelativePath = "/user";
    }

    @Override
    protected Long obtainDataCount(Object searchArgument) throws ReportException {
        try {
            UserQuery userQuery = (UserQuery) searchArgument;
            return userServiceHessian.getCountsForExportBuyerUser(userQuery);
        } catch (UserServiceException e) {
            logger.error("获取需导出的总记录数出现异常", e);
            throw new ReportException(e.getMessage());
        }
    }

    @Override
    protected List<?> obtainDataList(Object searchArgument, Long startLineNum, Integer pageSize) throws ReportException {
        try {
            UserQuery userQuery = (UserQuery) searchArgument;
            return userServiceHessian.listDataForExportBuyerUser(userQuery, startLineNum, pageSize);
        } catch (UserServiceException e) {
            logger.error("获取导出数据的List出现异常", e);
            throw new ReportException(e.getMessage());
        }
    }

    @Override
    protected int generateHead(Sheet sheet, int rowIndex) throws ReportException {
        try {
            List<Map<String, String>> headers = userReportHeader();
            String mainTitle = "买家用户统计报表";
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
                for (UserDto uDto : (List<UserDto>) dataList) {
                    Row row = sheet.createRow(rowIndex);
                    addCell(row, 0, rowIndex - 1);
                    addCell(row, 1, uDto.getUserName());
                    addCell(row, 2, uDto.getPhone());
                    addCell(row, 3, uDto.getEmail());
                    addCell(row,
                            4,
                            systemBasicDataInfoUtils.getSystemDictName(
                                    SystemContext.UserDomain.DictType.BUYERLEVEL.getValue(), uDto.getBuyerLevelCode()));
                    addCell(row, 5, uDto.getCreateTime());
                    addCell(row, 6, null == uDto.getVipCreateTime() ? "" : uDto.getVipCreateTime());
                    addCell(row, 7, null == uDto.getVipExpireDate() ? "" : uDto.getVipExpireDate());
                    addCell(row,
                            8,
                            systemBasicDataInfoUtils.getSystemDictName(
                                    SystemContext.UserDomain.DictType.CHANNELTYPE.getValue(), uDto.getRegisterPlatform()));
                    addCell(row,
                            9,
                            systemBasicDataInfoUtils.getSystemDictName(
                                    SystemContext.UserDomain.DictType.USERSTATUS.getValue(), uDto.getStatusCode()));
                    rowIndex++;
                }
            }
            return rowIndex;
        } catch (Exception e) {
            throw new ReportException("生成Excel主体数据信息出现异常：" + e.getMessage());
        }
    }

    public static List<Map<String, String>> userReportHeader() {
        List<Map<String, String>> headers = new ArrayList<Map<String, String>>();
        Map<String, String> map = new HashMap<String, String>();

        map.put("header", "客户ID");
        map.put("width", "8");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "用户名");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "手机号码");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "用户邮箱");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "用户类型");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "创建时间");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "会员开通时间");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "会员到期时间");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "注册平台");
        map.put("width", "25");
        headers.add(map);

        map = new HashMap<String, String>();
        map.put("header", "状态");
        map.put("width", "25");
        headers.add(map);

        return headers;
    }

    public IUserService getUserServiceHessian() {
        return userServiceHessian;
    }

    public void setUserServiceHessian(IUserService userServiceHessian) {
        this.userServiceHessian = userServiceHessian;
    }

    public SystemBasicDataInfoUtils getSystemBasicDataInfoUtils() {
        return systemBasicDataInfoUtils;
    }

    public void setSystemBasicDataInfoUtils(SystemBasicDataInfoUtils systemBasicDataInfoUtils) {
        this.systemBasicDataInfoUtils = systemBasicDataInfoUtils;
    }

}
