package com.yilidi.o2o.user.proxy.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.StoreWarehouseMapper;
import com.yilidi.o2o.user.proxy.IStoreWarehouseProxyService;

@Service("storeWarehouseProxyService")
public class StoreWarehouseProxyServiceImpl extends BasicDataService implements IStoreWarehouseProxyService {

    @Autowired
    private StoreWarehouseMapper storeWarehouseMapper;

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

}
