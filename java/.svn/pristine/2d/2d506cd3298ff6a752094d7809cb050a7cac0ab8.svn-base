package com.yilidi.o2o.user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.UserClientTokenMapper;
import com.yilidi.o2o.user.model.UserClientToken;
import com.yilidi.o2o.user.service.IUserClientTokenService;
import com.yilidi.o2o.user.service.dto.UserClientTokenDto;

/**
 * 用户与APP客户端Token关联关系Service实现类
 * 
 * @author: chenlian
 * @date: 2016年8月5日 下午7:44:43
 */
@Service("userClientTokenService")
public class UserClientTokenServiceImpl extends BasicDataService implements IUserClientTokenService {

    @Autowired
    private UserClientTokenMapper userClientTokenMapper;

    @Override
    public void save(UserClientTokenDto userClientTokenDto) throws UserServiceException {
        String msg = null;
        try {
            if (ObjectUtils.isNullOrEmpty(userClientTokenDto)) {
                msg = "userClientTokenDto为空";
                logger.error(msg);
                throw new UserServiceException(msg);
            }
            UserClientToken userClientToken = new UserClientToken();
            ObjectUtils.fastCopy(userClientTokenDto, userClientToken);
            userClientTokenMapper.save(userClientToken);
        } catch (Exception e) {
            msg = null == msg ? "新增用户与APP客户端Token关联关系出现系统异常" : msg;
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    @Override
    public void update(Integer id, String clientToken, String deviceToken, String platform) throws UserServiceException {
        try {
            userClientTokenMapper.update(id, clientToken, deviceToken, platform);
        } catch (Exception e) {
            String msg = "更新用户与APP客户端Token关联关系出现系统异常";
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    @Override
    public UserClientTokenDto loadByUserId(Integer userId) {
        try {
            UserClientToken userClientToken = userClientTokenMapper.loadByUserId(userId);
            UserClientTokenDto userClientTokenDto = null;
            if (null != userClientToken) {
                userClientTokenDto = new UserClientTokenDto();
                ObjectUtils.fastCopy(userClientToken, userClientTokenDto);
            }
            return userClientTokenDto;
        } catch (Exception e) {
            String msg = "根据用户ID获取用户与APP客户端Token关联关系出现系统异常";
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

	@Override
	public UserClientTokenDto loadByClientToken(String clientToken)
			throws UserServiceException {
		try {
            UserClientToken userClientToken = userClientTokenMapper.loadByClientToken(clientToken);
            UserClientTokenDto userClientTokenDto = null;
            if (null != userClientToken) {
                userClientTokenDto = new UserClientTokenDto();
                ObjectUtils.fastCopy(userClientToken, userClientTokenDto);
            }
            return userClientTokenDto;
        } catch (Exception e) {
            String msg = "根据APP客户端clientToken查询当前存在的关联关系数据信息异常";
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
	}

	@Override
	public UserClientTokenDto loadByDeviceToken(String deviceToken)
			throws UserServiceException {
		try {
            UserClientToken userClientToken = userClientTokenMapper.loadByDeviceToken(deviceToken);
            UserClientTokenDto userClientTokenDto = null;
            if (null != userClientToken) {
                userClientTokenDto = new UserClientTokenDto();
                ObjectUtils.fastCopy(userClientToken, userClientTokenDto);
            }
            return userClientTokenDto;
        } catch (Exception e) {
            String msg = "根据APP客户端deviceToken查询当前存在的关联关系数据信息异常";
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
	}

	@Override
	public void delete(Integer userClientTokenId) throws UserServiceException {
		String msg = null;
        try {
            if (null == userClientTokenId) {
                msg = "userClientTokenId为空";
                logger.error(msg);
                throw new UserServiceException(msg);
            }
            userClientTokenMapper.delete(userClientTokenId);
        } catch (Exception e) {
            msg = null == msg ? "清除用户与APP客户端Token关联关系出现系统异常" : msg;
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
	}

}
