package com.yilidi.o2o.user.proxy.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.ConsigneeAddressMapper;
import com.yilidi.o2o.user.model.ConsigneeAddress;
import com.yilidi.o2o.user.proxy.IConsigneeAddressProxyService;
import com.yilidi.o2o.user.proxy.dto.ConsigneeAddressProxyDto;

/**
 * 功能描述：收货地址Service服务实现类 <br/>
 * 作者： chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("consigneeAddressProxyService")
public class ConsigneeAddressProxyServiceImpl extends BasicDataService implements IConsigneeAddressProxyService {

    @Autowired
    private ConsigneeAddressMapper consigneeAddressMapper;

    @Override
    public ConsigneeAddressProxyDto loadById(Integer id) throws UserServiceException {
        try {
            ConsigneeAddress consigneeAddress = consigneeAddressMapper.loadById(id, null);
            ConsigneeAddressProxyDto consigneeAddressDto = null;
            if (null != consigneeAddress) {
                consigneeAddressDto = new ConsigneeAddressProxyDto();
                ObjectUtils.fastCopy(consigneeAddress, consigneeAddressDto);
            }
            return consigneeAddressDto;
        } catch (Exception e) {
            logger.error("loadById异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }
}
