package com.yilidi.o2o.user.proxy.impl;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.proxy.IUserShareProxyService;
import com.yilidi.o2o.user.service.IUserShareService;

/**
 * 功能描述：用户分享Service服务实现类 <br/>
 * 作者： chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("userShareProxyService")
public class UserShareProxyServiceImpl extends BasicDataService implements IUserShareProxyService {

    @Autowired
    private IUserShareService userShareService;

    @Override
    public void saveUserShareAwardForLoginContidion(Integer userId, Date nowTime) throws UserServiceException {
        try {
            userShareService.saveUserShareAwardForLoginContidion(userId, nowTime);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }

    }

    @Override
    public void saveUserShareAwardForProductOrderContidion(Integer userId, Date nowTime, String orderNo)
            throws UserServiceException {
        try {
            userShareService.saveUserShareAwardForProductOrderContidion(userId, nowTime, orderNo);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }

    }

    @Override
    public void saveUserShareAwardForAnyOrderContidion(Integer userId, Date nowTime, String orderNo)
            throws UserServiceException {
        try {
            userShareService.saveUserShareAwardForAnyOrderContidion(userId, nowTime, orderNo);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }

    }

    @Override
    public void saveUserShareAwardForRegisterContidion(Integer userId, Date nowTime) throws UserServiceException {
        try {
            userShareService.saveUserShareAwardForRegisterContidion(userId, nowTime);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }

    }
}
