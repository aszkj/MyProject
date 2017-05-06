package com.yilidi.o2o.order.service;

import java.util.List;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.order.service.dto.PurchaseOrderDto;
import com.yilidi.o2o.order.service.dto.PurchaseOrderHistoryDto;
import com.yilidi.o2o.order.service.dto.PurchaseOrderSaveDto;
import com.yilidi.o2o.order.service.dto.query.PurchaseOrderQueryDto;

/**
 * 采购单服务类
 * 
 * @author chenb
 * 
 */
public interface IPurchaseOrderService {

    /**
     * 保存采购单
     * 
     * @param purchaseOrderSaveDto
     *            采购单
     * @return 采购单编码
     * @throws OrderServiceException
     *             服务异常
     */
    public String saveCreatePurchaseOrder(PurchaseOrderSaveDto purchaseOrderSaveDto, Integer userId)
            throws OrderServiceException;

    /**
     * 通过采购单号获取采购单信息
     * 
     * @param purchaseOrderNo
     *            采购单号
     * @return 采购单信息
     * @throws OrderServiceException
     *             服务异常
     */
    public PurchaseOrderDto loadByPurchaseOrderNo(String purchaseOrderNo) throws OrderServiceException;

    /**
     * 分页方式获取采购单信息列表
     * 
     * @param purchaseOrderQueryDto
     *            采购单查询DTO
     * @return 分页采购单信息列表
     * @throws OrderServiceException
     *             服务异常
     */
    public YiLiDiPage<PurchaseOrderDto> findPurchaseOrders(PurchaseOrderQueryDto purchaseOrderQueryDto)
            throws OrderServiceException;

    /**
     * 更新采购单-通过审核完成采购单
     * 
     * @param purchaseOrderNo
     *            采购单号
     * @param operateUserId
     *            操作用户ID
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateForAuditPassed(String purchaseOrderNo, Integer operateUserId) throws OrderServiceException;

    /**
     * 更新采购单-拒绝通过完成采购单
     * 
     * @param purchaseOrderNo
     *            采购单号
     * @param operateUserId
     *            操作用户ID
     * @param rejectReason
     *            拒绝原因
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateForAuditRejected(String purchaseOrderNo, Integer operateUserId, String rejectReason)
            throws OrderServiceException;

    /**
     * 通过采购单号获取采购单状态历史记录列表
     * 
     * @param purchaseOrderNo
     *            采购单号
     * @return 采购单状态历史记录列表
     * @throws OrderServiceException
     *             服务异常
     */
    public List<PurchaseOrderHistoryDto> listPurchaseOrderHistorys(String purchaseOrderNo) throws OrderServiceException;

    /**
     * 分页获取报表数据
     * 
     * @param purchaseOrderQueryDto
     *            查询条件对象
     * @param startLineNum
     *            开始行数
     * @param pageSize
     *            分页大小
     * @return PurchaseOrderDto
     * @throws OrderServiceException
     *             销售域服务异常
     */
    List<PurchaseOrderDto> listDataForExportPurchaseOrder(PurchaseOrderQueryDto purchaseOrderQueryDto, Long startLineNum,
            Integer pageSize) throws OrderServiceException;

    /**
     * 
     * 获取需要导出的采购的数量
     * 
     * @param purchaseOrderQueryDto
     *            查询条件对象
     * @return long 记录总数
     * @throws OrderServiceException
     *             销售域服务异常
     */
    Long getCountsForExportPurchaseOrder(PurchaseOrderQueryDto purchaseOrderQueryDto) throws OrderServiceException;
}
