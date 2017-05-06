package com.yilidi.o2o.order.proxy;

import java.util.Date;
import java.util.List;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.order.proxy.dto.FinishOrderAmountInfoProxyDto;
import com.yilidi.o2o.order.proxy.dto.FinishOrderCountInfoProxyDto;
import com.yilidi.o2o.order.proxy.dto.SaleOrderItemInfoProxyDto;
import com.yilidi.o2o.order.proxy.dto.SaleOrderProxyDto;

/**
 * 订单代理服务接口
 * 
 * @author: chenlian
 * @date: 2016年6月29日 下午5:54:19
 */
public interface IOrderProxyService {

	/**
	 * 获取若干店铺的销售总额
	 * 
	 * @param storeIds
	 * @return List<FinishOrderAmountInfoProxyDto>
	 * @throws OrderServiceException
	 */
	public List<FinishOrderAmountInfoProxyDto> listFinishOrderAmountByStoreIds(List<Integer> storeIds)
			throws OrderServiceException;

	/**
	 * 获取若干店铺的完成订单数
	 * 
	 * @param storeIds
	 * @return List<FinishOrderCountInfoProxyDto>
	 * @throws OrderServiceException
	 */
	public List<FinishOrderCountInfoProxyDto> listFinishOrderCountByStoreIds(List<Integer> storeIds)
			throws OrderServiceException;

	/**
	 * 根据订单编号查找订单明细列表
	 * 
	 * @param saleOrderNo
	 *            订单编号
	 * @param statusCodes
	 *            订单状态列表
	 * @return 订单明细列表
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	public List<SaleOrderItemInfoProxyDto> listSaleOrderItemInfoByOrderNo(String saleOrderNo, List<String> statusCodes)
			throws OrderServiceException;

	/**
	 * 根据订单编号查找订单基础信息
	 * 
	 * @param saleOrderNo
	 *            订单编号
	 * @return 订单基础信息
	 * @throws OrderServiceException
	 *             交易域服务异常
	 */
	public SaleOrderProxyDto loadSaleOrderBasicInfoByOrderno(String saleOrderNo) throws OrderServiceException;
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
     * 发放用户注册奖励
     * 
     * @param userId
     *            操作用户
     * @throws nowTime
     *             当前时间
     */
	public void sendUserRegistAward(Integer userId, Date nowTime);
}
