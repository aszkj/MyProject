package com.yilidi.o2o.order.service;

import java.util.List;
import java.util.Map;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.order.service.dto.StockInDto;
import com.yilidi.o2o.order.service.dto.query.StockInQueryDto;

/**
 * 入库单服务类
 * 
 * @author simpson
 * 
 */
public interface IStockInService {

    /**
     * 根据订单号保存入库信息，当发货后买家拒绝收货而取消订单的时候，则需要使用给方法处理。
     * 
     * @param saleOrderNo
     *            订单编号
     * @return 入库信息
     * @throws OrderServiceException
     *             服务异常
     */
    public StockInDto saveStockInBySaleOrderNo(String saleOrderNo) throws OrderServiceException;

    /**
     * 根据订单号保存入库信息
     * 
     * @param flittingOrderNo
     *            调拨单编号
     * @return 入库信息列表
     * @throws OrderServiceException
     *             服务异常
     */
    public List<StockInDto> saveStockInByFlittingOrderNo(String flittingOrderNo) throws OrderServiceException;

    /**
     * 根据入库单ID获取入库单信息
     * 
     * @param stockInId
     *            入库单ID
     * @return 入库单信息
     * @throws OrderServiceException
     *             服务异常
     */
    public StockInDto loadByStockInId(Integer stockInId) throws OrderServiceException;

    /**
     * 根据条件查询入库单信息分页列表
     * 
     * @param stockInQueryDto
     *            查询条件DTO
     * @return 入库单信息分页列表
     * @throws OrderServiceException
     *             服务异常
     */
    public YiLiDiPage<StockInDto> findStockIns(StockInQueryDto stockInQueryDto) throws OrderServiceException;

    /**
     * 根据采购单号保存入库信息
     * 
     * @param purchaseOrderNo
     *            采购单编号
     * @param saleProductMap
     *            产品ID跟商品IDmap
     * @return 入库信息
     * @throws OrderServiceException
     *             服务异常
     */
    public StockInDto saveStockInByPurchaseOrderNo(String purchaseOrderNo, Map<Integer, Integer> saleProductMap)
            throws OrderServiceException;

}
