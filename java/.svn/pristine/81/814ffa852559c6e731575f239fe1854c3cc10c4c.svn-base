package com.yilidi.o2o.order.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.order.model.OrderGiftInfo;

/**
 * 
 * 订单赠品信息数据层操作接口类
 * 
 * @author: chenb
 * @date: 2015年11月6日 下午2:49:52
 * 
 */
public interface OrderGiftInfoMapper {
    /**
     * 新增保存
     * 
     * @param orderGiftInfo
     *            订单赠品信息
     * @return 影响行数
     */
    Integer save(OrderGiftInfo orderGiftInfo);

    /**
     * 根据订单号加载赠品信息列表
     * 
     * @param saleOrderNo
     *            订单号
     * @param giftType
     *            赠品类型
     * @param activityType
     *            活动类型
     * @param orderGiftStatus
     *            赠品奖励配置状态
     * @return OrderGiftInfo
     */
    List<OrderGiftInfo> listBySaleOrderNo(@Param("saleOrderNo") String saleOrderNo, @Param("giftType") String giftType,
            @Param("activityType") String activityType, @Param("orderGiftStatus") String orderGiftStatus);

    /**
     * 修改订单赠品信息为已发送状态
     * 
     * @param saleOrderNo
     *            订单状态
     * @param unSendStatus
     *            未发送状态编码
     * @param sendedStatus
     *            已发送状态编码
     * @param modifyUserId
     *            修改用户ID
     * @param modifyTime
     *            修改记录时间
     * @return
     */
    Integer updateStatusForSendedByOrderNo(@Param("saleOrderNo") String saleOrderNo, @Param("unSendStatus") String unSendStatus,
            @Param("sendedStatus") String sendedStatus, @Param("modifyUserId") Integer modifyUserId,
            @Param("modifyTime") Date modifyTime);

}
