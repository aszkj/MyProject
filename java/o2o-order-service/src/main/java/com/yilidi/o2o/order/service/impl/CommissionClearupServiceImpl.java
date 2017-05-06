/**
 * 文件名称：CommissionClearupService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service.impl;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.dao.CommissionClearupMapper;
import com.yilidi.o2o.order.model.result.CommissionReport;
import com.yilidi.o2o.order.service.ICommissionClearupService;
import com.yilidi.o2o.order.service.dto.CommissionClearupReportDto;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.proxy.ICustomerProxyService;
import com.yilidi.o2o.user.proxy.dto.CustomerProxyDto;

/**
 * 功能描述：佣金结算服务层实现类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("commissionClearupService")
public class CommissionClearupServiceImpl extends BasicDataService implements ICommissionClearupService {

    @Autowired
    private CommissionClearupMapper commissionClearupMapper;

    @Autowired
    private ICustomerProxyService customerProxyService;

    @Override
    public List<CommissionClearupReportDto> listClearupMonthly(String statusCode, Integer providerId, Integer year,
            Integer month) throws OrderServiceException {

        logger.debug("CommissionClearupService.listClearupMonthly => 参数信息：[statusCode:" + statusCode + ", providerId:"
                + providerId + ", year:" + year + ", month:" + month + "]");

        Date startDate = null;
        Date endDate = null;
        if ((!ObjectUtils.isNullOrEmpty(year) && (year > 0)) && (!ObjectUtils.isNullOrEmpty(month) && (month > 0))) {
            StringBuffer sb = new StringBuffer();
            sb.append(year + "-" + month + "-");
            try {
                startDate = DateUtils.parseDate(sb.toString() + "00 00:00:00");
                int days = DateUtils.getMonthLastDay(year, month);
                endDate = DateUtils.parseDate(sb.toString() + days + " 23:59:59");
                return this.getReportDto(statusCode, providerId, startDate, endDate);
            } catch (ParseException e) {
                logger.error("CommissionClearupService.listClearupMonthly => 日期转换异常");
                throw new OrderServiceException("日期转换异常");
            }

        } else {
            logger.error("CommissionClearupService.listClearupMonthly => 传入的结算日期异常，不能为null或小于0");
            throw new OrderServiceException("传入的结算日期异常，不能为null或小于0");
        }

    }

    @Override
    public List<CommissionClearupReportDto> listClearupSingly(Integer providerId, Date startDate, Date endDate)
            throws OrderServiceException {
        logger.debug("CommissionClearupService.listClearupSingly => 参数信息：[providerId:" + providerId + ", startDate:"
                + startDate + ", endDate:" + endDate + "] ");
        return this.getReportDto(null, providerId, startDate, endDate);
    }

    /**
     * 获取dto
     * 
     * @param statusCode
     *            结算状态
     * @param providerId
     *            供应商id
     * @param startDate
     *            开始时间
     * @param endDate
     *            结束时间
     * @return 佣金结算结果列表
     * @throws OrderServiceException
     *             异常
     */
    private List<CommissionClearupReportDto> getReportDto(String statusCode, Integer storeId, 
            Date startDate, Date endDate)
            throws OrderServiceException {

        List<CommissionClearupReportDto> dtoList = new ArrayList<CommissionClearupReportDto>();

        try {
            List<CommissionReport> rptList = commissionClearupMapper.listClearupReport(statusCode, storeId, startDate,
                    endDate);
            if (!ObjectUtils.isNullOrEmpty(rptList)) {
                for (CommissionReport rpt : rptList) {
                    CommissionClearupReportDto dto = new CommissionClearupReportDto();

                    CustomerProxyDto customer = customerProxyService.loadCustomerInfoById(rpt.getProviderId());
                    if (ObjectUtils.isNullOrEmpty(customer)) {
                        String msg = "获取客户信息异常  => 客户id[" + rpt.getProviderId() + "]对应记录不存在";
                        logger.error(msg);
                        throw new OrderServiceException(msg);
                    }

                    dto.setAccountBalance(customer.getAccountBalance());
                    dto.setCustomerName(customer.getCustomerName());
                    dto.setMasterName(customer.getMasterName());
                    dto.setStoreId(storeId);
                    dto.setRate(customer.getRate());
                    dto.setUserName(customer.getMasterUserName());
                    dto.setCommissionAmount(customer.getRate() * rpt.getSaleAmount());
                    dto.setSaleAmount(rpt.getSaleAmount());
                    dto.setSaleOrderCount(rpt.getSaleOrderCount());
                    dto.setStatusCode(rpt.getStatusCode());

                    dtoList.add(dto);
                }
                return dtoList;
            }
        } catch (UserServiceException e) {
            logger.error(e);
            throw new OrderServiceException(e);
        }

        return null;
    }

}
