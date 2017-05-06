package com.yilidi.o2o.order.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.OrderServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.order.dao.SmallTableUserInfoMapper;
import com.yilidi.o2o.order.model.SmallTableUserInfo;
import com.yilidi.o2o.order.service.ISmallTableUserInfoService;
import com.yilidi.o2o.order.service.dto.SmallTableUserInfoDto;
import com.yilidi.o2o.service.BasicDataService;

/**
 * 用户信息小表Service实现类
 * 
 * @author: chenlian
 * @date: 2016年8月11日 下午11:09:39
 */
@Service("smallTableUserInfoService")
public class SmallTableUserInfoServiceImpl extends BasicDataService implements ISmallTableUserInfoService {

    @Autowired
    private SmallTableUserInfoMapper smallTableUserInfoMapper;

    @Override
    public void save(SmallTableUserInfoDto smallTableUserInfoDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(smallTableUserInfoDto)) {
                throw new OrderServiceException("参数smallTableUserInfoDto不能为空");
            }
            SmallTableUserInfo smallTableUserInfo = new SmallTableUserInfo();
            ObjectUtils.fastCopy(smallTableUserInfoDto, smallTableUserInfo);
            smallTableUserInfoMapper.save(smallTableUserInfo);
        } catch (Exception e) {
            logger.error("save异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public void updateByUserId(SmallTableUserInfoDto smallTableUserInfoDto) throws OrderServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(smallTableUserInfoDto)) {
                throw new OrderServiceException("参数smallTableUserInfoDto不能为空");
            }
            SmallTableUserInfo smallTableUserInfo = new SmallTableUserInfo();
            ObjectUtils.fastCopy(smallTableUserInfoDto, smallTableUserInfo);
            smallTableUserInfoMapper.updateByUserId(smallTableUserInfo);
        } catch (Exception e) {
            logger.error("updateByUserId异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public SmallTableUserInfoDto loadByUserId(Integer userId) throws OrderServiceException {
        SmallTableUserInfoDto smallTableUserInfoDto = null;
        try {
            if (ObjectUtils.isNullOrEmpty(userId)) {
                throw new OrderServiceException("参数userId不能为空");
            }
            SmallTableUserInfo smallTableUserInfo = smallTableUserInfoMapper.loadByUserId(userId);
            if (!ObjectUtils.isNullOrEmpty(smallTableUserInfo)) {
                smallTableUserInfoDto = new SmallTableUserInfoDto();
                ObjectUtils.fastCopy(smallTableUserInfo, smallTableUserInfoDto);
            }
            return smallTableUserInfoDto;
        } catch (Exception e) {
            logger.error("loadByUserId异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

    @Override
    public List<SmallTableUserInfoDto> listByCustomerId(Integer customerId) throws OrderServiceException {
        List<SmallTableUserInfoDto> smallTableUserInfoDtoList = null;
        try {
            if (ObjectUtils.isNullOrEmpty(customerId)) {
                throw new OrderServiceException("参数customerId不能为空");
            }
            List<SmallTableUserInfo> smallTableUserInfoList = smallTableUserInfoMapper.listByCustomerId(customerId);
            if (!ObjectUtils.isNullOrEmpty(smallTableUserInfoList)) {
                smallTableUserInfoDtoList = new ArrayList<SmallTableUserInfoDto>();
                for (SmallTableUserInfo smallTableUserInfo : smallTableUserInfoList) {
                    SmallTableUserInfoDto smallTableUserInfoDto = new SmallTableUserInfoDto();
                    ObjectUtils.fastCopy(smallTableUserInfo, smallTableUserInfoDto);
                    smallTableUserInfoDtoList.add(smallTableUserInfoDto);
                }
            }
            return smallTableUserInfoDtoList;
        } catch (Exception e) {
            logger.error("listByCustomerId异常", e);
            throw new OrderServiceException(e.getMessage());
        }
    }

}
