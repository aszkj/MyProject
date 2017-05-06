package com.yilidi.o2o.order.dao;

import java.util.List;

import com.yilidi.o2o.order.model.OrderRefundStatusHistory;

/**
 * 功能描述： 退款订单退款状态历史记录数据层操作接口类 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface OrderRefundStatusHistoryMapper {

    /**
     * 保存历史记录
     * 
     * @param record
     *            记录
     * @return 影响行数
     */
    Integer save(OrderRefundStatusHistory record);

    /**
     * 根据订单编号查询订单的历史记录
     * 
     * @param saleOrderNo
     *            订单编号
     * @return 订单历史记录列表
     */
    List<OrderRefundStatusHistory> listBySaleOrderNo(String saleOrderNo);

}