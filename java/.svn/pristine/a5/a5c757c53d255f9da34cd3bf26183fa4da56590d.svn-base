package com.yilidi.o2o.order.proxy.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.dao.SmallTableUserInfoMapper;
import com.yilidi.o2o.order.model.SmallTableUserInfo;
import com.yilidi.o2o.order.proxy.ISmallTableUserInfoProxyService;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.proxy.dto.SmallTableUserInfoProxyDto;

/**
 * 用户信息小表代理Service实现类
 * 
 * @author: chenlian
 * @date: 2016年8月11日 下午11:09:39
 */
@Service("smallTableUserInfoProxyService")
public class SmallTableUserInfoProxyServiceImpl extends BasicDataService implements ISmallTableUserInfoProxyService {

    @Autowired
    private SmallTableUserInfoMapper smallTableUserInfoMapper;

    @Override
    public void save(SmallTableUserInfoProxyDto smallTableUserInfoProxyDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(smallTableUserInfoProxyDto)) {
                throw new OrderServiceException("参数smallTableUserInfoProxyDto不能为空");
            }
            SmallTableUserInfo smallTableUserInfo = new SmallTableUserInfo();
            ObjectUtils.fastCopy(smallTableUserInfoProxyDto, smallTableUserInfo);
            smallTableUserInfoMapper.save(smallTableUserInfo);
        } catch (Exception e) {
            logger.error("save异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateByUserId(SmallTableUserInfoProxyDto smallTableUserInfoProxyDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(smallTableUserInfoProxyDto)) {
                throw new OrderServiceException("参数smallTableUserInfoProxyDto不能为空");
            }
            SmallTableUserInfo smallTableUserInfo = new SmallTableUserInfo();
            ObjectUtils.fastCopy(smallTableUserInfoProxyDto, smallTableUserInfo);
            smallTableUserInfoMapper.updateByUserId(smallTableUserInfo);
        } catch (Exception e) {
            logger.error("updateByUserId异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

}
