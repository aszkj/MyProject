package com.yilidi.o2o.user.proxy.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.system.proxy.dto.CommunityProxyDto;
import com.yilidi.o2o.user.dao.CommunityMapper;
import com.yilidi.o2o.user.model.Community;
import com.yilidi.o2o.user.proxy.ICommunityProxyService;

/**
 * 功能描述： 小区Service服务实现类 <br/>
 * 作者： chenb <br/>
 * 
 * BugID: <br/>
 * 修改内容： <br/>
 */
@Service("communityProxyService")
public class CommunityProxyServiceImpl extends BasicDataService implements ICommunityProxyService {

    @Autowired
    private CommunityMapper communityMapper;

    @Override
    public CommunityProxyDto loadById(Integer id) throws UserServiceException {
        try {
            Community community = communityMapper.loadById(id);
            CommunityProxyDto communityProxyDto = null;
            if (null != community) {
                communityProxyDto = new CommunityProxyDto();
                ObjectUtils.fastCopy(community, communityProxyDto);
            }
            return communityProxyDto;
        } catch (Exception e) {
            logger.error("loadById异常", e);
            throw new UserServiceException(e.getMessage());
        }
    }
}
