package com.yilidi.o2o.order.dao;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.order.model.RefundApply;

/**
 * @Description: TODO(退款申请Mapper)
 * @author: chenlian
 * @date: 2016年6月18日 上午1:34:38
 */
public interface RefundApplyMapper {

    /**
     * @Description TODO(保存退款申请)
     * @param record
     * @return Integer
     */
    Integer save(RefundApply record);

    /**
     * @Description TODO(根据订单编号查询退款申请记录信息)
     * @param saleOrderNo
     * @return RefundApply
     */
    RefundApply loadByOrderNo(@Param("saleOrderNo") String saleOrderNo);

    /**
     * @Description TODO(根据订单编号更新退款申请记录信息)
     * @param saleOrderNo
     * @param preStatusCode
     * @param statusCode
     * @return int 影响行数
     */
    int updateByOrderNo(@Param("saleOrderNo") String saleOrderNo, @Param("preStatusCode") String preStatusCode,
            @Param("statusCode") String statusCode);

}