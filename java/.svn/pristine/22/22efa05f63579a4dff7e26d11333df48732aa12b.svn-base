/**
 * 文件名称：CommissionClearupService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.dao.OrderRefundMapper;
import com.yilidi.o2o.order.dao.OrderRefundStatusHistoryMapper;
import com.yilidi.o2o.order.model.OrderRefund;
import com.yilidi.o2o.order.model.OrderRefundStatusHistory;
import com.yilidi.o2o.order.service.IOrderRefundService;
import com.yilidi.o2o.order.service.dto.OrderRefundDto;
import com.yilidi.o2o.order.service.dto.OrderRefundStatusHistoryDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 
 * 订单退款服务接口实现类
 * 
 * @author: chenb
 * @date: 2016年7月12日 下午3:14:31
 * 
 */
@Service("orderRefundService")
public class OrderRefundServiceImpl extends BasicDataService implements IOrderRefundService {

    @Autowired
    private OrderRefundMapper orderRefundMapper;
    @Autowired
    private OrderRefundStatusHistoryMapper orderRefundStatusHistoryMapper;

    @Override
    public OrderRefundDto loadBySaleOrderNo(String saleOrderNo) throws OrderServiceException {
        try {
            OrderRefund orderRefund = orderRefundMapper.loadBySaleOrderNo(saleOrderNo);
            OrderRefundDto orderRefundDto = null;
            if (!ObjectUtils.isNullOrEmpty(orderRefund)) {
                orderRefundDto = new OrderRefundDto();
                ObjectUtils.fastCopy(orderRefund, orderRefundDto);
                List<OrderRefundStatusHistory> statusHistorys = orderRefundStatusHistoryMapper
                        .listBySaleOrderNo(saleOrderNo);
                if (!ObjectUtils.isNullOrEmpty(statusHistorys)) {
                    List<OrderRefundStatusHistoryDto> statusHistoryDtos = new ArrayList<OrderRefundStatusHistoryDto>();
                    for (OrderRefundStatusHistory orderRefundStatusHistory : statusHistorys) {
                        OrderRefundStatusHistoryDto orderRefundStatusHistoryDto = new OrderRefundStatusHistoryDto();
                        ObjectUtils.fastCopy(orderRefundStatusHistory, orderRefundStatusHistoryDto);
                        statusHistoryDtos.add(orderRefundStatusHistoryDto);
                    }
                    orderRefundDto.setOrderRefundStatusHistoreyDtos(statusHistoryDtos);
                }
            }
            return orderRefundDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

}
