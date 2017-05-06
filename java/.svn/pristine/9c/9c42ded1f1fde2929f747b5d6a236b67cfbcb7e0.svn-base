/**
 * 文件名称：OrderService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.service;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.order.service.dto.AllVolumeStatisticsInfoDto;
import com.yilidi.o2o.order.service.dto.CreateOrderDto;
import com.yilidi.o2o.order.service.dto.RecommendOrderInfoDto;
import com.yilidi.o2o.order.service.dto.SaleOrderDetailDto;
import com.yilidi.o2o.order.service.dto.SaleOrderDto;
import com.yilidi.o2o.order.service.dto.SaleOrderInfoDto;
import com.yilidi.o2o.order.service.dto.SaleOrderItemInfoDto;
import com.yilidi.o2o.order.service.dto.SaleOrderStatisticsDto;
import com.yilidi.o2o.order.service.dto.SaleProductStatisticsInfoDto;
import com.yilidi.o2o.order.service.dto.SaveOrderDto;
import com.yilidi.o2o.order.service.dto.SellerOrderDetailDto;
import com.yilidi.o2o.order.service.dto.SellerOrderListDto;
import com.yilidi.o2o.order.service.dto.SettleDetailDto;
import com.yilidi.o2o.order.service.dto.query.AllVolumeStatisticsQuery;
import com.yilidi.o2o.order.service.dto.query.RecommendOrderInfoQueryDto;
import com.yilidi.o2o.order.service.dto.query.SaleOrderQueryDto;
import com.yilidi.o2o.order.service.dto.query.SaleOrderStatisticsQuery;
import com.yilidi.o2o.order.service.dto.query.SaleProductStatisticsQuery;
import com.yilidi.o2o.order.service.dto.query.SellerListOrderQueryDto;
import com.yilidi.o2o.order.service.dto.query.SettleDetailQueryDto;

/**
 * 功能描述：订单服务接口 <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
public interface IOrderService {

	/**
	 * 根据订单号加载订单信息
	 * 
	 * @param saleOrderNo
	 *            订单编号
	 * @return 订单详情
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	SaleOrderDto loadBySaleOrderNo(String saleOrderNo) throws OrderServiceException;

	/**
	 * 查询订单分页
	 * 
	 * @param query
	 *            订单查询条件
	 * @return 订单列表
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	YiLiDiPage<SaleOrderInfoDto> findSaleOrderInfos(SaleOrderQueryDto query) throws OrderServiceException;

	/**
	 * 查询订单和订单明细分页
	 * 
	 * @param query
	 *            查询条件
	 * @return 订单列表
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	YiLiDiPage<SaleOrderDto> findSaleOrders(SaleOrderQueryDto query) throws OrderServiceException;

	/**
	 * 
	 * 根据订单号查看订单详情
	 * 
	 * @param orderNo
	 *            订单编号
	 * @return 详情dto
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	SaleOrderDetailDto findOrderDetailByOrderNo(String orderNo) throws OrderServiceException;

	/**
	 * 
	 * 用户销售统计列表
	 * 
	 * @param query
	 *            用户销售统计查询列表
	 * @return 用户销售统计列表
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	YiLiDiPage<SaleOrderStatisticsDto> findOrderStatisticsDtos(SaleOrderStatisticsQuery query)
			throws OrderServiceException;

	/**
	 * 用户销售统计导出列表数量
	 * 
	 * @param query
	 *            查询条件
	 * @return 数量
	 * @throws OrderServiceException
	 *             销售域服务异常
	 */
	Long getCountsForExportOrderStatistics(SaleOrderStatisticsQuery query) throws OrderServiceException;

	/**
	 * 
	 * 用户销售统计导出列表
	 * 
	 * @param query
	 *            用户销售统计导出查询列表
	 * @param startLineNum
	 *            开始行数
	 * @param pageSize
	 *            分页大小
	 * @return 用户销售统计导出列表
	 * @throws OrderServiceException
	 *             销售域服务异常
	 */
	List<SaleOrderStatisticsDto> listDataForExportOrderStatistics(SaleOrderStatisticsQuery query, Long startLineNum,
			Integer pageSize) throws OrderServiceException;

	/**
	 * 根据订单状态列表查询订单信息
	 * 
	 * @param statusCodes
	 *            订单状态列表
	 * @return 订单信息列表
	 * @throws OrderServiceException
	 *             销售域服务异常
	 */
	List<SaleOrderDto> listSaleOrderByStatusCodes(List<String> statusCodes) throws OrderServiceException;

	/**
	 * 
	 * 用户下单记录 按时间(下单笔数，下单金额)
	 * 
	 * @param query
	 *            用户下单记录条件
	 * @return 用户下单记录列表
	 * @throws OrderServiceException
	 *             销售域服务异常
	 */
	YiLiDiPage<SaleOrderStatisticsDto> findOrderStatisticsDtosByDate(SaleOrderStatisticsQuery query)
			throws OrderServiceException;

	/**
	 * 
	 * 用户下单记录导出数量
	 * 
	 * @param query
	 *            用户下单记录条件
	 * @return 数量
	 * @throws OrderServiceException
	 *             销售域服务异常
	 */
	Long getCountsForExportOrderStatisticsByDate(SaleOrderStatisticsQuery query) throws OrderServiceException;

	/**
	 * 
	 * 用户下单记录导出列表
	 * 
	 * @param query
	 *            查询
	 * @param startLineNum
	 *            开始行数
	 * @param pageSize
	 *            分页大小
	 * @return 用户下单记录导出列表
	 * @throws OrderServiceException
	 *             销售域服务异常
	 */
	List<SaleOrderStatisticsDto> listDataForExportOrderStatisticsByDate(SaleOrderStatisticsQuery query,
			Long startLineNum, Integer pageSize) throws OrderServiceException;

	/**
	 * 销量汇总统计
	 * 
	 * @return AllVolumeStatisticsInfoDto
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	public AllVolumeStatisticsInfoDto loadAllVolumeStatisticsInfoDto() throws OrderServiceException;

	/**
	 * 销量汇总统计明细
	 * 
	 * @param query
	 *            查询条件
	 * @return YiLiDiPage
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	public YiLiDiPage<AllVolumeStatisticsInfoDto> findAllVolumeStatisticsInfosDetail(AllVolumeStatisticsQuery query)
			throws OrderServiceException;

	/**
	 * 
	 * 销量汇总统计明细数量
	 * 
	 * @param query
	 *            查询条件
	 * @return Long
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	public Long getCountsForExportVolumeStatisticsDetail(AllVolumeStatisticsQuery query) throws OrderServiceException;

	/**
	 * 
	 * 导出销量汇总统计明细列表
	 * 
	 * @param query
	 *            查询条件
	 * @param startLineNum
	 *            开始行数
	 * @param pageSize
	 *            分页大小
	 * @return List<AllVolumeStatisticsInfoDto>
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	public List<AllVolumeStatisticsInfoDto> listDataForExportVolumeStatisticsDetail(AllVolumeStatisticsQuery query,
			Long startLineNum, Integer pageSize) throws OrderServiceException;

	/**
	 * 
	 * 门店销售统计 或者查看门店每天的销售统计
	 * 
	 * @param query
	 *            查询条件
	 * @return YiLiDiPage
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	public YiLiDiPage<AllVolumeStatisticsInfoDto> findAllVolumeStatisticsInfosForStore(AllVolumeStatisticsQuery query)
			throws OrderServiceException;

	/**
	 * 
	 * 门店每天的销售排行数量
	 * 
	 * @param query
	 *            查询条件
	 * @return Long
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	public Long getCountsForExportStoreVolumeByOneDay(AllVolumeStatisticsQuery query) throws OrderServiceException;

	/**
	 * 
	 * 门店每天的销售排行 导出列表
	 * 
	 * @param query
	 *            查询条件
	 * @param startLineNum
	 *            开始行数
	 * @param pageSize
	 *            分页大小
	 * @return List<AllVolumeStatisticsInfoDto>
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	public List<AllVolumeStatisticsInfoDto> listDataForExportStoreVolumeByOneDay(AllVolumeStatisticsQuery query,
			Long startLineNum, Integer pageSize) throws OrderServiceException;

	/**
	 * 
	 * 门店销售统计数量
	 * 
	 * @param query
	 *            查询条件
	 * @return Long
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	public Long getCountsForExportStoreVolumeList(AllVolumeStatisticsQuery query) throws OrderServiceException;

	/**
	 * 
	 * 门店销售统计 导出列表
	 * 
	 * @param query
	 *            查询条件
	 * @param startLineNum
	 *            开始行数
	 * @param pageSize
	 *            分页大小
	 * @return List<AllVolumeStatisticsInfoDto>
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	public List<AllVolumeStatisticsInfoDto> listDataForExportStoreVolumeList(AllVolumeStatisticsQuery query,
			Long startLineNum, Integer pageSize) throws OrderServiceException;

	/**
	 * 
	 * 门店销售统计 ->查看下单记录
	 * 
	 * @param query
	 *            查询条件
	 * @return YiLiDiPage
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	public YiLiDiPage<AllVolumeStatisticsInfoDto> findAllVolumeStatisticsInfosForStoreByDay(
			AllVolumeStatisticsQuery query) throws OrderServiceException;

	/**
	 * 
	 * 门店销售统计->查看下单记录数量
	 * 
	 * @param query
	 *            查询条件
	 * @return Long
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	public Long getCountsForExportStoreVolumeListForDay(AllVolumeStatisticsQuery query) throws OrderServiceException;

	/**
	 * 
	 * 门店销售统计->查看下单记录导出列表
	 * 
	 * @param query
	 *            查询条件
	 * @param startLineNum
	 *            开始数
	 * @param pageSize
	 *            条数
	 * @return List<AllVolumeStatisticsInfoDto>
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	public List<AllVolumeStatisticsInfoDto> listDataForExportStoreVolumeListForDay(AllVolumeStatisticsQuery query,
			Long startLineNum, Integer pageSize) throws OrderServiceException;

	/**
	 * 
	 * 商品销售统计
	 * 
	 * @param query
	 *            查询条件
	 * @return YiLiDiPage
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	public YiLiDiPage<SaleProductStatisticsInfoDto> findSaleProductStatistics(SaleProductStatisticsQuery query)
			throws OrderServiceException;

	/**
	 * 
	 * 商品销售统计导出数量
	 * 
	 * @param query
	 *            查询条件
	 * @return Long
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	public Long getCountsForExportProductStatisticsList(SaleProductStatisticsQuery query) throws OrderServiceException;

	/**
	 * 商品销售统计导出列表
	 * 
	 * @param query
	 *            查询条件
	 * @param startLineNum
	 *            开始数
	 * @param pageSize
	 *            条数
	 * @return List<SaleProductStatisticsInfoDto>
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	public List<SaleProductStatisticsInfoDto> listDataForExportProductStatisticsList(SaleProductStatisticsQuery query,
			Long startLineNum, Integer pageSize) throws OrderServiceException;

	/**
	 * 
	 * 商品销售统计->查看交易明细
	 * 
	 * @param query
	 *            查询条件
	 * @return YiLiDiPage
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	public YiLiDiPage<SaleProductStatisticsInfoDto> findSaleProductStatisticsDetail(SaleProductStatisticsQuery query)
			throws OrderServiceException;

	/**
	 * 
	 * 商品销售统计->查看交易明细导出数量
	 * 
	 * @param query
	 *            查询条件
	 * @return Long
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	public Long getCountsForExportProductStatisticsDetail(SaleProductStatisticsQuery query)
			throws OrderServiceException;

	/**
	 * 商品销售统计->查看交易明细导出列表
	 * 
	 * @param query
	 *            查询条件
	 * @param startLineNum
	 *            开始行数
	 * @param pageSize
	 *            分页大小
	 * @return List<SaleProductStatisticsInfoDto>
	 * @throws OrderServiceException
	 *             销售域服务异常
	 */
	public List<SaleProductStatisticsInfoDto> listDataForExportProductStatisticsDetail(SaleProductStatisticsQuery query,
			Long startLineNum, Integer pageSize) throws OrderServiceException;

	/**
	 * 
	 * 订单导出的总记录数
	 * 
	 * @param saleOrderQuery
	 *            查询条件
	 * @return Long
	 * @throws OrderServiceException
	 *             销售域服务异常
	 */
	public Long getCountsForExportOrder(SaleOrderQueryDto saleOrderQuery) throws OrderServiceException;

	/**
	 * 
	 * 订单导出列表
	 * 
	 * @param saleOrderQuery
	 *            订单查询实体
	 * @param startLineNum
	 *            开始行数
	 * @param pageSize
	 *            分页大小
	 * @return List<SaleOrderInfoDto>
	 * @throws OrderServiceException
	 *             销售域服务异常
	 */
	public List<SaleOrderInfoDto> listDataForExportOrder(SaleOrderQueryDto saleOrderQuery, Long startLineNum,
			Integer pageSize) throws OrderServiceException;

	/**
	 * 买家订单取消
	 * 
	 * @param saleOrderNo
	 *            订单编号
	 * @param userId
	 *            用户ID
	 * @param cancelReason
	 *            取消原因
	 * @throws OrderServiceException
	 *             订单域服务异常
	 */
	public void updateOrderForBuyerCancel(String saleOrderNo, Integer userId, String cancelReason)
			throws OrderServiceException;

	/**
	 * 运营取消订单
	 * 
	 * @param saleOrderNo
	 *            订单编号
	 * @param userId
	 *            用户ID
	 * @param cancelReason
	 *            取消原因
	 * @throws OrderServiceException
	 *             订单域服务异常
	 */
	public void updateOrderForOperationCancel(String saleOrderNo, Integer userId, String cancelReason)
			throws OrderServiceException;

	/**
	 * 退款审核通过
	 * 
	 * @param saleOrderNo
	 *            订单编号
	 * @param userId
	 *            用户ID
	 * @throws OrderServiceException
	 *             订单域服务异常
	 */
	public void updateOrderForOperationRefundAuditPassed(String saleOrderNo, Integer userId)
			throws OrderServiceException;

	/**
	 * 退款审核不通过
	 * 
	 * @param saleOrderNo
	 *            订单编号
	 * @param refundReason
	 *            退款不通过原因
	 * @param userId
	 *            用户ID
	 * @throws OrderServiceException
	 *             订单域服务异常
	 */
	public void updateOrderForOperationRefundAuditUnpassed(String saleOrderNo, String refundReason, Integer userId)
			throws OrderServiceException;

	/**
	 * 系统取消订单
	 * 
	 * @param saleOrderDto
	 *            订单对象
	 * @param nowDate
	 *            操作时间
	 * @throws OrderServiceException
	 *             订单域服务异常
	 */
	public void updateOrderForSystemCancel(SaleOrderDto saleOrderDto, Date nowDate) throws OrderServiceException;

	/**
	 * 生成订单
	 * 
	 * @param createOrderDto
	 *            创建订单数据
	 * @return SaveOrderDto
	 * @throws OrderServiceException
	 *             销售域服务异常
	 */
	SaveOrderDto saveCreateOrder(CreateOrderDto createOrderDto) throws OrderServiceException;

	/**
	 * 获取待接单数量
	 * 
	 * @param storeId
	 *            店铺ID
	 * @return Integer 待接单数量
	 * @throws OrderServiceException
	 *             销售域服务异常
	 */
	public Integer getForAcceptOrderCount(Integer storeId) throws OrderServiceException;

	/**
	 * 获取完成订单金额
	 * 
	 * @param storeId
	 *            店铺ID
	 * @param beginDate
	 *            开始时间
	 * @param endDate
	 *            结束时间
	 * @return Long 订单金额
	 * @throws OrderServiceException
	 *             服务异常
	 */
	public Long getFinishOrderAmount(Integer storeId, Date beginDate, Date endDate) throws OrderServiceException;

	/**
	 * 分页获取卖家订单列表信息
	 * 
	 * @param sellerListOrderQueryDto
	 *            查询条件
	 * @return YiLiDiPage<SellerOrderListDto> 订单分页信息
	 * @throws OrderServiceException
	 *             服务异常
	 */
	public YiLiDiPage<SellerOrderListDto> findOrderListForSeller(SellerListOrderQueryDto sellerListOrderQueryDto)
			throws OrderServiceException;

	/**
	 * 卖家显示订单详情
	 * 
	 * @param saleOrderNo
	 *            订单编码
	 * @param storeId
	 *            店铺ID
	 * @param storePhoneNo
	 *            店铺手机
	 * @return SellerOrderDetailDto 订单详情信息
	 * @throws OrderServiceException
	 *             服务异常
	 */
	public SellerOrderDetailDto showOrderDetailForSeller(String saleOrderNo, Integer storeId, String storePhoneNo)
			throws OrderServiceException;

	/**
	 * 订单接单
	 * 
	 * @param saleOrderNo
	 *            订单编码
	 * @param storeId
	 *            店铺ID
	 * @param storePhoneNo
	 *            店铺手机
	 * @param acceptUserId
	 *            接单用户ID
	 * @param acceptTime
	 *            接收时间
	 * @return Integer 订单ID
	 * @throws OrderServiceException
	 *             服务异常
	 */
	public Integer updateForAccept(String saleOrderNo, Integer storeId, String storePhoneNo, Integer acceptUserId,
			Date acceptTime) throws OrderServiceException;

	/**
	 * 接单时改变订单状态
	 * 
	 * @param saleOrderNo
	 *            订单编码
	 * @param acceptTime
	 *            接单时间
	 * @param acceptUserId
	 *            接单用户ID
	 * @return int 影响行数
	 * @throws OrderServiceException
	 *             服务异常
	 */
	public int updateOrderStatusForAccept(String saleOrderNo, Date acceptTime, Integer acceptUserId)
			throws OrderServiceException;

	/**
	 * 卖家取消订单
	 * 
	 * @param saleOrderNo
	 *            订单编码
	 * @param storeId
	 *            店铺ID
	 * @param cancelUserId
	 *            取消用户ID
	 * @param cancelTime
	 *            取消时间
	 * @return Integer 订单ID
	 * @throws OrderServiceException
	 *             服务异常
	 */
	public Integer updateForSellerCancel(String saleOrderNo, Integer storeId, Integer cancelUserId, Date cancelTime)
			throws OrderServiceException;

	/**
	 * 用户确认收货
	 * 
	 * @param saleOrderNo
	 *            订单编号
	 * @param userId
	 *            操作用户
	 * @throws OrderServiceException
	 *             销售域服务异常
	 */
	public void updateOrderConfirm(String saleOrderNo, Integer userId) throws OrderServiceException;
	
	/**
     * 用户评价订单
     * 
     * @param saleOrderNo
     *            订单编号
     * @param userId
     *            操作用户
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public void updateOrderStatusForAppraise(String saleOrderNo, Integer userId) throws OrderServiceException;

	/**
	 * 卖家发货
	 * 
	 * @param saleOrderNo
	 *            订单编码
	 * @param storeId
	 *            店铺ID
	 * @param storePhoneNo
	 *            店铺手机
	 * @param sendStatus
	 *            发货状态
	 * @param sendUserId
	 *            发货用户ID
	 * @param sendTime
	 *            发货时间
	 * @return Integer 订单ID
	 * @throws OrderServiceException
	 *             服务异常
	 */
	public Integer updateForSellerSend(String saleOrderNo, Integer storeId, String storePhoneNo, String sendStatus,
			Integer sendUserId, Date sendTime) throws OrderServiceException;

	/**
	 * 卖家发货时改变订单状态
	 * 
	 * @param saleOrderNo
	 *            订单编码
	 * @param sendCount
	 *            发货数量
	 * @param sendStatus
	 *            发货状态
	 * @param sendTime
	 *            发货时间
	 * @param sendUserId
	 *            发货用户ID
	 * @return int 影响行数
	 * @throws OrderServiceException
	 *             服务异常
	 */
	public int updateOrderStatusForSellerSend(String saleOrderNo, Integer sendCount, String sendStatus, Date sendTime,
			Integer sendUserId) throws OrderServiceException;

	/**
	 * 卖家确认收货
	 * 
	 * @param saleOrderNo
	 *            订单编码
	 * @param receiveNo
	 *            收货码
	 * @param storeId
	 *            店铺ID
	 * @param takeStatus
	 *            收货状态
	 * @param takeUserId
	 *            收货用户ID
	 * @param takeTime
	 *            收货时间
	 * @return Integer 订单ID
	 * @throws OrderServiceException
	 *             服务异常
	 */
	public Integer updateForSellerConfirmReceive(String saleOrderNo, String receiveNo, Integer storeId,
			String takeStatus, Integer takeUserId, Date takeTime) throws OrderServiceException;

	/**
	 * 卖家确认收货时改变订单状态
	 * 
	 * @param saleOrderNo
	 *            订单编码
	 * @param receiveNo
	 *            收货码
	 * @param takeStatus
	 *            收货状态
	 * @param takeTime
	 *            收货时间
	 * @param takeUserId
	 *            收货用户ID
	 * @return int 影响行数
	 * @throws OrderServiceException
	 *             服务异常
	 */
	public int updateOrderStatusForSellerConfirmReceive(String saleOrderNo, String receiveNo, String takeStatus,
			Date takeTime, Integer takeUserId) throws OrderServiceException;

	/**
	 * 获取卖家某一时间段内销售佣金总费用
	 * 
	 * @param storeId
	 *            店铺ID
	 * @param beginDate
	 *            开始时间
	 * @param endDate
	 *            结束时间
	 * @return Long 佣金总额
	 * @throws OrderServiceException
	 *             服务异常
	 */
	public Long getTotalCommissionAmountByTimes(Integer storeId, Date beginDate, Date endDate)
			throws OrderServiceException;

	/**
	 * 获取卖家某一时间段内应结算订单总数量
	 * 
	 * @param storeId
	 *            店铺ID
	 * @param beginDate
	 *            开始时间
	 * @param endDate
	 *            结束时间
	 * @return Integer 应结算订单总数量
	 * @throws OrderServiceException
	 *             服务异常
	 */
	public Integer getTotalCommissionCountByTimes(Integer storeId, Date beginDate, Date endDate)
			throws OrderServiceException;

	/**
	 * 获取卖家某一时间段内所完成订单笔数
	 * 
	 * @param storeId
	 *            店铺ID
	 * @param beginDate
	 *            开始时间
	 * @param endDate
	 *            结束时间
	 * @return Integer 订单笔数
	 * @throws OrderServiceException
	 *             服务异常
	 */
	public Integer getFinishOrderCountByTimes(Integer storeId, Date beginDate, Date endDate)
			throws OrderServiceException;

	/**
	 * 分页获取订单结算统计详细信息
	 * 
	 * @param settleDetailQueryDto
	 *            查询条件
	 * @return YiLiDiPage<SettleDetailDto> 统计详细分页信息
	 * @throws OrderServiceException
	 *             服务异常
	 */
	public YiLiDiPage<SettleDetailDto> findSettleDetails(SettleDetailQueryDto settleDetailQueryDto)
			throws OrderServiceException;

	/**
	 * 卖家利用收货码获取订单编号
	 * 
	 * @param storeId
	 *            店铺ID
	 * @param receiveCode
	 *            收货码
	 * @return String 订单编号
	 * @throws OrderServiceException
	 *             服务异常
	 */
	public String getSaleOrderNoBySellerWithReceiveCode(Integer storeId, String receiveCode)
			throws OrderServiceException;

	/**
	 * 更新订单信息为已付款在线支付订单
	 * 
	 * @param payLogOrderNo
	 *            支付日志编码
	 * @param paySequence
	 *            支付日志流水
	 * @param payerId
	 *            支付用户ID
	 * @param payerEmail
	 *            支付用户账号
	 * @throws OrderServiceException
	 *             服务异常
	 */
	public void updateOrderOnlinePay(String payLogOrderNo, String paySequence, String payerId, String payerEmail)
			throws OrderServiceException;

	/**
	 * 获取需要自动收货的订单列表
	 * 
	 * @param forReceiveStatusCode
	 * @param takeTime
	 * @return List<SaleOrderDto>
	 * @throws OrderServiceException
	 */
	public List<SaleOrderDto> listOrdersForNeedAutoReceived(String forReceiveStatusCode, Date takeTime)
			throws OrderServiceException;

	/**
	 * 根据配送方式和订单状态编码获取订单列表
	 * 
	 * @param deliveryMode
	 *            配送方式
	 * @param statusCode
	 *            订单状态编码
	 * @return 订单列表
	 * @throws OrderServiceException
	 *             订单服务异常
	 */
	public List<SaleOrderDto> listOrderByDeliveryModeAndStatusCode(String deliveryMode, String statusCode)
			throws OrderServiceException;

	/**
	 * 分页查询推荐订单相关信息
	 * 
	 * @param recommendOrderInfoQueryDto
	 *            查询条件
	 * @return 推荐订单相关信息
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	YiLiDiPage<RecommendOrderInfoDto> findRecommendOrderInfos(RecommendOrderInfoQueryDto recommendOrderInfoQueryDto)
			throws OrderServiceException;

	/**
	 * 
	 * 推荐订单导出的总记录数
	 * 
	 * @param recommendOrderInfoQueryDto
	 *            查询条件
	 * @return Long
	 * @throws OrderServiceException
	 *             销售域服务异常
	 */
	public Long getCountsForExportRecommendOrder(RecommendOrderInfoQueryDto recommendOrderInfoQueryDto)
			throws OrderServiceException;

	/**
	 * 
	 * 推荐订单导出列表
	 * 
	 * @param recommendOrderInfoQueryDto
	 *            查询DTO
	 * @param startLineNum
	 *            开始行数
	 * @param pageSize
	 *            分页大小
	 * @return 推荐订单导出列表
	 * @throws OrderServiceException
	 *             销售域服务异常
	 */
	List<RecommendOrderInfoDto> listDataForExportRecommendOrder(RecommendOrderInfoQueryDto recommendOrderInfoQueryDto,
			Long startLineNum, Integer pageSize) throws OrderServiceException;

	/**
	 * 根据订单编号查询订单明细信息列表
	 * 
	 * @param saleOrderNo
	 *            订单编号
	 * @param statusCodes
	 *            订单状态列表
	 * @return 订单明细信息列表
	 * @throws OrderServiceException
	 *             销售域服务异常
	 */
	List<SaleOrderItemInfoDto> listSaleOrderItemInfoByOrderNo(String saleOrderNo, List<String> statusCodes)
			throws OrderServiceException;

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
	YiLiDiPage<SaleOrderDto> getChildAccountOrder(SaleOrderQueryDto saleOrderQueryDto);

}
