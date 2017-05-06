package com.yilidi.o2o.order.service.impl;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.dao.RefundApplyHistoryMapper;
import com.yilidi.o2o.order.dao.RefundApplyMapper;
import com.yilidi.o2o.order.model.RefundApply;
import com.yilidi.o2o.order.model.RefundApplyHistory;
import com.yilidi.o2o.order.service.IOrderService;
import com.yilidi.o2o.order.service.IPayLogService;
import com.yilidi.o2o.order.service.IRefundApplyService;
import com.yilidi.o2o.order.service.dto.PayLogDto;
import com.yilidi.o2o.order.service.dto.RefundApplyDto;
import com.yilidi.o2o.order.service.dto.SaleOrderDto;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.proxy.IUserProxyService;
import com.yilidi.o2o.user.proxy.dto.UserProxyDto;

/**
 * 退款申请Service实现
 * 
 * @author: chenlian
 * @date: 2016年6月17日 下午8:47:38
 */
@Service("refundApplyService")
public class RefundApplyServiceImpl extends BasicDataService implements IRefundApplyService {

    @Autowired
    private RefundApplyMapper refundApplyMapper;
    @Autowired
    private RefundApplyHistoryMapper refundApplyHistoryMapper;
    @Autowired
    private IPayLogService payLogService;
    @Autowired
    private IOrderService orderService;
    @Autowired
    private IUserProxyService userProxyService;

    @Override
    public RefundApplyDto loadByOrderNo(String saleOrderNo) throws OrderServiceException {
        try {
            RefundApplyDto refundApplyDto = null;
            RefundApply refundApply = refundApplyMapper.loadByOrderNo(saleOrderNo);
            if (null != refundApply) {
                refundApplyDto = new RefundApplyDto();
                ObjectUtils.fastCopy(refundApply, refundApplyDto);
            }
            return refundApplyDto;
        } catch (Exception e) {
            String msg = "根据订单编号查询退款记录信息出现系统异常";
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    @Override
    public void save(RefundApplyDto refundApplyDto) throws OrderServiceException {
        try {
            if (null != refundApplyDto) {
                RefundApply refundApply = new RefundApply();
                ObjectUtils.fastCopy(refundApplyDto, refundApply);
                refundApplyMapper.save(refundApply);
                RefundApplyHistory refundApplyHistory = new RefundApplyHistory();
                refundApplyHistory.setApplyId(refundApply.getId());
                if (SystemContext.OrderDomain.REFUNDAPPLYSTATUS_REFUNDING.equals(refundApply.getStatusCode())) {
                    refundApplyHistory.setOperateType(SystemContext.OrderDomain.REFUNDAPPLYOPERTYPE_APPLY);
                }
                if (SystemContext.OrderDomain.REFUNDAPPLYSTATUS_SECCEED.equals(refundApply.getStatusCode())) {
                    refundApplyHistory.setOperateType(SystemContext.OrderDomain.REFUNDAPPLYOPERTYPE_RECEIVE);
                }
                ObjectUtils.fastCopy(refundApplyDto, refundApplyHistory);
                refundApplyHistoryMapper.save(refundApplyHistory);
            }
        } catch (Exception e) {
            String msg = "生成退款信息出现系统异常";
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

    @Override
    public void update(String saleOrderNo, String preStatusCode, String statusCode, Date operationTime,
            Integer operationUserId) throws OrderServiceException {
        try {
            int affectedCount = refundApplyMapper.updateByOrderNo(saleOrderNo, preStatusCode, statusCode);
            if (1 != affectedCount) {
                throw new IllegalStateException("当前退款状态不正确，无法更新退款信息");
            }
            RefundApply refundApply = refundApplyMapper.loadByOrderNo(saleOrderNo);
            RefundApplyHistory refundApplyHistory = new RefundApplyHistory();
            refundApplyHistory.setApplyId(refundApply.getId());
            if (SystemContext.OrderDomain.REFUNDAPPLYSTATUS_REFUNDING.equals(refundApply.getStatusCode())) {
                refundApplyHistory.setOperateType(SystemContext.OrderDomain.REFUNDAPPLYOPERTYPE_APPLY);
            }
            if (SystemContext.OrderDomain.REFUNDAPPLYSTATUS_SECCEED.equals(refundApply.getStatusCode())) {
                refundApplyHistory.setOperateType(SystemContext.OrderDomain.REFUNDAPPLYOPERTYPE_RECEIVE);
                // 查询支付成功日志
                PayLogDto payLogDto = payLogService.loadPaidBySaleOrderNo(saleOrderNo);
                if (!ObjectUtils.isNullOrEmpty(payLogDto)) {
                    // 当支付日志不为空时，则需要插入支付退款日志
                    PayLogDto savePayLogDto = new PayLogDto();
                    savePayLogDto.setContent(payLogDto.getContent());
                    savePayLogDto.setPayPlatformCode(payLogDto.getPayPlatformCode());
                    savePayLogDto.setCreateTime(operationTime);
                    savePayLogDto.setCreateUserId(operationUserId);
                    savePayLogDto.setPayLogOrderNo(StringUtils.generatePayLogOrderNo());
                    savePayLogDto.setPayLogType(SystemContext.OrderDomain.PAYLOGTYPE_REFUND);
                    savePayLogDto.setPayPrice(payLogDto.getPayPrice());
                    savePayLogDto.setSaleOrderNo(payLogDto.getSaleOrderNo());
                    savePayLogDto.setUpdateTime(operationTime);
                    savePayLogDto.setUserId(payLogDto.getUserId());
                    //savePayLogDto.setUserName(payLogDto.getUserName());
                    SaleOrderDto saleOrderDto = orderService.loadBySaleOrderNo(saleOrderNo);
                    UserProxyDto userProxyDto = userProxyService.getUserById(saleOrderDto.getCancelUserId());
                    if (ObjectUtils.isNullOrEmpty(userProxyDto)) {
                        throw new OrderServiceException("取消订单时数据错误");
                    }
                    if (SystemContext.UserDomain.CUSTOMERTYPE_BUYER.equals(userProxyDto.getCustomerType())) {
                        savePayLogDto.setOperUserType(SystemContext.OrderDomain.PAYLOGOPERUSERTYPE_BUYER);
                    } else if (SystemContext.UserDomain.CUSTOMERTYPE_SELLER.equals(userProxyDto.getCustomerType())) {
                        savePayLogDto.setOperUserType(SystemContext.OrderDomain.PAYLOGOPERUSERTYPE_SELLER);
                    } else if (SystemContext.UserDomain.CUSTOMERTYPE_OPERATOR.equals(userProxyDto.getCustomerType())) {
                        savePayLogDto.setOperUserType(SystemContext.OrderDomain.PAYLOGOPERUSERTYPE_OPERATOR);
                    }
                    savePayLogDto = payLogService.savePayLog(savePayLogDto);
                    // TODO 是否调用支付退款接口，待讨论
                }
            }
            refundApplyHistory.setOperationTime(operationTime);
            refundApplyHistory.setOperationUserId(operationUserId);
            ObjectUtils.fastCopy(refundApply, refundApplyHistory);
            refundApplyHistoryMapper.save(refundApplyHistory);
        } catch (Exception e) {
            String msg = null == e.getMessage() ? "更新退款信息出现系统异常" : e.getMessage();
            logger.error(msg, e);
            throw new OrderServiceException(msg);
        }
    }

}
