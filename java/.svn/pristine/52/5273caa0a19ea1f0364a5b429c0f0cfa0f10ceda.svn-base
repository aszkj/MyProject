package com.yilidi.o2o.order.dao;

import java.util.List;

import com.yilidi.o2o.order.model.RefundApplyHistory;

/**
 * @Description: TODO(申请退款的历史记录Mapper)
 * @author: chenlian
 * @date: 2016年6月18日 上午1:35:31
 */
public interface RefundApplyHistoryMapper {

    /**
     * 保存退款申请历史记录
     * 
     * @param record
     *            退款申请记录
     * @return 影响行数
     */
    Integer save(RefundApplyHistory record);

    /**
     * 根据申请id查询该申请的所哟历史记录
     * 
     * @param applyId
     *            申请Id
     * @return 申请历史列表
     */
    List<RefundApplyHistory> listByAppleyId(Integer applyId);

}