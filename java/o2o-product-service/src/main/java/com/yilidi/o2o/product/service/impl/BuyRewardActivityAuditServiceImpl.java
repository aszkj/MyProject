package com.yilidi.o2o.product.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.proxy.ICouponProxyService;
import com.yilidi.o2o.order.proxy.dto.CouponProxyDto;
import com.yilidi.o2o.product.dao.BuyRewardActivityAuditMapper;
import com.yilidi.o2o.product.model.BuyRewardActivityAudit;
import com.yilidi.o2o.product.model.BuyRewardActivityMapping;
import com.yilidi.o2o.product.model.query.BuyRewardActivityQuery;
import com.yilidi.o2o.product.service.IBuyRewardActivityAuditService;
import com.yilidi.o2o.product.service.IProductService;
import com.yilidi.o2o.product.service.ISaleProductService;
import com.yilidi.o2o.product.service.dto.BuyRewardActivityAuditDto;
import com.yilidi.o2o.product.service.dto.BuyRewardActivityMappingDto;
import com.yilidi.o2o.product.service.dto.ProductDto;
import com.yilidi.o2o.product.service.dto.RewardSaleProductDto;
import com.yilidi.o2o.product.service.dto.RewardTicketDto;
import com.yilidi.o2o.product.service.dto.SaleProductAppDto;
import com.yilidi.o2o.product.service.dto.query.BuyRewardActivityQueryDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 功能描述：买赠活动ServiceImpl 作者： xiasl<br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 * 
 * @date 2017年3月1日
 */
@Service("buyRewardActivityAuditService")
public class BuyRewardActivityAuditServiceImpl extends BasicDataService implements IBuyRewardActivityAuditService {

    @Autowired
    private BuyRewardActivityAuditMapper buyRewardActivityAuditMapper;
    @Autowired
    private IProductService productService;
    @Autowired
    private ICouponProxyService couponProxyService;
    @Autowired
    private ISaleProductService saleProductService;

    @Override
    public void saveBuyRewardActivity(BuyRewardActivityAuditDto buyRewardActivityDto) throws ProductServiceException {
        try {
            List<BuyRewardActivityAuditDto> dtoList = listBuyRewardActivityByActivityName(
                    buyRewardActivityDto.getActivityName());
            if (!ObjectUtils.isNullOrEmpty(dtoList)) {
                throw new ProductServiceException("已存在相同名称的买赠活动！");
            }
            BuyRewardActivityAudit buyRewardActivity = new BuyRewardActivityAudit();
            ObjectUtils.fastCopy(buyRewardActivityDto, buyRewardActivity);
            buyRewardActivity.setStatusCode(SystemContext.ProductDomain.BUYREWARDACTIVITYSTATUSCODE_NOTSTART);
            buyRewardActivityAuditMapper.save(buyRewardActivity);
            String productInfo[] = buyRewardActivityDto.getProductInfo().split("__");
            String rewardInfo[] = buyRewardActivityDto.getRewardInfo().split("__");
            String productIds[] = productInfo[0].trim().split(",");
            String conditions[] = productInfo[1].split("\\|\\|");
            List<BuyRewardActivityMapping> list = new ArrayList<BuyRewardActivityMapping>();
            for (int i = 0; i < productIds.length; i++) {
                Integer productId = Integer.valueOf(productIds[i].trim());
                List<BuyRewardActivityAuditDto> existActivitys = this.getBuyRewardActivityByProductId(productId);
                if (!ObjectUtils.isNullOrEmpty(existActivitys)) {
                    for (BuyRewardActivityAuditDto activityDto : existActivitys) {
                        if (!SystemContext.ProductDomain.BUYREWARDACTIVITYSTATUSCODE_EXPIRED
                                .equals(activityDto.getStatusCode())) {
                            if (checkActivityTime(buyRewardActivityDto, activityDto)) {
                                ProductDto pDto = productService.loadProductByProductIdAndChannelCode(productId, null);
                                throw new ProductServiceException(pDto.getProductName() + "的活动时间与已参加的其他活动时间冲突！");
                            }
                        }
                    }
                }
                BuyRewardActivityMapping buyRewardActivityMapping = new BuyRewardActivityMapping();
                buyRewardActivityMapping.setActivityId(buyRewardActivity.getId());
                buyRewardActivityMapping.setProductId(productId);
                buyRewardActivityMapping.setCreateTime(buyRewardActivity.getCreateTime());
                buyRewardActivityMapping.setCreateUserId(buyRewardActivity.getCreateUserId());
                buyRewardActivityMapping.setRewardConditions(conditions[i].trim());
                buyRewardActivityMapping.setRewardGifts(rewardInfo[0].trim());
                buyRewardActivityMapping.setGiftAmount(rewardInfo[1].trim());
                list.add(buyRewardActivityMapping);
            }
            buyRewardActivityAuditMapper.saveActivityMapping(list);
        } catch (Exception e) {
            logger.error("save异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<BuyRewardActivityAuditDto> listBuyRewardActivityByActivityName(String activityName)
            throws ProductServiceException {
        if (StringUtils.isEmpty(activityName)) {
            throw new ProductServiceException("参数activityName为空!");
        }
        List<BuyRewardActivityAudit> list = buyRewardActivityAuditMapper.listBuyRewardActivityByActivityName(activityName);
        List<BuyRewardActivityAuditDto> Dtolist = new ArrayList<BuyRewardActivityAuditDto>();
        if (!ObjectUtils.isNullOrEmpty(list)) {
            for (BuyRewardActivityAudit buyRewardActivity : list) {
                BuyRewardActivityAuditDto buyRewardActivityDto = new BuyRewardActivityAuditDto();
                ObjectUtils.fastCopy(buyRewardActivity, buyRewardActivityDto);
                Dtolist.add(buyRewardActivityDto);
            }
        }
        return Dtolist;
    }

    /**
     * 校验包含同一商品的 新建活动与已存在的活动是否存在活动时间交叉
     * 
     * @param buyRewardActivityDto
     *            新建的活动Dto
     * @param activityDto
     *            已参加的其他活动Dto
     * @return
     */
    private boolean checkActivityTime(BuyRewardActivityAuditDto buyRewardActivityDto,
            BuyRewardActivityAuditDto activityDto) {
        if (buyRewardActivityDto.getActivityBegin().after(activityDto.getActivityEnd())
                || buyRewardActivityDto.getActivityEnd().before(activityDto.getActivityBegin())) {
            return false;
        }
        if (activityDto.getId().equals(buyRewardActivityDto.getId())) {
            return false;
        }
        return true;
    }

    @Override
    public void updateBuyRewardActivity(BuyRewardActivityAuditDto buyRewardActivityDto) throws ProductServiceException {
        try {
            // 检查产品品牌参数品牌Id是否为空
            if (ObjectUtils.isNullOrEmpty(buyRewardActivityDto.getId())) {
                logger.error("buyRewardActivityDto.id => 需要更新的买赠活动参数id为空");
                throw new ProductServiceException("buyRewardActivityService的updateBuyRewardActivity方法参数id为空");
            }
            List<BuyRewardActivityAuditDto> dtoList = listBuyRewardActivityByActivityName(
                    buyRewardActivityDto.getActivityName());
            if (!ObjectUtils.isNullOrEmpty(dtoList)) {
                for (BuyRewardActivityAuditDto dto : dtoList) {
                    if (!dto.getId().equals(buyRewardActivityDto.getId())) {
                        throw new ProductServiceException("已存在相同名称的买赠活动！");
                    }
                }
            }
            /*
             * if
             * (SystemContext.ProductDomain.BUYREWARDACTIVITYSTATUSCODE_STARTED
             * .equals(buyRewardActivityDto.getStatusCode())) {
             * BuyRewardActivityAudit buyRewardActivity = new
             * BuyRewardActivityAudit();
             * ObjectUtils.fastCopy(buyRewardActivityDto, buyRewardActivity); if
             * (buyRewardActivity.getModifyTime().before(buyRewardActivity.
             * getActivityBegin())) {
             * buyRewardActivity.setStatusCode(SystemContext.ProductDomain.
             * BUYREWARDACTIVITYSTATUSCODE_NOTSTART); } else if
             * (buyRewardActivity.getModifyTime().after(buyRewardActivity.
             * getActivityEnd())) {
             * buyRewardActivity.setStatusCode(SystemContext.ProductDomain.
             * BUYREWARDACTIVITYSTATUSCODE_EXPIRED); } else {
             * buyRewardActivity.setStatusCode(SystemContext.ProductDomain.
             * BUYREWARDACTIVITYSTATUSCODE_STARTED); }
             * buyRewardActivityAuditMapper.update(buyRewardActivity); } else {
             */
            BuyRewardActivityAudit buyRewardActivity = new BuyRewardActivityAudit();
            ObjectUtils.fastCopy(buyRewardActivityDto, buyRewardActivity);
            /*
             * if (buyRewardActivity.getModifyTime().before(buyRewardActivity.
             * getActivityBegin())) {
             * buyRewardActivity.setStatusCode(SystemContext.ProductDomain.
             * BUYREWARDACTIVITYSTATUSCODE_NOTSTART); } else if
             * (buyRewardActivity.getModifyTime().after(buyRewardActivity.
             * getActivityEnd())) {
             * buyRewardActivity.setStatusCode(SystemContext.ProductDomain.
             * BUYREWARDACTIVITYSTATUSCODE_EXPIRED); } else {
             * buyRewardActivity.setStatusCode(SystemContext.ProductDomain.
             * BUYREWARDACTIVITYSTATUSCODE_STARTED); }
             */
            buyRewardActivityAuditMapper.update(buyRewardActivity);
            buyRewardActivityAuditMapper.deleteBuyRewardActivityMappingsByActivityId(buyRewardActivityDto.getId());
            String productInfo[] = buyRewardActivityDto.getProductInfo().split("__");
            String rewardInfo[] = buyRewardActivityDto.getRewardInfo().split("__");
            String productIds[] = productInfo[0].trim().split(",");
            String conditions[] = productInfo[1].split("\\|\\|");
            List<BuyRewardActivityMapping> list = new ArrayList<BuyRewardActivityMapping>();
            for (int i = 0; i < productIds.length; i++) {
                Integer productId = Integer.valueOf(productIds[i].trim());
                List<BuyRewardActivityAuditDto> existActivitys = this.getBuyRewardActivityByProductId(productId);
                if (!ObjectUtils.isNullOrEmpty(existActivitys)) {
                    for (BuyRewardActivityAuditDto activityDto : existActivitys) {
                        if (!SystemContext.ProductDomain.BUYREWARDACTIVITYSTATUSCODE_EXPIRED
                                .equals(activityDto.getStatusCode())) {
                            if (checkActivityTime(buyRewardActivityDto, activityDto)) {
                                ProductDto pDto = productService.loadProductByProductIdAndChannelCode(productId, null);
                                throw new ProductServiceException(pDto.getProductName() + "的活动时间与已参加的其他活动时间冲突！");
                            }
                        }
                    }
                }
                BuyRewardActivityMapping buyRewardActivityMapping = new BuyRewardActivityMapping();
                buyRewardActivityMapping.setActivityId(buyRewardActivity.getId());
                buyRewardActivityMapping.setProductId(productId);
                buyRewardActivityMapping.setCreateTime(buyRewardActivity.getModifyTime());
                buyRewardActivityMapping.setCreateUserId(buyRewardActivity.getModifyUserId());
                buyRewardActivityMapping.setRewardConditions(conditions[i].trim());
                buyRewardActivityMapping.setRewardGifts(rewardInfo[0].trim());
                buyRewardActivityMapping.setGiftAmount(rewardInfo[1].trim());
                list.add(buyRewardActivityMapping);
            }
            buyRewardActivityAuditMapper.saveActivityMapping(list);
        } catch (Exception e) {
            logger.error("updateBuyRewardActivity异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public BuyRewardActivityAuditDto loadById(Integer id) throws ProductServiceException {
        BuyRewardActivityAuditDto buyRewardActivityDto = null;
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new ProductServiceException("参数id不能为空");
            }
            BuyRewardActivityAudit buyRewardActivity = buyRewardActivityAuditMapper.loadById(id);// 活动概要信息
            if (ObjectUtils.isNullOrEmpty(buyRewardActivity)) {
                throw new ProductServiceException("查询失败");
            }
            if (!ObjectUtils.isNullOrEmpty(buyRewardActivity)) {
                buyRewardActivityDto = new BuyRewardActivityAuditDto();
                ObjectUtils.fastCopy(buyRewardActivity, buyRewardActivityDto);
                // 活动参数信息
                List<BuyRewardActivityMapping> detailList = buyRewardActivityAuditMapper
                        .listBuyRewardActivityDetailsByActivityId(id);
                List<BuyRewardActivityMappingDto> detailDtoList = new ArrayList<BuyRewardActivityMappingDto>();
                if (!ObjectUtils.isNullOrEmpty(detailList)) {
                    for (BuyRewardActivityMapping detail : detailList) {
                        BuyRewardActivityMappingDto detailDto = new BuyRewardActivityMappingDto();
                        ObjectUtils.fastCopy(detail, detailDto);
                        ProductDto pDto = productService.loadProductByProductIdAndChannelCode(detailDto.getProductId(),
                                null);
                        detailDto.setMainProduct(pDto);// 主商品信息
                        String rewardGiftIds[] = detailDto.getRewardGifts().split(",");
                        if (SystemContext.ProductDomain.BUYREWARDACTIVITYGIFTTYPE_PRODUCT
                                .equals(buyRewardActivity.getGiftType())) {
                            List<ProductDto> rewardProductDtos = new ArrayList<ProductDto>();
                            for (int i = 0; i < rewardGiftIds.length; i++) {
                                ProductDto rewardPDto = productService.loadProductByProductIdAndChannelCode(
                                        Integer.valueOf(rewardGiftIds[i].trim()), null);
                                rewardProductDtos.add(rewardPDto);
                            }
                            detailDto.setRewardProductDtos(rewardProductDtos);// 赠品信息list
                        }
                        if (SystemContext.ProductDomain.BUYREWARDACTIVITYGIFTTYPE_COUPON
                                .equals(buyRewardActivity.getGiftType())) {
                            List<Integer> couponIds = new ArrayList<Integer>(5);
                            for (String couponIdStr : rewardGiftIds) {
                                couponIds.add(Integer.parseInt(couponIdStr.trim()));
                            }
                            List<CouponProxyDto> couponProxyDtos = couponProxyService.listCouponByIds(couponIds);
                            detailDto.setCouponProxyDtos(couponProxyDtos);
                        }

                        List<String> giftAmountList = new ArrayList<String>();
                        String giftAmount[] = detailDto.getGiftAmount().split("\\|\\|");// 赠品之间间隔符为"||"
                        for (int j = 0; j < giftAmount.length; j++) {
                            giftAmountList.add(giftAmount[j].trim());
                        }
                        detailDto.setGiftAmountList(giftAmountList);// 每个赠品的赠送数量list(区间之间间隔符为",")
                        detailDtoList.add(detailDto);
                    }
                }
                buyRewardActivityDto.setBuyRewardActivityMappingDtoList(detailDtoList);
            }
            return buyRewardActivityDto;
        } catch (Exception e) {
            logger.error("loadById异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<BuyRewardActivityAuditDto> findBuyRewardActivitys(BuyRewardActivityQueryDto buyRewardActivityQueryDto)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(buyRewardActivityQueryDto)) {
                throw new ProductServiceException("参数buyRewardActivityQueryDto不能为空");
            }
            if (null == buyRewardActivityQueryDto.getStart() || buyRewardActivityQueryDto.getStart() <= 0) {
                buyRewardActivityQueryDto.setStart(1);
            }
            if (null == buyRewardActivityQueryDto.getPageSize() || buyRewardActivityQueryDto.getPageSize() <= 0) {
                buyRewardActivityQueryDto.setPageSize(CommonConstants.PAGE_SIZE);
            }
            Page<BuyRewardActivityAuditDto> pageDto = new Page<BuyRewardActivityAuditDto>(
                    buyRewardActivityQueryDto.getStart(), buyRewardActivityQueryDto.getPageSize());
            BuyRewardActivityQuery query = new BuyRewardActivityQuery();
            ObjectUtils.fastCopy(buyRewardActivityQueryDto, query);
            PageHelper.startPage(query.getStart(), query.getPageSize());
            Page<BuyRewardActivityAudit> page = buyRewardActivityAuditMapper.findBuyRewardActivityMappers(query);
            ObjectUtils.fastCopy(page, pageDto);
            List<BuyRewardActivityAudit> buyRewardActivitys = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(buyRewardActivitys)) {
                for (BuyRewardActivityAudit buyRewardActivity : buyRewardActivitys) {
                    BuyRewardActivityAuditDto buyRewardActivityDto = new BuyRewardActivityAuditDto();
                    ObjectUtils.fastCopy(buyRewardActivity, buyRewardActivityDto);

                    buyRewardActivityDto.setGiftTypeName(super.getSystemDictName(
                            SystemContext.ProductDomain.DictType.BUYREWARDACTIVITYGIFTTYPE.getValue(),
                            buyRewardActivityDto.getGiftType()));
                    buyRewardActivityDto.setValueMethodName(super.getSystemDictName(
                            SystemContext.ProductDomain.DictType.BUYREWARDACTIVITYVALUEMETHOD.getValue(),
                            buyRewardActivityDto.getValueMethod()));
                    buyRewardActivityDto.setStatusCodeName(super.getSystemDictName(
                            SystemContext.ProductDomain.DictType.BUYREWARDACTIVITYSTATUSCODE.getValue(),
                            buyRewardActivityDto.getStatusCode()));
                    buyRewardActivityDto.setAuditStatusName(super.getSystemDictName(
                            SystemContext.ProductDomain.DictType.BUYREWARDACTIVITYAUDITSTATUS.getValue(),
                            buyRewardActivityDto.getAuditStatus()));
                    pageDto.add(buyRewardActivityDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error("findBuyRewardActivitys异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<BuyRewardActivityAuditDto> getBuyRewardActivityByProductId(Integer productId)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(productId)) {
                throw new ProductServiceException("查询参数为空");
            }
            List<BuyRewardActivityAudit> aclist = buyRewardActivityAuditMapper.getBuyRewardActivityByProductId(productId);
            List<BuyRewardActivityAuditDto> acDtoList = new ArrayList<BuyRewardActivityAuditDto>();
            if (!ObjectUtils.isNullOrEmpty(aclist)) {
                for (BuyRewardActivityAudit buyRewardActivity : aclist) {
                    BuyRewardActivityAuditDto buyRewardActivityDto = new BuyRewardActivityAuditDto();
                    ObjectUtils.fastCopy(buyRewardActivity, buyRewardActivityDto);
                    acDtoList.add(buyRewardActivityDto);
                }
            }
            return acDtoList;
        } catch (Exception e) {
            logger.error("getBuyRewardActivityByProductId异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void deleteBuyRewardActivityById(List<Integer> idList, List<String> auditStatusList)
            throws ProductServiceException {
        try {
            // 检查数据包产品的Id是否为空
            if (ObjectUtils.isNullOrEmpty(idList)) {
                throw new ProductServiceException("买赠活动Id列表参数为空");
            }
            // 检查审核状态列表是否为空
            if (ObjectUtils.isNullOrEmpty(auditStatusList)) {
                throw new ProductServiceException("审核状态列表参数为空");
            }
            for (Integer id : idList) {
                int effectedCount = buyRewardActivityAuditMapper.deleteBuyRewardActivitysByIdsAndAuditStatusList(id,
                        auditStatusList);
                if (effectedCount == 1) {
                    buyRewardActivityAuditMapper.deleteBuyRewardActivityMappingsByActivityId(id);
                }
            }
        } catch (ProductServiceException e) {
            logger.error("updateAuditStatusByFinalAudit异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateAuditStatusByIds(List<Integer> idList, List<String> preAuditStatusList, Date submitTime,
            String auditStatus, Integer modifyUserId, Date modifyTime) throws ProductServiceException {
        try {
            // 检查数据包产品ID参数是否为空
            if (ObjectUtils.isNullOrEmpty(idList)) {
                throw new ProductServiceException("买赠活动ID列表参数为空");
            }
            // 检查提交审批之前的审核状态列表参数是否为空
            if (ObjectUtils.isNullOrEmpty(preAuditStatusList)) {
                throw new ProductServiceException("提交审批之前的审核状态列表参数为空");
            }
            // 检查提交审批时间参数是否为空
            if (ObjectUtils.isNullOrEmpty(submitTime)) {
                throw new ProductServiceException("提交审批时间参数为空");
            }
            // 检查提交审批之后的审核状态参数是否为空
            if (ObjectUtils.isNullOrEmpty(auditStatus)) {
                throw new ProductServiceException("提交审批之后的审核状态参数为空");
            }
            // 检查更新人参数是否为空
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                throw new ProductServiceException("更新人参数为空");
            }
            // 检查更新时间参数是否为空
            if (ObjectUtils.isNullOrEmpty(modifyTime)) {
                throw new ProductServiceException("更新时间参数为空");
            }
            for (Integer id : idList) {
                Integer effectedCount = buyRewardActivityAuditMapper.updateAuditStatusById(id, preAuditStatusList,
                        submitTime, auditStatus, modifyUserId, modifyTime);
                if (effectedCount.intValue() != 1) {
                    BuyRewardActivityAuditDto buyRewardActivityAuditDto = this.loadById(id);
                    if (!ObjectUtils.isNullOrEmpty(buyRewardActivityAuditDto)) {
                        throw new ProductServiceException(
                                "活动：" + buyRewardActivityAuditDto.getActivityName() + " 提交审批之前的审核状态只能为待审核，审批驳回");
                    } else {
                        throw new ProductServiceException("提交审批之前的审核状态只能为待审核、审批驳回");
                    }
                }
            }
        } catch (ProductServiceException e) {
            logger.error("updateAuditStatusByFinalAudit异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateAuditStatusByFinalAudit(Integer id, String preAuditStatus, String auditStatus,
            Integer finalAuditUserId, Date finalAuditTime, String finalAuditRejectReason, Integer modifyUserId,
            Date modifyTime) throws ProductServiceException {
        try {
            // 检查待审核买赠活动ID参数是否为空
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new ProductServiceException("待审核买赠活动ID参数为空");
            }
            // 检查审批之前的审核状态参数是否为空
            if (ObjectUtils.isNullOrEmpty(preAuditStatus)) {
                throw new ProductServiceException("审批之前的审核状态参数为空");
            }
            // 检查审批之后的审核状态参数是否为空
            if (ObjectUtils.isNullOrEmpty(auditStatus)) {
                throw new ProductServiceException("审批之后的审核状态参数为空");
            }
            // 检查审批用户ID参数是否为空
            if (ObjectUtils.isNullOrEmpty(finalAuditUserId)) {
                throw new ProductServiceException("审批用户ID参数为空");
            }
            // 检查审批时间参数是否为空
            if (ObjectUtils.isNullOrEmpty(finalAuditTime)) {
                throw new ProductServiceException("审批时间参数为空");
            }
            // 检查更新人参数是否为空
            if (ObjectUtils.isNullOrEmpty(modifyUserId)) {
                throw new ProductServiceException("更新人参数为空");
            }
            // 检查更新时间参数是否为空
            if (ObjectUtils.isNullOrEmpty(modifyTime)) {
                throw new ProductServiceException("更新时间参数为空");
            }
            Integer effectedCount = buyRewardActivityAuditMapper.updateAuditStatusByFinalAudit(id, preAuditStatus,
                    auditStatus, finalAuditUserId, finalAuditTime, finalAuditRejectReason, modifyUserId, modifyTime);
            if (effectedCount.intValue() != 1) {
                throw new ProductServiceException("审批之前的审核状态只能为待审批");
            }

        } catch (ProductServiceException e) {
            logger.error("updateAuditStatusByFinalAudit异常", e);
            throw new ProductServiceException(e.getMessage());
        }

    }

    @Override
    public void saveStandardByFinalAuditPass(Integer id, String preAuditStatus, String auditStatus, Integer finalAuditUserId,
            Date finalAuditTime, String finalAuditRejectReason, Integer modifyUserId, Date modifyTime) {
        try {
            BuyRewardActivityAuditDto auditDto = this.loadById(id);
            this.updateAuditStatusByFinalAudit(id, preAuditStatus, auditStatus, finalAuditUserId, finalAuditTime,
                    finalAuditRejectReason, modifyUserId, modifyTime);
            if (modifyTime.before(auditDto.getActivityBegin())) {
                auditDto.setStatusCode(SystemContext.ProductDomain.BUYREWARDACTIVITYSTATUSCODE_NOTSTART);
            } else if (modifyTime.after(auditDto.getActivityEnd())) {
                auditDto.setStatusCode(SystemContext.ProductDomain.BUYREWARDACTIVITYSTATUSCODE_EXPIRED);
            } else {
                auditDto.setStatusCode(SystemContext.ProductDomain.BUYREWARDACTIVITYSTATUSCODE_STARTED);
            }
            buyRewardActivityAuditMapper.updateStatusCode(id, auditDto.getStatusCode());
        } catch (ProductServiceException e) {
            logger.error("saveStandardByFinalAuditPass异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateActivityStatus(Integer id, String statusCode) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                throw new ProductServiceException("活动ID参数为空");
            }
            if (ObjectUtils.isNullOrEmpty(statusCode)) {
                throw new ProductServiceException("活动进行状态参数为空");
            }
            buyRewardActivityAuditMapper.updateStatusCode(id, statusCode);
        } catch (Exception e) {
            logger.error("updateActivityStatus异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<BuyRewardActivityAuditDto> listBuyRewardActivityByActivityStatusCode(String statusCode, String auditStatus)
            throws ProductServiceException {
        try {
            if (StringUtils.isEmpty(statusCode)) {
                statusCode = SystemContext.ProductDomain.BUYREWARDACTIVITYSTATUSCODE_EXPIRED;
            }
            if (StringUtils.isEmpty(auditStatus)) {
                statusCode = SystemContext.ProductDomain.BUYREWARDACTIVITYAUDITSTATUS_FINISHED;
            }
            List<BuyRewardActivityAudit> aclist = buyRewardActivityAuditMapper
                    .listBuyRewardActivityByActivityStatusCode(statusCode, auditStatus);
            List<BuyRewardActivityAuditDto> acDtoList = new ArrayList<BuyRewardActivityAuditDto>();
            if (!ObjectUtils.isNullOrEmpty(aclist)) {
                for (BuyRewardActivityAudit buyRewardActivity : aclist) {
                    BuyRewardActivityAuditDto buyRewardActivityDto = new BuyRewardActivityAuditDto();
                    ObjectUtils.fastCopy(buyRewardActivity, buyRewardActivityDto);
                    acDtoList.add(buyRewardActivityDto);
                }
            }
            return acDtoList;
        } catch (Exception e) {
            logger.error("listBuyRewardActivityByActivityStatusCode异常", e);
            throw new ProductServiceException(e.getMessage());
        }

    }

    @Override
    public void updateActivityTime(BuyRewardActivityAuditDto buyRewardActivityAuditDto) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(buyRewardActivityAuditDto)) {
                throw new ProductServiceException("要修改的活动参数为空");
            }
            BuyRewardActivityAudit act = new BuyRewardActivityAudit();
            ObjectUtils.fastCopy(buyRewardActivityAuditDto, act);
            Integer effectedCount = buyRewardActivityAuditMapper.updateActivityTime(act);
            if (effectedCount.intValue() != 1) {
                throw new ProductServiceException("请检查活动状态是否已发生变化");
            }
        } catch (Exception e) {
            logger.error("updateActivityTime异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    /*
     * @Override public String getActivitySummary(Integer productId) throws
     * ProductServiceException { try { List<BuyRewardActivityAuditDto>
     * existActivitys = this.getBuyRewardActivityByProductId(productId); Date
     * currentTime = DateUtils.getCurrentDateTime(); StringBuffer summaryStr =
     * new StringBuffer(""); if (ObjectUtils.isNullOrEmpty(existActivitys)) {
     * return summaryStr.toString(); } for (BuyRewardActivityAuditDto dto :
     * existActivitys) { if (currentTime.before(dto.getActivityEnd()) &&
     * currentTime.after(dto.getActivityBegin())) { BuyRewardActivityMapping
     * acDetail = buyRewardActivityAuditMapper
     * .getBuyRewardActivityDetailByProductIdAndActivityId(productId,
     * dto.getId()); BuyRewardActivityMappingDto detailDto = new
     * BuyRewardActivityMappingDto(); ObjectUtils.fastCopy(acDetail, detailDto);
     * String[] rewardGiftIds = detailDto.getRewardGifts().split(","); if
     * (SystemContext.ProductDomain.BUYREWARDACTIVITYVALUEMETHOD_INTERVAL.equals
     * (dto.getValueMethod())) { String[] conditions =
     * detailDto.getRewardConditions().split(","); summaryStr.append("购满" +
     * conditions[0].split("~")[0] + "件 赠"); Integer intervalNum =
     * conditions.length; String[] rewardCount =
     * detailDto.getGiftAmount().split("\\|\\|"); if
     * (SystemContext.ProductDomain.BUYREWARDACTIVITYGIFTTYPE_PRODUCT.equals(dto
     * .getGiftType())) { int i = 0; for (String rewardProductId :
     * rewardGiftIds) { ProductDto rpDto = productService
     * .loadProductByProductIdAndChannelCode(Integer.valueOf(rewardProductId),
     * null); summaryStr.append(rewardCount[i++].split(",")[0] + "件");
     * summaryStr.append( rpDto.getProductName() + "(" +
     * rpDto.getProductProfileDto().getProductSpec() + ")"); if (i <
     * rewardGiftIds.length) { summaryStr.append("及"); } } } if
     * (SystemContext.ProductDomain.BUYREWARDACTIVITYGIFTTYPE_COUPON.equals(dto.
     * getGiftType())) { List<Integer> couponIds = new ArrayList<Integer>(5);
     * for (String couponIdStr : rewardGiftIds) {
     * couponIds.add(Integer.parseInt(couponIdStr.trim())); }
     * List<CouponProxyDto> couponProxyDtos =
     * couponProxyService.listCouponByIds(couponIds); int j = 0; for
     * (CouponProxyDto couponProxyDto : couponProxyDtos) {
     * summaryStr.append(rewardCount[j++].split(",")[0] + "张");
     * summaryStr.append(couponProxyDto.getConName()+"优惠券"); if (j <
     * rewardGiftIds.length) { summaryStr.append("及"); } } } if (intervalNum >
     * 1) { summaryStr.append("，多买更有大惊喜！"); } } if
     * (SystemContext.ProductDomain.BUYREWARDACTIVITYVALUEMETHOD_MULTIPLE.equals
     * (dto.getValueMethod())) { String conditions =
     * detailDto.getRewardConditions(); summaryStr.append("购满" + conditions +
     * "件 赠"); String[] rewardCount = detailDto.getGiftAmount().split("\\|\\|");
     * if
     * (SystemContext.ProductDomain.BUYREWARDACTIVITYGIFTTYPE_PRODUCT.equals(dto
     * .getGiftType())) { int i = 0; for (String rewardProductId :
     * rewardGiftIds) { ProductDto rpDto = productService
     * .loadProductByProductIdAndChannelCode(Integer.valueOf(rewardProductId),
     * null); summaryStr.append(rewardCount[i++] + "件"); summaryStr.append(
     * rpDto.getProductName() + "(" +
     * rpDto.getProductProfileDto().getProductSpec() + ")"); if (i <
     * rewardGiftIds.length) { summaryStr.append("及"); } } } if
     * (SystemContext.ProductDomain.BUYREWARDACTIVITYGIFTTYPE_COUPON.equals(dto.
     * getGiftType())) { List<Integer> couponIds = new ArrayList<Integer>(5);
     * for (String couponIdStr : rewardGiftIds) {
     * couponIds.add(Integer.parseInt(couponIdStr.trim())); }
     * List<CouponProxyDto> couponProxyDtos =
     * couponProxyService.listCouponByIds(couponIds); int j = 0; for
     * (CouponProxyDto couponProxyDto : couponProxyDtos) {
     * summaryStr.append(rewardCount[j++] + "张");
     * summaryStr.append(couponProxyDto.getConName()+"优惠券"); if (j <
     * rewardGiftIds.length) { summaryStr.append("及"); } } }
     * summaryStr.append("，翻倍买，翻倍送！"); } } } return summaryStr.toString(); }
     * catch (Exception e) { logger.error("getActivitySummary异常", e); throw new
     * ProductServiceException(e.getMessage()); } }
     */
    @Override
    public List<BuyRewardActivityAuditDto> getActivityInfoList(Integer productId) throws ProductServiceException {
        try {
            List<BuyRewardActivityAuditDto> existActivitys = this.getBuyRewardActivityByProductId(productId);
            List<BuyRewardActivityAuditDto> startedActivitys = new ArrayList<BuyRewardActivityAuditDto>();
            Date currentTime = DateUtils.getCurrentDateTime();
            if (!ObjectUtils.isNullOrEmpty(existActivitys)) {
                for (BuyRewardActivityAuditDto dto : existActivitys) {
                    if (currentTime.before(dto.getActivityEnd()) && currentTime.after(dto.getActivityBegin())) {
                        startedActivitys.add(dto);
                    }
                }
            }
            return startedActivitys;
        } catch (Exception e) {
            logger.error("getActivityInfoList异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<RewardSaleProductDto> listRewardSaleProductsBySaleProductId(Integer saleProductId, Integer productNumber)
            throws ProductServiceException {
        try {
            SaleProductAppDto saleProductAppDto = saleProductService.loadSaleProductById(saleProductId,
                    SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON,
                    SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE, null);
            if (ObjectUtils.isNullOrEmpty(saleProductAppDto)) {
                return Collections.emptyList();
            }
            if (ObjectUtils.isNullOrEmpty(productNumber)) {
                return Collections.emptyList();
            }
            List<BuyRewardActivityAuditDto> buyRewardActivityAuditDtos = listProgressingBuyRewardActivity();
            if (ObjectUtils.isNullOrEmpty(buyRewardActivityAuditDtos)) {
                return Collections.emptyList();
            }
            List<RewardSaleProductDto> rewardSaleProductDtos = new ArrayList<RewardSaleProductDto>();
            for (BuyRewardActivityAuditDto buyRewardActivityAuditDto : buyRewardActivityAuditDtos) {
                if (!SystemContext.ProductDomain.BUYREWARDACTIVITYGIFTTYPE_PRODUCT
                        .equals(buyRewardActivityAuditDto.getGiftType())) {
                    continue;
                }
                BuyRewardActivityMapping buyRewardActivityMapping = buyRewardActivityAuditMapper
                        .getBuyRewardActivityDetailByProductIdAndActivityId(saleProductAppDto.getProductId(),
                                buyRewardActivityAuditDto.getId());
                if (ObjectUtils.isNullOrEmpty(buyRewardActivityMapping)) {
                    continue;
                }
                String[] rewardProductIdArr = buyRewardActivityMapping.getRewardGifts()
                        .split(CommonConstants.DELIMITER_COMMA);
                String[] giftAmountArr = StringUtils.trimToEmpty(buyRewardActivityMapping.getRewardGifts())
                        .split(CommonConstants.DELIMITER_DOUBLE_VERTICAL_LINE);
                String[] rewardCondArr = StringUtils.trimToEmpty(buyRewardActivityMapping.getRewardConditions())
                        .split(CommonConstants.DELIMITER_COMMA);
                if (ObjectUtils.isNullOrEmpty(giftAmountArr) || ObjectUtils.isNullOrEmpty(rewardCondArr)
                        || giftAmountArr.length != rewardProductIdArr.length) {
                    throw new ProductServiceException("买赠活动赠品奖励设置有误");
                }
                if (SystemContext.ProductDomain.BUYREWARDACTIVITYVALUEMETHOD_MULTIPLE
                        .equals(buyRewardActivityAuditDto.getValueMethod())) {
                    int rewardCond = ArithUtils.converStringToInt(StringUtils.trimToEmpty(rewardCondArr[0]));
                    if (rewardCond <= 0) {
                        throw new ProductServiceException("买赠活动赠品条件设置有误");
                    }
                    int multiple = productNumber / rewardCond;
                    if (multiple <= 0) {
                        continue;
                    }
                    for (int i = 0; i < rewardProductIdArr.length; i++) {
                        String[] productGiftAmountArr = StringUtils.trimToEmpty(giftAmountArr[i])
                                .split(CommonConstants.DELIMITER_COMMA);
                        if (productGiftAmountArr.length != 1) {
                            throw new ProductServiceException("买赠活动赠品奖励设置有误");
                        }
                        int productGiftAmount = ArithUtils.converStringToInt(productGiftAmountArr[0]);
                        Integer productId = ArithUtils.converStringToInt(rewardProductIdArr[i]);
                        SaleProductAppDto saleProductDto = saleProductService
                                .loadByStoreIdAndProductId(saleProductAppDto.getStoreId(), productId);
                        if (ObjectUtils.isNullOrEmpty(saleProductDto)) {
                            logger.info("店铺(" + saleProductAppDto.getStoreId() + ")不存在产品ID(" + productId + ")");
                            continue;
                        }
                        RewardSaleProductDto rewardSaleProductAppDto = new RewardSaleProductDto();
                        ObjectUtils.fastCopy(saleProductDto, rewardSaleProductAppDto);
                        rewardSaleProductAppDto.setNumber(multiple * productGiftAmount);
                        rewardSaleProductDtos.add(rewardSaleProductAppDto);
                    }
                }
                if (SystemContext.ProductDomain.BUYREWARDACTIVITYVALUEMETHOD_INTERVAL
                        .equals(buyRewardActivityAuditDto.getValueMethod())) {
                    for (int i = 0; i < rewardProductIdArr.length; i++) {
                        String[] productGiftAmountArr = StringUtils.trimToEmpty(giftAmountArr[i])
                                .split(CommonConstants.DELIMITER_COMMA);
                        if (productGiftAmountArr.length < rewardCondArr.length) {
                            throw new ProductServiceException("买赠活动赠品奖励设置有误");
                        }
                        Integer productId = ArithUtils.converStringToInt(rewardProductIdArr[i]);
                        SaleProductAppDto saleProductDto = saleProductService
                                .loadByStoreIdAndProductId(saleProductAppDto.getStoreId(), productId);
                        RewardSaleProductDto rewardSaleProductAppDto = new RewardSaleProductDto();
                        ObjectUtils.fastCopy(saleProductDto, rewardSaleProductAppDto);
                        int rewardNumber = 0;
                        for (int k = 0; k < rewardCondArr.length; k++) {
                            int intervalGiftAmount = ArithUtils.converStringToInt(productGiftAmountArr[k]);
                            String[] intervalArr = StringUtils.trimToEmpty(rewardCondArr[k])
                                    .split(CommonConstants.DELIMITER_WAVE_LINE);
                            int starInterval = ArithUtils.converStringToInt(intervalArr[0]);
                            int endInterval = Integer.MAX_VALUE;
                            if (intervalArr.length > 1) {
                                endInterval = ArithUtils.converStringToInt(intervalArr[1]);
                            }
                            if (productNumber >= starInterval && productNumber <= endInterval) {
                                rewardNumber = intervalGiftAmount;
                            }
                        }
                        if (rewardNumber <= 0) {
                            continue;
                        }
                        rewardSaleProductAppDto.setNumber(rewardNumber);
                        rewardSaleProductDtos.add(rewardSaleProductAppDto);
                    }
                }
            }
            return rewardSaleProductDtos;
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<BuyRewardActivityAuditDto> listProgressingBuyRewardActivity() throws ProductServiceException {
        try {
            List<BuyRewardActivityAuditDto> buyRewardActivityAuditDtos = this.listBuyRewardActivityByActivityStatusCode(
                    SystemContext.ProductDomain.BUYREWARDACTIVITYSTATUSCODE_STARTED,
                    SystemContext.ProductDomain.BUYREWARDACTIVITYAUDITSTATUS_FINISHED);
            if (ObjectUtils.isNullOrEmpty(buyRewardActivityAuditDtos)) {
                return Collections.emptyList();
            }
            List<BuyRewardActivityAuditDto> progressingActivityDtos = new ArrayList<BuyRewardActivityAuditDto>(
                    buyRewardActivityAuditDtos.size());
            Date nowTime = new Date();
            for (BuyRewardActivityAuditDto buyRewardActivityAuditDto : buyRewardActivityAuditDtos) {
                if (!nowTime.before(buyRewardActivityAuditDto.getActivityBegin())
                        && !buyRewardActivityAuditDto.getActivityEnd().before(nowTime)) {
                    progressingActivityDtos.add(buyRewardActivityAuditDto);
                }
            }
            return buyRewardActivityAuditDtos;
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<RewardTicketDto> listRewardTicketsBySaleProductId(Integer saleProductId, Integer productNumber)
            throws ProductServiceException {
        try {
            SaleProductAppDto saleProductAppDto = saleProductService.loadSaleProductById(saleProductId,
                    SystemContext.ProductDomain.SALEPRODUCTENABLEDFLAG_ON,
                    SystemContext.ProductDomain.SALEPRODUCTSALESTATUS_ONSALE, null);
            if (ObjectUtils.isNullOrEmpty(saleProductAppDto)) {
                return Collections.emptyList();
            }
            if (ObjectUtils.isNullOrEmpty(productNumber)) {
                return Collections.emptyList();
            }
            List<BuyRewardActivityAuditDto> buyRewardActivityAuditDtos = listProgressingBuyRewardActivity();
            if (ObjectUtils.isNullOrEmpty(buyRewardActivityAuditDtos)) {
                return Collections.emptyList();
            }
            List<RewardTicketDto> rewardTicketDtos = new ArrayList<RewardTicketDto>();
            for (BuyRewardActivityAuditDto buyRewardActivityAuditDto : buyRewardActivityAuditDtos) {
                if (!SystemContext.ProductDomain.BUYREWARDACTIVITYGIFTTYPE_COUPON
                        .equals(buyRewardActivityAuditDto.getGiftType())) {
                    continue;
                }
                BuyRewardActivityMapping buyRewardActivityMapping = buyRewardActivityAuditMapper
                        .getBuyRewardActivityDetailByProductIdAndActivityId(saleProductAppDto.getProductId(),
                                buyRewardActivityAuditDto.getId());
                if (ObjectUtils.isNullOrEmpty(buyRewardActivityMapping)) {
                    continue;
                }
                String[] rewardTicketIdArr = buyRewardActivityMapping.getRewardGifts()
                        .split(CommonConstants.DELIMITER_COMMA);
                String[] giftAmountArr = StringUtils.trimToEmpty(buyRewardActivityMapping.getRewardGifts())
                        .split(CommonConstants.DELIMITER_DOUBLE_VERTICAL_LINE);
                String[] rewardCondArr = StringUtils.trimToEmpty(buyRewardActivityMapping.getRewardConditions())
                        .split(CommonConstants.DELIMITER_COMMA);
                if (ObjectUtils.isNullOrEmpty(giftAmountArr) || ObjectUtils.isNullOrEmpty(rewardCondArr)
                        || giftAmountArr.length != rewardTicketIdArr.length) {
                    throw new ProductServiceException("买赠活动赠品奖励设置有误");
                }
                if (SystemContext.ProductDomain.BUYREWARDACTIVITYVALUEMETHOD_MULTIPLE
                        .equals(buyRewardActivityAuditDto.getValueMethod())) {
                    int rewardCond = ArithUtils.converStringToInt(StringUtils.trimToEmpty(rewardCondArr[0]));
                    if (rewardCond <= 0) {
                        throw new ProductServiceException("买赠活动赠品条件设置有误");
                    }
                    int multiple = productNumber / rewardCond;
                    if (multiple <= 0) {
                        continue;
                    }
                    for (int i = 0; i < rewardTicketIdArr.length; i++) {
                        String[] ticketGiftAmountArr = StringUtils.trimToEmpty(giftAmountArr[i])
                                .split(CommonConstants.DELIMITER_COMMA);
                        if (ticketGiftAmountArr.length != 1) {
                            throw new ProductServiceException("买赠活动赠品奖励设置有误");
                        }
                        int ticketGiftAmount = ArithUtils.converStringToInt(ticketGiftAmountArr[0]);
                        Integer ticketId = ArithUtils.converStringToInt(rewardTicketIdArr[i]);
                        CouponProxyDto couponProxyDto = couponProxyService.loadCouponById(ticketId);
                        RewardTicketDto rewardTicketDto = new RewardTicketDto();
                        rewardTicketDto.setTicketCode(SystemContext.ProductDomain.BUYREWARDACTIVITYGIFTTYPE_COUPON);
                        rewardTicketDto.setTicketCodeName(this.getSystemDictName(
                                SystemContext.ProductDomain.DictType.BUYREWARDACTIVITYGIFTTYPE.getValue(),
                                rewardTicketDto.getTicketCode()));
                        rewardTicketDto.setTicketId(couponProxyDto.getConId());
                        rewardTicketDto.setTicketDescription(couponProxyDto.getUseRangeCodeName());
                        rewardTicketDto.setRewardNumber(multiple * ticketGiftAmount);
                        rewardTicketDtos.add(rewardTicketDto);
                    }
                }
                if (SystemContext.ProductDomain.BUYREWARDACTIVITYVALUEMETHOD_INTERVAL
                        .equals(buyRewardActivityAuditDto.getValueMethod())) {
                    for (int i = 0; i < rewardTicketIdArr.length; i++) {
                        String[] ticketGiftAmountArr = StringUtils.trimToEmpty(giftAmountArr[i])
                                .split(CommonConstants.DELIMITER_COMMA);
                        if (ticketGiftAmountArr.length < rewardCondArr.length) {
                            throw new ProductServiceException("买赠活动赠品奖励设置有误");
                        }
                        Integer ticketId = ArithUtils.converStringToInt(rewardTicketIdArr[i]);
                        CouponProxyDto couponProxyDto = couponProxyService.loadCouponById(ticketId);
                        RewardTicketDto rewardTicketDto = new RewardTicketDto();
                        rewardTicketDto.setTicketCode(SystemContext.ProductDomain.BUYREWARDACTIVITYGIFTTYPE_COUPON);
                        rewardTicketDto.setTicketCodeName(this.getSystemDictName(
                                SystemContext.ProductDomain.DictType.BUYREWARDACTIVITYGIFTTYPE.getValue(),
                                rewardTicketDto.getTicketCode()));
                        rewardTicketDto.setTicketId(couponProxyDto.getConId());
                        rewardTicketDto.setTicketDescription(couponProxyDto.getUseRangeCodeName());
                        int rewardNumber = 0;
                        for (int k = 0; k < rewardCondArr.length; k++) {
                            int intervalGiftAmount = ArithUtils.converStringToInt(ticketGiftAmountArr[k]);
                            String[] intervalArr = StringUtils.trimToEmpty(rewardCondArr[k])
                                    .split(CommonConstants.DELIMITER_WAVE_LINE);
                            int starInterval = ArithUtils.converStringToInt(intervalArr[0]);
                            int endInterval = Integer.MAX_VALUE;
                            if (intervalArr.length > 1) {
                                endInterval = ArithUtils.converStringToInt(intervalArr[1]);
                            }
                            if (productNumber >= starInterval && productNumber <= endInterval) {
                                rewardNumber = intervalGiftAmount;
                            }
                        }
                        if (rewardNumber <= 0) {
                            continue;
                        }
                        rewardTicketDto.setRewardNumber(rewardNumber);
                        rewardTicketDtos.add(rewardTicketDto);
                    }
                }
            }
            return Collections.emptyList();
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }
}
