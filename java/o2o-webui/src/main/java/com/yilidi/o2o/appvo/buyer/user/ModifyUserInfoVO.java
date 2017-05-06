package com.yilidi.o2o.appvo.buyer.user;

import com.yilidi.o2o.appvo.AppBaseVO;

/**
 * 修改用户信息
 * 
 * @author: chenb
 * @date: 2016年5月25日 下午2:26:21
 */
public class ModifyUserInfoVO extends AppBaseVO {

    private static final long serialVersionUID = -7160803333454602609L;

    /**
     * 用户头像地址
     */
    private String userImageUrl;

    public String getUserImageUrl() {
        return userImageUrl;
    }

    public void setUserImageUrl(String userImageUrl) {
        this.userImageUrl = userImageUrl;
    }

}
