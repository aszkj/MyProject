package com.yilidi.o2o.order.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.dao.CouponMapper;
import com.yilidi.o2o.order.dao.CouponPackageMapper;
import com.yilidi.o2o.order.dao.UserCouponMapper;
import com.yilidi.o2o.order.model.Coupon;
import com.yilidi.o2o.order.model.CouponPackage;
import com.yilidi.o2o.order.model.UserCoupon;
import com.yilidi.o2o.order.model.query.CouponPackageQuery;
import com.yilidi.o2o.order.model.query.CouponQuery;
import com.yilidi.o2o.order.model.query.UserCouponQuery;
import com.yilidi.o2o.order.model.result.CouponInfo;
import com.yilidi.o2o.order.model.result.UserCouponInfo;
import com.yilidi.o2o.order.proxy.ICouponProxyService;
import com.yilidi.o2o.order.proxy.dto.CouponProxyDto;
import com.yilidi.o2o.order.service.ICouponService;
import com.yilidi.o2o.order.service.dto.CouponBasicInfoDto;
import com.yilidi.o2o.order.service.dto.CouponDto;
import com.yilidi.o2o.order.service.dto.CouponPackageDto;
import com.yilidi.o2o.order.service.dto.UserCouponDto;
import com.yilidi.o2o.order.service.dto.UserCouponInfoDto;
import com.yilidi.o2o.order.service.dto.query.CouponPackageQueryDto;
import com.yilidi.o2o.order.service.dto.query.CouponQueryDto;
import com.yilidi.o2o.order.service.dto.query.UserCouponQueryDto;
import com.yilidi.o2o.product.proxy.IProductClassProxyService;
import com.yilidi.o2o.product.proxy.IProductProxyService;
import com.yilidi.o2o.product.proxy.IRedEnvelopeProxyService;
import com.yilidi.o2o.product.proxy.dto.ProductClassProxyDto;
import com.yilidi.o2o.product.proxy.dto.ProductProxyDto;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.system.proxy.IMessageProxyService;
import com.yilidi.o2o.user.proxy.IUserProxyService;
import com.yilidi.o2o.user.proxy.dto.UserProxyDto;
import com.yilidi.o2o.user.proxy.dto.UserShareAwardProxyDto;

/**
 * 优惠券Service接口实现类
 * 
 * @author: chenlian
 * @date: 2016年10月19日 下午2:26:53
 */
@Service("couponService")
public class CouponServiceImpl extends BasicDataService implements ICouponService {

    /** 无效 **/
    private static final int USERCOUPONSTATUS_INVALID = 0;

    @Autowired
    private CouponPackageMapper couponPackageMapper;

    @Autowired
    private CouponMapper couponMapper;

    @Autowired
    private UserCouponMapper userCouponMapper;

    @Autowired
    private IUserProxyService userProxyService;

    @Autowired
    private IRedEnvelopeProxyService redEnvelopeProxyService;

    @Autowired
    private IProductClassProxyService productClassProxyService;

    @Autowired
    private IProductProxyService productProxyService;

    @Autowired
    private ICouponProxyService couponProxyService;
    @Autowired
    private IMessageProxyService messageProxyService;

    @Override
    public void saveCouponPackage(CouponPackageDto couponPackageDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(couponPackageDto)) {
                throw new OrderServiceException("参数couponPackageDto不能为空");
            }
            CouponPackage couponPackage = new CouponPackage();
            ObjectUtils.fastCopy(couponPackageDto, couponPackage);
            couponPackageMapper.save(couponPackage);
        } catch (Exception e) {
            logger.error("saveCouponPackage异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateCouponPackage(CouponPackageDto couponPackageDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(couponPackageDto)) {
                throw new OrderServiceException("参数couponPackageDto不能为空");
            }
            CouponPackage couponPackage = couponPackageMapper.loadById(couponPackageDto.getId());
            couponPackage.setConName(couponPackageDto.getConName());
            couponPackage.setAmount(couponPackageDto.getAmount());
            couponPackage.setUseCondition(couponPackageDto.getUseCondition());
            couponPackage.setModifyTime(couponPackageDto.getModifyTime());
            couponPackage.setModifyUserId(couponPackageDto.getModifyUserId());
            couponPackageMapper.update(couponPackage);
        } catch (Exception e) {
            logger.error("updateCouponPackage异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public CouponPackageDto loadCouponPackageById(Integer id) throws OrderServiceException {
        CouponPackageDto couponPackageDto = null;
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new OrderServiceException("参数id不能为空");
            }
            CouponPackage couponPackage = couponPackageMapper.loadById(id);
            if (!ObjectUtils.isNullOrEmpty(couponPackage)) {
                couponPackageDto = new CouponPackageDto();
                ObjectUtils.fastCopy(couponPackage, couponPackageDto);
            }
            return couponPackageDto;
        } catch (Exception e) {
            logger.error("loadCouponPackageById异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateCouponPackageStateById(Integer id, String state, Integer modifyUserId, Date modifyTime)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new OrderServiceException("参数id不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(state)) {
                throw new OrderServiceException("参数state不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                throw new OrderServiceException("参数modifyUserId不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(modifyTime)) {
                throw new OrderServiceException("参数modifyTime不能为空");
            }
            CouponPackage couponPackage = couponPackageMapper.loadById(id);
            couponPackage.setState(state);
            couponPackage.setModifyUserId(modifyUserId);
            couponPackage.setModifyTime(modifyTime);
            couponPackageMapper.updateStateById(id, state, modifyUserId, modifyTime);
        } catch (Exception e) {
            logger.error("updateCouponPackageStateById异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<CouponPackageDto> findCouponPackages(CouponPackageQueryDto couponPackageQueryDto)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(couponPackageQueryDto)) {
                throw new OrderServiceException("参数couponPackageQueryDto不能为空");
            }
            if (null == couponPackageQueryDto.getStart() || couponPackageQueryDto.getStart() <= 0) {
                couponPackageQueryDto.setStart(1);
            }
            if (null == couponPackageQueryDto.getPageSize() || couponPackageQueryDto.getPageSize() <= 0) {
                couponPackageQueryDto.setPageSize(CommonConstants.PAGE_SIZE);
            }
            Page<CouponPackageDto> pageDto = new Page<CouponPackageDto>(couponPackageQueryDto.getStart(),
                    couponPackageQueryDto.getPageSize());
            CouponPackageQuery couponPackageQuery = new CouponPackageQuery();
            ObjectUtils.fastCopy(couponPackageQueryDto, couponPackageQuery);
            PageHelper.startPage(couponPackageQuery.getStart(), couponPackageQuery.getPageSize());
            Page<CouponPackage> page = couponPackageMapper.findCouponPackages(couponPackageQuery);
            ObjectUtils.fastCopy(page, pageDto);
            List<CouponPackage> couponPackages = page.getResult();
            for (CouponPackage couponPackage : couponPackages) {
                CouponPackageDto couponPackageDto = new CouponPackageDto();
                ObjectUtils.fastCopy(couponPackage, couponPackageDto);
                pageDto.add(couponPackageDto);
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findCouponPackages异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public Map<String, Object> saveForGrantCoupons(CouponDto couponDto) throws OrderServiceException {
        // 返回controller的数据，是否可以推送消息
        Map<String, Object> map = null;
        try {
            if (ObjectUtils.isNullOrEmpty(couponDto)) {
                throw new OrderServiceException("参数couponDto不能为空");
            }
            // 注册有礼，系统中只能存在一种,去数据库查询当前券包有没有注册有礼的发放方式的优惠券
            if (couponDto.getGrantWay().equals(SystemContext.OrderDomain.COUPONSGRANTWAY_REGIST_GIFT)) {
                List<Coupon> couponList = couponMapper
                        .getCouponByGrantWay(SystemContext.OrderDomain.COUPONSGRANTWAY_REGIST_GIFT);
                if (!ObjectUtils.isNullOrEmpty(couponList)) {
                    int conPackId = -1;
                    for (Coupon coupon : couponList) {
                        // 根据优惠券查券包
                        if (conPackId != coupon.getConPackId().intValue()) {
                            CouponPackage pack = couponPackageMapper.loadById(coupon.getConPackId());
                            if (!ObjectUtils.isNullOrEmpty(pack)
                                    && pack.getState().equals(SystemContext.OrderDomain.COUPONSSTATE_GRANTED)) {
                                throw new OrderServiceException("券包" + pack.getConName() + "已经存在（注册有礼）的发放方式了，不能添加");
                            }
                        }
                        conPackId = coupon.getConPackId().intValue();
                    }
                }
            }
            // 先更新券包表
            this.updateCouponPackageStateById(couponDto.getConPackId(), SystemContext.OrderDomain.COUPONSSTATE_GRANTED,
                    couponDto.getGrantUserId(), couponDto.getGrantTime());
            // 生成批次号
            String batchNo = StringUtils.generateGrantCouponBatchNo();
            couponDto.setBatchNo(batchNo);
            String[] validTypeValues = couponDto.getValidTypeValue().split("\\|");
            if (!ObjectUtils.isNullOrEmpty(validTypeValues)) {
                Date beginTime = null;
                Date endTime = null;
                for (int i = 0; i < validTypeValues.length; i++) {
                    int stageNo = i + 1;
                    couponDto.setValidTypeValue(validTypeValues[i]);
                    couponDto.setStageNo(stageNo);
                    Integer conId = this.saveCoupon(couponDto);
                    // 处理优惠券有效期时间
                    if (couponDto.getValidType().equals(SystemContext.OrderDomain.COUPONVALIDTYPE_CUSTOMTYPE)) {
                        String[] values = validTypeValues[i].split(",");
                        beginTime = DateUtils.parseDate(values[0]);
                        endTime = DateUtils.parseDate(values[1]);
                    } else if (couponDto.getValidType().equals(SystemContext.OrderDomain.COUPONVALIDTYPE_SYSTEMTYPE)) {
                        if (stageNo == 1) {
                            beginTime = new Date();
                        } else {
                            beginTime = endTime;
                        }
                        endTime = DateUtils.addDays(beginTime, Integer.parseInt(validTypeValues[i]));
                    }
                    if (SystemContext.OrderDomain.COUPONSGRANTWAY_AUTO_RELEASE.equals(couponDto.getGrantWay())) {
                        List<Integer> userIdsList = null;
                        if (SystemContext.OrderDomain.COUPONSGRANTRANGE_BATCH.equals(couponDto.getGrantRange())) {
                            if (SystemContext.OrderDomain.BUYERUSERTYPELABEL_ALL.equals(couponDto.getBuyerUserType())) {
                                userIdsList = userProxyService
                                        .listUserIdsByCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
                            }
                        }
                        if (SystemContext.OrderDomain.COUPONSGRANTRANGE_SINGLE.equals(couponDto.getGrantRange())) {
                            String userNames = couponDto.getUserNames();
                            if (!ObjectUtils.isNullOrEmpty(userNames)) {
                                List<String> userNameList = Arrays.asList(userNames.split(","));
                                userIdsList = userProxyService.listUserIdsByUserNames(userNameList);
                            }
                        }
                        if (!ObjectUtils.isNullOrEmpty(userIdsList)) {
                            for (Integer userId : userIdsList) {
                                UserProxyDto userProxyDto = userProxyService.getUserById(userId);
                                if (ObjectUtils.isNullOrEmpty(userProxyDto)) {
                                    continue;
                                }
                                if (SystemContext.UserDomain.CUSTOMERTYPE_BUYER.equals(userProxyDto.getCustomerType())
                                        && SystemContext.UserDomain.USERAUDITSTATUS_PASSED
                                                .equals(userProxyDto.getAuditStatusCode())
                                        && SystemContext.UserDomain.USERSTATUS_ON.equals(userProxyDto.getStatusCode())) {
                                    UserCouponDto userCouponDto = new UserCouponDto();
                                    userCouponDto.setConId(conId);
                                    userCouponDto.setUserId(userId);
                                    userCouponDto.setBatchNo(batchNo);
                                    userCouponDto.setBeginTime(beginTime);
                                    userCouponDto.setEndTime(endTime);
                                    userCouponDto.setFindTime(couponDto.getGrantTime());
                                    if (DateUtils.getCurrentDateTime().before(beginTime)) {
                                        userCouponDto.setStatus(SystemContext.OrderDomain.USERCOUPONSSTATUS_RECEIVED);
                                    }
                                    if (DateUtils.getCurrentDateTime().after(beginTime)
                                            && DateUtils.getCurrentDateTime().before(endTime)) {
                                        userCouponDto.setStatus(SystemContext.OrderDomain.USERCOUPONSSTATUS_USABLE);
                                    }
                                    if (DateUtils.getCurrentDateTime().equals(beginTime)
                                            || DateUtils.getCurrentDateTime().equals(endTime)) {
                                        userCouponDto.setStatus(SystemContext.OrderDomain.USERCOUPONSSTATUS_USABLE);
                                    }
                                    if (DateUtils.getCurrentDateTime().after(endTime)) {
                                        userCouponDto.setStatus(SystemContext.OrderDomain.USERCOUPONSSTATUS_EXPIRED);
                                    }
                                    this.saveUserCoupon(userCouponDto);

                                }
                                // 将要推送的消息返回去
                                CouponPackage pack = couponPackageMapper.loadById(couponDto.getConPackId());
                                map = new HashMap<>();
                                map.put("flag", true);
                                map.put("userIdList", userIdsList);
                                map.put("couponNum", validTypeValues.length);
                                map.put("couponPrice", pack.getAmount());
                                map.put("grantRange", couponDto.getGrantRange());
                            }
                        }
                    }
                }
            }
            return map;
        } catch (Exception e) {
            logger.error("saveForGrantCoupons异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public int saveCoupon(CouponDto couponDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(couponDto)) {
                throw new OrderServiceException("参数couponDto不能为空");
            }
            Coupon coupon = new Coupon();
            ObjectUtils.fastCopy(couponDto, coupon);
            couponMapper.save(coupon);
            return coupon.getId();
        } catch (Exception e) {
            logger.error("saveCoupon异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void saveUserCoupon(UserCouponDto userCouponDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userCouponDto)) {
                throw new OrderServiceException("参数userCouponDto不能为空");
            }
            UserCoupon userCoupon = new UserCoupon();
            ObjectUtils.fastCopy(userCouponDto, userCoupon);
            userCouponMapper.save(userCoupon);
        } catch (Exception e) {
            logger.error("saveUserCoupon异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void saveUserCouponForGrabRedEnvelope(UserCouponDto userCouponDto, Integer userRedEnvelopeActivityId)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userCouponDto)) {
                throw new OrderServiceException("参数userCouponDto不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(userRedEnvelopeActivityId)) {
                throw new OrderServiceException("参数userRedEnvelopeActivityId不能为空");
            }
            UserCoupon userCoupon = new UserCoupon();
            ObjectUtils.fastCopy(userCouponDto, userCoupon);
            userCouponMapper.save(userCoupon);
            redEnvelopeProxyService.updateUserActivityByIdWithRedEnvelopeCount(userRedEnvelopeActivityId);
        } catch (Exception e) {
            logger.error("saveUserCouponForGrabRedEnvelope异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public UserCouponDto loadUserCouponById(Integer id) throws OrderServiceException {
        UserCouponDto userCouponDto = null;
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new OrderServiceException("参数id不能为空");
            }
            UserCoupon userCoupon = userCouponMapper.loadUserCouponById(id);
            if (!ObjectUtils.isNullOrEmpty(userCoupon)) {
                userCouponDto = new UserCouponDto();
                ObjectUtils.fastCopy(userCoupon, userCouponDto);
            }
            return userCouponDto;
        } catch (Exception e) {
            logger.error("loadUserCouponById异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<UserCouponInfoDto> findUserCoupons(UserCouponQueryDto userCouponQueryDto)
            throws OrderServiceException {
        try {
            if (null == userCouponQueryDto.getStart() || userCouponQueryDto.getStart() <= 0) {
                userCouponQueryDto.setStart(1);
            }
            if (null == userCouponQueryDto.getPageSize() || userCouponQueryDto.getPageSize() <= 0) {
                userCouponQueryDto.setPageSize(CommonConstants.PAGE_SIZE);
            }
            Page<UserCouponInfoDto> pageDto = new Page<UserCouponInfoDto>(userCouponQueryDto.getStart(),
                    userCouponQueryDto.getPageSize());
            UserCouponQuery userCouponQuery = new UserCouponQuery();
            ObjectUtils.fastCopy(userCouponQueryDto, userCouponQuery);
            PageHelper.startPage(userCouponQuery.getStart(), userCouponQuery.getPageSize());
            Page<UserCouponInfo> page = userCouponMapper.findUserCoupons(userCouponQuery);
            ObjectUtils.fastCopy(page, pageDto);
            List<UserCouponInfo> userCouponInfos = page.getResult();
            for (UserCouponInfo userCouponInfo : userCouponInfos) {
                UserCouponInfoDto userCouponInfoDto = new UserCouponInfoDto();
                ObjectUtils.fastCopy(userCouponInfo, userCouponInfoDto);
                userCouponInfoDto.setStatusName(super.getSystemDictName(
                        SystemContext.OrderDomain.DictType.USERCOUPONSSTATUS.getValue(), userCouponInfoDto.getStatus()));
                userCouponInfoDto.setUseRangeCodeName(super.getSystemDictName(
                        SystemContext.OrderDomain.DictType.COUPONSUSERANGE.getValue(), userCouponInfoDto.getUseRangeCode()));
                pageDto.add(userCouponInfoDto);
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findUserCoupons异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<UserCouponDto> listUserCouponsByAIdAndCId(Integer activityId, Integer conId) throws OrderServiceException {
        List<UserCouponDto> userCouponDtoList = null;
        try {
            List<UserCoupon> userCouponList = userCouponMapper.listByActivityIdAndConId(activityId, conId);
            if (!ObjectUtils.isNullOrEmpty(userCouponList)) {
                userCouponDtoList = new ArrayList<UserCouponDto>();
                for (UserCoupon userCoupon : userCouponList) {
                    UserCouponDto userCouponDto = new UserCouponDto();
                    ObjectUtils.fastCopy(userCoupon, userCouponDto);
                    userCouponDtoList.add(userCouponDto);
                }
            }
            return userCouponDtoList;
        } catch (Exception e) {
            logger.error("listUserCouponsByAIdAndCId异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<UserCouponDto> listUserCouponsByAIdAndCIdAndUIdAndStatus(Integer activityId, Integer conId, Integer userId,
            List<String> statusList) {
        List<UserCouponDto> userCouponDtoList = null;
        try {
            List<UserCoupon> userCouponList = userCouponMapper.listByActivityIdAndConIdAndUserIdAndStatus(activityId, conId,
                    userId, statusList);
            if (!ObjectUtils.isNullOrEmpty(userCouponList)) {
                userCouponDtoList = new ArrayList<UserCouponDto>();
                for (UserCoupon userCoupon : userCouponList) {
                    UserCouponDto userCouponDto = new UserCouponDto();
                    ObjectUtils.fastCopy(userCoupon, userCouponDto);
                    userCouponDtoList.add(userCouponDto);
                }
            }
            return userCouponDtoList;
        } catch (Exception e) {
            logger.error("listUserCouponsByAIdAndCIdAndUIdAndStatus异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<UserCouponDto> listCouponsForNeedAutoUpdateStatus(List<String> statusList) throws OrderServiceException {
        List<UserCouponDto> userCouponDtoList = null;
        try {
            List<UserCoupon> userCouponList = userCouponMapper.listCouponsForNeedAutoUpdateStatus(statusList);
            if (!ObjectUtils.isNullOrEmpty(userCouponList)) {
                userCouponDtoList = new ArrayList<UserCouponDto>();
                for (UserCoupon userCoupon : userCouponList) {
                    UserCouponDto userCouponDto = new UserCouponDto();
                    ObjectUtils.fastCopy(userCoupon, userCouponDto);
                    userCouponDtoList.add(userCouponDto);
                }
            }
            return userCouponDtoList;
        } catch (Exception e) {
            logger.error("listCouponsForNeedAutoUpdateStatus异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public CouponDto loadCouponById(Integer id) throws OrderServiceException {
        CouponDto couponDto = null;
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new OrderServiceException("参数id不能为空");
            }
            Coupon coupon = couponMapper.loadCouponById(id);
            if (!ObjectUtils.isNullOrEmpty(coupon)) {
                couponDto = new CouponDto();
                ObjectUtils.fastCopy(coupon, couponDto);
                if (!StringUtils.isEmpty(coupon.getUseRangeCode())) {
                    couponDto.setUseRangeCodeName(super.getSystemDictName(
                            SystemContext.OrderDomain.DictType.COUPONSUSERANGE.getValue(), couponDto.getUseRangeCode()));
                }
                if (!StringUtils.isEmpty(coupon.getGrantWay())) {
                    couponDto.setGrantWayName(super.getSystemDictName(
                            SystemContext.OrderDomain.DictType.COUPONSGRANTWAY.getValue(), couponDto.getGrantWay()));
                }
                CouponPackage couponPackage = couponPackageMapper.loadById(coupon.getConPackId());
                if (!ObjectUtils.isNullOrEmpty(couponPackage)) {
                    couponDto.setConPackName(couponPackage.getConName());
                }
            }
            return couponDto;
        } catch (Exception e) {
            logger.error("loadCouponById异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateUserCouponStatusById(Integer id, String status) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new OrderServiceException("参数id不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(status)) {
                throw new OrderServiceException("参数status不能为空");
            }
            UserCoupon userCoupon = userCouponMapper.loadUserCouponById(id);
            userCoupon.setStatus(status);
            userCouponMapper.updateStatusById(id, status);
        } catch (Exception e) {
            logger.error("updateUserCouponStatusById异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateUseCouponById(List<Integer> userCouponIdList, String status, Date useTime)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userCouponIdList)) {
                return;
            }
            if (ObjectUtils.isNullOrEmpty(status)) {
                return;
            }
            for (Integer userCouponId : userCouponIdList) {
                userCouponMapper.updateUseCouponById(userCouponId, status, useTime);
            }
        } catch (Exception e) {
            logger.error("updateUserCouponStatusByIds异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateUserCouponStatusIfEffectiveByIds(List<Integer> userCouponIdList, String status)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userCouponIdList)) {
                return;
            }
            if (ObjectUtils.isNullOrEmpty(status)) {
                return;
            }
            Date nowTime = new Date();
            for (Integer userCouponId : userCouponIdList) {
                UserCoupon userCoupon = userCouponMapper.loadUserCouponById(userCouponId);
                if (ObjectUtils.isNullOrEmpty(userCoupon)) {
                    continue;
                }
                Coupon coupon = couponMapper.loadCouponById(userCoupon.getConId());
                if (ObjectUtils.isNullOrEmpty(coupon)) {
                    continue;
                }
                if (!userCoupon.getBeginTime().after(nowTime) && !userCoupon.getEndTime().before(nowTime)) {
                    userCouponMapper.updateStatusById(userCouponId, status);
                }
            }
        } catch (Exception e) {
            logger.error("updateUserCouponStatusIfEffectiveByIds异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<CouponBasicInfoDto> listCouponsForRedEnvelopeActivity(Integer conPackId) throws OrderServiceException {
        List<CouponBasicInfoDto> couponBasicInfoDtoList = null;
        try {
            String grantWay = SystemContext.OrderDomain.COUPONSGRANTWAY_RED_ENVELOPE;
            String customerType = SystemContext.UserDomain.CUSTOMERTYPE_BUYER;
            String buyerUserType = SystemContext.OrderDomain.BUYERUSERTYPELABEL_ALL;
            List<Coupon> couponList = couponMapper.listCouponsForRedEnvelopeActivity(grantWay, conPackId, customerType,
                    buyerUserType);
            if (!ObjectUtils.isNullOrEmpty(couponList)) {
                for (Coupon coupon : couponList) {
                    CouponPackageDto couponPackageDto = this.loadCouponPackageById(conPackId);
                    if (ObjectUtils.isNullOrEmpty(couponBasicInfoDtoList)) {
                        couponBasicInfoDtoList = new ArrayList<CouponBasicInfoDto>();
                    }
                    CouponBasicInfoDto couponBasicInfoDto = new CouponBasicInfoDto();
                    couponBasicInfoDto.setConId(coupon.getId());
                    couponBasicInfoDto.setConName(couponPackageDto.getConName());
                    couponBasicInfoDto.setGrantTime(coupon.getGrantTime());
                    couponBasicInfoDto.setBatchNo(coupon.getBatchNo());
                    couponBasicInfoDto.setStageNo(coupon.getStageNo());
                    couponBasicInfoDtoList.add(couponBasicInfoDto);
                }
            }
            return couponBasicInfoDtoList;
        } catch (Exception e) {
            logger.error("listCouponsForRedEnvelopeActivity异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<UserCouponInfoDto> findUserCouponsByRealTimeStatus(Integer userId, Date currentTime,
            Integer userCouponStatus, Integer pageNo, Integer pageSize) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userId)) {
                throw new OrderServiceException("param userId cant not be null");
            }
            if (ObjectUtils.isNullOrEmpty(currentTime)) {
                currentTime = new Date();
            }
            boolean isValid = true; // 默认有效
            if (userCouponStatus != null && USERCOUPONSTATUS_INVALID == userCouponStatus.intValue()) {
                isValid = false;
            }
            if (null == pageNo) {
                pageNo = 1;
            }
            if (null == pageSize) {
                pageSize = CommonConstants.PAGE_SIZE;
            }
            Page<UserCouponInfoDto> pageDto = new Page<UserCouponInfoDto>(pageNo, pageSize);
            PageHelper.startPage(pageNo, pageSize);
            Page<UserCouponInfo> page = userCouponMapper.findUserCouponsByRealTimeStatus(userId, currentTime,
                    SystemContext.OrderDomain.USERCOUPONSSTATUS_USED, isValid);
            ObjectUtils.fastCopy(page, pageDto);
            List<UserCouponInfo> userCouponInfos = page.getResult();
            for (UserCouponInfo userCouponInfo : userCouponInfos) {
                UserCouponInfoDto userCouponInfoDto = new UserCouponInfoDto();
                ObjectUtils.fastCopy(userCouponInfo, userCouponInfoDto);
                userCouponInfoDto.setStatusName(super.getSystemDictName(
                        SystemContext.OrderDomain.DictType.USERCOUPONSSTATUS.getValue(), userCouponInfoDto.getStatus()));
                userCouponInfoDto.setUseRangeCodeName(super.getSystemDictName(
                        SystemContext.OrderDomain.DictType.COUPONSUSERANGE.getValue(), userCouponInfoDto.getUseRangeCode()));
                pageDto.add(userCouponInfoDto);
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public Integer getValidUserCouponCountByUserId(Integer userId, Date currentTime) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userId)) {
                return 0;
            }
            if (ObjectUtils.isNullOrEmpty(currentTime)) {
                currentTime = new Date();
            }
            return userCouponMapper.getValidUserCouponCountByUserId(userId, SystemContext.OrderDomain.USERCOUPONSSTATUS_USED,
                    currentTime);
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<UserCouponInfoDto> listValidAndUsebleUserCoupons(Integer userId, Date currentTime)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userId)) {
                return Collections.emptyList();
            }
            if (ObjectUtils.isNullOrEmpty(currentTime)) {
                currentTime = new Date();
            }
            List<UserCouponInfo> userCouponInfoList = userCouponMapper.listValidAndUsebleUserCoupons(userId, currentTime,
                    SystemContext.OrderDomain.USERCOUPONSSTATUS_USED);
            List<UserCouponInfoDto> userCouponInfoDtoList = new ArrayList<UserCouponInfoDto>();
            if (!ObjectUtils.isNullOrEmpty(userCouponInfoList)) {
                for (UserCouponInfo userCouponInfo : userCouponInfoList) {
                    UserCouponInfoDto userCouponInfoDto = new UserCouponInfoDto();
                    ObjectUtils.fastCopy(userCouponInfo, userCouponInfoDto);
                    userCouponInfoDto.setStatusName(super.getSystemDictName(
                            SystemContext.OrderDomain.DictType.USERCOUPONSSTATUS.getValue(), userCouponInfoDto.getStatus()));
                    userCouponInfoDto.setUseRangeCodeName(
                            super.getSystemDictName(SystemContext.OrderDomain.DictType.COUPONSUSERANGE.getValue(),
                                    userCouponInfoDto.getUseRangeCode()));
                    userCouponInfoDtoList.add(userCouponInfoDto);
                }
            }
            return userCouponInfoDtoList;
        } catch (Exception e) {
            logger.error("listValidAndUsebleUserCoupons异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public UserCouponInfoDto loadUserCouponByUserIdAndUserCouponId(Integer userId, Integer userCouponId) {
        try {
            if (ObjectUtils.isNullOrEmpty(userId) || ObjectUtils.isNullOrEmpty(userCouponId)) {
                return null;
            }
            UserCouponInfo userCouponInfo = userCouponMapper.loadUserCouponByUserIdAndUserCouponId(userId, userCouponId);
            UserCouponInfoDto userCouponInfoDto = null;
            if (!ObjectUtils.isNullOrEmpty(userCouponInfo)) {
                userCouponInfoDto = new UserCouponInfoDto();
                ObjectUtils.fastCopy(userCouponInfo, userCouponInfoDto);
                userCouponInfoDto.setStatusName(super.getSystemDictName(
                        SystemContext.OrderDomain.DictType.USERCOUPONSSTATUS.getValue(), userCouponInfoDto.getStatus()));
                userCouponInfoDto.setUseRangeCodeName(super.getSystemDictName(
                        SystemContext.OrderDomain.DictType.COUPONSUSERANGE.getValue(), userCouponInfoDto.getUseRangeCode()));
            }
            return userCouponInfoDto;
        } catch (Exception e) {
            logger.error("loadUserCouponByUserIdAndUserCouponId异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<CouponBasicInfoDto> listCouponsForShareRule(Integer conPackId) throws OrderServiceException {
        try {
            List<Coupon> couponList = couponMapper.listCouponsForShareRule(conPackId);
            List<CouponBasicInfoDto> couponBasicInfoDtoList = new ArrayList<CouponBasicInfoDto>();
            CouponBasicInfoDto couponBasicInfoDto = null;
            if (!ObjectUtils.isNullOrEmpty(couponList)) {
                for (Coupon coupon : couponList) {
                    couponBasicInfoDto = new CouponBasicInfoDto();
                    Integer conPackId1 = coupon.getConPackId();
                    CouponPackageDto couponPackageDto = this.loadCouponPackageById(conPackId1);
                    couponBasicInfoDto.setConId(coupon.getId());
                    couponBasicInfoDto.setConName(couponPackageDto.getConName());
                    couponBasicInfoDto.setGrantTime(coupon.getGrantTime());
                    couponBasicInfoDto.setStageNo(coupon.getStageNo());
                    couponBasicInfoDtoList.add(couponBasicInfoDto);
                }
            }
            return couponBasicInfoDtoList;
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<CouponDto> searchGrantRecord(CouponQueryDto couponQueryDto) throws OrderServiceException {
        if (null == couponQueryDto.getStart() || couponQueryDto.getStart() <= 0) {
            couponQueryDto.setStart(1);
        }
        if (null == couponQueryDto.getPageSize() || couponQueryDto.getPageSize() <= 0) {
            couponQueryDto.setPageSize(CommonConstants.PAGE_SIZE);
        }
        Page<CouponDto> couponDtoPage = new Page<CouponDto>(couponQueryDto.getStart(), couponQueryDto.getPageSize());
        PageHelper.startPage(couponQueryDto.getStart(), couponQueryDto.getPageSize());
        CouponQuery couponQuery = new CouponQuery();
        ObjectUtils.fastCopy(couponQueryDto, couponQuery);
        Page<CouponInfo> couponPage = couponMapper.findGrantRecord(couponQuery);
        ObjectUtils.fastCopy(couponPage, couponDtoPage);
        List<CouponInfo> couponList = couponPage.getResult();
        if (!ObjectUtils.isNullOrEmpty(couponList)) {
            CouponDto couponDto = null;
            for (CouponInfo coupon : couponList) {
                couponDto = new CouponDto();
                ObjectUtils.fastCopy(coupon, couponDto);
                if (couponDto.getUseNum() == 0 || couponDto.getGrantNum() == 0) {
                    couponDto.setUseRate(0);
                } else {
                    couponDto.setUseRate(couponDto.getUseNum() / couponDto.getGrantNum());
                }
                couponDto.setGrantWayName(this.getSystemDictName(
                        SystemContext.OrderDomain.DictType.COUPONSGRANTWAY.getValue(), couponDto.getGrantWay()));
                couponDto.setGrantUserName(userProxyService.getUserById(couponDto.getGrantUserId()).getUserName());
                couponDtoPage.add(couponDto);
            }
        }
        return YiLiDiPageUtils.encapsulatePageResult(couponDtoPage);
    }

    @Override
    public CouponDto getCouponGrantRecord(Integer conPackId, String batchNo) throws OrderServiceException {
        CouponDto couponDto = null;
        CouponInfo couponInfo = couponMapper.getCouponGrantRecord(conPackId, batchNo);
        if (!ObjectUtils.isNullOrEmpty(couponInfo)) {
            couponDto = new CouponDto();
            ObjectUtils.fastCopy(couponInfo, couponDto);
            // 券包名称
            CouponPackage pack = couponPackageMapper.loadById(couponDto.getConPackId());
            if (!ObjectUtils.isNullOrEmpty(pack)) {
                couponDto.setConPackName(pack.getConName());
            }
            // 处理使用范围名称的
            if (!ObjectUtils.isNullOrEmpty(couponDto.getUseRangeCode())) {
                if (!couponDto.getUseRangeCode().equals(SystemContext.OrderDomain.COUPONSUSERANGE_ALL)) {
                    String[] values = couponDto.getUseRange().split(",");
                    if (couponDto.getUseRangeCode().equals(SystemContext.OrderDomain.COUPONSUSERANGE_PRODUCT_CLASS)) {
                        for (String value : values) {
                            ProductClassProxyDto productClassProxyDto = productClassProxyService
                                    .getProductClassByCode(value);
                            if (!ObjectUtils.isNullOrEmpty(productClassProxyDto)) {
                                couponDto.getUseRangeNames().add(productClassProxyDto.getClassName());
                            }
                        }
                    } else if (couponDto.getUseRangeCode().equals(SystemContext.OrderDomain.COUPONSUSERANGE_PRODUCT_LABEL)) {
                        for (String value : values) {
                            couponDto.getUseRangeNames().add(this
                                    .getSystemDictName(SystemContext.OrderDomain.DictType.PRODUCTLABEL.getValue(), value));
                        }
                    } else if (couponDto.getUseRangeCode()
                            .equals(SystemContext.OrderDomain.COUPONSUSERANGE_SINGLE_PRODUCT)) {
                        for (String value : values) {
                            List<Integer> ids = new ArrayList<Integer>();
                            ids.add(Integer.parseInt(value));
                            List<ProductProxyDto> productProxyDtoList = productProxyService.listProductByProductIds(ids);
                            if (!ObjectUtils.isNullOrEmpty(productProxyDtoList)) {
                                couponDto.getUseRangeNames().add(productProxyDtoList.get(0).getProductClassName());
                            }
                        }
                    }
                }
            }
            // 处理有效时间
            if (!StringUtils.isEmpty(couponDto.getValidTypeValue())) {
                StringTokenizer st = new StringTokenizer(couponDto.getValidTypeValue(), "^");
                while (st.hasMoreTokens()) {
                    couponDto.getValidTimes().add(st.nextToken());
                }
            }
            // 处理用户类型
            if (!ObjectUtils.isNullOrEmpty(couponDto.getGrantRange())) {
                if (couponDto.getGrantRange().equals(SystemContext.OrderDomain.COUPONSGRANTRANGE_BATCH)) {
                    couponDto.setUserType(this.getSystemDictName(
                            SystemContext.OrderDomain.DictType.BUYERUSERTYPELABEL.getValue(), couponDto.getBuyerUserType()));
                } else if (couponDto.getGrantRange().equals(SystemContext.OrderDomain.COUPONSGRANTRANGE_SINGLE)) {
                    String mobiles = "";
                    List<UserCoupon> userCouponList = userCouponMapper.getUserCouponByConPackIdAndBatchNo(conPackId,
                            batchNo);
                    if (!ObjectUtils.isNullOrEmpty(userCouponList)) {
                        for (UserCoupon userCoupon : userCouponList) {
                            UserProxyDto userProxyDto = userProxyService.getUserById(userCoupon.getUserId());
                            if (!ObjectUtils.isNullOrEmpty(userProxyDto)) {
                                mobiles += userProxyDto.getPhone() + ",";
                            }
                        }
                    }
                    if (!"".equals(mobiles)) {
                        mobiles = mobiles.substring(0, mobiles.length() - 1);
                        couponDto.setUserType(mobiles);
                    }
                }
            }
        }
        return couponDto;
    }

    @Override
    public List<CouponPackageDto> listAvailableCouponPackage(String grantWay) throws OrderServiceException {
        List<CouponPackageDto> couponpackageDtoList = null;
        List<CouponPackage> couponPackageList = couponPackageMapper.listAvailableCouponPackage(grantWay);
        if (!ObjectUtils.isNullOrEmpty(couponPackageList)) {
            couponpackageDtoList = new ArrayList<>();
            CouponPackageDto couponPackageDto = null;
            for (CouponPackage couponPackage : couponPackageList) {
                couponPackageDto = new CouponPackageDto();
                ObjectUtils.fastCopy(couponPackage, couponPackageDto);
                couponpackageDtoList.add(couponPackageDto);
            }
        }
        return couponpackageDtoList;
    }

    @Override
    public List<CouponDto> getCouponByPackIdBatchNoGrantWay(Integer conPackId, String batchNo, String grantWay)
            throws OrderServiceException {
        List<CouponDto> couponDtoList = null;
        CouponDto couponDto = null;
        List<Coupon> couponList = couponMapper.getCouponByPackIdBatchNoGrantWay(conPackId, batchNo, grantWay);
        if (!ObjectUtils.isNullOrEmpty(couponList)) {
            couponDtoList = new ArrayList<>();
            for (Coupon coupon : couponList) {
                couponDto = new CouponDto();
                ObjectUtils.fastCopy(coupon, couponDto);
                couponDtoList.add(couponDto);
            }
        }
        return couponDtoList;
    }

    @Override
    public Map<String, Object> getCouponValid(CouponDto couponDto) throws OrderServiceException {
        CouponProxyDto couponProxyDto = new CouponProxyDto();
        ObjectUtils.fastCopy(couponDto, couponProxyDto);
        return couponProxyService.getCouponValid(couponProxyDto);
    }

    @Override
    public List<CouponDto> getValidRegistUseCouponActive(Date nowTime) throws OrderServiceException {
        List<CouponDto> couponDtoList = null;
        CouponDto couponDto = null;
        List<Coupon> couponList = couponMapper.getValidRegistUseCouponActive(nowTime);
        if (!ObjectUtils.isNullOrEmpty(couponList)) {
            couponDtoList = new ArrayList<CouponDto>();
            for (Coupon coupon : couponList) {
                couponDto = new CouponDto();
                ObjectUtils.fastCopy(coupon, couponDto);
                couponDtoList.add(couponDto);
            }
        }
        return couponDtoList;
    }

    @Override
    public YiLiDiPage<CouponDto> getCouponByGrantWay(CouponQueryDto couponQueryDto) {
        if (null == couponQueryDto.getStart() || couponQueryDto.getStart() <= 0) {
            couponQueryDto.setStart(1);
        }
        if (null == couponQueryDto.getPageSize() || couponQueryDto.getPageSize() <= 0) {
            couponQueryDto.setPageSize(CommonConstants.PAGE_SIZE);
        }
        Page<CouponDto> couponDtoPage = new Page<CouponDto>(couponQueryDto.getStart(), couponQueryDto.getPageSize());
        CouponDto couponDto = null;
        PageHelper.startPage(couponQueryDto.getStart(), couponQueryDto.getPageSize());
        CouponQuery couponQuery = new CouponQuery();
        ObjectUtils.fastCopy(couponQueryDto, couponQuery);
        Page<CouponInfo> couponPage = couponMapper.findCouponByGrantWay(couponQuery);
        if (!ObjectUtils.isNullOrEmpty(couponPage)) {
            List<CouponInfo> couponInfoList = couponPage.getResult();
            if (!ObjectUtils.isNullOrEmpty(couponInfoList)) {
                for (CouponInfo couponInfo : couponInfoList) {
                    couponDto = new CouponDto();
                    ObjectUtils.fastCopy(couponInfo, couponDto);
                    couponDto.setUseRangeCodeName(this.getSystemDictName(
                            SystemContext.OrderDomain.DictType.COUPONSUSERANGE.getValue(), couponDto.getUseRangeCode()));
                    couponDtoPage.add(couponDto);
                }
            }
        }
        return YiLiDiPageUtils.encapsulatePageResult(couponDtoPage);
    }

    @Override
    public void sendBuyActivityCouponMessage(String orderNo, Integer operationUserId, Date operationTime)
            throws UserServiceException {
        try {
            messageProxyService.sendBuyActivityCouponMessage(orderNo, operationUserId, operationTime);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }

    }

    @Override
    public UserCouponDto loadUserCouponByUserIdAndConId(Integer userId, Integer conId) throws OrderServiceException {
        UserCouponDto userCouponDto = null;
        try {
            if (ObjectUtils.isNullOrEmpty(userId)) {
                return userCouponDto;
            }
            if (ObjectUtils.isNullOrEmpty(conId)) {
                return userCouponDto;
            }
            UserCoupon userCoupon = userCouponMapper.loadUserCouponByUserIdAndConId(userId, conId);
            if (!ObjectUtils.isNullOrEmpty(userCoupon)) {
                userCouponDto = new UserCouponDto();
                ObjectUtils.fastCopy(userCoupon, userCouponDto);
            }
            return userCouponDto;
        } catch (Exception e) {
            logger.error("loadUserCouponByUserIdAndConId异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

}
