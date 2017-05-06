package com.yilidi.o2o.user.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.ArithUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.InviterUserShareWeekTopMapper;
import com.yilidi.o2o.user.model.InviterUserShareWeekTop;
import com.yilidi.o2o.user.service.IInviterUserShareWeekTopHistoryService;
import com.yilidi.o2o.user.service.IInviterUserShareWeekTopService;
import com.yilidi.o2o.user.service.IUserService;
import com.yilidi.o2o.user.service.dto.InviterUserShareWeekTopDto;
import com.yilidi.o2o.user.service.dto.InviterUserShareWeekTopHistoryDto;

/**
 * 邀请排行榜Service接口实现类
 * 
 * @author: chenb
 * @date: 2016年10月19日 下午2:26:53
 */
@Service("inviterUserShareWeekTopService")
public class InviterUserShareWeekTopServiceImpl extends BasicDataService implements IInviterUserShareWeekTopService {

    @Autowired
    private InviterUserShareWeekTopMapper inviterUserShareWeekTopMapper;
    @Autowired
    private IInviterUserShareWeekTopHistoryService inviterUserShareWeekTopHistoryService;

    @Autowired
    private IUserService userService;

    @Override
    public void save(InviterUserShareWeekTopDto inviterUserShareWeekTopDto) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopDto)
                    || ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopDto.getYear())
                    || ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopDto.getUserName())
                    || ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopDto.getMonth())
                    || ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopDto.getWeekNumber())
                    || ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopDto.getInviterCount())
                    || ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopDto.getCreateUserId())) {
                throw new UserServiceException("required params can not be null");
            }
            String userName = inviterUserShareWeekTopDto.getUserName();
            inviterUserShareWeekTopDto.setUserName(userName);
            inviterUserShareWeekTopDto.setRevisionUserName(userName);
            Date nowTime = new Date();
            if (ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopDto.getCreateTime())) {
                inviterUserShareWeekTopDto.setCreateTime(nowTime);
            }
            if (ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopDto.getModifyTime())) {
                inviterUserShareWeekTopDto.setModifyTime(nowTime);
            }
            if (ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopDto.getModifyUserId())) {
                inviterUserShareWeekTopDto.setModifyUserId(inviterUserShareWeekTopDto.getCreateUserId());
            }
            InviterUserShareWeekTop inviterUserShareWeekTop = new InviterUserShareWeekTop();
            ObjectUtils.fastCopy(inviterUserShareWeekTopDto, inviterUserShareWeekTop);
            inviterUserShareWeekTopMapper.deleteUserRecord(userName, inviterUserShareWeekTopDto.getYear(),
                    inviterUserShareWeekTopDto.getMonth(), inviterUserShareWeekTopDto.getWeekNumber());
            inviterUserShareWeekTopMapper.save(inviterUserShareWeekTop);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void saveBatch(List<InviterUserShareWeekTopDto> inviterUserShareWeekTopDtos) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopDtos)) {
                throw new UserServiceException("列表不能为空");
            }
            for (InviterUserShareWeekTopDto inviterUserShareWeekTopDto : inviterUserShareWeekTopDtos) {
                save(inviterUserShareWeekTopDto);
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<InviterUserShareWeekTopDto> findInviterUserShareWeekTops(Integer year, Integer month,
            Integer weekNumber, Integer pageNo, Integer pageSize) throws UserServiceException {
        try {
            PageHelper.startPage(pageNo, pageSize);
            Page<InviterUserShareWeekTop> page = inviterUserShareWeekTopMapper.findInviterUserShareWeekTops(year, month,
                    weekNumber, pageNo, pageSize);
            Page<InviterUserShareWeekTopDto> pageDto = new Page<InviterUserShareWeekTopDto>(pageNo, pageSize);
            ObjectUtils.fastCopy(page, pageDto);
            List<InviterUserShareWeekTop> inviterUserShareWeekTopList = page.getResult();
            if (!ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopList)) {
                for (InviterUserShareWeekTop inviterUserShareWeekTop : inviterUserShareWeekTopList) {
                    InviterUserShareWeekTopDto inviterUserShareWeekTopDto = new InviterUserShareWeekTopDto();
                    ObjectUtils.fastCopy(inviterUserShareWeekTop, inviterUserShareWeekTopDto);
                    pageDto.add(inviterUserShareWeekTopDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public Integer getInviterUserShareWeekTopsCount(Integer year, Integer month, Integer weekNumber)
            throws UserServiceException {
        try {
            Integer result = inviterUserShareWeekTopMapper.getInviterUserShareWeekTopsCount(year, month, weekNumber);
            return ArithUtils.converIntegerToInt(result);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void updateWeekTopByIntervention(InviterUserShareWeekTopDto inviterUserShareWeekTopDto)
            throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopDto)
                    || ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopDto.getWeekTopDataStr())
                    || ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopDto.getYear())
                    || ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopDto.getMonth())
                    || ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopDto.getWeekNumber())
                    || ObjectUtils.isNullOrEmpty(inviterUserShareWeekTopDto.getCreateUserId())) {
                throw new UserServiceException("没有接收到需要修改的参数");
            }
            Date nowTime = new Date();
            String dataWeekTopDataStr = inviterUserShareWeekTopDto.getWeekTopDataStr();
            String[] dataWeekTopDataStrArr = dataWeekTopDataStr.split(CommonConstants.DELIMITER_SEMICOLON);
            String indexUserName = "";
            List<InviterUserShareWeekTopDto> inviterUserShareWeekTopDtos = new ArrayList<InviterUserShareWeekTopDto>();
            for (String dataWeekTopDataItem : dataWeekTopDataStrArr) {
                String[] dataWeekTopDataItemArr = dataWeekTopDataItem.split(CommonConstants.DELIMITER_COMMA);
                if (dataWeekTopDataItemArr.length != 2) {
                    throw new UserServiceException("参数格式错误");
                }
                if (dataWeekTopDataItemArr[0].equals(indexUserName)) {
                    throw new UserServiceException("存在相同的手机号码");
                }
                indexUserName = dataWeekTopDataItemArr[0];
                InviterUserShareWeekTopDto updateInviterUserShareWeekTopDto = new InviterUserShareWeekTopDto();
                updateInviterUserShareWeekTopDto.setYear(inviterUserShareWeekTopDto.getYear());
                updateInviterUserShareWeekTopDto.setMonth(inviterUserShareWeekTopDto.getMonth());
                updateInviterUserShareWeekTopDto.setWeekNumber(inviterUserShareWeekTopDto.getWeekNumber());
                updateInviterUserShareWeekTopDto.setCreateTime(nowTime);
                updateInviterUserShareWeekTopDto.setModifyTime(nowTime);
                updateInviterUserShareWeekTopDto.setCreateUserId(inviterUserShareWeekTopDto.getCreateUserId());
                updateInviterUserShareWeekTopDto.setModifyUserId(inviterUserShareWeekTopDto.getCreateUserId());
                updateInviterUserShareWeekTopDto.setUserName(dataWeekTopDataItemArr[0]);
                updateInviterUserShareWeekTopDto.setInviterCount(Integer.parseInt(dataWeekTopDataItemArr[1]));
                inviterUserShareWeekTopDtos.add(updateInviterUserShareWeekTopDto);
            }
            Integer revisionCount = ArithUtils.converIntegerToInt(
                    inviterUserShareWeekTopHistoryService.getRevisionCount(inviterUserShareWeekTopDto.getYear(),
                            inviterUserShareWeekTopDto.getMonth(), inviterUserShareWeekTopDto.getWeekNumber(), null));
            if (revisionCount >= 3) {
                throw new UserServiceException("人工干预最多修改三次");
            }
            List<InviterUserShareWeekTopDto> saveUserShareWeekTopDtos = new ArrayList<InviterUserShareWeekTopDto>();
            List<InviterUserShareWeekTopHistoryDto> saveUserShareWeekTopHistoryDtos = new ArrayList<InviterUserShareWeekTopHistoryDto>();
            for (InviterUserShareWeekTopDto inviterUserShareWeekTopDtoParam : inviterUserShareWeekTopDtos) {
                InviterUserShareWeekTopDto saveUserShareWeekTopDto = new InviterUserShareWeekTopDto();
                ObjectUtils.fastCopy(inviterUserShareWeekTopDtoParam, saveUserShareWeekTopDto);
                InviterUserShareWeekTop existsInviterUserShareWeekTop = inviterUserShareWeekTopMapper
                        .loadByUserNameAndYearAndMonthAndWeekNumber(inviterUserShareWeekTopDtoParam.getUserName(),
                                inviterUserShareWeekTopDtoParam.getYear(), inviterUserShareWeekTopDtoParam.getMonth(),
                                inviterUserShareWeekTopDtoParam.getWeekNumber());
                // UserDto userDto = userService.loadUserByNameAndType(saveUserShareWeekTopDto.getUserName(),
                // SystemContext.UserDomain.CUSTOMERTYPE_BUYER);
                // if (ObjectUtils.isNullOrEmpty(userDto)) {
                // throw new UserServiceException("用户：" + saveUserShareWeekTopDto.getUserName() + "不是一里递平台用户");
                // }
                if (ObjectUtils.isNullOrEmpty(existsInviterUserShareWeekTop)) {
                    saveUserShareWeekTopDto.setRevisionUserName(saveUserShareWeekTopDto.getUserName());
                    saveUserShareWeekTopDto.setRevisionInviterCount(saveUserShareWeekTopDto.getInviterCount());
                } else {
                    saveUserShareWeekTopDto.setInviterCount(existsInviterUserShareWeekTop.getInviterCount());
                    saveUserShareWeekTopDto.setRevisionInviterCount(inviterUserShareWeekTopDtoParam.getInviterCount());
                    saveUserShareWeekTopDto.setUserName(existsInviterUserShareWeekTop.getUserName());
                    saveUserShareWeekTopDto.setRevisionUserName(inviterUserShareWeekTopDtoParam.getUserName());
                    saveUserShareWeekTopDto.setCreateTime(existsInviterUserShareWeekTop.getCreateTime());
                    saveUserShareWeekTopDto.setCreateUserId(existsInviterUserShareWeekTop.getCreateUserId());
                }
                saveUserShareWeekTopDtos.add(saveUserShareWeekTopDto);
                InviterUserShareWeekTopHistoryDto inviterUserShareWeekTopHistoryDto = new InviterUserShareWeekTopHistoryDto();
                ObjectUtils.fastCopy(saveUserShareWeekTopDto, inviterUserShareWeekTopHistoryDto);
                inviterUserShareWeekTopHistoryDto.setInviterCount(saveUserShareWeekTopDto.getRevisionInviterCount());
                inviterUserShareWeekTopHistoryDto.setUserName(saveUserShareWeekTopDto.getUserName());
                inviterUserShareWeekTopHistoryDto.setRevisionBatchCode(getNextRevisionBatchCode(revisionCount));
                saveUserShareWeekTopHistoryDtos.add(inviterUserShareWeekTopHistoryDto);
            }
            saveBatch(saveUserShareWeekTopDtos);
            inviterUserShareWeekTopHistoryService.saveBatch(saveUserShareWeekTopHistoryDtos);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }

    }

    private String getRevisionBatchCode(Integer revisionCount) {
        if (ObjectUtils.isNullOrEmpty(revisionCount)) {
            return SystemContext.UserDomain.INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE_FIRST;
        }
        switch (revisionCount) {
        case 1:
            return SystemContext.UserDomain.INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE_FIRST;
        case 2:
            return SystemContext.UserDomain.INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE_SECOND;
        case 3:
            return SystemContext.UserDomain.INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE_THIRD;
        case 4:
            return SystemContext.UserDomain.INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE_FOURTH;
        }
        return SystemContext.UserDomain.INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE_FIRST;
    }

    private String getNextRevisionBatchCode(Integer revisionCount) {
        if (ObjectUtils.isNullOrEmpty(revisionCount)) {
            return SystemContext.UserDomain.INVITERUSERSHAREWEEKTOPHISTORYREVISIONBATCHCODE_FIRST;
        }
        Integer nextRevisionCount = revisionCount + 1;
        return getRevisionBatchCode(nextRevisionCount);
    }
}
