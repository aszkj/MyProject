package com.yilidi.o2o.order.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.dao.FlittingOrderItemHistoryMapper;
import com.yilidi.o2o.order.dao.FlittingOrderItemMapper;
import com.yilidi.o2o.order.model.FlittingOrderItem;
import com.yilidi.o2o.order.model.FlittingOrderItemHistory;
import com.yilidi.o2o.order.service.IFlittingOrderItemService;
import com.yilidi.o2o.order.service.dto.FlittingOrderItemDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderItemHistoryDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 调拨单明细服务类实现
 * 
 * @author simpson
 * 
 */
@Service("flittingOrderItemService")
public class FlittingOrderItemServiceImpl extends BasicDataService implements IFlittingOrderItemService {

    @Autowired
    private FlittingOrderItemMapper flittingOrderItemMapper;
    @Autowired
    private FlittingOrderItemHistoryMapper flittingOrderItemHistoryMapper;

    @Override
    public List<FlittingOrderItemDto> listFlittingOrderItems(String flittingOrderNo) throws OrderServiceException {
        try {
            if (StringUtils.isBlank(flittingOrderNo)) {
                throw new OrderServiceException("调拨单编号不能为空");
            }
            List<FlittingOrderItem> items = flittingOrderItemMapper.listFlittingOrderItems(flittingOrderNo);
            if (ObjectUtils.isNullOrEmpty(items)) {
                return null;
            }
            List<FlittingOrderItemDto> itemDtos = new ArrayList<FlittingOrderItemDto>();
            for (FlittingOrderItem item : items) {
                if (ObjectUtils.isNullOrEmpty(item)) {
                    continue;
                }
                FlittingOrderItemDto itemDto = new FlittingOrderItemDto();
                ObjectUtils.fastCopy(item, itemDto);
                itemDtos.add(itemDto);
            }
            return itemDtos;
        } catch (Exception e) {
            logger.error("listFlittingOrderItems异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<FlittingOrderItemHistoryDto> listFlittingOrderItemHistorys(Integer flittingOrderRejectId)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(flittingOrderRejectId)) {
                throw new OrderServiceException("调拨单调整记录ID不能为空");
            }
            List<FlittingOrderItemHistory> items = flittingOrderItemHistoryMapper
                    .listFlittingOrderItemHistorys(flittingOrderRejectId);
            if (ObjectUtils.isNullOrEmpty(items)) {
                return null;
            }
            List<FlittingOrderItemHistoryDto> itemDtos = new ArrayList<FlittingOrderItemHistoryDto>();
            for (FlittingOrderItemHistory item : items) {
                if (ObjectUtils.isNullOrEmpty(item)) {
                    continue;
                }
                FlittingOrderItemHistoryDto itemDto = new FlittingOrderItemHistoryDto();
                ObjectUtils.fastCopy(item, itemDto);
                itemDtos.add(itemDto);
            }
            return itemDtos;
        } catch (Exception e) {
            logger.error("listFlittingOrderItemHistorys异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

}
