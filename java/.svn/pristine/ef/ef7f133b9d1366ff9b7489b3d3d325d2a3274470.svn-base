package com.yilidi.o2o.order.proxy;

import java.util.List;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.order.proxy.dto.CouponProxyDto;
import com.yilidi.o2o.order.proxy.dto.UserCouponProxyDto;

/**
 * 用户优惠券代理服务Service接口
 * 
 * @author: chenb
 * @date: 2016年10月19日 上午11:53:56
 */
public interface IUserCouponProxyService {

    /**
     * 新增用户优惠券
     * 
     * @param userCouponProxyDto
     *            用户优惠券信息
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public void saveUserCoupon(UserCouponProxyDto userCouponProxyDto) throws OrderServiceException;

    /**
     * 根据优惠券ID获取优惠券信息
     * 
     * @param couponId
     *            优惠券ID
     * @return 优惠券信息
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public CouponProxyDto loadByCouponId(Integer couponId) throws OrderServiceException;

    /**
     * 新增用户优惠券
     * 
     * @param userCouponProxyDtos
     *            用户优惠券信息列表
     * @throws OrderServiceException
     *             销售域服务异常
     */
    public void saveBatchUserCoupon(List<UserCouponProxyDto> userCouponProxyDtos) throws OrderServiceException;
}
