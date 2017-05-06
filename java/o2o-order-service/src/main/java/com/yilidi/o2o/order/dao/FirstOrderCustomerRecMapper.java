package com.yilidi.o2o.order.dao;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.order.model.FirstOrderCustomerRec;

/**
 * 
 * 首单记录信息数据层操作接口类
 * 
 * @author: chenb
 * @date: 2015年11月6日 下午2:49:52
 * 
 */
public interface FirstOrderCustomerRecMapper {
    /**
     * 新增保存
     * 
     * @param firstOrderCustomerRec
     *            首单信息实体
     * @return 影响行数
     */
    Integer save(FirstOrderCustomerRec firstOrderCustomerRec);

    /**
     * 根据订单号加载首单信息
     * 
     * @param saleOrderNo
     *            订单号
     * @return FirstOrderCustomerRec
     */
    FirstOrderCustomerRec loadBySaleOrderNo(@Param("saleOrderNo") String saleOrderNo);

    /**
     * 根据客户ID和首单类型查找首单信息
     * 
     * @param buyerCustomerId
     *            买家客户ID
     * @param firstOrderType
     *            首单类型
     * @return FirstOrderCustomerRec
     */
    FirstOrderCustomerRec loadByBuyerCustomerIdAndFirstOrderType(@Param("buyerCustomerId") Integer buyerCustomerId,
            @Param("firstOrderType") String firstOrderType);

    /**
     * 根据客户ID和首单类型删除首单信息
     * 
     * @param buyerCustomerId
     *            客户ID
     * @param firstOrderType
     *            首单类型
     * @return 影响行数
     */
    Integer deleteByBuyerCustomerIdAndFirstOrderType(@Param("buyerCustomerId") Integer buyerCustomerId,
            @Param("firstOrderType") String firstOrderType);
    
    /**
     * 根据订单的设备号和首单类型查找首单信息
     * 
     * @param deviceId
     *            设备号（客户端唯一标识符）
     * @param firstOrderType
     *            首单类型
     * @return FirstOrderCustomerRec
     */
    FirstOrderCustomerRec loadByDeviceIdAndFirstOrderType(@Param("deviceId") String deviceId,
            @Param("firstOrderType") String firstOrderType);
}
