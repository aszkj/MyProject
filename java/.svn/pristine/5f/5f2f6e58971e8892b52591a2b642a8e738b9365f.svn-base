package com.yilidi.o2o.order.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.DBTablesColumnsName;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.exception.ReportException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.core.utils.SystemBasicDataUtils;
import com.yilidi.o2o.order.dao.PayLogMapper;
import com.yilidi.o2o.order.model.PayLog;
import com.yilidi.o2o.order.model.query.PayLogQuery;
import com.yilidi.o2o.order.model.result.PayLogInfo;
import com.yilidi.o2o.order.service.IPayLogService;
import com.yilidi.o2o.order.service.dto.PayLogDto;
import com.yilidi.o2o.order.service.dto.query.PayLogQueryDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 支付日志服务实现类
 * 
 * @author simpson
 * 
 */
@Service("payLogService")
public class PayLogServiceImpl extends BasicDataService implements IPayLogService {

    @Autowired
    private PayLogMapper payLogMapper;

    private static final String PAYLOG_DTO_EMPTY = "支付日志信息不能为空";
    private static final String PAYLOG_ORDERNO_EMPTY = "支付日志编码不能为空";
    private static final String SALE_ORDERNO_EMPTY = "订单编码不能为空";
    private static final String UPDATE_PAYLOG_ERROR = "更新支付日志信息失败";
    private static final String STARTTIME = StringUtils.STARTTIMESTRING;
    private static final String ENDTIME = StringUtils.ENDTIMESTRING;

    @Override
    public PayLogDto savePayLog(PayLogDto payLogDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(payLogDto)) {
                throw new OrderServiceException(PAYLOG_DTO_EMPTY);
            }
            PayLog payLog = new PayLog();
            ObjectUtils.fastCopy(payLogDto, payLog);
            Date nowDate = new Date();
            payLog.setPayLogOrderNo(StringUtils.generatePayLogOrderNo());
            payLog.setCreateTime(nowDate);
            Integer effectCount = payLogMapper.save(payLog);
            if (1 != effectCount) {
                throw new OrderServiceException("保存支付日志信息失败");
            }
            payLogDto.setId(payLog.getId());
            payLogDto.setCreateTime(nowDate);
            payLogDto.setPayLogOrderNo(payLog.getPayLogOrderNo());
            return payLogDto;
        } catch (Exception e) {
            logger.error("savePayLog异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updatePayLogForMakeOrder(PayLogDto payLogDto, String payLogOrderNo) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(payLogDto)) {
                throw new OrderServiceException(PAYLOG_DTO_EMPTY);
            }
            if (ObjectUtils.isNullOrEmpty(payLogOrderNo)) {
                throw new OrderServiceException(PAYLOG_ORDERNO_EMPTY);
            }
            PayLog payLog = new PayLog();
            ObjectUtils.fastCopy(payLogDto, payLog);
            Date nowDate = new Date();
            if (ObjectUtils.isNullOrEmpty(payLogDto.getUpdateTime())) {
                payLog.setUpdateTime(nowDate);
            }
            Integer effectCount = payLogMapper.updatePayLogByPayLogOrderNoAndStatus(payLog, payLogOrderNo,
                    SystemContext.OrderDomain.PAYLOGSTATUS_INIT);
            if (1 != effectCount) {
                throw new OrderServiceException(UPDATE_PAYLOG_ERROR);
            }
        } catch (Exception e) {
            logger.error("updatePayLogForMakeOrder异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updatePayLogForNotify(PayLogDto payLogDto, String payLogOrderNo) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(payLogDto)) {
                throw new OrderServiceException(PAYLOG_DTO_EMPTY);
            }
            if (ObjectUtils.isNullOrEmpty(payLogOrderNo) || ObjectUtils.isNullOrEmpty(payLogDto.getPayLogStatus())
                    || ObjectUtils.isNullOrEmpty(payLogDto.getPaySequence())
                    || ObjectUtils.isNullOrEmpty(payLogDto.getPayerId())) {
                throw new OrderServiceException("更新内容不能为空");
            }
            PayLog payLog = new PayLog();
            ObjectUtils.fastCopy(payLogDto, payLog);
            Date nowDate = new Date();
            if (ObjectUtils.isNullOrEmpty(payLogDto.getUpdateTime())) {
                payLog.setUpdateTime(nowDate);
            }
            Integer effectCount = payLogMapper.updatePayLogByPayLogOrderNoAndStatus(payLog, payLogOrderNo,
                    SystemContext.OrderDomain.PAYLOGSTATUS_INIT);
            if (1 != effectCount) {
                throw new OrderServiceException(UPDATE_PAYLOG_ERROR);
            }
        } catch (Exception e) {
            logger.error("updatePayLogForNotify异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    private PayLogDto fillPayLogDto(PayLog payLog) {
        PayLogDto payLogDto = new PayLogDto();
        ObjectUtils.fastCopy(payLog, payLogDto);
        String payLogStatusName = SystemBasicDataUtils
                .getSystemDictName(SystemContext.OrderDomain.DictType.PAYLOGSTATUS.getValue(), payLogDto.getPayLogStatus());
        payLogDto.setPayLogStatusName(payLogStatusName);
        String payPlatformCodeName = SystemBasicDataUtils.getSystemDictName(
                SystemContext.OrderDomain.DictType.SALEORDERPAYPLATFORM.getValue(), payLogDto.getPayPlatformCode());
        payLogDto.setPayPlatformCodeName(payPlatformCodeName);
        String operUserTypeName = SystemBasicDataUtils.getSystemDictName(
                SystemContext.OrderDomain.DictType.PAYLOGOPERUSERTYPE.getValue(), payLogDto.getOperUserType());
        payLogDto.setOperUserTypeName(operUserTypeName);
        return payLogDto;
    }

    @Override
    public YiLiDiPage<PayLogDto> findPayLogs(PayLogQueryDto payLogQueryDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(payLogQueryDto)) {
                throw new OrderServiceException("查询条件不能为空");
            }
            if (!ObjectUtils.isNullOrEmpty(payLogQueryDto.getStrBeginCreateTime())) {
                Date beginCreateTime = DateUtils.parseDate(payLogQueryDto.getStrBeginCreateTime() + STARTTIME);
                payLogQueryDto.setBeginCreateTime(beginCreateTime);
            }
            if (!ObjectUtils.isNullOrEmpty(payLogQueryDto.getStrEndCreateTime())) {
                Date endCreateTime = DateUtils.parseDate(payLogQueryDto.getStrEndCreateTime() + ENDTIME);
                payLogQueryDto.setEndCreateTime(endCreateTime);
            }
            if (!ObjectUtils.isNullOrEmpty(payLogQueryDto.getStrBeginUpdateTime())) {
                Date beginUpdateeTime = DateUtils.parseDate(payLogQueryDto.getStrBeginUpdateTime() + STARTTIME);
                payLogQueryDto.setBeginUpdateTime(beginUpdateeTime);
            }
            if (!ObjectUtils.isNullOrEmpty(payLogQueryDto.getStrEndUpdateTime())) {
                Date endUpdateeTime = DateUtils.parseDate(payLogQueryDto.getStrEndUpdateTime() + ENDTIME);
                payLogQueryDto.setEndUpdateTime(endUpdateeTime);
            }
            payLogQueryDto.setOrder(DBTablesColumnsName.PayLog.CREATETIME);
            payLogQueryDto.setSort(CommonConstants.SORT_ORDER_DESC + " ," + DBTablesColumnsName.PayLog.UPDATETIME + " "
                    + CommonConstants.SORT_ORDER_DESC);
            PayLogQuery payLogQuery = new PayLogQuery();
            ObjectUtils.fastCopy(payLogQueryDto, payLogQuery);
            PageHelper.startPage(payLogQuery.getStart(), payLogQuery.getPageSize());
            Page<PayLogInfo> payLogPages = payLogMapper.findPayLogs(payLogQuery);
            Page<PayLogDto> pageDto = new Page<PayLogDto>(payLogQueryDto.getStart(), payLogQueryDto.getPageSize());
            ObjectUtils.fastCopy(payLogPages, pageDto);
            List<PayLogInfo> payLogs = payLogPages.getResult();
            if (!ObjectUtils.isNullOrEmpty(payLogs)) {
                for (PayLogInfo payLog : payLogs) {
                    PayLogDto payLogDto = new PayLogDto();
                    ObjectUtils.fastCopy(payLog, payLogDto);
                    String payLogStatusName = SystemBasicDataUtils.getSystemDictName(
                            SystemContext.OrderDomain.DictType.PAYLOGSTATUS.getValue(), payLogDto.getPayLogStatus());
                    payLogDto.setPayLogStatusName(payLogStatusName);
                    String payPlatformCodeName = SystemBasicDataUtils.getSystemDictName(
                            SystemContext.OrderDomain.DictType.SALEORDERPAYPLATFORM.getValue(),
                            payLogDto.getPayPlatformCode());
                    payLogDto.setPayPlatformCodeName(payPlatformCodeName);
                    String operUserTypeName = SystemBasicDataUtils.getSystemDictName(
                            SystemContext.OrderDomain.DictType.PAYLOGOPERUSERTYPE.getValue(), payLogDto.getOperUserType());
                    payLogDto.setOperUserTypeName(operUserTypeName);
                    pageDto.add(payLogDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findPayLogs异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<PayLogDto> listPayLogs(String saleOrderNo) throws OrderServiceException {
        try {
            if (StringUtils.isBlank(saleOrderNo)) {
                throw new OrderServiceException(SALE_ORDERNO_EMPTY);
            }
            List<PayLog> payLogs = payLogMapper.listInitPayLogs(saleOrderNo, SystemContext.OrderDomain.PAYLOGTYPE_PAY,
                    SystemContext.OrderDomain.PAYLOGSTATUS_INIT);
            if (ObjectUtils.isNullOrEmpty(payLogs)) {
                return null;
            }
            List<PayLogDto> payLogDtos = new ArrayList<PayLogDto>();
            for (PayLog payLog : payLogs) {
                payLogDtos.add(fillPayLogDto(payLog));
            }
            return payLogDtos;
        } catch (Exception e) {
            logger.error("listPayLogs异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public PayLogDto loadByPayLogOrderNo(String payLogOrderNo) throws OrderServiceException {
        try {
            if (StringUtils.isBlank(payLogOrderNo)) {
                throw new OrderServiceException(PAYLOG_ORDERNO_EMPTY);
            }
            PayLog payLog = payLogMapper.loadByPayLogOrderNo(payLogOrderNo);
            if (ObjectUtils.isNullOrEmpty(payLog)) {
                return null;
            }
            return fillPayLogDto(payLog);
        } catch (Exception e) {
            logger.error("loadByPayLogOrderNo异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public PayLogDto loadPaidBySaleOrderNo(String saleOrderNo) throws OrderServiceException {
        try {
            if (StringUtils.isBlank(saleOrderNo)) {
                throw new OrderServiceException(SALE_ORDERNO_EMPTY);
            }
            PayLog payLog = payLogMapper.loadBySaleOrderNo(saleOrderNo, SystemContext.OrderDomain.PAYLOGTYPE_PAY,
                    SystemContext.OrderDomain.PAYLOGSTATUS_PAYSECCEED);
            if (ObjectUtils.isNullOrEmpty(payLog)) {
                return null;
            }
            return fillPayLogDto(payLog);
        } catch (Exception e) {
            logger.error("loadPaidBySaleOrderNo异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public Long getCountsForExportPayLog(PayLogQueryDto payLogQueryDto) throws ReportException {
        try {
            if (!ObjectUtils.isNullOrEmpty(payLogQueryDto.getStrBeginCreateTime())) {
                Date beginCreateTime = DateUtils.parseDate(payLogQueryDto.getStrBeginCreateTime() + STARTTIME);
                payLogQueryDto.setBeginCreateTime(beginCreateTime);
            }
            if (!ObjectUtils.isNullOrEmpty(payLogQueryDto.getStrEndCreateTime())) {
                Date endCreateTime = DateUtils.parseDate(payLogQueryDto.getStrEndCreateTime() + ENDTIME);
                payLogQueryDto.setEndCreateTime(endCreateTime);
            }
            if (!ObjectUtils.isNullOrEmpty(payLogQueryDto.getStrBeginUpdateTime())) {
                Date beginUpdateeTime = DateUtils.parseDate(payLogQueryDto.getStrBeginUpdateTime() + STARTTIME);
                payLogQueryDto.setBeginUpdateTime(beginUpdateeTime);
            }
            if (!ObjectUtils.isNullOrEmpty(payLogQueryDto.getStrEndUpdateTime())) {
                Date endUpdateeTime = DateUtils.parseDate(payLogQueryDto.getStrEndUpdateTime() + ENDTIME);
                payLogQueryDto.setEndUpdateTime(endUpdateeTime);
            }
            PayLogQuery payLogQuery = new PayLogQuery();
            ObjectUtils.fastCopy(payLogQueryDto, payLogQuery);
            Long counts = this.payLogMapper.getCountsForExportPayLog(payLogQuery);
            return counts;
        } catch (Exception e) {
            logger.error("getCountsForExportPayLog异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<PayLogDto> listDataForExportPayLog(PayLogQueryDto payLogQueryDto, Long startLineNum, Integer pageSize)
            throws OrderServiceException {
        try {
            if (!ObjectUtils.isNullOrEmpty(payLogQueryDto.getStrBeginCreateTime())) {
                Date beginCreateTime = DateUtils.parseDate(payLogQueryDto.getStrBeginCreateTime() + STARTTIME);
                payLogQueryDto.setBeginCreateTime(beginCreateTime);
            }
            if (!ObjectUtils.isNullOrEmpty(payLogQueryDto.getStrEndCreateTime())) {
                Date endCreateTime = DateUtils.parseDate(payLogQueryDto.getStrEndCreateTime() + ENDTIME);
                payLogQueryDto.setEndCreateTime(endCreateTime);
            }
            if (!ObjectUtils.isNullOrEmpty(payLogQueryDto.getStrBeginUpdateTime())) {
                Date beginUpdateeTime = DateUtils.parseDate(payLogQueryDto.getStrBeginUpdateTime() + STARTTIME);
                payLogQueryDto.setBeginUpdateTime(beginUpdateeTime);
            }
            if (!ObjectUtils.isNullOrEmpty(payLogQueryDto.getStrEndUpdateTime())) {
                Date endUpdateeTime = DateUtils.parseDate(payLogQueryDto.getStrEndUpdateTime() + ENDTIME);
                payLogQueryDto.setEndUpdateTime(endUpdateeTime);
            }
            payLogQueryDto.setOrder(DBTablesColumnsName.PayLog.CREATETIME);
            payLogQueryDto.setSort(CommonConstants.SORT_ORDER_DESC + " ," + DBTablesColumnsName.PayLog.UPDATETIME + " "
                    + CommonConstants.SORT_ORDER_DESC);
            PayLogQuery payLogQuery = new PayLogQuery();
            ObjectUtils.fastCopy(payLogQueryDto, payLogQuery);
            List<PayLogInfo> PayLogs = payLogMapper.listDataForExportOnlinePayLog(payLogQuery, startLineNum, pageSize);
            List<PayLogDto> PayLogDtos = new ArrayList<PayLogDto>();
            ObjectUtils.fastCopy(PayLogs, PayLogDtos);
            if (!ObjectUtils.isNullOrEmpty(PayLogs)) {
                for (PayLogInfo payLog : PayLogs) {
                    PayLogDto payLogDto = new PayLogDto();
                    ObjectUtils.fastCopy(payLog, payLogDto);
                    String payLogStatusName = SystemBasicDataUtils.getSystemDictName(
                            SystemContext.OrderDomain.DictType.PAYLOGSTATUS.getValue(), payLogDto.getPayLogStatus());
                    payLogDto.setPayLogStatusName(payLogStatusName);
                    String payPlatformCodeName = SystemBasicDataUtils.getSystemDictName(
                            SystemContext.OrderDomain.DictType.SALEORDERPAYPLATFORM.getValue(),
                            payLogDto.getPayPlatformCode());
                    payLogDto.setPayPlatformCodeName(payPlatformCodeName);
                    String operUserTypeName = SystemBasicDataUtils.getSystemDictName(
                            SystemContext.OrderDomain.DictType.PAYLOGOPERUSERTYPE.getValue(), payLogDto.getOperUserType());
                    payLogDto.setOperUserTypeName(operUserTypeName);
                    PayLogDtos.add(payLogDto);
                }
            }
            return PayLogDtos;
        } catch (Exception e) {
            logger.error("listDataForExportPayLog异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

}
