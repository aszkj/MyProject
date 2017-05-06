package com.yilidi.o2o.user.service.dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.yilidi.o2o.core.model.BaseDto;

/**
 * 分享规则DTO
 * 
 * @author: chenb
 * @date: 2016年10月18日 下午5:53:42
 */
public class ShareRuleDto extends BaseDto {

    private static final long serialVersionUID = 4220452265775389799L;
    /**
     * ID，主键自增
     */
    private Integer id;
    /**
     * 分享规则名称
     */
    private String shareRuleName;
    /**
     * 有效开始时间
     */
    private Date startValidTime;
    /**
     * 有效结束时间
     */
    private Date endValidTime;
    /**
     * 角色类型,关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SHARERULEROLETYPE)
     */
    private String roleType;
    /**
     * 角色名称
     */
    private String roleTypeName;

    /**
     * 邀请人限制条件,关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SHARERULEINVITERCONDITIONTYPE)
     */
    private String inviterConditionType;
    /**
     * 邀请人限制条件名称
     */
    private String inviterConditionTypeName;
    /**
     * 被邀请人限制条件,关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SHARERULEINVITEDCONDITIONTYPE)
     */
    private String invitedConditionType;
    /**
     * 被邀请人限制条件名称
     */
    private String invitedConditionTypeName;
    /**
     * 被邀请人条件设置商品ID,多个以逗号隔开
     */
    private String invitedUseProduct;
    /**
     * 邀请人条件设置商品ID,多个以逗号隔开
     */
    private String inviterUseProduct;
    /**
     * 被邀请人条件设置商品ID,多个以逗号隔开
     */
    private String invitedUseProductName;
    /**
     * 邀请人条件设置商品ID,多个以逗号隔开
     */
    private String inviterUseProductName;
    /**
     * 邀请人奖励类型,关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SHARERULEAWARDTYPE)
     */
    private String inviterAwardType;
    /**
     * 邀请人奖励类型名称
     */
    private String inviterAwardTypeName;
    /**
     * 被邀请人奖励类型,关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SHARERULEAWARDTYPE)
     */
    private String invitedAwardType;
    /**
     * 被邀请人奖励类型名称
     */
    private String invitedAwardTypeName;
    
    /**
     * 邀请人奖励
     */
    private String inviterAward;
    /**
     * 被邀请人奖励
     */
    private String invitedAward;

    /**
     * 有效状态,关联系统域系统字典S_SYSTEM_DICT中的DICTCODE字段(DICTTYPE=SHARERULESTATUS)
     */
    private String status;
    /**
     * 状态名称
     */
    private String statusName;
    /**
     * 分享规则领取对应的h5页面地址
     */
    private String h5DrawUrl;
    /**
     * 分享活动规则说明页面URL
     */
    private String descriptionUrl;
    /**
     * 短信分享内容
     */
    private String smsContent;
    /**
     * 微信好友分享标题
     */
    private String friendTitle;
    /**
     * 微信好友分享内容
     */
    private String friendContent;
    /**
     * 分享背景图片地址
     */
    private String backgroundImageUrl;
    /**
     * 分享背景全部图片地址
     */
    private String fullBackgroundImageUrl;

    /**
     * 头像高度,单位:像素
     */
    private Integer avatarHeight;
    /**
     * 手机号码高度
     */
    private Integer mobileHeight;
    /**
     * 二维码高度
     */
    private Integer qrCodeHeight;
    /**
     * 分享背景图片标识（IMAGEFLAG_YES：本地刚上传的图片 ，IMAGEFLAG_NO：数据库中已有的图片）
     */
    private String imageFlag;
    /**
     * 被删除的分享图片URL
     */
    private String delImageUrl;

    /**
     * 创建记录用户ID
     */
    private Integer createUserId;
    /**
     * 创建记录时间
     */
    private Date createTime;
    /**
     * 最后操作用户ID
     */
    private Integer modifyUserId;
    /**
     * 最后操作记录时间
     */
    private Date modifyTime;
    /**
     * 活动开始时间,字符串
     */
    private String strStartValidTime;
    /**
     * 活动结束时间,字符串
     */
    private String strEndValidTime;
    /**
     * 用户分享码
     */
    private String shareCode;
    /**
     * 组装分享规则中邀请人优惠券信息
     */
    private List<Map<String, Object>> inviterCouponInfos = new ArrayList<Map<String, Object>>();
    /**
     * 组装分享规则中被邀请人优惠券信息
     */
    private List<Map<String, Object>> invitedCouponInfos = new ArrayList<Map<String, Object>>();

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getShareRuleName() {
        return shareRuleName;
    }

    public void setShareRuleName(String shareRuleName) {
        this.shareRuleName = shareRuleName;
    }

    public Date getStartValidTime() {
        return startValidTime;
    }

    public void setStartValidTime(Date startValidTime) {
        this.startValidTime = startValidTime;
    }

    public Date getEndValidTime() {
        return endValidTime;
    }

    public void setEndValidTime(Date endValidTime) {
        this.endValidTime = endValidTime;
    }

    public String getRoleType() {
        return roleType;
    }

    public void setRoleType(String roleType) {
        this.roleType = roleType;
    }

    public String getInviterConditionType() {
        return inviterConditionType;
    }

    public void setInviterConditionType(String inviterConditionType) {
        this.inviterConditionType = inviterConditionType;
    }

    public String getInviterConditionTypeName() {
        return inviterConditionTypeName;
    }

    public void setInviterConditionTypeName(String inviterConditionTypeName) {
        this.inviterConditionTypeName = inviterConditionTypeName;
    }

    public String getInvitedConditionType() {
        return invitedConditionType;
    }

    public void setInvitedConditionType(String invitedConditionType) {
        this.invitedConditionType = invitedConditionType;
    }

    public String getInvitedConditionTypeName() {
        return invitedConditionTypeName;
    }

    public void setInvitedConditionTypeName(String invitedConditionTypeName) {
        this.invitedConditionTypeName = invitedConditionTypeName;
    }

    public String getInvitedUseProduct() {
        return invitedUseProduct;
    }

    public void setInvitedUseProduct(String invitedUseProduct) {
        this.invitedUseProduct = invitedUseProduct;
    }

    public String getInviterUseProduct() {
        return inviterUseProduct;
    }

    public void setInviterUseProduct(String inviterUseProduct) {
        this.inviterUseProduct = inviterUseProduct;
    }

    public String getInvitedUseProductName() {
        return invitedUseProductName;
    }

    public void setInvitedUseProductName(String invitedUseProductName) {
        this.invitedUseProductName = invitedUseProductName;
    }

    public String getInviterUseProductName() {
        return inviterUseProductName;
    }

    public void setInviterUseProductName(String inviterUseProductName) {
        this.inviterUseProductName = inviterUseProductName;
    }

    public String getInviterAwardType() {
        return inviterAwardType;
    }

    public void setInviterAwardType(String inviterAwardType) {
        this.inviterAwardType = inviterAwardType;
    }

    public String getInviterAwardTypeName() {
        return inviterAwardTypeName;
    }

    public void setInviterAwardTypeName(String inviterAwardTypeName) {
        this.inviterAwardTypeName = inviterAwardTypeName;
    }

    public String getInvitedAwardType() {
        return invitedAwardType;
    }

    public void setInvitedAwardType(String invitedAwardType) {
        this.invitedAwardType = invitedAwardType;
    }

    public String getInvitedAwardTypeName() {
        return invitedAwardTypeName;
    }

    public void setInvitedAwardTypeName(String invitedAwardTypeName) {
        this.invitedAwardTypeName = invitedAwardTypeName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Integer createUserId) {
        this.createUserId = createUserId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getModifyUserId() {
        return modifyUserId;
    }

    public void setModifyUserId(Integer modifyUserId) {
        this.modifyUserId = modifyUserId;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    public String getStrStartValidTime() {
        return strStartValidTime;
    }

    public void setStrStartValidTime(String strStartValidTime) {
        this.strStartValidTime = strStartValidTime;
    }

    public String getStrEndValidTime() {
        return strEndValidTime;
    }

    public void setStrEndValidTime(String strEndValidTime) {
        this.strEndValidTime = strEndValidTime;
    }

    public String getRoleTypeName() {
        return roleTypeName;
    }

    public void setRoleTypeName(String roleTypeName) {
        this.roleTypeName = roleTypeName;
    }

    public String getStatusName() {
        return statusName;
    }

    public void setStatusName(String statusName) {
        this.statusName = statusName;
    }

    public String getH5DrawUrl() {
        return h5DrawUrl;
    }

    public void setH5DrawUrl(String h5DrawUrl) {
        this.h5DrawUrl = h5DrawUrl;
    }

    public String getDescriptionUrl() {
        return descriptionUrl;
    }

    public void setDescriptionUrl(String descriptionUrl) {
        this.descriptionUrl = descriptionUrl;
    }

    public String getSmsContent() {
        return smsContent;
    }

    public void setSmsContent(String smsContent) {
        this.smsContent = smsContent;
    }

    public String getFriendTitle() {
        return friendTitle;
    }

    public void setFriendTitle(String friendTitle) {
        this.friendTitle = friendTitle;
    }

    public String getFriendContent() {
        return friendContent;
    }

    public void setFriendContent(String friendContent) {
        this.friendContent = friendContent;
    }

    public String getBackgroundImageUrl() {
        return backgroundImageUrl;
    }

    public void setBackgroundImageUrl(String backgroundImageUrl) {
        this.backgroundImageUrl = backgroundImageUrl;
    }

    public Integer getAvatarHeight() {
        return avatarHeight;
    }

    public void setAvatarHeight(Integer avatarHeight) {
        this.avatarHeight = avatarHeight;
    }

    public Integer getMobileHeight() {
        return mobileHeight;
    }

    public void setMobileHeight(Integer mobileHeight) {
        this.mobileHeight = mobileHeight;
    }

    public Integer getQrCodeHeight() {
        return qrCodeHeight;
    }

    public void setQrCodeHeight(Integer qrCodeHeight) {
        this.qrCodeHeight = qrCodeHeight;
    }

    public String getImageFlag() {
        return imageFlag;
    }

    public void setImageFlag(String imageFlag) {
        this.imageFlag = imageFlag;
    }

    public String getDelImageUrl() {
        return delImageUrl;
    }

    public void setDelImageUrl(String delImageUrl) {
        this.delImageUrl = delImageUrl;
    }

    public String getFullBackgroundImageUrl() {
        return fullBackgroundImageUrl;
    }

    public void setFullBackgroundImageUrl(String fullBackgroundImageUrl) {
        this.fullBackgroundImageUrl = fullBackgroundImageUrl;
    }

    public String getShareCode() {
        return shareCode;
    }

    public void setShareCode(String shareCode) {
        this.shareCode = shareCode;
    }

	public String getInviterAward() {
		return inviterAward;
	}

	public void setInviterAward(String inviterAward) {
		this.inviterAward = inviterAward;
	}

	public String getInvitedAward() {
		return invitedAward;
	}

	public void setInvitedAward(String invitedAward) {
		this.invitedAward = invitedAward;
	}

	public List<Map<String, Object>> getInviterCouponInfos() {
		return inviterCouponInfos;
	}

	public void setInviterCouponInfos(List<Map<String, Object>> inviterCouponInfos) {
		this.inviterCouponInfos = inviterCouponInfos;
	}

	public List<Map<String, Object>> getInvitedCouponInfos() {
		return invitedCouponInfos;
	}

	public void setInvitedCouponInfos(List<Map<String, Object>> invitedCouponInfos) {
		this.invitedCouponInfos = invitedCouponInfos;
	}

}
