package com.yilidi.o2o.order.proxy.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.service.BaseService;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.dao.CouponMapper;
import com.yilidi.o2o.order.dao.OrderGiftInfoMapper;
import com.yilidi.o2o.order.dao.UserCouponMapper;
import com.yilidi.o2o.order.model.Coupon;
import com.yilidi.o2o.order.model.OrderGiftInfo;
import com.yilidi.o2o.order.model.UserCoupon;
import com.yilidi.o2o.order.proxy.ICouponProxyService;
import com.yilidi.o2o.order.proxy.dto.CouponProxyDto;
import com.yilidi.o2o.order.service.ICouponService;
import com.yilidi.o2o.order.service.IOrderService;
import com.yilidi.o2o.order.service.dto.CouponDto;
import com.yilidi.o2o.order.service.dto.SaleOrderDto;
import com.yilidi.o2o.order.service.dto.UserCouponDto;

@Service("couponProxyService")
public class CouponProxyServiceImpl extends BaseService implements ICouponProxyService {

    @Autowired
    private ICouponService couponService;

    @Autowired
    private OrderGiftInfoMapper orderGiftInfoMapper;
    @Autowired
    private IOrderService orderService;
    @Autowired
    private CouponMapper couponMapper;
    @Autowired
    private UserCouponMapper userCouponMapper;

    @Override
    public CouponProxyDto loadCouponById(Integer id) {
        CouponProxyDto couponProxyDto = null;
        CouponDto couponDto = couponService.loadCouponById(id);
        if (!ObjectUtils.isNullOrEmpty(couponDto)) {
            couponProxyDto = new CouponProxyDto();
            ObjectUtils.fastCopy(couponDto, couponProxyDto);
            couponProxyDto.setConId(couponDto.getId());
            couponProxyDto.setConName(couponDto.getConPackName());
        }
        return couponProxyDto;
    }

    @Override
    public Map<String, Object> getCouponValid(CouponProxyDto couponProxyDto) {
        Map<String, Object> timeMap = null;
        List<CouponDto> couponDtoList = couponService.getCouponByPackIdBatchNoGrantWay(couponProxyDto.getConPackId(),
                couponProxyDto.getBatchNo(), couponProxyDto.getGrantWay());
        if (!ObjectUtils.isNullOrEmpty(couponDtoList)) {
            timeMap = new HashMap<String, Object>();
            Date beginTime = null;
            Date endTime = null;
            for (int i = 0; i < couponDtoList.size(); i++) {
                if (couponDtoList.get(i).getStageNo() == 1) {
                    beginTime = new Date();
                } else {
                    beginTime = endTime;
                }
                endTime = DateUtils.addDays(beginTime, Integer.parseInt(couponDtoList.get(i).getValidTypeValue()));
                if ((i + 1) == couponProxyDto.getStageNo()) {
                    break;
                }
            }
            timeMap.put("beginTime", beginTime);
            timeMap.put("endTime", endTime);
        }
        return timeMap;
    }

    @Override
    public List<CouponProxyDto> listCouponByIds(List<Integer> couponIds) {
        try {
            if (ObjectUtils.isNullOrEmpty(couponIds)) {
                return Collections.emptyList();
            }
            List<CouponProxyDto> couponProxyDtos = new ArrayList<CouponProxyDto>(5);
            for (Integer couponId : couponIds) {
                CouponProxyDto couponProxyDto = this.loadCouponById(couponId);
                couponProxyDtos.add(couponProxyDto);
            }
            return couponProxyDtos;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void saveBuyRewardActivity(String orderNo, Integer operationUserId, Date nowTime) {
        try {
            List<OrderGiftInfo> orderGiftInfos = orderGiftInfoMapper.listBySaleOrderNo(orderNo, null, null,
                    SystemContext.OrderDomain.ORDERGIFTSTATUS_UNSEND);
            SaleOrderDto saleOrderDto = orderService.loadBySaleOrderNo(orderNo);
            if (ObjectUtils.isNullOrEmpty(saleOrderDto)) {
                return;
            }
            if (!ObjectUtils.isNullOrEmpty(orderGiftInfos)) {
                for (OrderGiftInfo orderGiftInfo : orderGiftInfos) {
                    UserCouponDto userCouponDto = new UserCouponDto();
                    userCouponDto.setUserId(saleOrderDto.getUserId());
                    userCouponDto.setConId(orderGiftInfo.getGiftId());
                    Coupon coupon = couponMapper.loadCouponById(orderGiftInfo.getGiftId());
                    if (ObjectUtils.isNullOrEmpty(coupon)) {
                        logger.info("优惠券:" + orderGiftInfo.getGiftId() + "无效");
                        throw new OrderServiceException("无效的优惠券");
                    }
                    CouponDto couponDto = new CouponDto();
                    ObjectUtils.fastCopy(coupon, couponDto);
                    Map<String, Object> timeMap = couponService.getCouponValid(couponDto);
                    if (ObjectUtils.isNullOrEmpty(timeMap)) {
                        throw new OrderServiceException("没有获取到奖励的优惠券");
                    }
                    for (int i = 0; i < orderGiftInfo.getGiftCount(); i++) {
                        UserCoupon userCoupon = new UserCoupon();
                        userCoupon.setConId(orderGiftInfo.getGiftId());
                        userCoupon.setUserId(saleOrderDto.getUserId());
                        userCoupon.setBatchNo(coupon.getBatchNo());
                        userCoupon.setStatus(SystemContext.OrderDomain.USERCOUPONSSTATUS_RECEIVED);
                        userCoupon.setFindTime(nowTime);
                        userCoupon.setBeginTime((Date) timeMap.get("beginTime"));
                        userCoupon.setEndTime((Date) timeMap.get("endTime"));
                        userCouponMapper.save(userCoupon);
                    }
                }
            }
            orderGiftInfoMapper.updateStatusForSendedByOrderNo(orderNo, SystemContext.OrderDomain.ORDERGIFTSTATUS_UNSEND,
                    SystemContext.OrderDomain.ORDERGIFTSTATUS_SENDED, operationUserId, nowTime);
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }

    }

}
