package com.yilidi.o2o.product.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
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
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.proxy.ISecKillSaleProductInventoryProxyService;
import com.yilidi.o2o.order.proxy.dto.SecKillSaleProductInventoryProxyDto;
import com.yilidi.o2o.product.dao.ActivityMapper;
import com.yilidi.o2o.product.dao.ProductMapper;
import com.yilidi.o2o.product.dao.SaleProductMapper;
import com.yilidi.o2o.product.dao.SecKillProductMapper;
import com.yilidi.o2o.product.dao.SecKillSceneMapper;
import com.yilidi.o2o.product.dao.SecKillSceneProductRelationMapper;
import com.yilidi.o2o.product.model.Activity;
import com.yilidi.o2o.product.model.Product;
import com.yilidi.o2o.product.model.SaleProduct;
import com.yilidi.o2o.product.model.SecKillProduct;
import com.yilidi.o2o.product.model.SecKillScene;
import com.yilidi.o2o.product.model.SecKillSceneProductRelation;
import com.yilidi.o2o.product.model.combination.SecKillProductRelatedInfo;
import com.yilidi.o2o.product.model.query.SecKillSceneQuery;
import com.yilidi.o2o.product.proxy.dto.SecKillSceneProxyDto;
import com.yilidi.o2o.product.service.ISecKillSceneService;
import com.yilidi.o2o.product.service.dto.SecKillProductDto;
import com.yilidi.o2o.product.service.dto.SecKillSceneDto;
import com.yilidi.o2o.product.service.dto.SecKillSceneRelateProductDto;
import com.yilidi.o2o.product.service.dto.query.SaleProductQuery;
import com.yilidi.o2o.product.service.dto.query.SecKillSceneQueryDto;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.proxy.IUserProxyService;
import com.yilidi.o2o.user.proxy.dto.UserProxyDto;

/**
 * 秒杀场次服务接口实现类
 * 
 * @author: chenb
 * @date: 2016年8月19日 上午11:26:29
 */
@Service("secKillSceneService")
public class SecKillSceneServiceImpl extends BasicDataService implements ISecKillSceneService {

    @Autowired
    private SecKillSceneMapper secKillSceneMapper;
    @Autowired
    private ActivityMapper activityMapper;
    @Autowired
    private SecKillProductMapper secKillProductMapper;
    @Autowired
    private SecKillSceneProductRelationMapper secKillSceneProductRelationMapper;
    @Autowired
    private ProductMapper productMapper;
    @Autowired
    private SaleProductMapper saleProductMapper;
    @Autowired
    private IUserProxyService userProxyService;
    @Autowired
    private ISecKillSaleProductInventoryProxyService secKillSaleProductInventoryProxyService;

    /** 秒杀场次活动间隔时间：单位:分钟 **/
    private static final int SECKILLSCENE_INTERVAL_TIME = 30;

    @Override
    public Integer save(SecKillSceneDto secKillSceneDto) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(secKillSceneDto) || ObjectUtils.isNullOrEmpty(secKillSceneDto.getSceneName())
                    || ObjectUtils.isNullOrEmpty(secKillSceneDto.getRepeatType())
                    || ObjectUtils.isNullOrEmpty(secKillSceneDto.getStartTime())
                    || ObjectUtils.isNullOrEmpty(secKillSceneDto.getCreateUserId())
                    || ObjectUtils.isNullOrEmpty(secKillSceneDto.getUpdateUserId())) {
                throw new ProductServiceException("必填参数不能为空");
            }
            int intervalTime = getSceneIntervalTime();
            Date beginStartTime = DateUtils.addMinutes(secKillSceneDto.getStartTime(), -intervalTime);
            List<SecKillScene> secKillSceneList = secKillSceneMapper.listByStartTime(beginStartTime,
                    secKillSceneDto.getStartTime());
            if (!ObjectUtils.isNullOrEmpty(secKillSceneList)) {
                throw new ProductServiceException("秒杀场次间隔不能小于" + intervalTime + "分钟");
            }
            Date operatioDate = new Date();
            secKillSceneDto.setCreateTime(operatioDate);
            secKillSceneDto.setUpdateTime(operatioDate);
            SecKillScene secKillScene = new SecKillScene();
            ObjectUtils.fastCopy(secKillSceneDto, secKillScene);

            Activity activity = new Activity();
            activity.setActivityName(secKillScene.getSceneName());
            activity.setActivityType(SystemContext.ProductDomain.ACTIVITYTYPE_SECKILL);
            activity.setCreateTime(operatioDate);
            activity.setCreateUserId(secKillScene.getCreateUserId());
            activity.setUpdateUserId(secKillScene.getUpdateUserId());
            activity.setUpdateTime(secKillScene.getUpdateTime());
            activity.setStartTime(secKillScene.getStartTime());
            activityMapper.save(activity);
            secKillScene.setActivityId(activity.getId());
            secKillScene.setStatusCode(SystemContext.ProductDomain.SECKILLSCENESTATUSCODE_NOTSTART);
            Integer result = secKillSceneMapper.save(secKillScene);
            if (result == null || result.intValue() != 1) {
                throw new ProductServiceException("新增场次失败");
            }
            return result;
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    private int getSceneIntervalTime() {
        try {
            String sceneInvervalTimeStr = StringUtils
                    .trim(super.getSystemParamValue(SystemContext.SystemParams.P_SECKILLSCENE_INTERVAL_TIME));
            if (StringUtils.isBlank(sceneInvervalTimeStr)) {
                return SECKILLSCENE_INTERVAL_TIME;
            }
            return Integer.parseInt(sceneInvervalTimeStr);
        } catch (Exception e) {
            logger.error(e, e);
            return SECKILLSCENE_INTERVAL_TIME;
        }

    }

    @Override
    public Integer deleteById(Integer id) throws ProductServiceException {
        try {
            return null;
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public Integer updateSelective(SecKillSceneDto secKillSceneDto) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(secKillSceneDto) || ObjectUtils.isNullOrEmpty(secKillSceneDto.getActivityId())
                    || ObjectUtils.isNullOrEmpty(secKillSceneDto.getSceneName())
                    || ObjectUtils.isNullOrEmpty(secKillSceneDto.getRepeatType())
                    || ObjectUtils.isNullOrEmpty(secKillSceneDto.getUpdateUserId())) {
                throw new ProductServiceException("参数不能为空");
            }
            Date operationTime = new Date();
            SecKillScene secKillScene = secKillSceneMapper.loadByActivityId(secKillSceneDto.getActivityId());
            if (ObjectUtils.isNullOrEmpty(secKillScene)) {
                throw new ProductServiceException("场次不存在,编辑错误");
            }
            if (!ObjectUtils.isNullOrEmpty(secKillSceneDto.getStartTime())) {
                if (!SystemContext.ProductDomain.SECKILLSCENESTATUSCODE_NOTSTART.equals(secKillScene.getStatusCode())
                        && secKillSceneDto.getStartTime().getTime() != secKillScene.getStartTime().getTime()) {
                    throw new ProductServiceException("不是未开始状态不能修改开始时间");
                }
                secKillScene.setStartTime(secKillSceneDto.getStartTime());
            }
            secKillScene.setSceneName(secKillSceneDto.getSceneName());
            secKillScene.setRepeatType(secKillSceneDto.getRepeatType());
            secKillScene.setUpdateTime(operationTime);
            secKillScene.setUpdateUserId(secKillSceneDto.getUpdateUserId());
            return secKillSceneMapper.updateSelective(secKillScene);
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public Integer updateStatusCodeById(Integer id, String statusCode, Integer updateUserId, Date updateTime)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(id) || ObjectUtils.isNullOrEmpty(statusCode)
                    || ObjectUtils.isNullOrEmpty(updateUserId) || ObjectUtils.isNullOrEmpty(updateTime)) {
                throw new ProductServiceException("parameter can not be null");
            }
            return secKillSceneMapper.updateStatusCodeById(id, statusCode, updateUserId, updateTime);
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public SecKillSceneDto loadById(Integer secKillSceneId) throws ProductServiceException {
        try {
            SecKillScene secKillScene = secKillSceneMapper.loadById(secKillSceneId);
            SecKillSceneDto secKillSceneDto = null;
            if (!ObjectUtils.isNullOrEmpty(secKillScene)) {
                secKillSceneDto = new SecKillSceneDto();
                ObjectUtils.fastCopy(secKillScene, secKillSceneDto);
                UserProxyDto userProxyDto = userProxyService.getUserById(secKillSceneDto.getCreateUserId());
                if (!ObjectUtils.isNullOrEmpty(userProxyDto)) {
                    secKillSceneDto.setCreateUserName(userProxyDto.getUserName());
                }
                secKillSceneDto.setRepeatTypeName(
                        super.getSystemDictName(SystemContext.ProductDomain.DictType.SECKILLSCENEREPEATTYPE.getValue(),
                                secKillSceneDto.getRepeatType()));
                secKillSceneDto.setStatusCodeName(
                        super.getSystemDictName(SystemContext.ProductDomain.DictType.SECKILLSCENESTATUSCODE.getValue(),
                                secKillSceneDto.getStatusCode()));
                List<SecKillProductRelatedInfo> secKillProductRelatedInfoS = secKillProductMapper
                        .listSecKillProductBySeceneId(secKillSceneId);
                List<SecKillProductDto> secKillProductDtos = new ArrayList<SecKillProductDto>();
                if (!ObjectUtils.isNullOrEmpty(secKillProductRelatedInfoS)) {
                    for (SecKillProductRelatedInfo secKillProductRelatedInfo : secKillProductRelatedInfoS) {
                        SecKillProductDto secKillProductDto = new SecKillProductDto();
                        ObjectUtils.fastCopy(secKillProductRelatedInfo, secKillProductDto);
                        secKillProductDto.setStatusCodeName(super.getSystemDictName(
                                SystemContext.ProductDomain.DictType.SECKILLSCENEPRODUTRELATIONSTATUSCODE.getValue(),
                                secKillProductDto.getStatusCode()));
                        secKillProductDto.setSecKillProductStatusName(
                                super.getSystemDictName(SystemContext.ProductDomain.DictType.SECKILLPRODUCTSTATUS.getValue(),
                                        secKillProductDto.getSecKillProductStatus()));
                        secKillProductDtos.add(secKillProductDto);
                    }
                }
                secKillSceneDto.setSecKillProductDtos(secKillProductDtos);
            }
            return secKillSceneDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public SecKillSceneDto loadByActivityId(Integer activityId) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(activityId)) {
                throw new ProductServiceException("activityId can not be null");
            }
            SecKillScene secKillScene = secKillSceneMapper.loadByActivityId(activityId);
            if (ObjectUtils.isNullOrEmpty(secKillScene)) {
                return null;
            }
            SecKillSceneDto secKillSceneDto = null;
            if (!ObjectUtils.isNullOrEmpty(secKillScene)) {
                secKillSceneDto = new SecKillSceneDto();
                ObjectUtils.fastCopy(secKillScene, secKillSceneDto);
                secKillSceneDto.setRepeatTypeName(
                        super.getSystemDictName(SystemContext.ProductDomain.DictType.SECKILLSCENEREPEATTYPE.getValue(),
                                secKillSceneDto.getRepeatType()));
                secKillSceneDto.setStatusCodeName(
                        super.getSystemDictName(SystemContext.ProductDomain.DictType.SECKILLSCENESTATUSCODE.getValue(),
                                secKillSceneDto.getStatusCode()));
                List<SecKillProductRelatedInfo> secKillProductRelatedInfoS = secKillProductMapper
                        .listSecKillProductBySeceneId(secKillScene.getId());
                List<SecKillProductDto> secKillProductDtos = new ArrayList<SecKillProductDto>();
                if (!ObjectUtils.isNullOrEmpty(secKillProductRelatedInfoS)) {
                    for (SecKillProductRelatedInfo secKillProductRelatedInfo : secKillProductRelatedInfoS) {
                        SecKillProductDto secKillProductDto = new SecKillProductDto();
                        ObjectUtils.fastCopy(secKillProductRelatedInfo, secKillProductDto);
                        secKillProductDto.setStatusCodeName(super.getSystemDictName(
                                SystemContext.ProductDomain.DictType.SECKILLSCENEPRODUTRELATIONSTATUSCODE.getValue(),
                                secKillProductDto.getStatusCode()));
                        secKillProductDto.setSecKillProductStatusName(
                                super.getSystemDictName(SystemContext.ProductDomain.DictType.SECKILLPRODUCTSTATUS.getValue(),
                                        secKillProductDto.getSecKillProductStatus()));
                        secKillProductDtos.add(secKillProductDto);
                    }
                }
                secKillSceneDto.setSecKillProductDtos(secKillProductDtos);
            }
            ObjectUtils.fastCopy(secKillScene, secKillSceneDto);
            return secKillSceneDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<SecKillSceneDto> findSecKillScenes(SecKillSceneQueryDto secKillSceneQueryDto)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(secKillSceneQueryDto)) {
                throw new ProductServiceException("查询条件不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(secKillSceneQueryDto.getStart())) {
                secKillSceneQueryDto.setStart(1);
            }
            if (ObjectUtils.isNullOrEmpty(secKillSceneQueryDto.getPageSize())) {
                secKillSceneQueryDto.setStart(CommonConstants.PAGE_SIZE);
            }
            SecKillSceneQuery secKillSceneQuery = new SecKillSceneQuery();
            ObjectUtils.fastCopy(secKillSceneQueryDto, secKillSceneQuery);
            if (!ObjectUtils.isNullOrEmpty(secKillSceneQueryDto.getStrBeginStartTime())) {
                Date beginStartDate = DateUtils
                        .parseDate(secKillSceneQueryDto.getStrBeginStartTime() + StringUtils.STARTTIMESTRING);
                secKillSceneQuery.setBeginStartTime(beginStartDate);
            }
            if (!ObjectUtils.isNullOrEmpty(secKillSceneQueryDto.getStrEndStartTime())) {
                Date endStartTime = DateUtils
                        .parseDate(secKillSceneQueryDto.getStrEndStartTime() + StringUtils.ENDTIMESTRING);
                secKillSceneQuery.setEndStartTime(endStartTime);
            }
            PageHelper.startPage(secKillSceneQuery.getStart(), secKillSceneQuery.getPageSize());
            Page<SecKillScene> secKillScenePages = secKillSceneMapper.findSecKillScenes(secKillSceneQuery);
            Page<SecKillSceneDto> pageDto = new Page<SecKillSceneDto>(secKillSceneQuery.getStart(),
                    secKillSceneQuery.getPageSize());
            ObjectUtils.fastCopy(secKillScenePages, pageDto);
            List<SecKillScene> secKillSceneList = secKillScenePages.getResult();
            if (!ObjectUtils.isNullOrEmpty(secKillSceneList)) {
                for (SecKillScene secKillScene : secKillSceneList) {
                    SecKillSceneDto secKillSceneDto = new SecKillSceneDto();
                    ObjectUtils.fastCopy(secKillScene, secKillSceneDto);
                    secKillSceneDto.setStatusCodeName(
                            super.getSystemDictName(SystemContext.ProductDomain.DictType.SECKILLSCENESTATUSCODE.getValue(),
                                    secKillSceneDto.getStatusCode()));
                    secKillSceneDto.setRepeatTypeName(
                            super.getSystemDictName(SystemContext.ProductDomain.DictType.SECKILLSCENEREPEATTYPE.getValue(),
                                    secKillSceneDto.getRepeatType()));
                    pageDto.add(secKillSceneDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<SecKillSceneDto> findSecKillProductRelationScenes(SecKillSceneQueryDto secKillSceneQueryDto)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(secKillSceneQueryDto)) {
                throw new ProductServiceException("查询条件不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(secKillSceneQueryDto.getStart())) {
                secKillSceneQueryDto.setStart(1);
            }
            if (ObjectUtils.isNullOrEmpty(secKillSceneQueryDto.getPageSize())) {
                secKillSceneQueryDto.setStart(CommonConstants.PAGE_SIZE);
            }
            SecKillSceneQuery secKillSceneQuery = new SecKillSceneQuery();
            ObjectUtils.fastCopy(secKillSceneQueryDto, secKillSceneQuery);
            if (!ObjectUtils.isNullOrEmpty(secKillSceneQueryDto.getStrBeginStartTime())) {
                Date beginStartDate = DateUtils
                        .parseDate(secKillSceneQueryDto.getStrBeginStartTime() + StringUtils.STARTTIMESTRING);
                secKillSceneQuery.setBeginStartTime(beginStartDate);
            }
            if (!ObjectUtils.isNullOrEmpty(secKillSceneQueryDto.getStrEndStartTime())) {
                Date endStartTime = DateUtils
                        .parseDate(secKillSceneQueryDto.getStrEndStartTime() + StringUtils.ENDTIMESTRING);
                secKillSceneQuery.setEndStartTime(endStartTime);
            }
            PageHelper.startPage(secKillSceneQuery.getStart(), secKillSceneQuery.getPageSize());
            Page<SecKillScene> secKillScenePages = secKillSceneMapper.findSecKillProductRelationScenes(secKillSceneQuery);
            Page<SecKillSceneDto> pageDto = new Page<SecKillSceneDto>(secKillSceneQuery.getStart(),
                    secKillSceneQuery.getPageSize());
            ObjectUtils.fastCopy(secKillScenePages, pageDto);
            List<SecKillScene> secKillSceneList = secKillScenePages.getResult();
            if (!ObjectUtils.isNullOrEmpty(secKillSceneList)) {
                for (SecKillScene secKillScene : secKillSceneList) {
                    SecKillSceneDto secKillSceneDto = new SecKillSceneDto();
                    ObjectUtils.fastCopy(secKillScene, secKillSceneDto);
                    secKillSceneDto.setStatusCodeName(
                            super.getSystemDictName(SystemContext.ProductDomain.DictType.SECKILLSCENESTATUSCODE.getValue(),
                                    secKillSceneDto.getStatusCode()));
                    secKillSceneDto.setRepeatTypeName(
                            super.getSystemDictName(SystemContext.ProductDomain.DictType.SECKILLSCENEREPEATTYPE.getValue(),
                                    secKillSceneDto.getRepeatType()));
                    pageDto.add(secKillSceneDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateRelateSecKillProduct(SecKillSceneRelateProductDto secKillSceneRelateProductDto, Integer operatorUserId)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(secKillSceneRelateProductDto)
                    || ObjectUtils.isNullOrEmpty(secKillSceneRelateProductDto.getSceneId())
                    || ObjectUtils.isNullOrEmpty(secKillSceneRelateProductDto.getSecKillProductIds())
                    || ObjectUtils.isNullOrEmpty(operatorUserId)) {
                throw new ProductServiceException("参数不能为空");
            }
            Date nowDate = new Date();
            SecKillScene secKillScene = secKillSceneMapper.loadById(secKillSceneRelateProductDto.getSceneId());
            if (ObjectUtils.isNullOrEmpty(secKillScene)) {
                throw new ProductServiceException("场次不存在");
            }
            if (secKillScene.getStartTime().before(nowDate)) {
                throw new ProductServiceException("该场次不是未开始状态,不能再关联商品");
            }
            String[] secKillProductArr = secKillSceneRelateProductDto.getSecKillProductIds()
                    .split(CommonConstants.DELIMITER_COMMA);
            List<SecKillSaleProductInventoryProxyDto> secKillSaleProductInventoryProxyDtos = new ArrayList<SecKillSaleProductInventoryProxyDto>();
            for (String secKillProductIdStr : secKillProductArr) {
                int secKillProductId = Integer.parseInt(secKillProductIdStr);
                SecKillSceneProductRelation secKillSceneProductRelation = new SecKillSceneProductRelation();
                secKillSceneProductRelation.setUpdateUserId(operatorUserId);
                secKillSceneProductRelation.setUpdateTime(nowDate);
                secKillSceneProductRelation.setCreateTime(nowDate);
                secKillSceneProductRelation.setCreateUserId(operatorUserId);
                secKillSceneProductRelation.setSecKillProductId(secKillProductId);
                secKillSceneProductRelation.setSecKillSceneId(secKillSceneRelateProductDto.getSceneId());
                secKillSceneProductRelation
                        .setStatusCode(SystemContext.ProductDomain.SECKILLSCENEPRODUTRELATIONSTATUSCODE_ON);
                SecKillProduct secKillProduct = secKillProductMapper.loadById(secKillProductId);
                if (ObjectUtils.isNullOrEmpty(secKillProduct)) {
                    throw new ProductServiceException("秒杀商品【" + secKillProductId + "】不存在");
                }
                SecKillSceneProductRelation secKillSceneProductRelationTemp = secKillSceneProductRelationMapper
                        .loadBySceneIdAndSecKillProductId(secKillSceneRelateProductDto.getSceneId(), secKillProductId);
                if (ObjectUtils.isNullOrEmpty(secKillSceneProductRelationTemp)) {
                    secKillSceneProductRelationTemp = secKillSceneProductRelationMapper.loadBySceneIdAndProductIdNoCache(
                            secKillSceneRelateProductDto.getSceneId(), secKillProduct.getProductId());
                    if (!ObjectUtils.isNullOrEmpty(secKillSceneProductRelationTemp)) {
                        Product product = productMapper.loadProductBasicInfoById(secKillProduct.getProductId());
                        throw new ProductServiceException("一个场次不能同时关联两个以上产品:" + product.getProductName());
                    }
                    Integer effectCount = secKillSceneProductRelationMapper.save(secKillSceneProductRelation);
                    if (effectCount != 1) {
                        throw new ProductServiceException("场次关联秒杀商品失败");
                    }
                }
                SaleProductQuery saleProductQuery = new SaleProductQuery();
                saleProductQuery.setProductId(secKillProduct.getProductId());
                List<SaleProduct> saleProductList = saleProductMapper.listSaleProductBasicInfos(saleProductQuery);
                if (!ObjectUtils.isNullOrEmpty(saleProductList)) {
                    for (SaleProduct saleProduct : saleProductList) {
                        SecKillSaleProductInventoryProxyDto secKillSaleProductInventoryProxyDto = new SecKillSaleProductInventoryProxyDto();
                        secKillSaleProductInventoryProxyDto.setRemainCount(secKillProduct.getRemainCount());
                        secKillSaleProductInventoryProxyDto.setSaleProductId(saleProduct.getId());
                        secKillSaleProductInventoryProxyDto.setStoreId(saleProduct.getStoreId());
                        secKillSaleProductInventoryProxyDtos.add(secKillSaleProductInventoryProxyDto);
                    }
                }
            }
            if (!ObjectUtils.isNullOrEmpty(secKillSaleProductInventoryProxyDtos)) {
                secKillSaleProductInventoryProxyService.saveSecKillSaleProductInventory(secKillScene.getActivityId(),
                        secKillSaleProductInventoryProxyDtos, operatorUserId);
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }

    }

    @Override
    public void updateReleaseSecKillProduct(SecKillSceneRelateProductDto secKillSceneRelateProductDto,
            Integer operatorUserId) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(secKillSceneRelateProductDto)
                    || ObjectUtils.isNullOrEmpty(secKillSceneRelateProductDto.getSceneId())
                    || ObjectUtils.isNullOrEmpty(secKillSceneRelateProductDto.getSecKillProductIds())
                    || ObjectUtils.isNullOrEmpty(operatorUserId)) {
                throw new ProductServiceException("参数不能为空");
            }
            Date nowDate = new Date();
            SecKillScene secKillScene = secKillSceneMapper.loadById(secKillSceneRelateProductDto.getSceneId());
            if (ObjectUtils.isNullOrEmpty(secKillScene)) {
                throw new ProductServiceException("场次不存在");
            }
            if (secKillScene.getStartTime().before(nowDate)) {
                throw new ProductServiceException("该场次不是未开始状态,不能再取消关联商品");
            }
            String[] secKillProductArr = secKillSceneRelateProductDto.getSecKillProductIds()
                    .split(CommonConstants.DELIMITER_COMMA);
            for (String secKillProductIdStr : secKillProductArr) {
                int secKillProductId = Integer.parseInt(secKillProductIdStr);
                secKillSceneProductRelationMapper
                        .deleteBySceneIdAndSecKillProductId(secKillSceneRelateProductDto.getSceneId(), secKillProductId);
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }

    }

    @Override
    public void updateInvalidateSceneSecKillProduct(SecKillSceneRelateProductDto secKillSceneRelateProductDto,
            Integer operatorUserId) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(secKillSceneRelateProductDto)
                    || ObjectUtils.isNullOrEmpty(secKillSceneRelateProductDto.getSceneId())
                    || ObjectUtils.isNullOrEmpty(secKillSceneRelateProductDto.getSecKillProductIds())
                    || ObjectUtils.isNullOrEmpty(operatorUserId)) {
                throw new ProductServiceException("参数不能为空");
            }
            Date nowDate = new Date();
            String[] secKillProductArr = secKillSceneRelateProductDto.getSecKillProductIds()
                    .split(CommonConstants.DELIMITER_COMMA);
            for (String secKillProductIdStr : secKillProductArr) {
                int secKillProductId = Integer.parseInt(secKillProductIdStr);
                secKillSceneProductRelationMapper.updateStatusCodeBySceneIdAndSecKillProductId(
                        secKillSceneRelateProductDto.getSceneId(), secKillProductId,
                        SystemContext.ProductDomain.SECKILLSCENEPRODUTRELATIONSTATUSCODE_OFF, operatorUserId, nowDate);
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }

    }

    @Override
    public void updateValidSceneSecKillProduct(SecKillSceneRelateProductDto secKillSceneRelateProductDto,
            Integer operatorUserId) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(secKillSceneRelateProductDto)
                    || ObjectUtils.isNullOrEmpty(secKillSceneRelateProductDto.getSceneId())
                    || ObjectUtils.isNullOrEmpty(secKillSceneRelateProductDto.getSecKillProductIds())
                    || ObjectUtils.isNullOrEmpty(operatorUserId)) {
                throw new ProductServiceException("参数不能为空");
            }
            Date nowDate = new Date();
            String[] secKillProductArr = secKillSceneRelateProductDto.getSecKillProductIds()
                    .split(CommonConstants.DELIMITER_COMMA);
            for (String secKillProductIdStr : secKillProductArr) {
                int secKillProductId = Integer.parseInt(secKillProductIdStr);
                secKillSceneProductRelationMapper.updateStatusCodeBySceneIdAndSecKillProductId(
                        secKillSceneRelateProductDto.getSceneId(), secKillProductId,
                        SystemContext.ProductDomain.SECKILLSCENEPRODUTRELATIONSTATUSCODE_ON, operatorUserId, nowDate);
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }

    }

    @Override
    public SecKillSceneDto loadSecKillSceneForStarting(Date startTime) throws ProductServiceException {
        try {
            SecKillSceneDto secKillSceneDto = null;
            if (ObjectUtils.isNullOrEmpty(startTime)) {
                startTime = new Date();
            }
            SecKillScene secKillScene = secKillSceneMapper.loadStartingSecKillSceneByCurrentTime(startTime);
            if (!ObjectUtils.isNullOrEmpty(secKillScene)) {
                secKillSceneDto = new SecKillSceneDto();
                ObjectUtils.fastCopy(secKillScene, secKillSceneDto);
                SecKillScene nextSecKillScene = secKillSceneMapper.loadNextSecKillSceneByCurrentTime(startTime);
                if (!ObjectUtils.isNullOrEmpty(nextSecKillScene)) {
                    secKillSceneDto.setEndTime(nextSecKillScene.getStartTime());
                    secKillSceneDto.setStatusCode(SystemContext.ProductDomain.SECKILLSCENESTATUSCODE_STARTING);
                } else {
                    if (startTime.after(
                            DateUtils.addHours(secKillSceneDto.getStartTime(), getSystemParamSecKillSceneEndTime()))) {
                        secKillSceneDto.setEndTime(DateUtils.getSpecificEndDate(startTime));
                        secKillSceneDto.setStatusCode(SystemContext.ProductDomain.SECKILLSCENESTATUSCODE_STARTED);
                    } else {
                        secKillSceneDto.setEndTime(
                                DateUtils.addHours(secKillSceneDto.getStartTime(), getSystemParamSecKillSceneEndTime()));
                        secKillSceneDto.setStatusCode(SystemContext.ProductDomain.SECKILLSCENESTATUSCODE_STARTING);
                    }
                }
            }
            return secKillSceneDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<SecKillSceneDto> listSecKillScene(Date currentTime, Integer size) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(currentTime)) {
                currentTime = new Date();
            }
            if (ObjectUtils.isNullOrEmpty(size)) {
                size = 4;
            }
            List<SecKillSceneDto> secKillSceneDtos = new ArrayList<SecKillSceneDto>(size);
            List<SecKillScene> beforeSecKillSceneList = secKillSceneMapper.listBeforeOrEqualsByCurrentTime(currentTime, 2);
            List<SecKillScene> secKillSceneList = new ArrayList<SecKillScene>(size);
            List<SecKillScene> afterSecKillSceneList = null;
            if (!ObjectUtils.isNullOrEmpty(beforeSecKillSceneList)) {
                if (beforeSecKillSceneList.size() == 1) {
                    afterSecKillSceneList = secKillSceneMapper.listAfterByCurrentTime(currentTime, size);
                } else {
                    afterSecKillSceneList = secKillSceneMapper.listAfterByCurrentTime(currentTime, size - 1);
                }
            } else {
                afterSecKillSceneList = secKillSceneMapper.listAfterByCurrentTime(currentTime, size + 1);
            }
            if (ObjectUtils.isNullOrEmpty(beforeSecKillSceneList) && ObjectUtils.isNullOrEmpty(afterSecKillSceneList)) {
                return secKillSceneDtos;
            }
            SecKillScene startingSecKillScene = null;
            Date endTime = null;
            if (!ObjectUtils.isNullOrEmpty(beforeSecKillSceneList)) {
                startingSecKillScene = beforeSecKillSceneList.get(0);
                if (!ObjectUtils.isNullOrEmpty(afterSecKillSceneList)) {
                    endTime = afterSecKillSceneList.get(0).getStartTime();
                } else {
                    endTime = DateUtils.addHours(startingSecKillScene.getStartTime(), getSystemParamSecKillSceneEndTime());
                }
                if (endTime.before(currentTime)) {
                    secKillSceneList.add(startingSecKillScene);
                } else {
                    secKillSceneList.addAll(beforeSecKillSceneList);
                }
            }
            if (!ObjectUtils.isNullOrEmpty(afterSecKillSceneList)) {
                secKillSceneList.addAll(afterSecKillSceneList);
            }
            Collections.sort(secKillSceneList, new Comparator<SecKillScene>() {

                @Override
                public int compare(SecKillScene o1, SecKillScene o2) {
                    return (int) (o1.getStartTime().getTime() - o2.getStartTime().getTime());
                }

            });
            for (int i = 0, capacity = secKillSceneList.size(); i < capacity; i++) {
                if (i >= size) {
                    break;
                }
                SecKillScene secKillScene = secKillSceneList.get(i);
                SecKillScene nextSecKillScene = null;
                if (i != capacity - 1) {
                    nextSecKillScene = secKillSceneList.get(i + 1);
                }
                SecKillSceneDto secKillSceneDto = new SecKillSceneDto();
                ObjectUtils.fastCopy(secKillScene, secKillSceneDto);
                if (!ObjectUtils.isNullOrEmpty(nextSecKillScene)) {
                    secKillSceneDto.setEndTime(nextSecKillScene.getStartTime());
                } else {
                    secKillSceneDto.setEndTime(
                            DateUtils.addHours(secKillSceneDto.getStartTime(), getSystemParamSecKillSceneEndTime()));
                }
                if (secKillSceneDto.getStartTime().after(currentTime)) {
                    secKillSceneDto.setStatusCode(SystemContext.ProductDomain.SECKILLSCENESTATUSCODE_NOTSTART);
                }
                if (secKillSceneDto.getStartTime().before(currentTime)) {
                    if (!ObjectUtils.isNullOrEmpty(secKillSceneDto.getEndTime())
                            && secKillSceneDto.getEndTime().before(currentTime)) {
                        secKillSceneDto.setStatusCode(SystemContext.ProductDomain.SECKILLSCENESTATUSCODE_STARTED);
                    } else {
                        secKillSceneDto.setStatusCode(SystemContext.ProductDomain.SECKILLSCENESTATUSCODE_STARTING);
                    }
                }
                secKillSceneDtos.add(secKillSceneDto);
            }
            return secKillSceneDtos;
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<SecKillSceneDto> listSecKillSceneBeforOrEqualsStartTime(Date nowTime, Integer size)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(nowTime)) {
                nowTime = new Date();
            }
            List<SecKillSceneDto> sceKillSceneDtos = new ArrayList<SecKillSceneDto>();
            List<SecKillScene> secKillSceneList = secKillSceneMapper.listBeforeOrEqualsByCurrentTime(nowTime, size);
            SecKillScene nextSecKillScene = secKillSceneMapper.loadNextSecKillSceneByCurrentTime(nowTime);
            if (!ObjectUtils.isNullOrEmpty(secKillSceneList)) {
                for (SecKillScene secKillScene : secKillSceneList) {
                    SecKillSceneDto secKillSceneDto = new SecKillSceneDto();
                    ObjectUtils.fastCopy(secKillScene, secKillSceneDto);
                    sceKillSceneDtos.add(secKillSceneDto);
                }
                SecKillSceneDto lastSecKillSceneDto = sceKillSceneDtos.get(0);
                if (ObjectUtils.isNullOrEmpty(nextSecKillScene)) {
                    lastSecKillSceneDto.setEndTime(
                            DateUtils.addHours(lastSecKillSceneDto.getStartTime(), getSystemParamSecKillSceneEndTime()));
                } else {
                    lastSecKillSceneDto.setEndTime(nextSecKillScene.getStartTime());
                }
            }
            return sceKillSceneDtos;
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateStatusCodeForExpiredByStartTime(Date startTime, Integer updateUserId, Date updateTime)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(startTime)) {
                throw new ProductServiceException("startTime can not be null");
            }
            if (ObjectUtils.isNullOrEmpty(updateUserId)) {
                throw new ProductServiceException("updateUserId can not be null");
            }
            if (ObjectUtils.isNullOrEmpty(updateTime)) {
                updateTime = new Date();
            }
            secKillSceneMapper.updateStatusCodeForExpiredByStartTime(startTime,
                    SystemContext.ProductDomain.SECKILLSCENESTATUSCODE_EXPIRED, updateUserId, updateTime);
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public List<SecKillSceneDto> listSecKillSceneForRepeatByDate(Date beginStartTime, Date endStartTime)
            throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(beginStartTime) || ObjectUtils.isNullOrEmpty(beginStartTime)) {
                throw new ProductServiceException("时间范围不能为空");
            }
            List<SecKillSceneDto> secKillSceneDtos = new ArrayList<SecKillSceneDto>();
            List<SecKillScene> secKillSceneList = secKillSceneMapper.listSecKillSceneForRepeatByStartTime(beginStartTime,
                    endStartTime, SystemContext.ProductDomain.SECKILLSCENEREPEATTYPE_REPEAT);
            if (!ObjectUtils.isNullOrEmpty(secKillSceneList)) {
                for (SecKillScene secKillScene : secKillSceneList) {
                    SecKillSceneDto secKillSceneDto = new SecKillSceneDto();
                    ObjectUtils.fastCopy(secKillScene, secKillSceneDto);
                    secKillSceneDtos.add(secKillSceneDto);
                }
            }
            return secKillSceneDtos;
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void saveCopyScene(SecKillSceneDto secKillSceneDto) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(secKillSceneDto) || ObjectUtils.isNullOrEmpty(secKillSceneDto.getSceneName())
                    || ObjectUtils.isNullOrEmpty(secKillSceneDto.getRepeatType())
                    || ObjectUtils.isNullOrEmpty(secKillSceneDto.getStartTime())
                    || ObjectUtils.isNullOrEmpty(secKillSceneDto.getCreateUserId())
                    || ObjectUtils.isNullOrEmpty(secKillSceneDto.getUpdateUserId())) {
                throw new ProductServiceException("必填参数不能为空");
            }
            int intervalTime = getSceneIntervalTime();
            Date beginStartTime = DateUtils.addMinutes(secKillSceneDto.getStartTime(), -intervalTime);
            List<SecKillScene> secKillSceneList = secKillSceneMapper.listByStartTime(beginStartTime,
                    secKillSceneDto.getStartTime());
            if (!ObjectUtils.isNullOrEmpty(secKillSceneList)) {
                throw new ProductServiceException("秒杀场次间隔不能小于" + intervalTime + "分钟");
            }
            Date operatioDate = new Date();
            secKillSceneDto.setCreateTime(operatioDate);
            secKillSceneDto.setUpdateTime(operatioDate);
            SecKillScene secKillScene = new SecKillScene();
            ObjectUtils.fastCopy(secKillSceneDto, secKillScene);

            Activity activity = new Activity();
            activity.setActivityName(secKillScene.getSceneName());
            activity.setActivityType(SystemContext.ProductDomain.ACTIVITYTYPE_SECKILL);
            activity.setCreateTime(operatioDate);
            activity.setCreateUserId(secKillScene.getCreateUserId());
            activity.setUpdateUserId(secKillScene.getUpdateUserId());
            activity.setUpdateTime(secKillScene.getUpdateTime());
            activity.setStartTime(secKillScene.getStartTime());
            activityMapper.save(activity);
            secKillScene.setActivityId(activity.getId());
            secKillScene.setStatusCode(SystemContext.ProductDomain.SECKILLSCENESTATUSCODE_NOTSTART);
            Integer result = secKillSceneMapper.save(secKillScene);
            if (result == null || result.intValue() != 1) {
                throw new ProductServiceException("新增场次失败");
            }
            List<SecKillSceneProductRelation> secKillSceneProductRelationList = secKillSceneProductRelationMapper
                    .listBySceneId(secKillSceneDto.getId());
            List<SecKillSceneProductRelation> copySecKillSceneProductRelationList = null;
            List<SecKillSaleProductInventoryProxyDto> secKillSaleProductInventoryProxyDtos = new ArrayList<SecKillSaleProductInventoryProxyDto>();
            if (!ObjectUtils.isNullOrEmpty(secKillSceneProductRelationList)) {
                copySecKillSceneProductRelationList = new ArrayList<SecKillSceneProductRelation>();
                for (SecKillSceneProductRelation secKillSceneProductRelation : secKillSceneProductRelationList) {
                    SecKillSceneProductRelation copySecKillSceneProductRelation = new SecKillSceneProductRelation();
                    copySecKillSceneProductRelation.setCreateTime(operatioDate);
                    copySecKillSceneProductRelation.setCreateUserId(CommonConstants.SYSTEM_USER_ID);
                    copySecKillSceneProductRelation.setSecKillProductId(secKillSceneProductRelation.getSecKillProductId());
                    copySecKillSceneProductRelation.setSecKillSceneId(secKillScene.getId());
                    copySecKillSceneProductRelation.setStatusCode(secKillSceneProductRelation.getStatusCode());
                    copySecKillSceneProductRelation.setUpdateTime(operatioDate);
                    copySecKillSceneProductRelation.setUpdateUserId(CommonConstants.SYSTEM_USER_ID);
                    copySecKillSceneProductRelationList.add(copySecKillSceneProductRelation);

                    SecKillProduct secKillProduct = secKillProductMapper
                            .loadById(secKillSceneProductRelation.getSecKillProductId());
                    if (ObjectUtils.isNullOrEmpty(secKillProduct)) {
                        throw new ProductServiceException(
                                "秒杀商品【" + secKillSceneProductRelation.getSecKillProductId() + "】不存在");
                    }
                    SaleProductQuery saleProductQuery = new SaleProductQuery();
                    saleProductQuery.setProductId(secKillProduct.getProductId());
                    List<SaleProduct> saleProductList = saleProductMapper.listSaleProductBasicInfos(saleProductQuery);
                    if (!ObjectUtils.isNullOrEmpty(saleProductList)) {
                        for (SaleProduct saleProduct : saleProductList) {
                            SecKillSaleProductInventoryProxyDto secKillSaleProductInventoryProxyDto = new SecKillSaleProductInventoryProxyDto();
                            secKillSaleProductInventoryProxyDto.setRemainCount(secKillProduct.getRemainCount());
                            secKillSaleProductInventoryProxyDto.setSaleProductId(saleProduct.getId());
                            secKillSaleProductInventoryProxyDto.setStoreId(saleProduct.getStoreId());
                            secKillSaleProductInventoryProxyDtos.add(secKillSaleProductInventoryProxyDto);
                        }
                    }
                }
            }
            if (!ObjectUtils.isNullOrEmpty(copySecKillSceneProductRelationList)) {
                secKillSceneProductRelationMapper.batchSave(copySecKillSceneProductRelationList);
            }
            if (!ObjectUtils.isNullOrEmpty(secKillSaleProductInventoryProxyDtos)) {
                secKillSaleProductInventoryProxyService.saveSecKillSaleProductInventory(secKillScene.getActivityId(),
                        secKillSaleProductInventoryProxyDtos, secKillSceneDto.getCreateUserId());
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    private int getSystemParamSecKillSceneEndTime() {
        String endTime = super.getSystemParamValue(SystemContext.SystemParams.SECKILLSCENE_ENDTIME);
        if (ObjectUtils.isNullOrEmpty(endTime)) {
            return CommonConstants.SECKILLSCENE_ENDTIME_DEFAULT;
        }
        try {
            return Integer.parseInt(endTime.trim());
        } catch (Exception e) {
            logger.warn(e);
        }
        return CommonConstants.SECKILLSCENE_ENDTIME_DEFAULT;
    }

    @Override
    public List<SecKillSceneDto> listStartedAndStaring(Date currentTime) throws ProductServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(currentTime)) {
                currentTime = new Date();
            }
            List<SecKillScene> secKillSceneList = secKillSceneMapper.listBeforeOrEqualsByCurrentTime(currentTime, 2);
            if (ObjectUtils.isNullOrEmpty(secKillSceneList)) {
                return Collections.emptyList();
            }
            SecKillScene startingSecKillScene = secKillSceneList.get(0);
            SecKillScene startedSecKillScene = null;
            if (secKillSceneList.size() == 2) {
                startedSecKillScene = secKillSceneList.get(1);
            }
            SecKillSceneDto startingSceneDto = new SecKillSceneDto();
            SecKillSceneDto startedSceneDto = new SecKillSceneDto();
            ObjectUtils.fastCopy(startingSecKillScene, startingSceneDto);
            List<SecKillSceneDto> secKillSceneDtos = new ArrayList<SecKillSceneDto>();
            SecKillScene nextSecKillScene = secKillSceneMapper.loadNextSecKillSceneByCurrentTime(currentTime);
            if (!ObjectUtils.isNullOrEmpty(nextSecKillScene)) {
                startingSceneDto.setEndTime(nextSecKillScene.getStartTime());
            } else {
                startingSceneDto.setEndTime(
                        DateUtils.addHours(startingSceneDto.getStartTime(), getSystemParamSecKillSceneEndTime()));
            }
            secKillSceneDtos.add(startingSceneDto);
            if (!ObjectUtils.isNullOrEmpty(startedSecKillScene)) {
                ObjectUtils.fastCopy(startedSecKillScene, startedSceneDto);
                startedSceneDto.setEndTime(startingSceneDto.getStartTime());
            }
            if (currentTime.before(startingSceneDto.getEndTime()) && !ObjectUtils.isNullOrEmpty(startedSecKillScene)) {
                secKillSceneDtos.add(startedSceneDto);
            }
            return Collections.emptyList();
        } catch (Exception e) {
            logger.error(e, e);
            throw new ProductServiceException(e.getMessage());
        }
    }
}
