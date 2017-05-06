/**
 * 文件名称：OrderProxyService.java
 * 
 * 描述：
 * 
 *
 */
package com.yilidi.o2o.order.proxy.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.service.BaseService;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.dao.SaleOrderMapper;
import com.yilidi.o2o.order.model.SaleOrder;
import com.yilidi.o2o.order.model.result.FinishOrderAmountInfo;
import com.yilidi.o2o.order.model.result.FinishOrderCountInfo;
import com.yilidi.o2o.order.model.result.SaleOrderItemInfo;
import com.yilidi.o2o.order.proxy.IOrderProxyService;
import com.yilidi.o2o.order.proxy.dto.FinishOrderAmountInfoProxyDto;
import com.yilidi.o2o.order.proxy.dto.FinishOrderCountInfoProxyDto;
import com.yilidi.o2o.order.proxy.dto.SaleOrderItemInfoProxyDto;
import com.yilidi.o2o.order.proxy.dto.SaleOrderProxyDto;
import com.yilidi.o2o.order.service.ICouponService;
import com.yilidi.o2o.order.service.IOrderService;
import com.yilidi.o2o.order.service.IVoucherService;
import com.yilidi.o2o.order.service.dto.CouponDto;
import com.yilidi.o2o.order.service.dto.CouponPackageDto;
import com.yilidi.o2o.order.service.dto.UserCouponDto;
import com.yilidi.o2o.order.service.dto.UserVoucherDto;
import com.yilidi.o2o.order.service.dto.VoucherDto;
import com.yilidi.o2o.system.proxy.IMessageProxyService;
import com.yilidi.o2o.system.proxy.ISystemParamsProxyService;

/**
 * 功能描述：<简单描述> <br/>
 * 作者：chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("orderProxyService")
public class OrderProxyService extends BaseService implements IOrderProxyService {

    @Autowired
    private SaleOrderMapper saleOrderMapper;

    @Autowired
    private IOrderService orderService;
    @Autowired
    private ICouponService couponService;
    @Autowired
    private IVoucherService voucherService;
    @Autowired
    private IMessageProxyService messageProxyService;
    @Autowired 
    private ISystemParamsProxyService systemParamsProxyService;

    public List<FinishOrderAmountInfoProxyDto> listFinishOrderAmountByStoreIds(List<Integer> storeIds)
            throws OrderServiceException {
        try {
            List<FinishOrderAmountInfo> finishOrderAmountInfoList = this.saleOrderMapper
                    .listFinishOrderAmountByStoreIds(storeIds, SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED);
            List<FinishOrderAmountInfoProxyDto> finishOrderAmountInfoProxyDtoList = new ArrayList<FinishOrderAmountInfoProxyDto>();
            if (!ObjectUtils.isNullOrEmpty(finishOrderAmountInfoList)) {
                for (FinishOrderAmountInfo info : finishOrderAmountInfoList) {
                    FinishOrderAmountInfoProxyDto finishOrderAmountInfoProxyDto = new FinishOrderAmountInfoProxyDto();
                    ObjectUtils.fastCopy(info, finishOrderAmountInfoProxyDto);
                    finishOrderAmountInfoProxyDtoList.add(finishOrderAmountInfoProxyDto);
                }
            }
            return finishOrderAmountInfoProxyDtoList;
        } catch (Exception e) {
            String msg = "获取若干店铺的销售总额出现系统异常";
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    public List<FinishOrderCountInfoProxyDto> listFinishOrderCountByStoreIds(List<Integer> storeIds)
            throws OrderServiceException {
        try {
            List<FinishOrderCountInfo> finishOrderCountInfoList = this.saleOrderMapper
                    .listFinishOrderCountByStoreIds(storeIds, SystemContext.OrderDomain.SALEORDERSTATUS_FINISHED);
            List<FinishOrderCountInfoProxyDto> finishOrderCountInfoProxyDtoList = new ArrayList<FinishOrderCountInfoProxyDto>();
            if (!ObjectUtils.isNullOrEmpty(finishOrderCountInfoList)) {
                for (FinishOrderCountInfo info : finishOrderCountInfoList) {
                    FinishOrderCountInfoProxyDto finishOrderCountInfoProxyDto = new FinishOrderCountInfoProxyDto();
                    ObjectUtils.fastCopy(info, finishOrderCountInfoProxyDto);
                    finishOrderCountInfoProxyDtoList.add(finishOrderCountInfoProxyDto);
                }
            }
            return finishOrderCountInfoProxyDtoList;
        } catch (Exception e) {
            String msg = "获取若干店铺的完成订单数出现系统异常";
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    @Override
    public List<SaleOrderItemInfoProxyDto> listSaleOrderItemInfoByOrderNo(String saleOrderNo, List<String> statusCodes)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(saleOrderNo)) {
                return Collections.emptyList();
            }
            if (ObjectUtils.isNullOrEmpty(statusCodes)) {
                statusCodes = null;
            }
            List<SaleOrderItemInfo> saleOrderItemInfos = saleOrderMapper.listSaleOrderItemInfoByOrderNo(saleOrderNo,
                    statusCodes);
            if (ObjectUtils.isNullOrEmpty(saleOrderItemInfos)) {
                return Collections.emptyList();
            }
            List<SaleOrderItemInfoProxyDto> saleOrderItemProxyDtos = new ArrayList<SaleOrderItemInfoProxyDto>();
            for (SaleOrderItemInfo saleOrderItemInfo : saleOrderItemInfos) {
                SaleOrderItemInfoProxyDto saleOrderItemProxyDto = new SaleOrderItemInfoProxyDto();
                ObjectUtils.fastCopy(saleOrderItemInfo, saleOrderItemProxyDto);
                saleOrderItemProxyDtos.add(saleOrderItemProxyDto);
            }
            return saleOrderItemProxyDtos;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public SaleOrderProxyDto loadSaleOrderBasicInfoByOrderno(String saleOrderNo) throws OrderServiceException {
        try {
            SaleOrderProxyDto saleOrderProxyDto = null;
            if (ObjectUtils.isNullOrEmpty(saleOrderNo)) {
                return saleOrderProxyDto;
            }
            SaleOrder saleOrder = saleOrderMapper.loadBySaleOrderNo(saleOrderNo);
            if (!ObjectUtils.isNullOrEmpty(saleOrder)) {
                saleOrderProxyDto = new SaleOrderProxyDto();
                ObjectUtils.fastCopy(saleOrder, saleOrderProxyDto);
            }
            return saleOrderProxyDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateOrderStatusForAppraise(String saleOrderNo, Integer userId) throws OrderServiceException {
        try {
            orderService.updateOrderStatusForAppraise(saleOrderNo, userId);
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

	@Override
	public void sendUserRegistAward(Integer userId, Date nowTime) {
		//查询当前注册送优惠券活动
		List<CouponDto> couponDtoList = couponService.getValidRegistUseCouponActive(nowTime);
		if(!ObjectUtils.isNullOrEmpty(couponDtoList)){
			//发放优惠券
			Map<String, Object> timeMap = null;
			UserCouponDto userCouponDto = null;
			double amount = 0.00;
			for (CouponDto couponDto : couponDtoList) {
				timeMap = couponService.getCouponValid(couponDto);
				if(!ObjectUtils.isNullOrEmpty(timeMap)){
					CouponPackageDto pack = couponService.loadCouponPackageById(couponDto.getConPackId());
					amount += pack.getAmount();
					userCouponDto = new UserCouponDto();
					userCouponDto.setBatchNo(couponDto.getBatchNo());
					userCouponDto.setConId(couponDto.getId());
					userCouponDto.setFindTime(new Date());
					userCouponDto.setUserId(userId);
					userCouponDto.setBeginTime((Date)timeMap.get("beginTime"));
					userCouponDto.setEndTime((Date)timeMap.get("endTime"));
					userCouponDto.setStatus(SystemContext.OrderDomain.USERCOUPONSSTATUS_RECEIVED);
					couponService.saveUserCoupon(userCouponDto);
				}
			}
			//可以推送消息
			List<Integer> userIdList = new ArrayList<Integer>();
			userIdList.add(userId);
			String messageTitle = "您获得"+couponDtoList.size()+"张价值"+amount/1000+"元优惠券";
			String messageIntro = "亲爱的用户,恭喜您获得了"+couponDtoList.size()+"张价值"+amount/1000+"元优惠券";
			messageProxyService.sendPreferenceMessage(CommonConstants.SYSTEM_USER_ID, userIdList, messageTitle, messageIntro,SystemContext.SystemDomain.MESSAGEPUBLISHOBJECT_BUYER_SPECIAL);
		}
		//查询当前注册送抵用券活动
		List<VoucherDto> voucherDtoList = voucherService.getValidRegistUsevoucherActive(nowTime);
		if(!ObjectUtils.isNullOrEmpty(voucherDtoList)){
			//发放抵用券
			UserVoucherDto userVoucherDto = null;  
			for (VoucherDto voucherDto : voucherDtoList) {
				userVoucherDto = new UserVoucherDto();
				userVoucherDto.setBatchNo(voucherDto.getBatchNo());
				userVoucherDto.setUserId(userId);
				userVoucherDto.setVouId(voucherDto.getId());
				userVoucherDto.setUseTime(new Date());
				userVoucherDto.setStatus(SystemContext.OrderDomain.USERVOUCHERSTATUS_RECEIVED);
				voucherService.saveUserVoucher(userVoucherDto);
			}
		}
	}

}
