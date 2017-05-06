package com.yilidi.o2o.order.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.dao.UserVoucherMapper;
import com.yilidi.o2o.order.dao.VoucherMapper;
import com.yilidi.o2o.order.dao.VoucherPackageMapper;
import com.yilidi.o2o.order.model.UserVoucher;
import com.yilidi.o2o.order.model.Voucher;
import com.yilidi.o2o.order.model.VoucherPackage;
import com.yilidi.o2o.order.model.query.UserVoucherQuery;
import com.yilidi.o2o.order.model.query.VoucherPackageQuery;
import com.yilidi.o2o.order.model.query.VoucherQuery;
import com.yilidi.o2o.order.model.result.UserVoucherInfo;
import com.yilidi.o2o.order.model.result.VoucherInfo;
import com.yilidi.o2o.order.service.IVoucherService;
import com.yilidi.o2o.order.service.dto.UserVoucherDto;
import com.yilidi.o2o.order.service.dto.UserVoucherInfoDto;
import com.yilidi.o2o.order.service.dto.VoucherBasicInfoDto;
import com.yilidi.o2o.order.service.dto.VoucherDto;
import com.yilidi.o2o.order.service.dto.VoucherPackageDto;
import com.yilidi.o2o.order.service.dto.query.UserVoucherQueryDto;
import com.yilidi.o2o.order.service.dto.query.VoucherPackageQueryDto;
import com.yilidi.o2o.order.service.dto.query.VoucherQueryDto;
import com.yilidi.o2o.product.proxy.IProductClassProxyService;
import com.yilidi.o2o.product.proxy.IProductProxyService;
import com.yilidi.o2o.product.proxy.IRedEnvelopeProxyService;
import com.yilidi.o2o.product.proxy.dto.ProductClassProxyDto;
import com.yilidi.o2o.product.proxy.dto.ProductProxyDto;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.proxy.IUserProxyService;
import com.yilidi.o2o.user.proxy.dto.UserProxyDto;

/**
 * 抵用券Service接口实现类
 * 
 * @author: chenlian
 * @date: 2016年10月27日 下午3:34:33
 */
@Service("voucherService")
public class VoucherServiceImpl extends BasicDataService implements IVoucherService {

    /** 无效 **/
    private static final int USERVOUCHERSTATUS_INVALID = 0;

    @Autowired
    private VoucherPackageMapper voucherPackageMapper;

    @Autowired
    private VoucherMapper voucherMapper;

    @Autowired
    private UserVoucherMapper userVoucherMapper;

    @Autowired
    private IUserProxyService userProxyService;

    @Autowired
    private IRedEnvelopeProxyService redEnvelopeProxyService;
    
    @Autowired
    private IProductClassProxyService productClassProxyService;
    
    @Autowired
    private IProductProxyService productProxyService;

    @Override
    public void saveVoucherPackage(VoucherPackageDto voucherPackageDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(voucherPackageDto)) {
                throw new OrderServiceException("参数voucherPackageDto不能为空");
            }
            VoucherPackage voucherPackage = new VoucherPackage();
            ObjectUtils.fastCopy(voucherPackageDto, voucherPackage);
            voucherPackageMapper.save(voucherPackage);
        } catch (Exception e) {
            logger.error("saveVoucherPackage异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateVoucherPackage(VoucherPackageDto voucherPackageDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(voucherPackageDto)) {
                throw new OrderServiceException("参数voucherPackageDto不能为空");
            }
            VoucherPackage voucherPackage = voucherPackageMapper.loadById(voucherPackageDto.getId());
            voucherPackage.setVouName(voucherPackageDto.getVouName());
            voucherPackage.setAmount(voucherPackageDto.getAmount());
            voucherPackage.setVouPackType(voucherPackageDto.getVouPackType());
            voucherPackage.setVouPackContent(voucherPackageDto.getVouPackContent());
            voucherPackage.setModifyTime(voucherPackageDto.getModifyTime());
            voucherPackage.setModifyUserId(voucherPackageDto.getModifyUserId());
            voucherPackageMapper.update(voucherPackage);
        } catch (Exception e) {
            logger.error("updateVoucherPackage异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public VoucherPackageDto loadVoucherPackageById(Integer id) throws OrderServiceException {
        VoucherPackageDto voucherPackageDto = null;
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new OrderServiceException("参数id不能为空");
            }
            VoucherPackage voucherPackage = voucherPackageMapper.loadById(id);
            if (!ObjectUtils.isNullOrEmpty(voucherPackage)) {
                voucherPackageDto = new VoucherPackageDto();
                ObjectUtils.fastCopy(voucherPackage, voucherPackageDto);
            }
            return voucherPackageDto;
        } catch (Exception e) {
            logger.error("loadVoucherPackageById异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateVoucherPackageStateById(Integer id, String state, Integer modifyUserId, Date modifyTime)
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
            VoucherPackage voucherPackage = voucherPackageMapper.loadById(id);
            voucherPackage.setState(state);
            voucherPackage.setModifyUserId(modifyUserId);
            voucherPackage.setModifyTime(modifyTime);
            voucherPackageMapper.updateStateById(id, state, modifyUserId, modifyTime);
        } catch (Exception e) {
            logger.error("updateVoucherPackageStateById异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<VoucherPackageDto> findVoucherPackages(VoucherPackageQueryDto voucherPackageQueryDto)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(voucherPackageQueryDto)) {
                throw new OrderServiceException("参数voucherPackageQueryDto不能为空");
            }
            if (null == voucherPackageQueryDto.getStart() || voucherPackageQueryDto.getStart() <= 0) {
                voucherPackageQueryDto.setStart(1);
            }
            if (null == voucherPackageQueryDto.getPageSize() || voucherPackageQueryDto.getPageSize() <= 0) {
                voucherPackageQueryDto.setPageSize(CommonConstants.PAGE_SIZE);
            }
            Page<VoucherPackageDto> pageDto = new Page<VoucherPackageDto>(voucherPackageQueryDto.getStart(),
                    voucherPackageQueryDto.getPageSize());
            VoucherPackageQuery voucherPackageQuery = new VoucherPackageQuery();
            ObjectUtils.fastCopy(voucherPackageQueryDto, voucherPackageQuery);
            PageHelper.startPage(voucherPackageQuery.getStart(), voucherPackageQuery.getPageSize());
            Page<VoucherPackage> page = voucherPackageMapper.findVoucherPackages(voucherPackageQuery);
            ObjectUtils.fastCopy(page, pageDto);
            List<VoucherPackage> voucherPackages = page.getResult();
            for (VoucherPackage voucherPackage : voucherPackages) {
                VoucherPackageDto voucherPackageDto = new VoucherPackageDto();
                ObjectUtils.fastCopy(voucherPackage, voucherPackageDto);
                pageDto.add(voucherPackageDto);
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findVoucherPackages异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void saveForGrantVouchers(VoucherDto voucherDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(voucherDto)) {
                throw new OrderServiceException("参数voucherDto不能为空");
            }
            
            //注册有礼，系统中只能存在一种,去数据库查询当前券包有没有注册有礼的发放方式的优惠券
            if(voucherDto.getGrantWay().equals(SystemContext.OrderDomain.VOUCHERGRANTWAY_REGISTER_GIFT)){
            	List<Voucher> voucherList = voucherMapper.getVoucherByGrantWay(SystemContext.OrderDomain.VOUCHERGRANTWAY_REGISTER_GIFT);
            	if(!ObjectUtils.isNullOrEmpty(voucherList)){
            		int vouPackId = -1;
            		for (Voucher voucher: voucherList) {
            			//根据优惠券查券包
            			if(vouPackId != voucher.getVouPackId().intValue()){
            				VoucherPackage pack = voucherPackageMapper.loadById(voucher.getVouPackId());
            				if(!ObjectUtils.isNullOrEmpty(pack) && pack.getState().equals(SystemContext.OrderDomain.VOUCHERSTATE_GRANTED)){
            					throw new OrderServiceException("券包"+pack.getVouName()+"已经存在（注册有礼）的发放方式了，不能添加");
            				}
            			}
            			vouPackId = voucher.getVouPackId().intValue();
					}
            	}
            }
            
            this.updateVoucherPackageStateById(voucherDto.getVouPackId(), SystemContext.OrderDomain.VOUCHERSTATE_GRANTED,
                    voucherDto.getGrantUserId(), voucherDto.getGrantTime());
            VoucherPackageDto voucherPackageDto = this.loadVoucherPackageById(voucherDto.getVouPackId());
            String vouPackContent = voucherPackageDto.getVouPackContent();
            String[] vouPackContentArray = vouPackContent.split(",");
            String batchNo = StringUtils.generateGrantCouponBatchNo();
            for (int i = 0; i < vouPackContentArray.length; i++) {
                String[] vouInfos = vouPackContentArray[i].split("_");
                Long price = Long.parseLong(vouInfos[0]);
                Integer count = Integer.parseInt(vouInfos[1]);
                voucherDto.setVouAmount(price);
                voucherDto.setBatchNo(batchNo);
                Integer vouId = this.saveVoucher(voucherDto);
                for (int j = 0; j < count; j++) {
                    if (SystemContext.OrderDomain.VOUCHERGRANTWAY_AUTO_RELEASE.equals(voucherDto.getGrantWay())) {
                        List<Integer> userIdsList = null;
                        if (SystemContext.OrderDomain.VOUCHERGRANTRANGE_BATCH.equals(voucherDto.getGrantRange())) {
                            if (SystemContext.OrderDomain.BUYERUSERTYPELABEL_ALL.equals(voucherDto.getBuyerUserType())) {
                                userIdsList = userProxyService
                                        .listUserIdsByCustomerType(SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
                            }
                        }
                        if (SystemContext.OrderDomain.VOUCHERGRANTRANGE_SINGLE.equals(voucherDto.getGrantRange())) {
                            String userNames = voucherDto.getUserNames();
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
                                    UserVoucherDto userVoucherDto = new UserVoucherDto();
                                    userVoucherDto.setVouId(vouId);
                                    userVoucherDto.setUserId(userId);
                                    userVoucherDto.setBatchNo(batchNo);
                                    if (DateUtils.getCurrentDateTime().before(voucherDto.getValidStartTime())) {
                                        userVoucherDto.setStatus(SystemContext.OrderDomain.USERVOUCHERSTATUS_RECEIVED);
                                    }
                                    if (DateUtils.getCurrentDateTime().after(voucherDto.getValidStartTime())
                                            && DateUtils.getCurrentDateTime().before(voucherDto.getValidEndTime())) {
                                        userVoucherDto.setStatus(SystemContext.OrderDomain.USERVOUCHERSTATUS_USABLE);
                                    }
                                    if (DateUtils.getCurrentDateTime().equals(voucherDto.getValidStartTime())
                                            || DateUtils.getCurrentDateTime().equals(voucherDto.getValidEndTime())) {
                                        userVoucherDto.setStatus(SystemContext.OrderDomain.USERCOUPONSSTATUS_USABLE);
                                    }
                                    if (DateUtils.getCurrentDateTime().after(voucherDto.getValidEndTime())) {
                                        userVoucherDto.setStatus(SystemContext.OrderDomain.USERVOUCHERSTATUS_EXPIRED);
                                    }
                                    this.saveUserVoucher(userVoucherDto);
                                }
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            logger.error("saveForGrantVouchers异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public int saveVoucher(VoucherDto voucherDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(voucherDto)) {
                throw new OrderServiceException("参数voucherDto不能为空");
            }
            Voucher voucher = new Voucher();
            ObjectUtils.fastCopy(voucherDto, voucher);
            voucherMapper.save(voucher);
            return voucher.getId();
        } catch (Exception e) {
            logger.error("saveVoucher异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void saveUserVoucher(UserVoucherDto userVoucherDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userVoucherDto)) {
                throw new OrderServiceException("参数userVoucherDto不能为空");
            }
            UserVoucher userVoucher = new UserVoucher();
            ObjectUtils.fastCopy(userVoucherDto, userVoucher);
            userVoucherMapper.save(userVoucher);
        } catch (Exception e) {
            logger.error("saveUserVoucher异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void saveUserVoucherForGrabRedEnvelope(List<UserVoucherDto> userVoucherDtoList, Integer userRedEnvelopeActivityId)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userVoucherDtoList)) {
                throw new OrderServiceException("参数userVoucherDtoList不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(userRedEnvelopeActivityId)) {
                throw new OrderServiceException("参数userRedEnvelopeActivityId不能为空");
            }
            for (UserVoucherDto userVoucherDto : userVoucherDtoList) {
                this.saveUserVoucher(userVoucherDto);
            }
            redEnvelopeProxyService.updateUserActivityByIdWithRedEnvelopeCount(userRedEnvelopeActivityId);
        } catch (Exception e) {
            logger.error("saveUserVoucherForGrabRedEnvelope异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public UserVoucherDto loadUserVoucherById(Integer id) throws OrderServiceException {
        UserVoucherDto userVoucherDto = null;
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new OrderServiceException("参数id不能为空");
            }
            UserVoucher userVoucher = userVoucherMapper.loadUserVoucherById(id);
            if (!ObjectUtils.isNullOrEmpty(userVoucher)) {
                userVoucherDto = new UserVoucherDto();
                ObjectUtils.fastCopy(userVoucher, userVoucherDto);
            }
            return userVoucherDto;
        } catch (Exception e) {
            logger.error("loadUserVoucherById异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<UserVoucherInfoDto> findUserVouchers(UserVoucherQueryDto userVoucherQueryDto)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userVoucherQueryDto)) {
                throw new OrderServiceException("参数userVoucherQueryDto不能为空");
            }
            if (null == userVoucherQueryDto.getStart() || userVoucherQueryDto.getStart() <= 0) {
                userVoucherQueryDto.setStart(1);
            }
            if (null == userVoucherQueryDto.getPageSize() || userVoucherQueryDto.getPageSize() <= 0) {
                userVoucherQueryDto.setPageSize(CommonConstants.PAGE_SIZE);
            }
            Page<UserVoucherInfoDto> pageDto = new Page<UserVoucherInfoDto>(userVoucherQueryDto.getStart(),
                    userVoucherQueryDto.getPageSize());
            UserVoucherQuery userVoucherQuery = new UserVoucherQuery();
            ObjectUtils.fastCopy(userVoucherQueryDto, userVoucherQuery);
            PageHelper.startPage(userVoucherQuery.getStart(), userVoucherQuery.getPageSize());
            Page<UserVoucherInfo> page = userVoucherMapper.findUserVouchers(userVoucherQuery);
            ObjectUtils.fastCopy(page, pageDto);
            List<UserVoucherInfo> userVoucherInfos = page.getResult();
            for (UserVoucherInfo userVoucherInfo : userVoucherInfos) {
                UserVoucherInfoDto userVoucherInfoDto = new UserVoucherInfoDto();
                ObjectUtils.fastCopy(userVoucherInfo, userVoucherInfoDto);
                userVoucherInfoDto.setStatusName(super.getSystemDictName(
                        SystemContext.OrderDomain.DictType.USERVOUCHERSTATUS.getValue(), userVoucherInfoDto.getStatus()));
                pageDto.add(userVoucherInfoDto);
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findUserVouchers异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<UserVoucherDto> listUserVouchersByAIdAndVIds(Integer activityId, List<Integer> vouIds)
            throws OrderServiceException {
        List<UserVoucherDto> userVoucherDtoList = null;
        try {
            List<UserVoucher> userVoucherList = userVoucherMapper.listByActivityIdAndVouIds(activityId, vouIds);
            if (!ObjectUtils.isNullOrEmpty(userVoucherList)) {
                userVoucherDtoList = new ArrayList<UserVoucherDto>();
                for (UserVoucher userVoucher : userVoucherList) {
                    UserVoucherDto userVoucherDto = new UserVoucherDto();
                    ObjectUtils.fastCopy(userVoucher, userVoucherDto);
                    userVoucherDtoList.add(userVoucherDto);
                }
            }
            return userVoucherDtoList;
        } catch (Exception e) {
            logger.error("listUserVouchersByAIdAndVIds异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<UserVoucherDto> listUserVouchersByAIdAndVIdsAndUIdAndStatus(Integer activityId, List<Integer> vouIds,
            Integer userId, List<String> statusList) {
        List<UserVoucherDto> userVoucherDtoList = null;
        try {
            List<UserVoucher> userVoucherList = userVoucherMapper.listByActivityIdAndVouIdsAndUserIdAndStatus(activityId,
                    vouIds, userId, statusList);
            if (!ObjectUtils.isNullOrEmpty(userVoucherList)) {
                userVoucherDtoList = new ArrayList<UserVoucherDto>();
                for (UserVoucher userVoucher : userVoucherList) {
                    UserVoucherDto userVoucherDto = new UserVoucherDto();
                    ObjectUtils.fastCopy(userVoucher, userVoucherDto);
                    userVoucherDtoList.add(userVoucherDto);
                }
            }
            return userVoucherDtoList;
        } catch (Exception e) {
            logger.error("listUserVouchersByAIdAndVIdsAndUIdAndStatus异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<UserVoucherDto> listVouchersForNeedAutoUpdateStatus(List<String> statusList) throws OrderServiceException {
        List<UserVoucherDto> userVoucherDtoList = null;
        try {
            List<UserVoucher> userVoucherList = userVoucherMapper.listVouchersForNeedAutoUpdateStatus(statusList);
            if (!ObjectUtils.isNullOrEmpty(userVoucherList)) {
                userVoucherDtoList = new ArrayList<UserVoucherDto>();
                for (UserVoucher userVoucher : userVoucherList) {
                    UserVoucherDto userVoucherDto = new UserVoucherDto();
                    ObjectUtils.fastCopy(userVoucher, userVoucherDto);
                    userVoucherDtoList.add(userVoucherDto);
                }
            }
            return userVoucherDtoList;
        } catch (Exception e) {
            logger.error("listVouchersForNeedAutoUpdateStatus异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public VoucherDto loadVoucherById(Integer id) throws OrderServiceException {
        VoucherDto voucherDto = null;
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new OrderServiceException("参数id不能为空");
            }
            Voucher voucher = voucherMapper.loadVoucherById(id);
            if (!ObjectUtils.isNullOrEmpty(voucher)) {
                voucherDto = new VoucherDto();
                ObjectUtils.fastCopy(voucher, voucherDto);
            }
            return voucherDto;
        } catch (Exception e) {
            logger.error("loadVoucherById异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateUserVoucherStatusById(Integer id, String status) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new OrderServiceException("参数id不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(status)) {
                throw new OrderServiceException("参数status不能为空");
            }
            UserVoucher userVoucher = userVoucherMapper.loadUserVoucherById(id);
            userVoucher.setStatus(status);
            userVoucherMapper.updateStatusById(id, status);
        } catch (Exception e) {
            logger.error("updateUserVoucherStatusById异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateUseVoucherById(List<Integer> userVoucherIdList, String status,Date useTime)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userVoucherIdList)) {
                return;
            }
            if (ObjectUtils.isNullOrEmpty(status)) {
                return;
            }
            for (Integer userVoucherId : userVoucherIdList) {
                userVoucherMapper.updateUseVoucherById(userVoucherId, status,useTime);
            }
        } catch (Exception e) {
            logger.error("updateUserVoucherStatusByUserVoucherIds异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateUserVoucherStatusIfEffectiveByVoucherIds(List<Integer> userVoucherIdList, String status)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userVoucherIdList)) {
                return;
            }
            if (ObjectUtils.isNullOrEmpty(status)) {
                return;
            }
            Date nowTime = new Date();
            for (Integer userVoucherId : userVoucherIdList) {
                UserVoucher userVoucher = userVoucherMapper.loadUserVoucherById(userVoucherId);
                if (ObjectUtils.isNullOrEmpty(userVoucher)) {
                    continue;
                }
                Voucher voucher = voucherMapper.loadVoucherById(userVoucher.getVouId());
                if (ObjectUtils.isNullOrEmpty(voucher)) {
                    continue;
                }
                if (!voucher.getValidStartTime().after(nowTime) && !voucher.getValidEndTime().before(nowTime)) {
                    userVoucherMapper.updateStatusById(userVoucherId, status);
                }
            }
        } catch (Exception e) {
            logger.error("updateUserVoucherStatusIfEffectiveByVoucherIds异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<VoucherBasicInfoDto> listVoucherPackagesForRedEnvelopeActivity(Date activityStartDate)
            throws OrderServiceException {
        List<VoucherBasicInfoDto> voucherBasicInfoDtoList = null;
        try {
            String grantWay = SystemContext.OrderDomain.VOUCHERGRANTWAY_RED_ENVELOPE;
            String customerType = SystemContext.UserDomain.CUSTOMERTYPE_BUYER;
            String buyerUserType = SystemContext.OrderDomain.BUYERUSERTYPELABEL_ALL;
            List<Voucher> voucherList = voucherMapper.listVouPackIdForRedEnvelopeActivity(grantWay, activityStartDate,
                    customerType, buyerUserType);
            if (!ObjectUtils.isNullOrEmpty(voucherList)) {
                for (Voucher voucher : voucherList) {
                    VoucherPackageDto voucherPackageDto = this.loadVoucherPackageById(voucher.getVouPackId());
                    if (ObjectUtils.isNullOrEmpty(voucherBasicInfoDtoList)) {
                        voucherBasicInfoDtoList = new ArrayList<VoucherBasicInfoDto>();
                    }
                    VoucherBasicInfoDto voucherBasicInfoDto = new VoucherBasicInfoDto();
                    voucherBasicInfoDto.setVouPackId(voucher.getVouPackId());
                    voucherBasicInfoDto.setVouPackName(voucherPackageDto.getVouName());
                    voucherBasicInfoDto.setGrantTime(voucher.getGrantTime());
                    voucherBasicInfoDtoList.add(voucherBasicInfoDto);
                }
            }
            return voucherBasicInfoDtoList;
        } catch (Exception e) {
            logger.error("listVoucherPackagesForRedEnvelopeActivity异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<VoucherDto> listVouchersByVouPackIdAndGrantTime(Integer vouPackId, Date grantTime)
            throws OrderServiceException {
        List<VoucherDto> voucherDtoList = null;
        try {
            List<Voucher> voucherList = voucherMapper.listByVouPackIdAndGrantTime(vouPackId, grantTime);
            if (!ObjectUtils.isNullOrEmpty(voucherList)) {
                voucherDtoList = new ArrayList<VoucherDto>();
                for (Voucher voucher : voucherList) {
                    VoucherDto voucherDto = new VoucherDto();
                    ObjectUtils.fastCopy(voucher, voucherDto);
                    voucherDtoList.add(voucherDto);
                }
            }
            return voucherDtoList;
        } catch (Exception e) {
            logger.error("listVouchersByVouPackIdAndGrantTime异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<UserVoucherInfoDto> findUserVouchersByRealTimeStatus(Integer userId, Date currentTime,
            Integer userVoucherStatus, Integer pageNo, Integer pageSize) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userId)) {
                throw new OrderServiceException("param userId cant not be null");
            }
            if (ObjectUtils.isNullOrEmpty(currentTime)) {
                currentTime = new Date();
            }
            boolean isValid = true; // 默认有效
            if (userVoucherStatus != null && USERVOUCHERSTATUS_INVALID == userVoucherStatus.intValue()) {
                isValid = false;
            }
            if (null == pageNo) {
                pageNo = 1;
            }
            if (null == pageSize) {
                pageSize = CommonConstants.PAGE_SIZE;
            }
            Page<UserVoucherInfoDto> pageDto = new Page<UserVoucherInfoDto>(pageNo, pageSize);
            PageHelper.startPage(pageNo, pageSize);
            Page<UserVoucherInfo> page = userVoucherMapper.findUserVouchersByRealTimeStatus(userId, currentTime,
                    SystemContext.OrderDomain.USERVOUCHERSTATUS_USED, isValid);
            ObjectUtils.fastCopy(page, pageDto);
            List<UserVoucherInfo> userCouponInfos = page.getResult();
            for (UserVoucherInfo userCouponInfo : userCouponInfos) {
                UserVoucherInfoDto userCouponInfoDto = new UserVoucherInfoDto();
                ObjectUtils.fastCopy(userCouponInfo, userCouponInfoDto);
                userCouponInfoDto.setStatusName(super.getSystemDictName(
                        SystemContext.OrderDomain.DictType.USERVOUCHERSTATUS.getValue(), userCouponInfoDto.getStatus()));
                pageDto.add(userCouponInfoDto);
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<UserVoucherInfoDto> listValidAndUsebleUserVouchers(Integer userId, Date currentTime)
            throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userId)) {
                return Collections.emptyList();
            }
            if (ObjectUtils.isNullOrEmpty(currentTime)) {
                currentTime = new Date();
            }
            List<UserVoucherInfo> userVoucherInfoList = userVoucherMapper.listValidAndUsebleUserVouchers(userId, currentTime,
                    SystemContext.OrderDomain.USERVOUCHERSTATUS_USED);
            List<UserVoucherInfoDto> userVoucherInfoDtoList = new ArrayList<UserVoucherInfoDto>();
            if (!ObjectUtils.isNullOrEmpty(userVoucherInfoList)) {
                for (UserVoucherInfo userVoucherInfo : userVoucherInfoList) {
                    UserVoucherInfoDto userVoucherInfoDto = new UserVoucherInfoDto();
                    ObjectUtils.fastCopy(userVoucherInfo, userVoucherInfoDto);
                    userVoucherInfoDto.setStatusName(
                            super.getSystemDictName(SystemContext.OrderDomain.DictType.USERVOUCHERSTATUS.getValue(),
                                    userVoucherInfoDto.getStatus()));
                    userVoucherInfoDtoList.add(userVoucherInfoDto);
                }
            }
            return userVoucherInfoDtoList;
        } catch (Exception e) {
            logger.error("listValidAndUsebleUserVouchers异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public UserVoucherInfoDto loadUserVoucherByUserIdAndUserVoucherId(Integer userId, Integer userVoucherId) {
        try {
            if (ObjectUtils.isNullOrEmpty(userId) || ObjectUtils.isNullOrEmpty(userVoucherId)) {
                return null;
            }
            UserVoucherInfo userVoucherInfo = userVoucherMapper.loadUserVoucherByUserIdAndUserVoucherId(userId,
                    userVoucherId);
            UserVoucherInfoDto userVoucherInfoDto = null;
            if (!ObjectUtils.isNullOrEmpty(userVoucherInfo)) {
                userVoucherInfoDto = new UserVoucherInfoDto();
                ObjectUtils.fastCopy(userVoucherInfo, userVoucherInfoDto);
                userVoucherInfoDto.setStatusName(super.getSystemDictName(
                        SystemContext.OrderDomain.DictType.USERVOUCHERSTATUS.getValue(), userVoucherInfoDto.getStatus()));
            }
            return userVoucherInfoDto;
        } catch (Exception e) {
            logger.error("loadUserVoucherByUserIdAndUserVoucherId异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public Integer getValidUserVoucherCountByUserId(Integer userId, Date currentTime) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userId)) {
                return 0;
            }
            if (ObjectUtils.isNullOrEmpty(currentTime)) {
                currentTime = new Date();
            }
            return userVoucherMapper.getValidUserVoucherCountByUserId(userId,
                    SystemContext.OrderDomain.USERVOUCHERSTATUS_USED, currentTime);
        } catch (Exception e) {
            logger.error(e, e);
            throw new OrderServiceException(e.getMessage());
        }
    }

	@Override
	public YiLiDiPage<VoucherDto> searchVoucherRecord(VoucherQueryDto voucherQueryDto) throws OrderServiceException {
		if (null == voucherQueryDto.getStart() || voucherQueryDto.getStart() <= 0) {
			voucherQueryDto.setStart(1);
        }
        if (null == voucherQueryDto.getPageSize() || voucherQueryDto.getPageSize() <= 0) {
        	voucherQueryDto.setPageSize(CommonConstants.PAGE_SIZE);
        }
        Page<VoucherDto> voucherDtoPage = new Page<VoucherDto>(voucherQueryDto.getStart(), voucherQueryDto.getPageSize());
        PageHelper.startPage(voucherQueryDto.getStart(), voucherQueryDto.getPageSize());
        VoucherQuery voucherQuery = new VoucherQuery();
        ObjectUtils.fastCopy(voucherQueryDto, voucherQuery);
        Page<VoucherInfo> voucherPage = voucherMapper.findVoucherRecord(voucherQuery);
        ObjectUtils.fastCopy(voucherPage, voucherDtoPage);
        
        List<VoucherInfo> voucherList = voucherPage.getResult();
        if(!ObjectUtils.isNullOrEmpty(voucherList)){
        	VoucherDto voucherDto = null;
        	for (VoucherInfo voucher : voucherList) {
        		voucherDto = new VoucherDto();
        		ObjectUtils.fastCopy(voucher, voucherDto);
        		if(voucherDto.getUseNum() == 0 || voucherDto.getGrantNum() == 0){
        			voucherDto.setUseRate(0);
        		}else{
        			voucherDto.setUseRate(voucherDto.getUseNum()/voucherDto.getGrantNum());
        		}
        		voucherDto.setGrantWayName(this.getSystemDictName(SystemContext.OrderDomain.DictType.COUPONSGRANTWAY.getValue(), voucherDto.getGrantWay()));
        		voucherDto.setGrantUserName(userProxyService.getUserById(voucherDto.getGrantUserId()).getUserName()); 
        		voucherDtoPage.add(voucherDto);
			}
        }
        return YiLiDiPageUtils.encapsulatePageResult(voucherDtoPage);
	}

	@Override
	public VoucherDto getVoucherGrantRecord(Integer vouPackId, String batchNo) throws OrderServiceException{
		VoucherDto voucherDto = null;
		VoucherInfo voucherInfo = voucherMapper.getVoucherGrantRecord(vouPackId,batchNo);
		if(!ObjectUtils.isNullOrEmpty(voucherInfo)){
			voucherDto = new VoucherDto();
			ObjectUtils.fastCopy(voucherInfo, voucherDto);
			//券包名称
			VoucherPackage pack = voucherPackageMapper.loadById(voucherDto.getVouPackId());
			if(!ObjectUtils.isNullOrEmpty(pack)){
				voucherDto.setVouPackName(pack.getVouName());
			}
			//解析商品品类限制
			if(!StringUtils.isEmpty(voucherDto.getProductClassLimit())){
				String[] classCodes = voucherDto.getProductClassLimit().split(",");
				for (String classCode : classCodes) {
					ProductClassProxyDto productClassProxyDto = productClassProxyService.getProductClassByCode(classCode);
					if(!ObjectUtils.isNullOrEmpty(productClassProxyDto)){
						voucherDto.getProductClassNames().add(productClassProxyDto.getClassName());
					}
				}
			}
			//解析业务限制
			if(!StringUtils.isEmpty(voucherDto.getBusinessRuleLimit())){
				String[] businessRuleLimits = voucherDto.getBusinessRuleLimit().split(",");
				Map<String, Object> businessRuleLimitMap = null;
				for (String businessRuleLimit : businessRuleLimits) {
					businessRuleLimitMap = new HashMap<String,Object>();
					businessRuleLimitMap.put("name", this.getSystemDictName(SystemContext.OrderDomain.DictType.VOUCHERBUSINESSRULELIMIT.getValue(), businessRuleLimit));
					businessRuleLimitMap.put("code", businessRuleLimit);
					voucherDto.getBusinessRuleLimitMaps().add(businessRuleLimitMap);
					//如果业务限制是特殊商品无法使用-解析商品
					if(businessRuleLimit.equals(SystemContext.OrderDomain.VOUCHERBUSINESSRULELIMIT_SPECIAL_PRODUCT_NO_USE)){
						String[] productLimits = voucherDto.getProductLimit().split(",");
						for (String productLimit : productLimits) {
							List<Integer> productIds = new ArrayList<>();
							productIds.add(Integer.parseInt(productLimit));
							List<ProductProxyDto> productProxyDtoList = productProxyService.listProductByProductIds(productIds);
							if(!ObjectUtils.isNullOrEmpty(productProxyDtoList)){
								voucherDto.getProducts().add(productProxyDtoList.get(0));
							}
						}
					}
				}
			}
			//处理用户类型
			if(!ObjectUtils.isNullOrEmpty(voucherDto.getGrantRange())){
				if(voucherDto.getGrantRange().equals(SystemContext.OrderDomain.VOUCHERGRANTRANGE_BATCH)){
					voucherDto.setUserType(this.getSystemDictName(SystemContext.OrderDomain.DictType.BUYERUSERTYPELABEL.getValue(),voucherDto.getBuyerUserType()));
				}else if(voucherDto.getGrantRange().equals(SystemContext.OrderDomain.VOUCHERGRANTRANGE_SINGLE)){
					String mobiles = "";
					List<UserVoucher> userVoucherList = userVoucherMapper.getUserCouponByConPackIdAndBatchNo(vouPackId,batchNo);
					if(!ObjectUtils.isNullOrEmpty(userVoucherList)){
						for (UserVoucher userVoucher : userVoucherList) {
							UserProxyDto userProxyDto = userProxyService.getUserById(userVoucher.getUserId());
							if(!ObjectUtils.isNullOrEmpty(userProxyDto)){
								mobiles += userProxyDto.getPhone()+",";
							}
						}
					}
					if(!StringUtils.isEmpty(mobiles)){
						mobiles = mobiles.substring(0,mobiles.length()-1);
						voucherDto.setUserType(mobiles);
					}
				}
			}
		}
		return voucherDto;
	}

	@Override
	public List<VoucherPackageDto> listAvailableVoucherPackage() throws OrderServiceException{
		List<VoucherPackageDto> voucherPackageDtoList = null;
		List<VoucherPackage> voucherPackageList = voucherPackageMapper.listAvailableVoucherPackage();
		if(!ObjectUtils.isNullOrEmpty(voucherPackageList)){
			voucherPackageDtoList = new ArrayList<>();
			VoucherPackageDto voucherPackageDto = null;
			for (VoucherPackage voucherPackage : voucherPackageList) {
				voucherPackageDto = new VoucherPackageDto();
				ObjectUtils.fastCopy(voucherPackage, voucherPackageDto);
				voucherPackageDtoList.add(voucherPackageDto);
			}
		}
		return voucherPackageDtoList;
	}

	@Override
	public List<VoucherDto> getValidRegistUsevoucherActive(Date nowTime) {
		List<VoucherDto> voucherDtoList = null; 
		VoucherDto voucherDto = null;
		List<Voucher> voucherList = voucherMapper.getValidRegistUsevoucherActive(nowTime);
		if(!ObjectUtils.isNullOrEmpty(voucherList)){
			voucherDtoList = new ArrayList<VoucherDto>();
			for (Voucher voucher : voucherList) {
				voucherDto = new VoucherDto();
				ObjectUtils.fastCopy(voucher, voucherDto);
				voucherDtoList.add(voucherDto);
			}
		}
		return voucherDtoList;
	}
}
