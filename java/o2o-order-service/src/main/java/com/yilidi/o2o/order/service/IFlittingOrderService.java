package com.yilidi.o2o.order.service;

import java.util.List;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.order.service.dto.FlittingOrderDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderHistoryDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderItemDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderRejectDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderSaveDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderAuditDto;
import com.yilidi.o2o.order.service.dto.FlittingOrderDetailDto;
import com.yilidi.o2o.order.service.dto.query.FlittingOrderQueryDto;

/**
 * 调拨单服务类
 * 
 * @author simpson
 * 
 */
public interface IFlittingOrderService {

    /**
     * 保存调拨单
     * 
     * @param flittingOrderSaveDto
     *            调拨单
     * @return 调拨单编码
     * @throws OrderServiceException
     *             服务异常
     */
    public String saveOrder(FlittingOrderSaveDto flittingOrderSaveDto) throws OrderServiceException;

    /**
     * 通过调拨单号获取调拨单信息
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @return 调拨单信息
     * @throws OrderServiceException
     *             服务异常
     */
    public FlittingOrderDto loadByFlittingOrderNo(String flittingOrderNo) throws OrderServiceException;

    /**
     * 通过调拨单号获取调拨单详细信息
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @return 调拨单详细信息
     * @throws OrderServiceException
     *             服务异常
     */
    public FlittingOrderDetailDto loadDetailByFlittingOrderNo(String flittingOrderNo) throws OrderServiceException;

    /**
     * 分页方式获取调拨单信息列表
     * 
     * @param flittingOrderQueryDto
     *            调拨单查询DTO
     * @return 分页调拨单信息列表
     * @throws OrderServiceException
     *             服务异常
     */
    public YiLiDiPage<FlittingOrderDto> findFlittingOrders(FlittingOrderQueryDto flittingOrderQueryDto)
            throws OrderServiceException;

    /**
     * 更新调拨单-同意接收调拨单
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @param operateUserId
     *            操作用户ID
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateForAcceptPassed(String flittingOrderNo, Integer operateUserId) throws OrderServiceException;

    /**
     * 更新调拨单-拒绝接收调拨单
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @param operateUserId
     *            操作用户ID
     * @param rejectReason
     *            拒绝原因
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateForAcceptRejected(String flittingOrderNo, Integer operateUserId, String rejectReason)
            throws OrderServiceException;

    /**
     * 更新调拨单-发货调拨单
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @param operateUserId
     *            操作用户ID
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateForSend(String flittingOrderNo, Integer operateUserId) throws OrderServiceException;

    /**
     * 更新调拨单-验货调拨单
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @param operateUserId
     *            操作用户ID
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateForChecking(String flittingOrderNo, Integer operateUserId) throws OrderServiceException;

    /**
     * 更新调拨单-完成验货调拨单
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @param flittingOrderItemDtos
     *            验货调整数量列表
     * @param operateUserId
     *            操作用户ID
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateForChecked(String flittingOrderNo, List<FlittingOrderItemDto> flittingOrderItemDtos,
            Integer operateUserId) throws OrderServiceException;

    /**
     * 更新调拨单-通过审核完成调拨单
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @param operateUserId
     *            操作用户ID
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateForAuditPassed(String flittingOrderNo, Integer operateUserId) throws OrderServiceException;

    /**
     * 更新调拨单-拒绝通过完成调拨单
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @param operateUserId
     *            操作用户ID
     * @param rejectReason
     *            拒绝原因
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateForAuditRejected(String flittingOrderNo, Integer operateUserId, String rejectReason)
            throws OrderServiceException;

    /**
     * 更新调拨单-客服仲裁调拨单
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @param operateUserId
     *            操作用户ID
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateForArbitrateByOper(String flittingOrderNo, Integer operateUserId) throws OrderServiceException;

    /**
     * 更新调拨单-操作员调整调拨单并完成调拨单
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @param flittingOrderItemDtos
     *            调整数量列表
     * @param operateUserId
     *            操作用户ID
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateForAdjustAndFinishByOper(String flittingOrderNo, List<FlittingOrderItemDto> flittingOrderItemDtos,
            Integer operateUserId) throws OrderServiceException;

    /**
     * 通过调拨单号获取调拨单状态历史记录列表
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @return 调拨单状态历史记录列表
     * @throws OrderServiceException
     *             服务异常
     */
    public List<FlittingOrderHistoryDto> listFlittingOrderHistorys(String flittingOrderNo) throws OrderServiceException;

    /**
     * 通过调拨单号获取调拨单数量调整历史记录列表
     * 
     * @param flittingOrderNo
     *            调拨单号
     * @return 调拨单数量调整历史记录列表
     * @throws OrderServiceException
     *             服务异常
     */
    public List<FlittingOrderRejectDto> listFlittingOrderRejects(String flittingOrderNo) throws OrderServiceException;

    /**
     * 终极修改调拨单
     * 
     * @param flittingOrderAuditDto
     *            审核调拨单参数封装
     * @param operateUserId
     *            操作用户ID
     * @throws OrderServiceException
     *             服务异常
     */
    public void updateForUlitmateModify(FlittingOrderAuditDto flittingOrderAuditDto, Integer operateUserId)
            throws OrderServiceException;
}
