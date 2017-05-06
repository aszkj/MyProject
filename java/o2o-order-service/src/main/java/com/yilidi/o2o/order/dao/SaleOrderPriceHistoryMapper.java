package com.yilidi.o2o.order.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yilidi.o2o.order.model.SaleOrderPriceHistory;

/**
 * 功能描述：订单价格修改历史记录数据层操作接口 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SaleOrderPriceHistoryMapper {

    /**
     * 保存历史记录
     * 
     * @param record
     *            记录
     * @return 影响行数
     */
    Integer save(SaleOrderPriceHistory record);

    /**
     * 根据订单编号查询价格修改历史记录
     * 
     * @param saleOrderNo
     *            订单编号
     * @param statusCode
     *            状态编码
     * @return 修改记录信息列表
     */
    List<SaleOrderPriceHistory> listBySaleOrderNo(@Param("saleOrderNo") String saleOrderNo,
            @Param("statusCode") String statusCode);

}