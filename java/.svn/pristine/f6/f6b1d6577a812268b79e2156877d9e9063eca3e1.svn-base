package com.yilidi.o2o.user.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.InviterUserShareAwardMapper;
import com.yilidi.o2o.user.model.InviterUserShareAward;
import com.yilidi.o2o.user.model.combination.InviterUserAwardStatisticInfo;
import com.yilidi.o2o.user.service.IInviterUserShareAwardService;
import com.yilidi.o2o.user.service.dto.InviterUserShareAwardDto;

/**
 * 邀请人分享奖励Service接口实现类
 * 
 * @author: chenb
 * @date: 2016年10月19日 下午2:26:53
 */
@Service("inviterUserShareAwardService")
public class InviterUserShareAwardServiceImpl extends BasicDataService implements IInviterUserShareAwardService {

    @Autowired
    private InviterUserShareAwardMapper inviterUserShareAwardMapper;

    @Override
    public void save(InviterUserShareAwardDto inviterUserShareAwardDto) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(inviterUserShareAwardDto)) {
                throw new UserServiceException("分享记录信息不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(inviterUserShareAwardDto.getShareCode())
                    || ObjectUtils.isNullOrEmpty(inviterUserShareAwardDto.getUserId())
                    || ObjectUtils.isNullOrEmpty(inviterUserShareAwardDto.getShareRuleId())) {
                throw new UserServiceException("必填参数不能为空");
            }
            Date nowTime = new Date();
            if (ObjectUtils.isNullOrEmpty(inviterUserShareAwardDto.getCreateTime())) {
                inviterUserShareAwardDto.setCreateTime(nowTime);
            }
            if (ObjectUtils.isNullOrEmpty(inviterUserShareAwardDto.getCreateUserId())) {
                inviterUserShareAwardDto.setCreateUserId(inviterUserShareAwardDto.getUserId());
            }
            InviterUserShareAward inviterUserShareAward = new InviterUserShareAward();
            ObjectUtils.fastCopy(inviterUserShareAwardDto, inviterUserShareAward);
            inviterUserShareAwardMapper.save(inviterUserShareAward);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }

    }

    @Override
    public InviterUserShareAwardDto loadById(Integer id) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                return null;
            }
            InviterUserShareAward userShareResult = inviterUserShareAwardMapper.loadById(id);
            if (ObjectUtils.isNullOrEmpty(userShareResult)) {
                return null;
            }
            InviterUserShareAwardDto userShareResultDto = new InviterUserShareAwardDto();
            ObjectUtils.fastCopy(userShareResult, userShareResultDto);
            return userShareResultDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public InviterUserShareAwardDto loadByShareCodeAndShareRuleId(String shareCode, Integer shareRuleId)
            throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(shareCode) || ObjectUtils.isNullOrEmpty(shareRuleId)) {
                return null;
            }
            InviterUserShareAward inviterUserShareAward = inviterUserShareAwardMapper
                    .loadByShareCodeAndShareRuleId(shareCode, shareRuleId);
            if (ObjectUtils.isNullOrEmpty(inviterUserShareAward)) {
                return null;
            }
            InviterUserShareAwardDto inviterUserShareAwardDto = new InviterUserShareAwardDto();
            ObjectUtils.fastCopy(inviterUserShareAward, inviterUserShareAwardDto);
            return inviterUserShareAwardDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public InviterUserShareAwardDto loadByUserIdAndShareRuleIdAndInvitedUserId(Integer inviterUserId, Integer shareRuleId,
            Integer invitedUserId) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(inviterUserId) || ObjectUtils.isNullOrEmpty(shareRuleId)) {
                return null;
            }
            InviterUserShareAward userShareResult = inviterUserShareAwardMapper
                    .loadByUserIdAndShareRuleIdAndInvitedUserId(inviterUserId, shareRuleId, invitedUserId);
            if (ObjectUtils.isNullOrEmpty(userShareResult)) {
                return null;
            }
            InviterUserShareAwardDto userShareResultDto = new InviterUserShareAwardDto();
            ObjectUtils.fastCopy(userShareResult, userShareResultDto);
            return userShareResultDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public InviterUserShareAwardDto getAwardStatisticsInfo(Integer userId, Date startTime, Date endTime)
            throws UserServiceException {
        try {
            InviterUserAwardStatisticInfo inviterUserAwardStatisticInfo = inviterUserShareAwardMapper
                    .getAwardStatisticsInfo(userId, startTime, endTime);
            InviterUserShareAwardDto inviterUserShareAwardDto = null;
            if (!ObjectUtils.isNullOrEmpty(inviterUserAwardStatisticInfo)) {
                inviterUserShareAwardDto = new InviterUserShareAwardDto();
                ObjectUtils.fastCopy(inviterUserAwardStatisticInfo, inviterUserShareAwardDto);
            }
            return inviterUserShareAwardDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public Long getInviterAmountCountByShareUserIdAndTime(Integer shareUserId, Date startTime, Date endTime)
            throws UserServiceException {
        try {
            return inviterUserShareAwardMapper.getInviterAmountCountByShareUserIdAndTime(shareUserId, null, null);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

	@Override
	public void save(List<InviterUserShareAwardDto> inviterUserShareAwardDtoList) {
		try {
            if (ObjectUtils.isNullOrEmpty(inviterUserShareAwardDtoList)) {
                throw new UserServiceException("分享记录信息不能为空");
            }
            InviterUserShareAward inviterUserShareAward = null;
            for (InviterUserShareAwardDto inviterUserShareAwardDto : inviterUserShareAwardDtoList) {
            	inviterUserShareAward = new InviterUserShareAward();
            	ObjectUtils.fastCopy(inviterUserShareAwardDto, inviterUserShareAward);
            	inviterUserShareAwardMapper.save(inviterUserShareAward);
			}
		} catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
	}
}
