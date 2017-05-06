package com.yilidi.o2o.user.service.impl;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.InvitedUserShareRecordMapper;
import com.yilidi.o2o.user.model.InvitedUserShareRecord;
import com.yilidi.o2o.user.service.IInvitedUserShareRecordService;
import com.yilidi.o2o.user.service.dto.InvitedUserShareRecordDto;

/**
 * 用户分享结果Service接口实现类
 * 
 * @author: chenb
 * @date: 2016年10月19日 下午2:26:53
 */
@Service("invitedUserShareRecordService")
public class InvitedUserShareRecordServiceImpl extends BasicDataService implements IInvitedUserShareRecordService {

    @Autowired
    private InvitedUserShareRecordMapper invitedUserShareRecordMapper;

    @Override
    public void save(InvitedUserShareRecordDto userShareResultDto) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userShareResultDto)) {
                throw new UserServiceException("分享记录信息不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(userShareResultDto.getShareCode())
                    || ObjectUtils.isNullOrEmpty(userShareResultDto.getInvitedUserId())
                    || ObjectUtils.isNullOrEmpty(userShareResultDto.getShareUserId())
                    || ObjectUtils.isNullOrEmpty(userShareResultDto.getShareRuleId())) {
                throw new UserServiceException("必填参数不能为空");
            }
            Date nowTime = new Date();
            if (ObjectUtils.isNullOrEmpty(userShareResultDto.getCreateTime())) {
                userShareResultDto.setCreateTime(nowTime);
            }
            if (ObjectUtils.isNullOrEmpty(userShareResultDto.getCreateUserId())) {
                userShareResultDto.setCreateUserId(userShareResultDto.getInvitedUserId());
            }
            InvitedUserShareRecord userShareResult = new InvitedUserShareRecord();
            ObjectUtils.fastCopy(userShareResultDto, userShareResult);
            invitedUserShareRecordMapper.save(userShareResult);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }

    }

    @Override
    public InvitedUserShareRecordDto loadById(Integer userShareResultId) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userShareResultId)) {
                return null;
            }
            InvitedUserShareRecord userShareResult = invitedUserShareRecordMapper.loadById(userShareResultId);
            if (ObjectUtils.isNullOrEmpty(userShareResult)) {
                return null;
            }
            InvitedUserShareRecordDto userShareResultDto = new InvitedUserShareRecordDto();
            ObjectUtils.fastCopy(userShareResult, userShareResultDto);
            return userShareResultDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public InvitedUserShareRecordDto loadByShareCodeAndShareRuleId(String shareCode, Integer shareRuleId)
            throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(shareCode) || ObjectUtils.isNullOrEmpty(shareRuleId)) {
                return null;
            }
            InvitedUserShareRecord userShareResult = invitedUserShareRecordMapper.loadByShareCodeAndShareRuleId(shareCode,
                    shareRuleId);
            if (ObjectUtils.isNullOrEmpty(userShareResult)) {
                return null;
            }
            InvitedUserShareRecordDto userShareResultDto = new InvitedUserShareRecordDto();
            ObjectUtils.fastCopy(userShareResult, userShareResultDto);
            return userShareResultDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public InvitedUserShareRecordDto loadByInvitedUserIdAndShareRuleId(Integer invitedUserId, Integer shareRuleId)
            throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(invitedUserId) || ObjectUtils.isNullOrEmpty(shareRuleId)) {
                return null;
            }
            InvitedUserShareRecord userShareResult = invitedUserShareRecordMapper
                    .loadByInvitedUserIdAndShareRuleId(invitedUserId, shareRuleId);
            if (ObjectUtils.isNullOrEmpty(userShareResult)) {
                return null;
            }
            InvitedUserShareRecordDto userShareResultDto = new InvitedUserShareRecordDto();
            ObjectUtils.fastCopy(userShareResult, userShareResultDto);
            return userShareResultDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

}
