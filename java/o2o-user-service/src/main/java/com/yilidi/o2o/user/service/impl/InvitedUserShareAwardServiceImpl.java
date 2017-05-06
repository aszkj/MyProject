package com.yilidi.o2o.user.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.InvitedUserShareAwardMapper;
import com.yilidi.o2o.user.model.InvitedUserShareAward;
import com.yilidi.o2o.user.model.combination.InviterUserStatisticInfo;
import com.yilidi.o2o.user.model.query.InvitedUserShareAwardQuery;
import com.yilidi.o2o.user.service.IInvitedUserShareAwardService;
import com.yilidi.o2o.user.service.dto.InvitedUserShareAwardDto;
import com.yilidi.o2o.user.service.dto.InviterUserStatisticInfoDto;
import com.yilidi.o2o.user.service.dto.query.InvitedUserShareAwardQueryDto;

/**
 * 用户分享奖励记录Service接口实现类
 * 
 * @author: chenb
 * @date: 2016年10月19日 下午2:26:53
 */
@Service("invitedUserShareAwardService")
public class InvitedUserShareAwardServiceImpl extends BasicDataService implements IInvitedUserShareAwardService {

    @Autowired
    private InvitedUserShareAwardMapper invitedUserShareAwardMapper;

    @Override
    public void save(InvitedUserShareAwardDto userShareRecordDto) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(userShareRecordDto)) {
                throw new UserServiceException("分享记录信息不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(userShareRecordDto.getShareCode())
                    || ObjectUtils.isNullOrEmpty(userShareRecordDto.getShareRuleId())
                    || ObjectUtils.isNullOrEmpty(userShareRecordDto.getShareUserId())
                    || ObjectUtils.isNullOrEmpty(userShareRecordDto.getInvitedUserId())) {
                throw new UserServiceException("必填参数不能为空");
            }
            Date nowTime = new Date();
            if (ObjectUtils.isNullOrEmpty(userShareRecordDto.getCreateTime())) {
                userShareRecordDto.setCreateTime(nowTime);
            }
            if (ObjectUtils.isNullOrEmpty(userShareRecordDto.getCreateUserId())) {
                userShareRecordDto.setCreateUserId(userShareRecordDto.getInvitedUserId());
            }
            InvitedUserShareAward userShareRecord = new InvitedUserShareAward();
            ObjectUtils.fastCopy(userShareRecordDto, userShareRecord);
            invitedUserShareAwardMapper.save(userShareRecord);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }

    }

    @Override
    public InvitedUserShareAwardDto loadById(Integer id) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(id)) {
                return null;
            }
            InvitedUserShareAward userShareRecord = invitedUserShareAwardMapper.loadById(id);
            if (ObjectUtils.isNullOrEmpty(userShareRecord)) {
                return null;
            }
            InvitedUserShareAwardDto userShareRecordDto = new InvitedUserShareAwardDto();
            ObjectUtils.fastCopy(userShareRecord, userShareRecordDto);
            return userShareRecordDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public InvitedUserShareAwardDto loadByInvitedUserIdAndShareRuleId(Integer invitedUserId, Integer shareRuleId)
            throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(invitedUserId)) {
                return null;
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleId)) {
                return null;
            }
            InvitedUserShareAward userShareRecord = invitedUserShareAwardMapper
                    .loadByInvitedUserIdAndShareRuleId(invitedUserId, shareRuleId);
            if (ObjectUtils.isNullOrEmpty(userShareRecord)) {
                return null;
            }
            InvitedUserShareAwardDto invitedUserShareAwardDto = new InvitedUserShareAwardDto();
            ObjectUtils.fastCopy(userShareRecord, invitedUserShareAwardDto);
            return invitedUserShareAwardDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public InviterUserStatisticInfoDto loadStatisticsCountByShareUserIdAndTime(Integer shareUserId, Date startTime,
            Date endTime) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(shareUserId)) {
                return null;
            }
            InviterUserStatisticInfo inviterUserStatisticInfo = invitedUserShareAwardMapper
                    .loadStatisticsCountByShareUserIdAndTime(shareUserId, startTime, endTime);
            if (ObjectUtils.isNullOrEmpty(inviterUserStatisticInfo)) {
                return null;
            }
            InviterUserStatisticInfoDto inviterUserStatisticInfoDto = new InviterUserStatisticInfoDto();
            ObjectUtils.fastCopy(inviterUserStatisticInfo, inviterUserStatisticInfoDto);
            return inviterUserStatisticInfoDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<InvitedUserShareAwardDto> findInvitedUserShareAwardsByShareUserId(
            InvitedUserShareAwardQueryDto invitedUserShareAwardQueryDto) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(invitedUserShareAwardQueryDto)) {
                throw new UserServiceException("查询条件不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(invitedUserShareAwardQueryDto.getStart())) {
                invitedUserShareAwardQueryDto.setStart(1);
            }
            if (ObjectUtils.isNullOrEmpty(invitedUserShareAwardQueryDto.getPageSize())) {
                invitedUserShareAwardQueryDto.setStart(CommonConstants.PAGE_SIZE);
            }
            InvitedUserShareAwardQuery invitedUserShareAwardQuery = new InvitedUserShareAwardQuery();
            ObjectUtils.fastCopy(invitedUserShareAwardQueryDto, invitedUserShareAwardQuery);
            PageHelper.startPage(invitedUserShareAwardQuery.getStart(), invitedUserShareAwardQuery.getPageSize());
            Page<InvitedUserShareAward> page = invitedUserShareAwardMapper
                    .findInvitedUserShareAwardsByShareUserId(invitedUserShareAwardQuery);
            Page<InvitedUserShareAwardDto> pageDto = new Page<InvitedUserShareAwardDto>(
                    invitedUserShareAwardQuery.getStart(), invitedUserShareAwardQuery.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<InvitedUserShareAward> invitedUserShareAwardList = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(invitedUserShareAwardList)) {
                for (InvitedUserShareAward userShareResult : invitedUserShareAwardList) {
                    InvitedUserShareAwardDto invitedUserShareAwardDto = new InvitedUserShareAwardDto();
                    ObjectUtils.fastCopy(userShareResult, invitedUserShareAwardDto);
                    pageDto.add(invitedUserShareAwardDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<InviterUserStatisticInfoDto> findInviterStatisticsCounts(
            InvitedUserShareAwardQueryDto invitedUserShareAwardQueryDto) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(invitedUserShareAwardQueryDto)) {
                throw new UserServiceException("required params cant not be null");
            }
            InvitedUserShareAwardQuery invitedUserShareAwardQuery = new InvitedUserShareAwardQuery();
            ObjectUtils.fastCopy(invitedUserShareAwardQueryDto, invitedUserShareAwardQuery);
            if (ObjectUtils.isNullOrEmpty(invitedUserShareAwardQuery.getStart())) {
                invitedUserShareAwardQuery.setStart(1);
            }
            if (ObjectUtils.isNullOrEmpty(invitedUserShareAwardQuery.getPageSize())) {
                invitedUserShareAwardQuery.setPageSize(CommonConstants.PAGE_SIZE);
            }
            PageHelper.startPage(invitedUserShareAwardQuery.getStart(), invitedUserShareAwardQuery.getPageSize());
            Page<InviterUserStatisticInfo> page = invitedUserShareAwardMapper
                    .findInviterStatisticsCounts(invitedUserShareAwardQuery);
            Page<InviterUserStatisticInfoDto> pageDto = new Page<InviterUserStatisticInfoDto>(
                    invitedUserShareAwardQuery.getStart(), invitedUserShareAwardQuery.getPageSize());
            ObjectUtils.fastCopy(page, pageDto);
            List<InviterUserStatisticInfo> inviterUserStatisticInfoList = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(inviterUserStatisticInfoList)) {
                for (InviterUserStatisticInfo inviterUserStatisticInfo : inviterUserStatisticInfoList) {
                    InviterUserStatisticInfoDto inviterUserStatisticInfoDto = new InviterUserStatisticInfoDto();
                    ObjectUtils.fastCopy(inviterUserStatisticInfo, inviterUserStatisticInfoDto);
                    pageDto.add(inviterUserStatisticInfoDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public Integer getInviterStatisticsCount(InvitedUserShareAwardQueryDto invitedUserShareAwardQueryDto)
            throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(invitedUserShareAwardQueryDto)) {
                throw new UserServiceException("required params cant not be null");
            }
            InvitedUserShareAwardQuery invitedUserShareAwardQuery = new InvitedUserShareAwardQuery();
            ObjectUtils.fastCopy(invitedUserShareAwardQueryDto, invitedUserShareAwardQuery);
            if (ObjectUtils.isNullOrEmpty(invitedUserShareAwardQuery.getStart())) {
                invitedUserShareAwardQuery.setStart(1);
            }
            if (ObjectUtils.isNullOrEmpty(invitedUserShareAwardQuery.getPageSize())) {
                invitedUserShareAwardQuery.setPageSize(CommonConstants.PAGE_SIZE);
            }
            PageHelper.startPage(invitedUserShareAwardQuery.getStart(), invitedUserShareAwardQuery.getPageSize());
            Integer result = invitedUserShareAwardMapper.getInviterStatisticsCount(invitedUserShareAwardQuery);
            return ArithUtils.converIntegerToInt(result);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public Integer loadChampionByTime(Date startTime, Date endTime) throws UserServiceException {
        try {
            return invitedUserShareAwardMapper.loadChampionByTime(startTime, endTime);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public Integer getInviterCountByShareUserIdAndTime(Integer shareUserId, Date startTime, Date endTime)
            throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(shareUserId)) {
                throw new UserServiceException("param[shareUserId] can not be null");
            }
            Integer totalCount = invitedUserShareAwardMapper.getInviterCountByShareUserIdAndTime(shareUserId, startTime,
                    endTime);
            if (ObjectUtils.isNullOrEmpty(totalCount)) {
                totalCount = 0;
            }
            return totalCount;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<InvitedUserShareAwardDto> findInvitedUserShareAwards(
            InvitedUserShareAwardQueryDto invitedUserShareAwardQueryDto) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(invitedUserShareAwardQueryDto)) {
                throw new UserServiceException("查询条件不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(invitedUserShareAwardQueryDto.getStart())) {
                invitedUserShareAwardQueryDto.setStart(1);
            }
            if (ObjectUtils.isNullOrEmpty(invitedUserShareAwardQueryDto.getPageSize())) {
                invitedUserShareAwardQueryDto.setStart(CommonConstants.PAGE_SIZE);
            }
            InvitedUserShareAwardQuery invitedUserShareAwardQuery = new InvitedUserShareAwardQuery();
            ObjectUtils.fastCopy(invitedUserShareAwardQueryDto, invitedUserShareAwardQuery);
            if (!ObjectUtils.isNullOrEmpty(invitedUserShareAwardQueryDto.getStrStartTime())) {
                Date beginStartDate = DateUtils.parseDate(invitedUserShareAwardQueryDto.getStrStartTime(),
                        CommonConstants.DATE_FORMAT_DAY);
                invitedUserShareAwardQuery.setStartTime(beginStartDate);
            }
            if (!ObjectUtils.isNullOrEmpty(invitedUserShareAwardQueryDto.getStrEndTime())) {
                Date endStartTime = DateUtils.parseDate(invitedUserShareAwardQueryDto.getStrEndTime(),
                        CommonConstants.DATE_FORMAT_DAY);
                invitedUserShareAwardQuery.setEndTime(endStartTime);
            }
            PageHelper.startPage(invitedUserShareAwardQuery.getStart(), invitedUserShareAwardQuery.getPageSize());
            Page<InvitedUserShareAward> userShareRecordPages = invitedUserShareAwardMapper
                    .findInvitedUserShareAwards(invitedUserShareAwardQuery);
            Page<InvitedUserShareAwardDto> pageDto = new Page<InvitedUserShareAwardDto>(
                    invitedUserShareAwardQuery.getStart(), invitedUserShareAwardQuery.getPageSize());
            ObjectUtils.fastCopy(userShareRecordPages, pageDto);
            List<InvitedUserShareAward> invitedUserShareAwardList = userShareRecordPages.getResult();
            if (!ObjectUtils.isNullOrEmpty(invitedUserShareAwardList)) {
                for (InvitedUserShareAward invitedUserShareAward : invitedUserShareAwardList) {
                    InvitedUserShareAwardDto invitedUserShareAwardDto = new InvitedUserShareAwardDto();
                    ObjectUtils.fastCopy(invitedUserShareAward, invitedUserShareAwardDto);
                    pageDto.add(invitedUserShareAwardDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public List<InviterUserStatisticInfoDto> listInviterStatisticsCountsByTime(Date startTime, Date endTime)
            throws UserServiceException {
        try {
            List<InviterUserStatisticInfo> inviterUserStatisticInfos = invitedUserShareAwardMapper
                    .listInviterStatisticsCountsByTime(startTime, endTime);
            List<InviterUserStatisticInfoDto> inviterUserStatisticInfoDtos = new ArrayList<InviterUserStatisticInfoDto>();
            if (!ObjectUtils.isNullOrEmpty(inviterUserStatisticInfos)) {
                InviterUserStatisticInfoDto inviterUserStatisticInfoDto = new InviterUserStatisticInfoDto();
                for (InviterUserStatisticInfo inviterUserStatisticInfo : inviterUserStatisticInfos) {
                    ObjectUtils.fastCopy(inviterUserStatisticInfo, inviterUserStatisticInfoDto);
                    inviterUserStatisticInfoDtos.add(inviterUserStatisticInfoDto);
                }
            }
            return inviterUserStatisticInfoDtos;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

	@Override
	public void save(List<InvitedUserShareAwardDto> userShareRecordDtoList) {
		try {
            if (ObjectUtils.isNullOrEmpty(userShareRecordDtoList)) {
                throw new UserServiceException("分享记录信息不能为空");
            }
            InvitedUserShareAward userShareRecord = null;
            for (InvitedUserShareAwardDto userShareRecordDto : userShareRecordDtoList) {
            	userShareRecord = new InvitedUserShareAward();
            	ObjectUtils.fastCopy(userShareRecordDto, userShareRecord);
            	invitedUserShareAwardMapper.save(userShareRecord);
			}
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }

	}

}
