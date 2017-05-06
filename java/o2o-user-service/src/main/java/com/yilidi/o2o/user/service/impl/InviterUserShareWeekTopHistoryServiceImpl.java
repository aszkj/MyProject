package com.yilidi.o2o.user.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.InviterUserShareWeekTopHistoryMapper;
import com.yilidi.o2o.user.model.InviterUserShareWeekTopHistory;
import com.yilidi.o2o.user.service.IInviterUserShareWeekTopHistoryService;
import com.yilidi.o2o.user.service.dto.InviterUserShareWeekTopHistoryDto;

/**
 * 邀请排行榜修改历史Service接口实现类
 * 
 * @author: chenb
 * @date: 2016年10月19日 下午2:26:53
 */
@Service("inviterUserShareWeekTopHistoryService")
public class InviterUserShareWeekTopHistoryServiceImpl extends BasicDataService
        implements IInviterUserShareWeekTopHistoryService {

    @Autowired
    private InviterUserShareWeekTopHistoryMapper inviterUserShareWeekTopHistoryMapper;

    @Override
    public void save(InviterUserShareWeekTopHistoryDto inviterUserShareWeekTopHistoryDto) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopHistoryDto)
                    || ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopHistoryDto.getUserName())
                    || ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopHistoryDto.getYear())
                    || ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopHistoryDto.getMonth())
                    || ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopHistoryDto.getWeekNumber())
                    || ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopHistoryDto.getInviterCount())
                    || ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopHistoryDto.getCreateUserId())) {
                throw new UserServiceException("required params can not be null");
            }
            Date nowTime = new Date();
            if (ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopHistoryDto.getCreateTime())) {
                inviterUserShareWeekTopHistoryDto.setCreateTime(nowTime);
            }
            if (ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopHistoryDto.getModifyTime())) {
                inviterUserShareWeekTopHistoryDto.setModifyTime(nowTime);
            }
            if (ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopHistoryDto.getModifyUserId())) {
                inviterUserShareWeekTopHistoryDto.setModifyUserId(inviterUserShareWeekTopHistoryDto.getCreateUserId());
            }
            InviterUserShareWeekTopHistory inviterUserShareWeekTopHistory = new InviterUserShareWeekTopHistory();
            ObjectUtils.fastCopy(inviterUserShareWeekTopHistoryDto, inviterUserShareWeekTopHistory);
            inviterUserShareWeekTopHistoryMapper.save(inviterUserShareWeekTopHistory);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }

    }

    @Override
    public void saveBatch(List<InviterUserShareWeekTopHistoryDto> inviterUserShareWeekTopHistoryDtos)
            throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopHistoryDtos)) {
                throw new UserServiceException("没有需要保存的数据");
            }
            for (InviterUserShareWeekTopHistoryDto inviterUserShareWeekTopHistoryDto : inviterUserShareWeekTopHistoryDtos) {
                save(inviterUserShareWeekTopHistoryDto);
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }

    }

    @Override
    public YiLiDiPage<InviterUserShareWeekTopHistoryDto> findInviterUserShareWeekTopHistorys(Integer year, Integer month,
            Integer weekNumber, String revisionBatchCode, Integer pageNo, Integer pageSize) throws UserServiceException {
        try {
            PageHelper.startPage(pageNo, pageSize);
            Page<InviterUserShareWeekTopHistory> page = inviterUserShareWeekTopHistoryMapper
                    .findInviterUserShareWeekTopHistorys(year, month, weekNumber, revisionBatchCode, pageNo, pageSize);
            Page<InviterUserShareWeekTopHistoryDto> pageDto = new Page<InviterUserShareWeekTopHistoryDto>(pageNo, pageSize);
            ObjectUtils.fastCopy(page, pageDto);
            List<InviterUserShareWeekTopHistory> inviterUserShareWeekTopHistoryList = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopHistoryList)) {
                for (InviterUserShareWeekTopHistory inviterUserShareWeekTopHistory : inviterUserShareWeekTopHistoryList) {
                    InviterUserShareWeekTopHistoryDto inviterUserShareWeekTopHistoryDto = new InviterUserShareWeekTopHistoryDto();
                    ObjectUtils.fastCopy(inviterUserShareWeekTopHistory, inviterUserShareWeekTopHistoryDto);
                    pageDto.add(inviterUserShareWeekTopHistoryDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public Integer getRevisionCount(Integer year, Integer month, Integer weekNumber, String userName)
            throws UserServiceException {
        try {
            return inviterUserShareWeekTopHistoryMapper.getRevisionCount(year, month, weekNumber, userName);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

}
