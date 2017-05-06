package com.yilidi.o2o.user.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.RecommendCustomerStoreMapper;
import com.yilidi.o2o.user.model.RecommendCustomerStore;
import com.yilidi.o2o.user.service.IRecommendCustomerStoreService;
import com.yilidi.o2o.user.service.dto.RecommendCustomerStoreDto;

@Service("recommendCustomerStoreService")
public class RecommendCustomerStoreServiceImpl extends BasicDataService implements IRecommendCustomerStoreService {

    @Autowired
    private RecommendCustomerStoreMapper recommendCustomerStoreMapper;

    @Override
    public void save(RecommendCustomerStoreDto recommendCustomerStoreDto) throws UserServiceException {
        String msg = null;
        try {
            if (ObjectUtils.isNullOrEmpty(recommendCustomerStoreDto)) {
                msg = "recommendCustomerStoreDto为空";
                logger.error(msg);
                throw new UserServiceException(msg);
            }
            Integer storeId = loadStoreIdByRecommendCustomerId(recommendCustomerStoreDto.getRecommendCustomerId());
            if (null != storeId) {
                deleteByRecommendCustomerId(recommendCustomerStoreDto.getRecommendCustomerId());
            }
            if (null != recommendCustomerStoreDto.getStoreId()) {
                RecommendCustomerStore recommendCustomerStore = new RecommendCustomerStore();
                ObjectUtils.fastCopy(recommendCustomerStoreDto, recommendCustomerStore);
                recommendCustomerStoreMapper.save(recommendCustomerStore);
            }
        } catch (Exception e) {
            msg = null == msg ? "新增推广客户与店铺关联关系出现系统异常" : msg;
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    @Override
    public void deleteByRecommendCustomerId(Integer recommendCustomerId) throws UserServiceException {
        String msg = null;
        try {
            if (ObjectUtils.isNullOrEmpty(recommendCustomerId)) {
                msg = "recommendCustomerId为空";
                logger.error(msg);
                throw new UserServiceException(msg);
            }
            recommendCustomerStoreMapper.deleteByRecommendCustomerId(recommendCustomerId);
        } catch (Exception e) {
            msg = null == msg ? "根据推广客户ID删除推广客户与店铺关联关系出现系统异常" : msg;
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    @Override
    public List<Integer> listRecommendCustomerIdsByStoreId(Integer storeId) throws UserServiceException {
        String msg = null;
        List<Integer> recommendCustomerIds = null;
        try {
            if (ObjectUtils.isNullOrEmpty(storeId)) {
                msg = "storeId为空";
                logger.error(msg);
                throw new UserServiceException(msg);
            }
            recommendCustomerIds = recommendCustomerStoreMapper.listRecommendCustomerIdsByStoreId(storeId);
            return recommendCustomerIds;
        } catch (Exception e) {
            msg = null == msg ? "根据店铺ID获取该店铺所关联的所有推广客户ID列表出现系统异常" : msg;
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

    @Override
    public Integer loadStoreIdByRecommendCustomerId(Integer recommendCustomerId) throws UserServiceException {
        String msg = null;
        Integer storeId = null;
        try {
            if (ObjectUtils.isNullOrEmpty(recommendCustomerId)) {
                msg = "recommendCustomerId为空";
                logger.error(msg);
                throw new UserServiceException(msg);
            }
            storeId = recommendCustomerStoreMapper.loadStoreIdByRecommendCustomerId(recommendCustomerId);
            return storeId;
        } catch (Exception e) {
            msg = null == msg ? "根据推广客户ID获取该推广客户所关联的店铺ID出现系统异常" : msg;
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

}
