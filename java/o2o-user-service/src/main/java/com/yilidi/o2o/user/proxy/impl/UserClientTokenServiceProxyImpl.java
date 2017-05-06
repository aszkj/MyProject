package com.yilidi.o2o.user.proxy.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.UserClientTokenMapper;
import com.yilidi.o2o.user.model.UserClientToken;
import com.yilidi.o2o.user.proxy.IUserClientTokenProxyService;
import com.yilidi.o2o.user.proxy.dto.UserClientTokenProxyDto;

/**
 * 用户与APP客户端Token关联关系代理Service实现类
 * 
 * @author: chenlian
 * @date: 2016年8月8日 下午6:50:39
 */
@Service("userClientTokenProxyService")
public class UserClientTokenServiceProxyImpl extends BasicDataService implements IUserClientTokenProxyService {

    @Autowired
    private UserClientTokenMapper userClientTokenMapper;

    @Override
    public UserClientTokenProxyDto loadByUserId(Integer userId) {
        try {
            UserClientToken userClientToken = userClientTokenMapper.loadByUserId(userId);
            UserClientTokenProxyDto userClientTokenProxyDto = null;
            if (null != userClientToken) {
                userClientTokenProxyDto = new UserClientTokenProxyDto();
                ObjectUtils.fastCopy(userClientToken, userClientTokenProxyDto);
            }
            return userClientTokenProxyDto;
        } catch (Exception e) {
            String msg = "根据用户ID获取用户与APP客户端Token关联关系出现系统异常";
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

}
