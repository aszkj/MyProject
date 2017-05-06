package com.yilidi.o2o.user.service.impl;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.UserShareCodeMapper;
import com.yilidi.o2o.user.model.UserShareCode;
import com.yilidi.o2o.user.service.IUserShareCodeService;
import com.yilidi.o2o.user.service.dto.UserShareCodeDto;

/**
 * 用户分享码Service服务实现类
 * 
 * @author: chenb
 * @date: 2016年10月19日 下午2:26:53
 */
@Service("userShareCodeService")
public class UserShareCodeServiceImpl extends BasicDataService implements IUserShareCodeService {

    @Autowired
    private UserShareCodeMapper userShareCodeMapper;

    @Override
    public void save(UserShareCodeDto userShareCodeDto) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userShareCodeDto)) {
                throw new UserServiceException("用户分享码信息不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(userShareCodeDto.getShareCode())
                    || ObjectUtils.isNullOrEmpty(userShareCodeDto.getCreateUserId())
                    || ObjectUtils.isNullOrEmpty(userShareCodeDto.getShareUserId())) {
                throw new UserServiceException("必填参数不能为空");
            }
            Date nowTime = new Date();
            if (ObjectUtils.isNullOrEmpty(userShareCodeDto.getCreateTime())) {
                userShareCodeDto.setCreateTime(nowTime);
            }
            UserShareCode userShareCode = new UserShareCode();
            ObjectUtils.fastCopy(userShareCodeDto, userShareCode);
            userShareCodeMapper.save(userShareCode);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }

    }

    @Override
    public UserShareCodeDto loadById(Integer id) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                return null;
            }
            UserShareCode userShareCode = userShareCodeMapper.loadById(id);
            if (ObjectUtils.isNullOrEmpty(userShareCode)) {
                return null;
            }
            UserShareCodeDto userShareCodeDto = new UserShareCodeDto();
            ObjectUtils.fastCopy(userShareCode, userShareCodeDto);
            return userShareCodeDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public UserShareCodeDto loadByShareUserId(Integer shareUserId) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(shareUserId)) {
                return null;
            }
            UserShareCode userShareCode = userShareCodeMapper.loadByShareUserId(shareUserId);
            if (ObjectUtils.isNullOrEmpty(userShareCode)) {
                return null;
            }
            UserShareCodeDto userShareCodeDto = new UserShareCodeDto();
            ObjectUtils.fastCopy(userShareCode, userShareCodeDto);
            return userShareCodeDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public UserShareCodeDto loadByShareCode(String shareCode) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(shareCode)) {
                return null;
            }
            UserShareCode userShareCode = userShareCodeMapper.loadByShareCode(shareCode);
            if (ObjectUtils.isNullOrEmpty(userShareCode)) {
                return null;
            }
            UserShareCodeDto userShareCodeDto = new UserShareCodeDto();
            ObjectUtils.fastCopy(userShareCode, userShareCodeDto);
            return userShareCodeDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public UserShareCodeDto loadByShareCodeAndUserId(String shareCode, Integer userId) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(shareCode)) {
                throw new UserServiceException("param[shareCode] can not be null");
            }
            if (ObjectUtils.isNullOrEmpty(userId)) {
                throw new UserServiceException("param[userId] can not be null");
            }
            UserShareCode userShareCode = userShareCodeMapper.loadByShareCodeAndUserId(shareCode, userId);
            if (ObjectUtils.isNullOrEmpty(userShareCode)) {
                return null;
            }
            UserShareCodeDto userShareCodeDto = new UserShareCodeDto();
            ObjectUtils.fastCopy(userShareCode, userShareCodeDto);
            return userShareCodeDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }
}
