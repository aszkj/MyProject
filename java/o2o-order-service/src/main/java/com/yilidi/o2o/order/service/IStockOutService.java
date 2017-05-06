package com.yilidi.o2o.order.service;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.order.service.dto.StockOutDto;
import com.yilidi.o2o.order.service.dto.query.StockOutQueryDto;

/**
 * 出库单服务类
 * 
 * @author simpson
 * 
 */
public interface IStockOutService {

    /**
     * 根据订单号保存出库信息
     * 
     * @param saleOrderNo
     *            订单编号
     * @return 出库信息
     * @throws OrderServiceException
     *             服务异常
     */
    public StockOutDto saveStockOutBySaleOrderNo(String saleOrderNo) throws OrderServiceException;

    /**
     * 根据订单号保存出库信息
     * 
     * @param flittingOrderNo
     *            调拨单编号
     * @return 出库信息
     * @throws OrderServiceException
     *             服务异常
     */
    public StockOutDto saveStockOutByFlittingOrderNo(String flittingOrderNo) throws OrderServiceException;

    /**
     * 根据入库单ID获取出库单信息
     * 
     * @param stockOutId
     *            出库单ID
     * @return 出库单信息
     * @throws OrderServiceException
     *             服务异常
     */
    public StockOutDto loadByStockOutId(Integer stockOutId) throws OrderServiceException;

    /**
     * 根据条件查询出库单信息分页列表
     * 
     * @param stockOutQueryDto
     *            查询条件DTO
     * @return 出库单信息分页列表
     * @throws OrderServiceException
     *             服务异常
     */
    public YiLiDiPage<StockOutDto> findStockOuts(StockOutQueryDto stockOutQueryDto) throws OrderServiceException;

    /**
     * 根据出库订单保存出库记录信息
     * 
     * @param stockOutOrderNo
     *            出库订单号
     * @return 出库记录信息
     * @throws OrderServiceException
     *             服务异常
     */
    public StockOutDto saveStockOutByStockOutOrderNo(String stockOutOrderNo) throws OrderServiceException;

}
