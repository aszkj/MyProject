package com.yilidi.o2o.order.service;

import java.util.List;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.order.service.dto.StockOutOrderDto;
import com.yilidi.o2o.order.service.dto.StockOutOrderHistoryDto;
import com.yilidi.o2o.order.service.dto.StockOutOrderSaveDto;
import com.yilidi.o2o.order.service.dto.query.StockOutOrderQueryDto;

/**
 * 出库单服务类
 * 
 * @author chenb
 * 
 */
public interface IStockOutOrderService {

    /**
     * 保存出库单
     * 
     * @param stockOutOrderSaveDto
     *            出库单
     * @return 出库单编码
     * @throws OrderServiceException
     *             服务异常
     */
    public String saveCreateStockOutOrder(StockOutOrderSaveDto stockOutOrderSaveDto, Integer userId)
            throws OrderServiceException;

    /**
     * 通过出库单号获取出库单信息
     * 
     * @param stockOutOrderNo
     *            出库单号
     * @return 出库单信息
     * @throws OrderServiceException
     *             服务异常
     */
    public StockOutOrderDto loadByStockOutOrderNo(String stockOutOrderNo) throws OrderServiceException;

    /**
     * 分页方式获取出库单信息列表
     * 
     * @param stockOutOrderQueryDto
     *            出库单查询DTO
     * @return 分页出库单信息列表
     * @throws OrderServiceException
     *             服务异常
     */
    public YiLiDiPage<StockOutOrderDto> findStockOutOrders(StockOutOrderQueryDto stockOutOrderQueryDto)
            throws OrderServiceException;

    /**
     * 更新出库单-通过审核完成出库单
     * 
     * @param stockOutOrderNo
     *            出库单号
     * @param operateUserId
     *            操作用户ID
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateForAuditPassed(String stockOutOrderNo, Integer operateUserId) throws OrderServiceException;

    /**
     * 更新出库单-拒绝通过完成出库单
     * 
     * @param stockOutOrderNo
     *            出库单号
     * @param operateUserId
     *            操作用户ID
     * @param rejectReason
     *            拒绝原因
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateForAuditRejected(String stockOutOrderNo, Integer operateUserId, String rejectReason)
            throws OrderServiceException;

    /**
     * 通过出库单号获取出库单状态历史记录列表
     * 
     * @param stockOutOrderNo
     *            出库单号
     * @return 出库单状态历史记录列表
     * @throws OrderServiceException
     *             服务异常
     */
    public List<StockOutOrderHistoryDto> listStockOutOrderHistorys(String stockOutOrderNo) throws OrderServiceException;

    /**
     * 分页获取报表数据
     * 
     * @param stockOutOrderQueryDto
     *            查询条件对象
     * @param startLineNum
     *            开始行数
     * @param pageSize
     *            分页大小
     * @return StockOutOrderDto
     * @throws OrderServiceException
     *             销售域服务异常
     */
    List<StockOutOrderDto> listDataForExportStockOutOrder(StockOutOrderQueryDto stockOutOrderQueryDto, Long startLineNum,
            Integer pageSize) throws OrderServiceException;

    /**
     * 
     * 获取需要导出的出库的数量
     * 
     * @param stockOutOrderQueryDto
     *            查询条件对象
     * @return long 记录总数
     * @throws OrderServiceException
     *             销售域服务异常
     */
    Long getCountsForExportStockOutOrder(StockOutOrderQueryDto stockOutOrderQueryDto) throws OrderServiceException;
}
