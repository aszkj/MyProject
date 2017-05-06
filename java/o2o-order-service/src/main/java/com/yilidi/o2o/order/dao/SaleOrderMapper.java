package com.yilidi.o2o.order.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.github.pagehelper.Page;
import com.yilidi.o2o.order.model.SaleOrder;
import com.yilidi.o2o.order.model.query.RecommendOrderInfoQuery;
import com.yilidi.o2o.order.model.query.SaleOrderQuery;
import com.yilidi.o2o.order.model.query.SellerListOrderQuery;
import com.yilidi.o2o.order.model.query.SettleDetailQuery;
import com.yilidi.o2o.order.model.result.AllVolumeStatisticsInfo;
import com.yilidi.o2o.order.model.result.BaseVolumeStatisticsInfo;
import com.yilidi.o2o.order.model.result.FinishOrderAmountInfo;
import com.yilidi.o2o.order.model.result.FinishOrderCountInfo;
import com.yilidi.o2o.order.model.result.RecommendOrderInfo;
import com.yilidi.o2o.order.model.result.SaleOrderInfo;
import com.yilidi.o2o.order.model.result.SaleOrderItemInfo;
import com.yilidi.o2o.order.model.result.SaleOrderStatisticsInfo;
import com.yilidi.o2o.order.model.result.SaleProductStatisticsInfo;
import com.yilidi.o2o.order.model.result.SettleDetailInfo;
import com.yilidi.o2o.order.service.dto.query.AllVolumeStatisticsQuery;
import com.yilidi.o2o.order.service.dto.query.SaleOrderQueryDto;
import com.yilidi.o2o.order.service.dto.query.SaleOrderStatisticsQuery;
import com.yilidi.o2o.order.service.dto.query.SaleProductStatisticsQuery;

/**
 * 功能描述：订单数据层操作接口类 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface SaleOrderMapper {

    /**
     * 保存订单信息
     * 
     * @param record
     *            订单记录
     * @return 影响行数
     */
    Integer save(SaleOrder record);

    /**
     * 更新订单的总价
     * 
     * @param saleOrderNo
     *            订单id
     * @param totalAmount
     *            总价
     * @param transferFee
     *            运费
     * @return 影响行数
     */
    Integer updatePriceBySaleOrderNo(@Param("saleOrderNo") String saleOrderNo, @Param("totalAmount") Long totalAmount,
            @Param("transferFee") Long transferFee);

    /**
     * 根据id更新订单的状态
     * 
     * @param saleOrderNo
     *            订单id
     * @param statusCode
     *            状态编码
     * @return 影响行数
     */
    Integer updateStautsCodeBySaleOrderNo(@Param("saleOrderNo") String saleOrderNo, @Param("statusCode") String statusCode);

    /**
     * 根据订单id 更新订单的支付方式，支付时间
     * 
     * @param saleOrderNo
     *            订单id
     * @param payTypeCode
     *            支付方式
     * @param payTime
     *            支付时间
     * @return 影响行数
     */
    Integer updatePayBySaleOrderNo(@Param("saleOrderNo") String saleOrderNo, @Param("payTypeCode") String payTypeCode,
            @Param("payTime") Date payTime);

    /**
     * 根据订单id查询订单信息
     * 
     * @param saleOrderNo
     *            订单id
     * @return 订单信息对象
     */
    SaleOrder loadBySaleOrderNo(String saleOrderNo);

    /**
     * 根据条件查询订单
     * 
     * @param query
     *            查询条件对象
     * @return 订单列表
     */
    Page<SaleOrderInfo> findSaleOrderInfos(SaleOrderQueryDto query);

    /**
     * 根据条件查询订单
     * 
     * @param query
     *            查询条件
     * @return 订单列表
     */
    Page<SaleOrder> findSaleOrders(SaleOrderQuery query);

    /**
     * 
     * 订单取消
     * 
     * @param orderId
     *            订单ID
     * @param reason
     *            取消原因
     * @param cancelType
     *            取消类型
     * @param cancelTime
     *            取消时间
     * @param orderStatus
     *            状态
     */
    void cancelOrder(@Param("orderId") Integer orderId, @Param("reason") String reason,
            @Param("cancelType") String cancelType, @Param("cancelTime") Date cancelTime,
            @Param("orderStatus") String orderStatus);

    /**
     * 用户销售统计 (下单笔数，下单金额)
     * 
     * @param query
     *            查询条件
     * @return Page<SaleOrderStatisticsInfo>
     */
    Page<SaleOrderStatisticsInfo> findOrderStatisticsInfos(SaleOrderStatisticsQuery query);

    /**
     * 
     * 用户销售统计数量
     * 
     * @param query
     *            查询实体
     * @return long 数量
     */
    Long getCountsForExportOrderStatistics(SaleOrderStatisticsQuery query);

    /**
     * 
     * 用户销售统计导出列表
     * 
     * @param saleOrderStatisticsQuery
     *            查询实体
     * @param startLineNum
     *            开始行数
     * @param pageSize
     *            每页大小
     * @return List<SaleOrderStatisticsInfo> 列表
     */
    List<SaleOrderStatisticsInfo> listDataForExportOrderStatistics(
            @Param("saleOrderStatisticsQuery") SaleOrderStatisticsQuery saleOrderStatisticsQuery,
            @Param("startLineNum") Long startLineNum, @Param("pageSize") Integer pageSize);

    /**
     * 根据订单状态查询订单列表
     * 
     * @param statusCodes
     *            订单状态列表
     * @return 订单信息列表
     */
    List<SaleOrderInfo> listSaleOrderByStatusCodes(@Param("statusCodes") List<String> statusCodes);

    /**
     * 用户销售统计 (成交笔数，成交金额)
     * 
     * @param query
     *            查询条件
     * @return SaleOrderStatisticsInfo
     */
    SaleOrderStatisticsInfo getOrderStatisticsInfoFromSuccess(SaleOrderStatisticsQuery query);

    /**
     * 用户销售统计 (取消订单数，取消金额)
     * 
     * @param query
     *            查询条件
     * @return SaleOrderStatisticsInfo
     */
    SaleOrderStatisticsInfo getOrderStatisticsInfoFromCancel(SaleOrderStatisticsQuery query);

    /**
     * 用户下单记录 按时间(下单笔数，下单金额)
     * 
     * @param query
     *            查询条件
     * @return Page<SaleOrderStatisticsInfo>
     */
    Page<SaleOrderStatisticsInfo> findOrderStatisticsInfosByDate(SaleOrderStatisticsQuery query);

    /**
     * 
     * 用户下单记录数量
     * 
     * @param query
     *            查询实体
     * @return long 数量
     */
    Long getCountsForExportOrderStatisticsByDate(SaleOrderStatisticsQuery query);

    /**
     * 
     * 获取需要导出的用户下单记录列表
     * 
     * @param saleOrderStatisticsQuery
     *            查询实体
     * @param startLineNum
     *            开始行数
     * @param pageSize
     *            每页大小
     * @return List<SaleOrderStatisticsInfo> 列表
     */
    List<SaleOrderStatisticsInfo> listDataForExportOrderStatisticsByDate(
            @Param("saleOrderStatisticsQuery") SaleOrderStatisticsQuery saleOrderStatisticsQuery,
            @Param("startLineNum") Long startLineNum, @Param("pageSize") Integer pageSize);

    /**
     * 用户下单记录 按时间(成交笔数，成交金额)
     * 
     * @param query
     *            查询条件
     * @return SaleOrderStatisticsInfo
     */
    SaleOrderStatisticsInfo getOrderStatisticsInfoFromSuccessByDate(SaleOrderStatisticsQuery query);

    /**
     * 用户下单记录 按时间 (取消订单数，取消金额)
     * 
     * @param query
     *            查询条件
     * @return SaleOrderStatisticsInfo
     */
    SaleOrderStatisticsInfo getOrderStatisticsInfoFromCancelByDate(SaleOrderStatisticsQuery query);

    /**
     * 销量汇总统计 根据订单状态来统计
     * 
     * @param orderStatusList
     *            状态列表
     * @return BaseVolumeStatisticsInfo
     */
    BaseVolumeStatisticsInfo getBaseVolumeStatisticsInfoByStatusList(@Param("orderStatusList") List<String> orderStatusList);

    /**
     * 
     * 根据查询条件查询销售汇总明细列表
     * 
     * @param query
     *            查询条件
     * @return Page<AllVolumeStatisticsInfo>
     */
    Page<AllVolumeStatisticsInfo> findAllVolumeStatisticsInfos(AllVolumeStatisticsQuery query);

    /**
     * 
     * 销售汇总明细数量
     * 
     * @param query
     *            查询实体
     * @return long 数量
     */
    Long getCountsForExportVolumeStatisticsDetail(AllVolumeStatisticsQuery query);

    /**
     * 
     * 获取需要导出的销售汇总明细列表
     * 
     * @param allVolumeStatisticsQuery
     *            查询实体
     * @param startLineNum
     *            开始行数
     * @param pageSize
     *            每页大小
     * @return List<AllVolumeStatisticsInfo> 列表
     */
    List<AllVolumeStatisticsInfo> listDataForExportVolumeStatisticsDetail(
            @Param("allVolumeStatisticsQuery") AllVolumeStatisticsQuery allVolumeStatisticsQuery,
            @Param("startLineNum") Long startLineNum, @Param("pageSize") Integer pageSize);

    /**
     * 
     * 根据订单日期查询订单号列表
     * 
     * @param query
     *            查询 条件
     * @return List<String>
     */
    List<String> listSaleOrderNosByTime(@Param("allVolumeStatisticsQuery") AllVolumeStatisticsQuery query);

    /**
     * 销售汇总明细列表 (已成交)
     * 
     * @param query
     *            查询条件
     * @return AllVolumeStatisticsInfo
     */
    AllVolumeStatisticsInfo getAllVolumeStatisticsInfoFromSuccessByDate(AllVolumeStatisticsQuery query);

    /**
     * 销售汇总明细列表 (取消)
     * 
     * @param query
     *            查询条件
     * @return AllVolumeStatisticsInfo
     */
    AllVolumeStatisticsInfo getAllVolumeStatisticsInfoFromCancelByDate(AllVolumeStatisticsQuery query);

    /**
     * 
     * 查询门店销售统计列表
     * 
     * @param query
     *            查询条件
     * @return Page<AllVolumeStatisticsInfo>
     */
    Page<AllVolumeStatisticsInfo> findAllVolumeStatisticsInfosForStore(AllVolumeStatisticsQuery query);

    /**
     * 
     * 门店每天的销售排行数量
     * 
     * @param query
     *            查询条件
     * @return Long
     */
    Long getCountsForExportStoreVolumeByOneDay(AllVolumeStatisticsQuery query);

    /**
     * 
     * 门店每天的销售排行 导出列表
     * 
     * @param allVolumeStatisticsQuery
     *            查询条件
     * @param startLineNum
     *            开始行数
     * @param pageSize
     *            每页大小
     * @return List<AllVolumeStatisticsInfo>
     */
    List<AllVolumeStatisticsInfo> listDataForExportStoreVolumeByOneDay(
            @Param("allVolumeStatisticsQuery") AllVolumeStatisticsQuery allVolumeStatisticsQuery,
            @Param("startLineNum") Long startLineNum, @Param("pageSize") Integer pageSize);

    /**
     * 
     * 门店销售统计数量
     * 
     * @param query
     *            查询条件
     * @return Long
     */
    Long getCountsForExportStoreVolumeList(AllVolumeStatisticsQuery query);

    /**
     * 
     * 门店销售统计导出列表
     * 
     * @param allVolumeStatisticsQuery
     *            查询条件
     * @param startLineNum
     *            开始行数
     * @param pageSize
     *            每页大小
     * @return List<AllVolumeStatisticsInfo>
     */
    List<AllVolumeStatisticsInfo> listDataForExportStoreVolumeList(
            @Param("allVolumeStatisticsQuery") AllVolumeStatisticsQuery allVolumeStatisticsQuery,
            @Param("startLineNum") Long startLineNum, @Param("pageSize") Integer pageSize);

    /**
     * 
     * 查询门店销售统计列表->查看下单记录
     * 
     * @param query
     *            查询条件
     * @return Page<AllVolumeStatisticsInfo>
     */
    Page<AllVolumeStatisticsInfo> findAllVolumeStatisticsInfosForStoreByDay(AllVolumeStatisticsQuery query);

    /**
     * 
     * 门店销售统计列表->查看下单记录数量
     * 
     * @param query
     *            查询条件
     * @return Long
     */
    Long getCountsForExportStoreVolumeListForDay(AllVolumeStatisticsQuery query);

    /**
     * 
     * 门店销售统计列表->查看下单记录导出列表
     * 
     * @param allVolumeStatisticsQuery
     *            查询条件
     * @param startLineNum
     *            开始数
     * @param pageSize
     *            条数
     * @return List<AllVolumeStatisticsInfo>
     */
    List<AllVolumeStatisticsInfo> listDataForExportStoreVolumeListForDay(
            @Param("allVolumeStatisticsQuery") AllVolumeStatisticsQuery allVolumeStatisticsQuery,
            @Param("startLineNum") Long startLineNum, @Param("pageSize") Integer pageSize);

    /**
     * 
     * 商品销售统计
     * 
     * @param query
     *            查询条件
     * @return Page<AllVolumeStatisticsInfo>
     */
    Page<SaleProductStatisticsInfo> findSaleProductStatistics(SaleProductStatisticsQuery query);

    /**
     * 
     * 商品销售统计列表数量
     * 
     * @param query
     *            查询条件
     * @return Long 数量
     */
    Long getCountsForExportProductStatisticsList(SaleProductStatisticsQuery query);

    /**
     * 
     * 商品销售统计导出列表
     * 
     * @param saleProductStatisticsQuery
     *            查询条件
     * @param startLineNum
     *            开始数
     * @param pageSize
     *            条数
     * @return List<SaleProductStatisticsInfo>
     */
    List<SaleProductStatisticsInfo> listDataForExportProductStatisticsList(
            @Param("saleProductStatisticsQuery") SaleProductStatisticsQuery saleProductStatisticsQuery,
            @Param("startLineNum") Long startLineNum, @Param("pageSize") Integer pageSize);

    /**
     * 
     * 商品销售统计->查看交易明细
     * 
     * @param query
     *            查询条件
     * @return Page<AllVolumeStatisticsInfo>
     */
    Page<SaleProductStatisticsInfo> findSaleProductStatisticsDetail(SaleProductStatisticsQuery query);

    /**
     * 
     * 商品销售统计->查看交易明细数量
     * 
     * @param query
     *            查询条件
     * @return Long 数量
     */
    Long getCountsForExportProductStatisticsDetail(SaleProductStatisticsQuery query);

    /**
     * 
     * 商品销售统计->查看交易明细导出列表
     * 
     * @param saleProductStatisticsQuery
     *            查询条件
     * @param startLineNum
     *            开始数
     * @param pageSize
     *            条数
     * @return List<SaleProductStatisticsInfo>
     */
    List<SaleProductStatisticsInfo> listDataForExportProductStatisticsDetail(
            @Param("saleProductStatisticsQuery") SaleProductStatisticsQuery saleProductStatisticsQuery,
            @Param("startLineNum") Long startLineNum, @Param("pageSize") Integer pageSize);

    /**
     * 
     * 导出订单数量
     * 
     * @param query
     *            订单查询实体
     * @return long 订单数量
     */
    Long getCountsForExportOrder(SaleOrderQueryDto query);

    /**
     * 
     * 获取需要导出的订单列表
     * 
     * @param saleOrderQuery
     *            订单查询实体
     * @param startLineNum
     *            开始行数
     * @param pageSize
     *            每页大小
     * @return List<SaleOrderInfo> 订单列表
     */
    List<SaleOrderInfo> listDataForExportOrder(@Param("saleOrderQueryDto") SaleOrderQueryDto saleOrderQuery,
            @Param("startLineNum") Long startLineNum, @Param("pageSize") Integer pageSize);

    /**
     * @Description TODO(获取待接单数量)
     * @param storeId
     * @param statusCode
     * @return Integer
     */
    Integer getForAcceptOrderCount(@Param("storeId") Integer storeId, @Param("statusCode") String statusCode);

    /**
     * @Description TODO(获取完成订单金额)
     * @param storeId
     * @param statusCode
     * @param beginDate
     * @param endDate
     * @return Long
     */
    Long getFinishOrderAmount(@Param("storeId") Integer storeId, @Param("statusCode") String statusCode,
            @Param("beginDate") Date beginDate, @Param("endDate") Date endDate);

    /**
     * @Description TODO(分页获取卖家订单列表基本信息)
     * @param sellerListOrderQuery
     * @return Page<SaleOrder>
     */
    Page<SaleOrder> findOrderBasicInfoListForSeller(SellerListOrderQuery sellerListOrderQuery);

    /**
     * @Description TODO(通过关键字搜索分页获取卖家订单列表基本信息)
     * @param sellerListOrderQuery
     * @return Page<SaleOrder>
     */
    Page<SaleOrder> findOrderBasicInfoListForSellerWithKeyword(SellerListOrderQuery sellerListOrderQuery);

    /**
     * 付款时改变订单状态
     * 
     * @param saleOrderNo
     *            订单编码
     * @param notPayStatusCode
     *            未付款状态
     * @param forAcceptStatusCode
     *            待接单状态
     * @param paidStatusCode
     *            付款状态
     * @param payTime
     *            付款时间
     * @param payPlatformCode
     *            付款平台
     * @return 影响行数
     */
    int updateOrderStatusForPaid(@Param("saleOrderNo") String saleOrderNo,
            @Param("notPayStatusCode") String notPayStatusCode, @Param("forAcceptStatusCode") String forAcceptStatusCode,
            @Param("paidStatusCode") String paidStatusCode, @Param("payTime") Date payTime,
            @Param("payPlatformCode") String payPlatformCode);

    /**
     * @Description TODO(接单时改变订单状态)
     * @param saleOrderNo
     * @param paidStatusCode
     * @param forSendStatusCode
     * @param acceptTime
     * @param acceptUserId
     * @return int 影响行数
     */
    int updateOrderStatusForAccept(@Param("saleOrderNo") String saleOrderNo, @Param("paidStatusCode") String paidStatusCode,
            @Param("forSendStatusCode") String forSendStatusCode, @Param("acceptTime") Date acceptTime,
            @Param("acceptUserId") Integer acceptUserId);

    /**
     * @Description TODO(卖家订单取消时改变订单状态)
     * @param saleOrderNo
     * @param paidStatusCode
     * @param refundingStatusCode
     * @param cancelTypeCode
     * @param cancelReason
     * @param cancelTime
     * @param cancelUserId
     * @return int 影响行数
     */
    int updateOrderStatusForSellerCancel(@Param("saleOrderNo") String saleOrderNo,
            @Param("paidStatusCode") String paidStatusCode, @Param("refundingStatusCode") String cancelStatusCode,
            @Param("cancelTypeCode") String cancelTypeCode, @Param("cancelReason") String cancelReason,
            @Param("cancelTime") Date cancelTime, @Param("cancelUserId") Integer cancelUserId);

    /**
     * 待发货状态时取消订单
     * 
     * @param saleOrderNo
     *            订单编号
     * @param forSendStatusCode
     *            待发货状态
     * @param refundingStatusCode
     *            退款中
     * @param cancelTypeCode
     *            取消类型编码
     * @param cancelReason
     *            取消原因
     * @param cancelTime
     *            取消时间
     * @param cancelUserId
     *            取消用户ID
     * @return 影响行数
     */
    int updateOrderStatusForSendCancel(@Param("saleOrderNo") String saleOrderNo,
            @Param("forSendStatusCode") String forSendStatusCode, @Param("refundingStatusCode") String refundingStatusCode,
            @Param("cancelTypeCode") String cancelTypeCode, @Param("cancelReason") String cancelReason,
            @Param("cancelTime") Date cancelTime, @Param("cancelUserId") Integer cancelUserId);

    /**
     * 待收状态时取消订单
     * 
     * @param saleOrderNo
     *            订单编号
     * @param forReceiveStatusCode
     *            待收货状态
     * @param refundingStatusCode
     *            退款中
     * @param cancelTypeCode
     *            取消类型编码
     * @param cancelReason
     *            取消原因
     * @param cancelTime
     *            取消时间
     * @param cancelUserId
     *            取消用户ID
     * @return 影响行数
     */
    int updateOrderStatusForReceiveCancel(@Param("saleOrderNo") String saleOrderNo,
            @Param("forReceiveStatusCode") String forReceiveStatusCode,
            @Param("refundingStatusCode") String refundingStatusCode, @Param("cancelTypeCode") String cancelTypeCode,
            @Param("cancelReason") String cancelReason, @Param("cancelTime") Date cancelTime,
            @Param("cancelUserId") Integer cancelUserId);

    /**
     * 用户确认收货时改变订单状态
     * 
     * @param saleOrderNo
     *            订单编号
     * @param forReceiveStatusCode
     *            等收货状态编码
     * @param finishedStatusCode
     *            订单状态完成编码
     * @param takeStatusCode
     *            已收货状态编码
     * @param takeUserId
     *            收货操作人
     * @param takeTime
     *            收货时间
     * @return 影响行数
     */
    int updateOrderStatusForFinished(@Param("saleOrderNo") String saleOrderNo,
            @Param("forReceiveStatusCode") String forReceiveStatusCode,
            @Param("finishedStatusCode") String finishedStatusCode, @Param("takeStatusCode") String takeStatusCode,
            @Param("takeUserId") Integer takeUserId, @Param("takeTime") Date takeTime);

    /**
     * 退款审核成功时修改订单状态
     * 
     * @param saleOrderNo
     *            订单编号
     * @param refundingStatusCode
     *            退款中状态编码
     * @param refundSuccessStatusCode
     *            退款成功编码
     * @param refundAuditUserId
     *            退款审核用户ID
     * @param refundAuditTime
     *            退款审核时间
     * @return 影响行数
     */
    int updateOrderStatusForRefundSuccess(@Param("saleOrderNo") String saleOrderNo,
            @Param("refundingStatusCode") String refundingStatusCode,
            @Param("refundSuccessStatusCode") String refundSuccessStatusCode,
            @Param("refundAuditUserId") Integer refundAuditUserId, @Param("refundAuditTime") Date refundAuditTime);

    /**
     * 退款审核成功时修改订单状态
     * 
     * @param saleOrderNo
     *            订单编号
     * @param refundingStatusCode
     *            退款中状态编码
     * @param refundFailureStatusCode
     *            退款失败编码
     * @param refundFailureReason
     *            退款失败原因
     * @param refundAuditUserId
     *            退款审核用户ID
     * @param refundAuditTime
     *            退款审核时间
     * @return 影响行数
     */
    int updateOrderStatusForRefundFailure(@Param("saleOrderNo") String saleOrderNo,
            @Param("refundingStatusCode") String refundingStatusCode,
            @Param("refundFailureStatusCode") String refundFailureStatusCode,
            @Param("refundFailureReason") String refundFailureReason, @Param("refundAuditUserId") Integer refundAuditUserId,
            @Param("refundAuditTime") Date refundAuditTime);

    /**
     * 用户未付款取消时订单状态变更
     * 
     * @param saleOrderNo
     *            订单编号
     * @param forPayStatusCode
     *            未付款状态
     * @param cancelStatusCode
     *            已取消订单状态
     * @param cancelTypeCode
     *            取消类型
     * @param cancelReason
     *            取消原因
     * @param cancelTime
     *            取消时间
     * @param cancelUserId
     *            取消用户ID
     * @return 影响行数
     */
    int updateOrderStatusForUnPayCancel(@Param("saleOrderNo") String saleOrderNo,
            @Param("forPayStatusCode") String forPayStatusCode, @Param("cancelStatusCode") String cancelStatusCode,
            @Param("cancelTypeCode") String cancelTypeCode, @Param("cancelReason") String cancelReason,
            @Param("cancelUserId") Integer cancelUserId, @Param("cancelTime") Date cancelTime);

    /**
     * @Description TODO(卖家发货时改变订单状态)
     * @param saleOrderNo
     * @param forSendStatusCode
     * @param forReceiveStatusCode
     * @param sendCount
     * @param sendStatus
     * @param sendTime
     * @param sendUserId
     * @return int 影响行数
     */
    int updateOrderStatusForSellerSend(@Param("saleOrderNo") String saleOrderNo,
            @Param("forSendStatusCode") String forSendStatusCode, @Param("forReceiveStatusCode") String forReceiveStatusCode,
            @Param("sendCount") Integer sendCount, @Param("sendStatus") String sendStatus, @Param("sendTime") Date sendTime,
            @Param("sendUserId") Integer sendUserId);

    /**
     * @Description TODO(卖家确认收货时改变订单状态)
     * @param saleOrderNo
     * @param receiveNo
     * @param forReceiveStatusCode
     * @param finishedStatusCode
     * @param takeStatus
     * @param takeTime
     * @param takeUserId
     * @return int 影响行数
     */
    int updateOrderStatusForSellerConfirmReceive(@Param("saleOrderNo") String saleOrderNo,
            @Param("receiveNo") String receiveNo, @Param("forReceiveStatusCode") String forReceiveStatusCode,
            @Param("finishedStatusCode") String finishedStatusCode, @Param("takeStatus") String takeStatus,
            @Param("takeTime") Date takeTime, @Param("takeUserId") Integer takeUserId);

    /**
     * @Description TODO(获取某一时间段内销售佣金总费用)
     * @param storeId
     * @param statusCode
     * @param beginDate
     * @param endDate
     * @return Long
     */
    Long getTotalCommissionAmountByTimes(@Param("storeId") Integer storeId, @Param("statusCode") String statusCode,
            @Param("beginDate") Date beginDate, @Param("endDate") Date endDate);
    
    /**
     * 获取卖家某一时间段内应结算订单总数量
     * 
     * @param storeId
     * @param statusCode
     * @param beginDate
     * @param endDate
     * @return Integer
     */
    Integer getTotalCommissionCountByTimes(@Param("storeId") Integer storeId, @Param("statusCode") String statusCode,
            @Param("beginDate") Date beginDate, @Param("endDate") Date endDate);

    /**
     * 根据收货码获取店铺的订单状态为未付款,待接单,待发货,待收货数量
     * 
     * @param storeId
     *            店铺ID
     * @param receiveCode
     *            收货码
     * @param statusCodes
     *            订单状态
     * @return 订单总数
     */
    Integer getTotalByStoreIdAndReceiveCodeAndStatusCodes(@Param("storeId") Integer storeId,
            @Param("receiveCode") String receiveCode, @Param("statusCodes") List<String> statusCodes);

    /**
     * 卖家根据收货码获取店铺的订单状态为待接单,待发货,待收货的订单编码
     * 
     * @param storeId
     *            店铺ID
     * @param receiveCode
     *            收货码
     * @param statusCodes
     *            订单状态
     * @return 订单编码
     */
    String getSaleOrderNoByStoreIdAndReceiveCodeAndStatusCodes(@Param("storeId") Integer storeId,
            @Param("receiveCode") String receiveCode, @Param("statusCodes") List<String> statusCodes);

    /**
     * @Description TODO(获取卖家某一时间段内所完成订单笔数)
     * @param storeId
     * @param statusCode
     * @param beginDate
     * @param endDate
     * @return Integer
     */
    Integer getFinishOrderCountByTimes(@Param("storeId") Integer storeId, @Param("statusCode") String statusCode,
            @Param("beginDate") Date beginDate, @Param("endDate") Date endDate);

    /**
     * @Description TODO(分页获取订单结算统计详细信息)
     * @param settleDetailQuery
     * @return Page<SettleDetailInfo>
     */
    Page<SettleDetailInfo> findSettleDetails(SettleDetailQuery settleDetailQuery);

    /**
     * 获取若干店铺的销售总额
     * 
     * @param storeIds
     * @param statusCode
     * @return List<FinishOrderAmountInfo>
     */
    List<FinishOrderAmountInfo> listFinishOrderAmountByStoreIds(@Param("storeIds") List<Integer> storeIds,
            @Param("statusCode") String statusCode);

    /**
     * 获取若干店铺的完成订单数
     * 
     * @param storeIds
     * @param statusCode
     * @return List<FinishOrderCountInfo>
     */
    List<FinishOrderCountInfo> listFinishOrderCountByStoreIds(@Param("storeIds") List<Integer> storeIds,
            @Param("statusCode") String statusCode);

    /**
     * 根据订单编号更新订单类型
     * 
     * @param saleOrderNo
     *            订单编号
     * @param typeCode
     *            订单类型
     * @param commissionAmount
     *            佣金
     * @param commissionCount
     *            佣金的商品数量
     * @return 影响行数
     */
    int updateOrderTypeBySaleOrderNo(@Param("saleOrderNo") String saleOrderNo, @Param("typeCode") String typeCode,
            @Param("commissionAmount") Long commissionAmount, @Param("commissionCount") Integer commissionCount);

    /**
     * 获取需要自动收货的订单列表
     * 
     * @param forReceiveStatusCode
     * @param sendTimeForNeedAutoReceive
     * @return List<SaleOrder>
     */
    List<SaleOrder> listOrdersForNeedAutoReceived(@Param("forReceiveStatusCode") String forReceiveStatusCode,
            @Param("sendTimeForNeedAutoReceive") Date sendTimeForNeedAutoReceive,
            @Param("deliveryMode") String deliveryMode);

    /**
     * 根据配送方式和订单状态编码查找订单列表
     * 
     * @param deliveryMode
     *            配送方式
     * @param statusCode
     *            订单状态编码
     * @return 订单列表
     */
    List<SaleOrder> listOrderByDeliveryModeAndStatusCode(@Param("deliveryMode") String deliveryMode,
            @Param("statusCode") String statusCode);

    /**
     * 分页查询推荐订单相关信息
     * 
     * @param statusCodes
     * @param recommendOrderInfoQuery
     * @return Page<RecommendOrderInfo>
     */
    Page<RecommendOrderInfo> findRecommendOrderInfos(@Param("statusCodes") List<String> statusCodes,
            @Param("recommendOrderInfoQuery") RecommendOrderInfoQuery recommendOrderInfoQuery);

    /**
     * 
     * 获取导出的推荐订单总数
     * 
     * @param statusCodes
     * @param recommendOrderInfoQuery
     * @return long
     */
    Long getCountsForExportRecommendOrder(@Param("statusCodes") List<String> statusCodes,
            @Param("recommendOrderInfoQuery") RecommendOrderInfoQuery recommendOrderInfoQuery);

    /**
     * 
     * 获取导出的推荐订单列表
     * 
     * @param statusCodes
     *            订单状态列表
     * @param recommendOrderInfoQuery
     *            查询实体
     * @param startLineNum
     *            开始行数
     * @param pageSize
     *            每页大小
     * @return List<RecommendOrderInfo> 列表
     */
    List<RecommendOrderInfo> listDataForExportRecommendOrder(@Param("statusCodes") List<String> statusCodes,
            @Param("recommendOrderInfoQuery") RecommendOrderInfoQuery recommendOrderInfoQuery,
            @Param("startLineNum") Long startLineNum, @Param("pageSize") Integer pageSize);

    /**
     * 根据订单编号查询订单明细列表信息
     * 
     * @param saleOrderNo
     *            订单编号
     * @param statusCodes
     *            订单状态
     * @return 订单明细信息列表
     */
    List<SaleOrderItemInfo> listSaleOrderItemInfoByOrderNo(@Param("saleOrderNo") String saleOrderNo,
            @Param("statusCodes") List<String> statusCodes);
    
    /**
     * 用户评价后改变订单状态
     * 
     * @param saleOrderNo
     *            订单编号
     * @param saleorderstatusFinished
     *            订单状态完成编码
     * @param saleorderstatusAppraise
     *            订单状态评价编码
     * @param appraiseUserId
     *            收货操作人
     * @param appraiseTime
     *            收货时间
     * @return 影响行数
     */
    Integer updateOrderStatusForAppraise(@Param("saleOrderNo") String saleOrderNo,
            @Param("saleorderstatusFinished") String saleorderstatusFinished, @Param("saleorderstatusAppraise") String saleorderstatusAppraise,
            @Param("appraiseUserId") Integer appraiseUserId, @Param("appraiseTime")Date appraiseTime);

    /**
     * 获取子账号订单列表
     * 
     * @param id	
     * 			子账号id
     * @param saleOrderNo
     * 				订单号
     * @param statusCode
     * 				订单状态		
     * @param beginTime
     * 				订单处理开始时间
     * @param endTime		
     * 				订单处理结束时间
     * @return 
     * 		MsgBean
     */
	Page<SaleOrder> findChildAccountOrder(SaleOrderQuery saleOrderQuery);

}