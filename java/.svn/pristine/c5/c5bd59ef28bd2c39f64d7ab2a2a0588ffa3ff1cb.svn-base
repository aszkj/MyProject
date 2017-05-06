package com.yilidi.o2o.order.dao;

import java.util.Date;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.order.model.StockOut;

/**
 * 功能描述：出库记录数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface StockOutMapper {

    /**
     * 保存出库记录
     * 
     * @param record
     *            出库记录
     * @return 影响行数
     */
    Integer save(StockOut record);

    /**
     * 根据id查询出库记录
     * 
     * @param id
     *            记录id
     * @return 出库记录
     */
    StockOut loadById(Integer id);

    /**
     * 查询出库记录
     * 
     * @param storeId
     *            店铺ID，可以为null
     * @param stockOutType
     *            出库类型编码，可以为null
     * @param startDate
     *            出库查询开始时间，可以为null
     * @param endDate
     *            出库查询结束时间，可以为null
     * @return 出库记录列表
     */
    Page<StockOut> findStockOuts(@Param("storeId") Integer storeId, @Param("stockOutType") String stockOutType,
            @Param("startDate") Date startDate, @Param("endDate") Date endDate);

}