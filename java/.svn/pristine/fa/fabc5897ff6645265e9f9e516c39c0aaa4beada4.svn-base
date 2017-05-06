package com.yilidi.o2o.order.service;

import java.util.Date;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.order.service.dto.RefundApplyDto;

/**
 * @Description: TODO(退款Service接口)
 * @author: chenlian
 * @date: 2016年6月18日 上午1:21:25
 */
public interface IRefundApplyService {

    /**
     * @Description TODO(根据订单编号查询退款记录信息)
     * @param saleOrderNo
     * @return RefundApplyDto
     * @throws OrderServiceException
     */
    public RefundApplyDto loadByOrderNo(String saleOrderNo) throws OrderServiceException;

    /**
     * @Description TODO(生成退款信息)
     * @param refundApplyDto
     * @throws OrderServiceException
     */
    public void save(RefundApplyDto refundApplyDto) throws OrderServiceException;

    /**
     * @Description TODO(更新退款信息)
     * @param saleOrderNo
     * @param preStatusCode
     * @param statusCode
     * @param operationTime
     * @param operationUserId
     * @throws OrderServiceException
     */
    public void update(String saleOrderNo, String preStatusCode, String statusCode, Date operationTime,
            Integer operationUserId) throws OrderServiceException;
}
