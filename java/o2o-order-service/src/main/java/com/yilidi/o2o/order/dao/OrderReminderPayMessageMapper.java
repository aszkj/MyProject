package com.yilidi.o2o.order.dao;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.order.model.OrderReminderPayMessage;

/**
 * 催付款短信日志数据层操作类
 * 
 * @author chenb
 * 
 */
public interface OrderReminderPayMessageMapper {

    /**
     * 保存催付款短信日志信息
     * 
     * @param record
     *            短信日志信息
     * @return 影响行数
     */
    Integer save(OrderReminderPayMessage record);

    /**
     * 根据订单号和手机号获取短信日志信息
     * 
     * @param saleOrderNo
     *            订单号
     * @param toUser
     *            手机号
     * @return 日志信息
     */
    OrderReminderPayMessage loadBySaleOrderNoAndPhoneNo(@Param("saleOrderNo") String saleOrderNo,
            @Param("toUser") String toUser);

}
