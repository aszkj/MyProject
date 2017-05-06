package com.yilidi.o2o.order.service;

import java.util.List;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.order.service.dto.FlittingOrderItemDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderItemHistoryDto;

/**
 * 调拨明细服务类
 * 
 * @author simpson
 * 
 */
public interface IFlittingOrderItemService {

    /**
     * 通过调拨单号获取调拨单明细信息列表
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @return 调拨单信息列表
     * @throws OrderServiceException
     *             服务异常
     */
    public List<FlittingOrderItemDto> listFlittingOrderItems(String flittingOrderNo) throws OrderServiceException;

    /**
     * 通过调拨单调整记录ID获取调拨单明细数量调整历史记录列表
     * 
     * @param flittingOrderRejectId
     *            调拨单号
     * @return 调拨单明细数量调整历史记录列表
     * @throws OrderServiceException
     *             服务异常
     */
    public List<FlittingOrderItemHistoryDto> listFlittingOrderItemHistorys(Integer flittingOrderRejectId)
            throws OrderServiceException;

}
