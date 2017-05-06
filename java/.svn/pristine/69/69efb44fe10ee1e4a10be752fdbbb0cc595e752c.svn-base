package com.yilidi.o2o.order.proxy.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.dao.CouponMapper;
import com.yilidi.o2o.order.dao.CouponPackageMapper;
import com.yilidi.o2o.order.dao.UserCouponMapper;
import com.yilidi.o2o.order.model.Coupon;
import com.yilidi.o2o.order.model.CouponPackage;
import com.yilidi.o2o.order.model.UserCoupon;
import com.yilidi.o2o.order.proxy.IUserCouponProxyService;
import com.yilidi.o2o.order.proxy.dto.CouponProxyDto;
import com.yilidi.o2o.order.proxy.dto.UserCouponProxyDto;
import com.yilidi.o2o.order.service.ICouponService;
import com.yilidi.o2o.order.service.dto.CouponDto;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.system.proxy.IMessageProxyService;
import com.yilidi.o2o.system.proxy.ISystemParamsProxyService;

/**
 * 用户优惠券代理Service接口实现类
 * 
 * @author: chenb
 * @date: 2016年10月19日 下午2:26:53
 */
@Service("userCouponProxyService")
public class UserCouponProxyServiceImpl extends BasicDataService implements IUserCouponProxyService {

    @Autowired
    private CouponMapper couponMapper;

    @Autowired
    private UserCouponMapper userCouponMapper;
    @Autowired
    private CouponPackageMapper couponPackageMapper;
    @Autowired
    private ICouponService couponService;
    @Autowired
    private IMessageProxyService messageProxyService;
    @Autowired 
    private ISystemParamsProxyService systemParamsProxyService;

    @Override
    public void saveUserCoupon(UserCouponProxyDto userCouponProxyDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userCouponProxyDto) || ObjectUtils.isNullOrEmpty(userCouponProxyDto.getConId())
                    || ObjectUtils.isNullOrEmpty(userCouponProxyDto.getUserId())) {
                throw new OrderServiceException("参数不能为空");
            }
            Coupon coupon = couponMapper.loadCouponById(userCouponProxyDto.getConId());
            if (ObjectUtils.isNullOrEmpty(coupon)) {
                logger.info("优惠券:" + userCouponProxyDto.getConId() + "无效");
                throw new OrderServiceException("无效的优惠券");
            }
            if (ObjectUtils.isNullOrEmpty(userCouponProxyDto.getCount())) {
                userCouponProxyDto.setCount(1);
            }
            CouponDto couponDto = new CouponDto();
            ObjectUtils.fastCopy(coupon, couponDto);
            Map<String, Object> timeMap = couponService.getCouponValid(couponDto);
            if(ObjectUtils.isNullOrEmpty(timeMap)){
            	throw new OrderServiceException("没有获取到奖励的优惠券");
            }
            for (int i = 0; i < userCouponProxyDto.getCount(); i++) {
                UserCoupon userCoupon = new UserCoupon();
                userCoupon.setConId(userCouponProxyDto.getConId());
                userCoupon.setUserId(userCouponProxyDto.getUserId());
                userCoupon.setBatchNo(coupon.getBatchNo());
                userCoupon.setStatus(SystemContext.OrderDomain.USERCOUPONSSTATUS_RECEIVED);
                userCoupon.setFindTime(new Date());
                userCoupon.setBeginTime((Date)timeMap.get("beginTime"));
                userCoupon.setEndTime((Date)timeMap.get("endTime"));
                userCouponMapper.save(userCoupon);
            }
        } catch (Exception e) {
            logger.error("saveUserCoupon异常", e);
            throw new OrderServiceException(e.getMessage());
        }

    }

    @Override
    public CouponProxyDto loadByCouponId(Integer couponId) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(couponId)) {
                return null;
            }
            CouponProxyDto couponProxyDto = new CouponProxyDto();
            Coupon coupon = couponMapper.loadCouponById(couponId);
            couponProxyDto.setConId(couponId);
            CouponPackage couponPackage = couponPackageMapper.loadById(coupon.getConPackId());
            if (!ObjectUtils.isNullOrEmpty(couponPackage)) {
                couponProxyDto.setConName(couponPackage.getConName());
                couponProxyDto.setAmount(couponPackage.getAmount());
            }
            return couponProxyDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void saveBatchUserCoupon(List<UserCouponProxyDto> userCouponProxyDtos) throws OrderServiceException {
        try {
            if (!ObjectUtils.isNullOrEmpty(userCouponProxyDtos)) {
            	Integer userId = 0;
            	int couponNum = 0; //单券数量
            	double amount = 0.00;//单券价格
                for (UserCouponProxyDto userCouponProxyDto : userCouponProxyDtos) {
                	userId = userCouponProxyDto.getUserId();
                	couponNum += userCouponProxyDto.getCount();
                	Coupon coupon = couponMapper.loadCouponById(userCouponProxyDto.getConId());
                    CouponPackage couponPackage = couponPackageMapper.loadById(coupon.getConPackId());
                    amount += couponPackage.getAmount()*userCouponProxyDto.getCount();
                    this.saveUserCoupon(userCouponProxyDto);
                }
                
                //可以推送消息
                List<Integer> userIdList = new ArrayList<Integer>();
                userIdList.add(userId);
                String messageTitle = "您获得"+couponNum+"张价值"+amount/1000+"元优惠券";
        		String messageIntro = "亲爱的用户,恭喜您获得了"+couponNum+"张价值"+amount/1000+"元优惠券";
        		messageProxyService.sendPreferenceMessage(CommonConstants.SYSTEM_USER_ID, userIdList, messageTitle, messageIntro, SystemContext.SystemDomain.MESSAGEPUBLISHOBJECT_BUYER_SPECIAL);
    		}
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }

    }
}
