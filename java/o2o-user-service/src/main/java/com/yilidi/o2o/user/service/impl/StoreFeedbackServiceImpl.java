package com.yilidi.o2o.user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.StoreFeedbackMapper;
import com.yilidi.o2o.user.model.StoreFeedback;
import com.yilidi.o2o.user.service.IStoreFeedbackService;
import com.yilidi.o2o.user.service.dto.StoreFeedbackDto;

/**
 * @Description: TODO(店铺意见反馈Service实现类)
 * @author: chenlian
 * @date: 2016年6月21日 上午12:05:08
 */
@Service("storeFeedbackService")
public class StoreFeedbackServiceImpl extends BasicDataService implements IStoreFeedbackService {

    @Autowired
    private StoreFeedbackMapper storeFeedbackMapper;

    @Override
    public void save(StoreFeedbackDto storeFeedbackDto) throws UserServiceException {
        String msg = null;
        try {
            if (ObjectUtils.isNullOrEmpty(storeFeedbackDto)) {
                msg = "storeFeedbackDto为空";
                logger.error(msg);
                throw new UserServiceException(msg);
            }
            StoreFeedback storeFeedback = new StoreFeedback();
            ObjectUtils.fastCopy(storeFeedbackDto, storeFeedback);
            storeFeedbackMapper.save(storeFeedback);
        } catch (Exception e) {
            msg = null == msg ? "新增店铺意见反馈出现系统异常" : msg;
            logger.error(msg, e);
            throw new UserServiceException(msg);
        }
    }

}
