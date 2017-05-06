package com.yilidi.o2o.appparam.buyer.user;

import com.yilidi.o2o.appparam.AppBaseParam;
import com.yilidi.o2o.common.annotation.Field;
import com.yilidi.o2o.core.paramvalidate.build.Param;
import com.yilidi.o2o.core.utils.ParamValidateUtils;

/**
 * 分享送好礼新用户领取注册信息
 * 
 * @author: chenb
 * @date: 2016年6月1日 上午10:52:51
 */
public class AcceptInviteParam extends AppBaseParam {

    private static final long serialVersionUID = -1423261469541676825L;

    @Field("微信唯一标识码")
    private String code;
    @Field("分享码")
    private String shareCode;
    @Field("邀请人手机号")
    private String mobile;

    public void validateParams() {
        Param shareCodeValidate = new Param.Builder(getFieldName("shareCode"), Param.ParamType.STR_NORMAL.getType(),
                shareCode, false).build();
        Param codeValidate = new Param.Builder(getFieldName("code"), Param.ParamType.STR_NORMAL.getType(), code, false)
                .build();
        Param mobileValidate = new Param.Builder(getFieldName("mobile"), Param.ParamType.STR_MOBILE.getType(), mobile, false)
                .build();
        ParamValidateUtils.validateParams(shareCodeValidate, codeValidate, mobileValidate);
    }

    public String getShareCode() {
        return shareCode;
    }

    public void setShareCode(String shareCode) {
        this.shareCode = shareCode;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

}
