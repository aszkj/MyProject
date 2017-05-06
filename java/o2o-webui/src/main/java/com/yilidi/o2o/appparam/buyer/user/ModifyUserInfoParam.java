package com.yilidi.o2o.appparam.buyer.user;

import java.util.ArrayList;
import java.util.List;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 修改用户信息接收参数
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class ModifyUserInfoParam extends AppBaseParam {

    private static final long serialVersionUID = -8811736006733663717L;
    private static final String USERSEX_PATTERN = "^(1|2)$";
    @Field("出生日期")
    private String birthday;
    @Field("性别")
    private Integer userSex;
    @Field("用户昵称")
    private String nickName;
    @Field("头像地址")
    private String userImageUrl;

    public void validateParams() {
        if (ObjectUtils.isNullOrEmpty(birthday) && ObjectUtils.isNullOrEmpty(userSex)
                && ObjectUtils.isNullOrEmpty(userImageUrl) && ObjectUtils.isNullOrEmpty(nickName)) {
            throw new IllegalArgumentException("argument cant not be null");
        }
        List<Param> params = new ArrayList<Param>(4);
        if (!ObjectUtils.isNullOrEmpty(birthday)) {
            Param param = new Param.Builder(getFieldName("birthday"), Param.ParamType.STR_DATE.getType(), birthday, false)
                    .build();
            params.add(param);
        }
        if (!ObjectUtils.isNullOrEmpty(userSex)) {
            Param param = new Param.Builder(getFieldName("userSex"), Param.ParamType.STR_INTEGER.getType(), userSex, false)
                    .regex(USERSEX_PATTERN).build();
            params.add(param);
        }
        if (!ObjectUtils.isNullOrEmpty(nickName)) {
            Param param = new Param.Builder(getFieldName("nickName"), Param.ParamType.STR_NORMAL.getType(), nickName, false)
                    .build();
            params.add(param);
        }
        if (!ObjectUtils.isNullOrEmpty(userImageUrl)) {
            Param param = new Param.Builder(getFieldName("userImageUrl"), Param.ParamType.STR_NORMAL.getType(), userImageUrl,
                    false).build();
            params.add(param);
        }
        if (!ObjectUtils.isNullOrEmpty(params)) {
            ParamValidateUtils.validateParams(params.toArray(new Param[params.size()]));
        }
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public Integer getUserSex() {
        return userSex;
    }

    public void setUserSex(Integer userSex) {
        this.userSex = userSex;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getUserImageUrl() {
        return userImageUrl;
    }

    public void setUserImageUrl(String userImageUrl) {
        this.userImageUrl = userImageUrl;
    }

}
