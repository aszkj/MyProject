package com.yilidi.o2o.order.dao;

import java.util.Date;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.order.model.OrderRefund;

/**
 * 
 * 退款订单记录信息数据层操作接口类
 * 
 * @author: chenb
 * @date: 2015年11月6日 下午2:49:52
 * 
 */
public interface OrderRefundMapper {
    /**
     * 新增保存
     * 
     * @param orderRefund
     *            退款订单记录信息实体
     * @return 影响行数
     */
    Integer save(OrderRefund orderRefund);

    /**
     * 根据订单编号获取退款信息
     * 
     * @param saleOrderNo
     *            订单编号
     * @return
     */
    OrderRefund loadBySaleOrderNo(@Param("saleOrderNo") String saleOrderNo);

    /**
     * 更新退款订单状态
     * 
     * @param saleOrderNo
     *            订单编号
     * @param prevStatus
     *            退款中审核状态
     * @param updateStatus
     *            审核状态
     * @param refundReason
     *            失败原因
     * @param modifyUserId
     *            修改用户ID 审核状态
     * @param modifyTime
     *            修改时间 审核状态
     * @return 影响行数
     */
    Integer updateStatusBySaleOrderNo(@Param("saleOrderNo") String saleOrderNo, @Param("prevStatus") String prevStatus,
            @Param("updateStatus") String updateStatus, @Param("refundReason") String refundReason,
            @Param("modifyUserId") Integer modifyUserId, @Param("modifyTime") Date modifyTime);
}
