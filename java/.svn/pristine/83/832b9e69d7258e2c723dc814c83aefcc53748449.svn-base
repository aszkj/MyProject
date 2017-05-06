package com.yilidi.o2o.user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.FileUploadUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.UserProfileMapper;
import com.yilidi.o2o.user.model.UserProfile;
import com.yilidi.o2o.user.service.IUserProfileService;
import com.yilidi.o2o.user.service.dto.UserProfileDto;

/**
 * 功能描述：用户Service服务实现类 <br/>
 * 作者： chenl <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("userProfileService")
public class UserProfileServiceImpl extends BasicDataService implements IUserProfileService {

    @Autowired
    private UserProfileMapper userProfileMapper;

    @Override
    public void updateByUserIdSelective(UserProfileDto userProfileDto) {
        try {
            if (ObjectUtils.isNullOrEmpty(userProfileDto) || ObjectUtils.isNullOrEmpty(userProfileDto.getUserId())) {
                throw new UserServiceException("必填参数不能为空");
            }
            UserProfile userProfile = new UserProfile();
            ObjectUtils.fastCopy(userProfileDto, userProfile);
            userProfileMapper.updateByUserIdSelective(userProfile);
            if (!ObjectUtils.isNullOrEmpty(userProfile.getUserImageUrl())) {
                FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
                fileUploadUtils.uploadPublishFile(userProfile.getUserImageUrl());
            }
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

}
