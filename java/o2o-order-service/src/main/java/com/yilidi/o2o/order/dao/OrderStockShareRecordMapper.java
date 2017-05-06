package com.yilidi.o2o.order.dao;

import com.yilidi.o2o.order.model.OrderStockShareRecord;

/**
 * 功能描述：共享库存订单记录操作接口类 <br/>
 * 作者：chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface OrderStockShareRecordMapper {

    /**
     * 保存共享库存订单记录
     * 
     * @param record
     *            共享库存订单记录
     * @return 影响的行数
     */
    Integer save(OrderStockShareRecord record);

}