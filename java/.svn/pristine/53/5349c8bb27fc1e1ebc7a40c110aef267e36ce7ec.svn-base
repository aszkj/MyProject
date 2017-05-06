package com.yilidi.o2o.user.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.proxy.IOrderProxyService;
import com.yilidi.o2o.order.proxy.dto.FinishOrderAmountInfoProxyDto;
import com.yilidi.o2o.order.proxy.dto.FinishOrderCountInfoProxyDto;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.StoreWarehouseMapper;
import com.yilidi.o2o.user.model.StoreWarehouse;
import com.yilidi.o2o.user.model.query.WarehousePartnersQuery;
import com.yilidi.o2o.user.service.IStoreProfileService;
import com.yilidi.o2o.user.service.IStoreWarehouseService;
import com.yilidi.o2o.user.service.dto.StoreProfileDto;
import com.yilidi.o2o.user.service.dto.StoreWarehouseDto;
import com.yilidi.o2o.user.service.dto.WarehouseAssociatePartnerDto;
import com.yilidi.o2o.user.service.dto.query.WarehousePartnersQueryDto;

@Service("storeWarehouseService")
public class StoreWarehouseServiceImpl extends BasicDataService implements IStoreWarehouseService {

    @Autowired
    private StoreWarehouseMapper storeWarehouseMapper;

    @Autowired
    private IStoreProfileService storeProfileService;

    @Autowired
    private IOrderProxyService orderProxyService;

    @Override
    public void save(StoreWarehouseDto storeWarehouseDto) throws UserServiceException {
        String msg = null;
        try {
            if (ObjectUtils.isNullOrEmpty(storeWarehouseDto)) {
                msg = "storeWarehouseDto为空";
                logger.error(msg);
                throw new UserServiceException(msg);
            }
            Integer warehouseId = loadWarehouseIdByStoreId(storeWarehouseDto.getStoreId());
            if (null != warehouseId) {
                deleteByStoreId(storeWarehouseDto.getStoreId());
            }
            if (null != storeWarehouseDto.getWarehouseId()) {
                StoreProfileDto wareHouseDto = storeProfileService.loadByStoreId(storeWarehouseDto.getWarehouseId(), null);
                if (ObjectUtils.isNullOrEmpty(wareHouseDto)) {
                    throw new UserServiceException("关联的微仓不存在");
                }
                StoreWarehouse storeWarehouse = new StoreWarehouse();
                ObjectUtils.fastCopy(storeWarehouseDto, storeWarehouse);
                storeWarehouseMapper.save(storeWarehouse);
                // 修改店铺的共享库存字段,date:2016-12-10
                storeProfileService.updateStockShareByStoreId(storeWarehouseDto.getStoreId(), wareHouseDto.getStockShare());
            } else {
                // 修改店铺为非共享,date:2016-12-10
                storeProfileService.updateStockShareByStoreId(storeWarehouseDto.getStoreId(),
                        SystemContext.UserDomain.STORESTOCKSHARE_NO);
            }
        } catch (Exception e) {
            msg = null == msg ? "新增店铺与微仓关联关系出现系统异常" : msg;
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    @Override
    public void deleteByStoreId(Integer storeId) throws UserServiceException {
        String msg = null;
        try {
            if (ObjectUtils.isNullOrEmpty(storeId)) {
                msg = "storeId为空";
                logger.error(msg);
                throw new UserServiceException(msg);
            }
            storeWarehouseMapper.deleteByStoreId(storeId);
        } catch (Exception e) {
            msg = null == msg ? "根据店铺ID删除店铺与微仓关联关系出现系统异常" : msg;
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    @Override
    public List<Integer> listStoreIdsByWarehouseId(Integer warehouseId) throws UserServiceException {
        String msg = null;
        List<Integer> storeIds = null;
        try {
            if (ObjectUtils.isNullOrEmpty(warehouseId)) {
                msg = "warehouseId为空";
                logger.error(msg);
                throw new UserServiceException(msg);
            }
            storeIds = storeWarehouseMapper.listStoreIdsByWarehouseId(warehouseId);
            return storeIds;
        } catch (Exception e) {
            msg = null == msg ? "根据微仓ID获取该微仓所关联的所有店铺ID列表出现系统异常" : msg;
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    @Override
    public Integer loadWarehouseIdByStoreId(Integer storeId) throws UserServiceException {
        String msg = null;
        Integer warehouseId = null;
        try {
            if (ObjectUtils.isNullOrEmpty(storeId)) {
                msg = "storeId为空";
                logger.error(msg);
                throw new UserServiceException(msg);
            }
            warehouseId = storeWarehouseMapper.loadWarehouseIdByStoreId(storeId);
            return warehouseId;
        } catch (Exception e) {
            msg = null == msg ? "根据店铺ID获取该店铺所关联的微仓ID出现系统异常" : msg;
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    @Override
    public YiLiDiPage<WarehouseAssociatePartnerDto> findWarehouseAssociatePartners(
            WarehousePartnersQueryDto warehousePartnersQueryDto) throws UserServiceException {
        String msg = null;
        try {
            if (null == warehousePartnersQueryDto.getStart() || warehousePartnersQueryDto.getStart() <= 0) {
                warehousePartnersQueryDto.setStart(1);
            }
            if (null == warehousePartnersQueryDto.getPageSize() || warehousePartnersQueryDto.getPageSize() <= 0) {
                warehousePartnersQueryDto.setPageSize(CommonConstants.PAGE_SIZE);
            }
            WarehousePartnersQuery warehousePartnersQuery = new WarehousePartnersQuery();
            ObjectUtils.fastCopy(warehousePartnersQueryDto, warehousePartnersQuery);
            PageHelper.startPage(warehousePartnersQuery.getStart(), warehousePartnersQuery.getPageSize());
            Page<StoreWarehouse> page = storeWarehouseMapper.findStoreWarehouseRelations(warehousePartnersQuery);
            Page<WarehouseAssociatePartnerDto> pageDto = new Page<WarehouseAssociatePartnerDto>(
                    warehousePartnersQueryDto.getStart(), warehousePartnersQueryDto.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<StoreWarehouse> storeWarehouses = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(storeWarehouses)) {
                List<Integer> storeIds = new ArrayList<Integer>();
                for (StoreWarehouse storeWarehouse : storeWarehouses) {
                    storeIds.add(storeWarehouse.getStoreId());
                    WarehouseAssociatePartnerDto warehouseAssociatePartnerDto = new WarehouseAssociatePartnerDto();
                    warehouseAssociatePartnerDto.setStoreId(storeWarehouse.getStoreId());
                    warehouseAssociatePartnerDto.setAssociateTime(storeWarehouse.getCreateTime());
                    pageDto.add(warehouseAssociatePartnerDto);
                }
                List<WarehouseAssociatePartnerDto> wapDtoList = pageDto.getResult();
                List<StoreProfileDto> storeProfileDtoList = storeProfileService.listStoreProfileByStoreIds(storeIds);
                if (ObjectUtils.isNullOrEmpty(storeProfileDtoList)) {
                    msg = "微仓所关联的门店不存在";
                    logger.error(msg);
                    throw new UserServiceException(msg);
                }
                List<FinishOrderAmountInfoProxyDto> finishOrderAmountInfoProxyDtoList = orderProxyService
                        .listFinishOrderAmountByStoreIds(storeIds);
                if (ObjectUtils.isNullOrEmpty(finishOrderAmountInfoProxyDtoList)) {
                    for (WarehouseAssociatePartnerDto wapDto : wapDtoList) {
                        wapDto.setFinishOrderAmount(0L);
                    }
                }
                List<FinishOrderCountInfoProxyDto> finishOrderCountInfoProxyDtoList = orderProxyService
                        .listFinishOrderCountByStoreIds(storeIds);
                if (ObjectUtils.isNullOrEmpty(finishOrderCountInfoProxyDtoList)) {
                    for (WarehouseAssociatePartnerDto wapDto : wapDtoList) {
                        wapDto.setFinishOrderCount(0);
                    }
                }
                for (WarehouseAssociatePartnerDto wapDto : wapDtoList) {
                    boolean isStoreFound = false;
                    boolean isAmountFound = false;
                    boolean isCountFound = false;
                    for (StoreProfileDto storeProfileDto : storeProfileDtoList) {
                        if (wapDto.getStoreId().intValue() == storeProfileDto.getStoreId().intValue()) {
                            wapDto.setStoreName(storeProfileDto.getStoreName());
                            wapDto.setStoreCode(storeProfileDto.getStoreCode());
                            wapDto.setMobile(storeProfileDto.getMobile());
                            wapDto.setFullAddress(
                                    super.getAddressPrefix(storeProfileDto.getProvinceCode(), storeProfileDto.getCityCode(),
                                            storeProfileDto.getCountyCode()) + storeProfileDto.getAddressDetail());
                            isStoreFound = true;
                            break;
                        }
                    }
                    if (!isStoreFound) {
                        msg = "微仓所关联的门店不存在，门店ID：" + wapDto.getStoreId();
                        logger.error(msg);
                        throw new UserServiceException(msg);
                    }
                    for (FinishOrderAmountInfoProxyDto finishOrderAmountInfoProxyDto : finishOrderAmountInfoProxyDtoList) {
                        if (wapDto.getStoreId().intValue() == finishOrderAmountInfoProxyDto.getStoreId().intValue()) {
                            wapDto.setFinishOrderAmount(finishOrderAmountInfoProxyDto.getSumOrderAmount());
                            isAmountFound = true;
                            break;
                        }
                    }
                    if (!isAmountFound) {
                        wapDto.setFinishOrderAmount(0L);
                    }
                    for (FinishOrderCountInfoProxyDto finishOrderCountInfoProxyDto : finishOrderCountInfoProxyDtoList) {
                        if (wapDto.getStoreId().intValue() == finishOrderCountInfoProxyDto.getStoreId().intValue()) {
                            wapDto.setFinishOrderCount(finishOrderCountInfoProxyDto.getFinishedCount());
                            isCountFound = true;
                            break;
                        }
                    }
                    if (!isCountFound) {
                        wapDto.setFinishOrderCount(0);
                    }
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            msg = null == msg ? "分页获取微仓所关联的门店信息出现系统异常" : msg;
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

}
