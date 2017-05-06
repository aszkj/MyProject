package com.yilidi.o2o.order.dao;

import java.util.Date;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.order.model.StockIn;

/**
 * 功能描述：商品入库数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface StockInMapper {

    /**
     * 保存商品入库记录
     * 
     * @param record
     *            入库记录
     * @return 影响行数
     */
    Integer save(StockIn record);

    /**
     * 根据id查询入库记录
     * 
     * @param id
     *            记录id
     * @return 入库记录
     */
    StockIn loadById(Integer id);

    /**
     * 查询入库记录
     * 
     * @param storeId
     *            店铺ID
     * @param stockInType
     *            入库类型编码，可以为null
     * @param startDate
     *            入库查询开始时间，可以为null
     * @param endDate
     *            入库查询结束时间，可以为null
     * @return 入库记录列表
     */
    Page<StockIn> findStockIns(@Param("storeId") Integer storeId, @Param("stockInType") String stockInType,
            @Param("startDate") Date startDate, @Param("endDate") Date endDate);

}