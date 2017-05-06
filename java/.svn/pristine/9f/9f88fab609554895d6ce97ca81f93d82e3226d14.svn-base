package com.yilidi.o2o.user.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.yilidi.o2o.core.CommonConstants;
import com.yilidi.o2o.core.SystemContext;
import com.yilidi.o2o.core.exception.ProductServiceException;
import com.yilidi.o2o.core.exception.UserServiceException;
import com.yilidi.o2o.core.page.YiLiDiPage;
import com.yilidi.o2o.core.page.YiLiDiPageUtils;
import com.yilidi.o2o.core.utils.DateUtils;
import com.yilidi.o2o.core.utils.FileUploadUtils;
import com.yilidi.o2o.core.utils.ObjectUtils;
import com.yilidi.o2o.core.utils.StringUtils;
import com.yilidi.o2o.order.proxy.ICouponProxyService;
import com.yilidi.o2o.order.proxy.IUserCouponProxyService;
import com.yilidi.o2o.order.proxy.dto.CouponProxyDto;
import com.yilidi.o2o.product.proxy.IProductProxyService;
import com.yilidi.o2o.product.proxy.dto.ProductProxyDto;
import com.yilidi.o2o.service.BasicDataService;
import com.yilidi.o2o.user.dao.ShareRuleMapper;
import com.yilidi.o2o.user.model.ShareRule;
import com.yilidi.o2o.user.model.query.ShareRuleQuery;
import com.yilidi.o2o.user.service.IShareRuleService;
import com.yilidi.o2o.user.service.dto.ShareRuleDto;
import com.yilidi.o2o.user.service.dto.query.ShareRuleQueryDto;

/**
 * 分享规则Service接口实现类
 * 
 * @author: chenb
 * @date: 2016年10月19日 下午2:26:53
 */
@Service("shareRuleService")
public class ShareRuleServiceImpl extends BasicDataService implements IShareRuleService {

    private static final String IMAGEFLAG_YES = "IMAGEFLAG_YES";

    @Autowired
    private ShareRuleMapper shareRuleMapper;
    @Autowired
    private IProductProxyService productProxyService;
    @Autowired
    private IUserCouponProxyService userCouponProxyService;
    @Autowired
    private ICouponProxyService couponProxyService;

    @Override
    public void saveShareRule(ShareRuleDto shareRuleDto) throws UserServiceException {
        try {
            Date nowTime = new Date();
            if (ObjectUtils.isNullOrEmpty(shareRuleDto)) {
                throw new UserServiceException("规则信息不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getShareRuleName())) {
                throw new UserServiceException("规则名称不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getStartValidTime())
                    || ObjectUtils.isNullOrEmpty(shareRuleDto.getEndValidTime())) {
                throw new UserServiceException("活动时间不能为空");
            }
            if (!shareRuleDto.getEndValidTime().after(shareRuleDto.getStartValidTime())) {
                throw new UserServiceException("不是有效的活动时间范围");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getRoleType())) {
                throw new UserServiceException("角色类型不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getCreateUserId())) {
                throw new UserServiceException("操作用户ID不能为空");
            }
            if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInviterAwardType())
                    && ObjectUtils.isNullOrEmpty(shareRuleDto.getInviterConditionType())) {
                throw new UserServiceException("邀请人条件设置不能为空");
            }
            if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedAwardType())
                    && ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedConditionType())) {
                throw new UserServiceException("被邀请人条件设置不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getH5DrawUrl())) {
                throw new UserServiceException("分享规则h5页面地址不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getAvatarHeight())) {
                throw new UserServiceException("头像高度不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getMobileHeight())) {
                throw new UserServiceException("手机号码高度不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getQrCodeHeight())) {
                throw new UserServiceException("二维码高度不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getSmsContent())) {
                throw new UserServiceException("短信分享内容不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getFriendTitle())) {
                throw new UserServiceException("微信好友分享标题不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getFriendContent())) {
                throw new UserServiceException("微信好友分享内容不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getCreateTime())) {
                shareRuleDto.setCreateTime(nowTime);
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getModifyTime())) {
                shareRuleDto.setModifyTime(nowTime);
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getModifyUserId())) {
                shareRuleDto.setModifyUserId(shareRuleDto.getCreateUserId());
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getStatus())) {
                shareRuleDto.setStatus(SystemContext.UserDomain.SHARERULESTATUS_NORMAL);
            }
            if (SystemContext.UserDomain.SHARERULEAWARDTYPE_CASH.equals(shareRuleDto.getInvitedAwardType())) {
                if (ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedAward())) {
                    throw new UserServiceException("被邀请人现金不能为空");
                }
            }
            if (SystemContext.UserDomain.SHARERULEAWARDTYPE_CASH.equals(shareRuleDto.getInviterAwardType())) {
                if (ObjectUtils.isNullOrEmpty(shareRuleDto.getInviterAward())) {
                    throw new UserServiceException("邀请人现金不能为空");
                }
            }
            if (SystemContext.UserDomain.SHARERULEAWARDTYPE_COUPON.equals(shareRuleDto.getInvitedAwardType())) {
            	if(ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedAward())){
            		throw new UserServiceException("被邀请人优惠券不能为空");
            	}
                CouponProxyDto couponProxyDto = null;
                String[] invitedAwardArrays = shareRuleDto.getInvitedAward().split(";");
                String[] awardArrays = null;
                String invitedAward = "";
                for (String invitedAwardArray : invitedAwardArrays) {
                	awardArrays = invitedAwardArray.split(",");
                	couponProxyDto = userCouponProxyService.loadByCouponId(Integer.parseInt(awardArrays[0]));
                	if (ObjectUtils.isNullOrEmpty(couponProxyDto)) {
                        throw new UserServiceException("被邀请人优惠券不存在");
                    }
                	if(!("").equals(invitedAward)){
                		invitedAward += ";";
                	}
                	invitedAward += awardArrays[0] +","+ couponProxyDto.getAmount() +","+ awardArrays[1];
				}
                if(!("").equals(invitedAward)){
                	shareRuleDto.setInvitedAward(invitedAward);
            	}
            }
            if (SystemContext.UserDomain.SHARERULEAWARDTYPE_COUPON.equals(shareRuleDto.getInviterAwardType())) {
            	if(ObjectUtils.isNullOrEmpty(shareRuleDto.getInviterAward())){
            		throw new UserServiceException("被邀请人优惠券不能为空");
            	}
            	CouponProxyDto couponProxyDto = null;
                String[] inviterAwardArrays = shareRuleDto.getInviterAward().split(";");
                String[] awardArrays = null;
                String inviterAward = "";
                for (String inviterAwardArray : inviterAwardArrays) {
                	awardArrays = inviterAwardArray.split(",");
                	couponProxyDto = userCouponProxyService.loadByCouponId(Integer.parseInt(awardArrays[0]));
                	if (ObjectUtils.isNullOrEmpty(couponProxyDto)) {
                        throw new UserServiceException("被邀请人优惠券不存在");
                    }
                	if(!("").equals(inviterAward)){
                		inviterAward += ";";
                	}
                	inviterAward += awardArrays[0] +","+ couponProxyDto.getAmount() +","+ awardArrays[1];
				}
                if(!("").equals(inviterAward)){
                	shareRuleDto.setInviterAward(inviterAward);
            	}
            }
            if (SystemContext.UserDomain.SHARERULEAWARDTYPE_POINTS.equals(shareRuleDto.getInvitedAwardType())) {
                if (ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedAward())) {
                    throw new UserServiceException("被邀请人积分不能为空");
                }
                if (Integer.parseInt(shareRuleDto.getInvitedAward()) < 0) {
                    throw new UserServiceException("被邀请人积分不合法");
                }
            }
            if (SystemContext.UserDomain.SHARERULEAWARDTYPE_POINTS.equals(shareRuleDto.getInviterAwardType())) {
                if (ObjectUtils.isNullOrEmpty(shareRuleDto.getInviterAward())) {
                    throw new UserServiceException("邀请人积分不能为空");
                }
                if (Integer.parseInt(shareRuleDto.getInviterAward()) < 0) {
                    throw new UserServiceException("邀请人积分不合法");
                }
            }
            List<ShareRule> existsShareRuleList = shareRuleMapper.listByValidTime(shareRuleDto.getStartValidTime(),
                    shareRuleDto.getEndValidTime(), SystemContext.UserDomain.SHARERULESTATUS_OFF);
            if (!ObjectUtils.isNullOrEmpty(existsShareRuleList)) {
                throw new UserServiceException("活动时间范围内存在分享规则");
            }
            ShareRule shareRule = new ShareRule();
            ObjectUtils.fastCopy(shareRuleDto, shareRule);
            shareRuleMapper.save(shareRule);
            operateImage(shareRuleDto.getImageFlag(), shareRuleDto.getDelImageUrl(), shareRuleDto.getBackgroundImageUrl());
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    private void operateImage(String imageFlag, String delImageUrl, String classImageUrl) throws ProductServiceException {
        try {
            FileUploadUtils fileUploadUtils = FileUploadUtils.getInstance();
            if (!ObjectUtils.isNullOrEmpty(imageFlag) && IMAGEFLAG_YES.equals(imageFlag)) {
                fileUploadUtils.uploadPublishFile(classImageUrl);
            }
            if (!ObjectUtils.isNullOrEmpty(delImageUrl)) {
                fileUploadUtils.deletePublishFile(delImageUrl);
            }
        } catch (ProductServiceException e) {
            logger.error("operateImage异常", e);
            throw new ProductServiceException(e.getMessage());
        }
    }

    @Override
    public void updateShareRule(ShareRuleDto shareRuleDto) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(shareRuleDto)) {
                throw new UserServiceException("规则信息不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getId())) {
                throw new UserServiceException("规则ID不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getShareRuleName())) {
                throw new UserServiceException("规则名称不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getModifyUserId())) {
                throw new UserServiceException("操作用户不能为空");
            }
            Date nowTime = new Date();
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getModifyTime())) {
                shareRuleDto.setModifyTime(nowTime);
            }
            ShareRule shareRule = shareRuleMapper.loadById(shareRuleDto.getId());
            if (ObjectUtils.isNullOrEmpty(shareRule)) {
                throw new UserServiceException("此分享规则不存在");
            }
            if (nowTime.after(shareRule.getEndValidTime())) {
                throw new UserServiceException("分享规则已无效不能编辑");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleDto.getEndValidTime())) {
                throw new UserServiceException("活动结束时间不能为空");
            }
            if (shareRule.getEndValidTime().before(nowTime)) {
                throw new UserServiceException("无效的规则不能编辑");
            }
            if (shareRule.getStartValidTime().before(nowTime)) {
                // 已开始只能修改名称和结束时间
                if (shareRuleDto.getEndValidTime().before(shareRule.getStartValidTime())) {
                    throw new UserServiceException("活动结束时间不能小于开始时间");
                }
                List<ShareRule> existsShareRuleList = shareRuleMapper.listByValidTime(shareRule.getStartValidTime(),
                        shareRuleDto.getEndValidTime(), SystemContext.UserDomain.SHARERULESTATUS_OFF);
                if (!ObjectUtils.isNullOrEmpty(existsShareRuleList)) {
                    if (existsShareRuleList.size() > 1) {
                        throw new UserServiceException("活动时间范围内存在分享规则");
                    } else {
                        if (existsShareRuleList.get(0).getId().intValue() != shareRuleDto.getId().intValue()) {
                            throw new UserServiceException("活动时间范围内存在分享规则");
                        }
                    }
                }
                ShareRule updateShare = new ShareRule();
                updateShare.setId(shareRuleDto.getId());
                updateShare.setShareRuleName(shareRuleDto.getShareRuleName());
                updateShare.setEndValidTime(shareRuleDto.getEndValidTime());
                updateShare.setModifyTime(nowTime);
                updateShare.setModifyUserId(shareRuleDto.getModifyUserId());
                shareRuleMapper.updateSelective(updateShare);
            } else {
                if (ObjectUtils.isNullOrEmpty(shareRuleDto.getStartValidTime())) {
                    throw new UserServiceException("活动开始时间不能为空");
                }
                if (!shareRuleDto.getEndValidTime().after(shareRuleDto.getStartValidTime())) {
                    throw new UserServiceException("不是有效的活动时间范围");
                }
                if (ObjectUtils.isNullOrEmpty(shareRuleDto.getRoleType())) {
                    throw new UserServiceException("角色类型不能为空");
                }
                if (ObjectUtils.isNullOrEmpty(shareRuleDto.getStatus())) {
                    shareRuleDto.setStatus(SystemContext.UserDomain.SHARERULESTATUS_NORMAL);
                }
                if (ObjectUtils.isNullOrEmpty(shareRuleDto.getModifyUserId())) {
                    throw new UserServiceException("操作用户ID不能为空");
                }
                if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInviterAwardType())
                        && ObjectUtils.isNullOrEmpty(shareRuleDto.getInviterConditionType())) {
                    throw new UserServiceException("邀请人条件设置不能为空");
                }
                if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedAwardType())
                        && ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedConditionType())) {
                    throw new UserServiceException("被邀请人条件设置不能为空");
                }
                if (ObjectUtils.isNullOrEmpty(shareRuleDto.getH5DrawUrl())) {
                    throw new UserServiceException("分享规则h5页面地址不能为空");
                }
                if (ObjectUtils.isNullOrEmpty(shareRuleDto.getAvatarHeight())) {
                    throw new UserServiceException("头像高度不能为空");
                }
                if (ObjectUtils.isNullOrEmpty(shareRuleDto.getMobileHeight())) {
                    throw new UserServiceException("手机号码高度不能为空");
                }
                if (ObjectUtils.isNullOrEmpty(shareRuleDto.getQrCodeHeight())) {
                    throw new UserServiceException("二维码高度不能为空");
                }
                if (ObjectUtils.isNullOrEmpty(shareRuleDto.getSmsContent())) {
                    throw new UserServiceException("短信分享内容不能为空");
                }
                if (ObjectUtils.isNullOrEmpty(shareRuleDto.getFriendTitle())) {
                    throw new UserServiceException("微信好友分享标题不能为空");
                }
                if (ObjectUtils.isNullOrEmpty(shareRuleDto.getFriendContent())) {
                    throw new UserServiceException("微信好友分享内容不能为空");
                }
                if (SystemContext.UserDomain.SHARERULEAWARDTYPE_COUPON.equals(shareRuleDto.getInvitedAwardType())) {
                	if(ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedAward())){
                		throw new UserServiceException("被邀请人优惠券不能为空");
                	}
                    CouponProxyDto couponProxyDto = null;
                    String[] invitedAwardArrays = shareRuleDto.getInvitedAward().split(";");
                    String[] awardArrays = null;
                    String invitedAward = "";
                    for (String invitedAwardArray : invitedAwardArrays) {
                    	awardArrays = invitedAwardArray.split(",");
                		couponProxyDto = userCouponProxyService.loadByCouponId(Integer.parseInt(awardArrays[0]));
                    	if (ObjectUtils.isNullOrEmpty(couponProxyDto)) {
                            throw new UserServiceException("被邀请人优惠券不存在");
                        }
                    	if(!("").equals(invitedAward)){
                    		invitedAward += ";";
                    	}
                        invitedAward += awardArrays[0] +","+ couponProxyDto.getAmount() +","+ awardArrays[1];
    				}
                    if(!("").equals(invitedAward)){
                    	shareRuleDto.setInvitedAward(invitedAward);
                	}
                }
                if (SystemContext.UserDomain.SHARERULEAWARDTYPE_COUPON.equals(shareRuleDto.getInviterAwardType())) {
                	if(ObjectUtils.isNullOrEmpty(shareRuleDto.getInviterAward())){
                		throw new UserServiceException("邀请人优惠券不能为空");
                	}
                    CouponProxyDto couponProxyDto = null;
                    String[] inviterAwardArrays = shareRuleDto.getInviterAward().split(";");
                    String[] awardArrays = null;
                    String inviterAward = "";
                    for (String inviterAwardArray : inviterAwardArrays) {
                    	awardArrays = inviterAwardArray.split(",");
                		couponProxyDto = userCouponProxyService.loadByCouponId(Integer.parseInt(awardArrays[0]));
                    	if (ObjectUtils.isNullOrEmpty(couponProxyDto)) {
                            throw new UserServiceException("被邀请人优惠券不存在");
                        }
                    	if(!("").equals(inviterAward)){
                    		inviterAward += ";";
                    	}
                    	inviterAward += awardArrays[0] +","+ couponProxyDto.getAmount() +","+ awardArrays[1];
    				}
                    if(!("").equals(inviterAward)){
                    	shareRuleDto.setInviterAward(inviterAward);
                	}
                }
                ShareRule updateShare = new ShareRule();
                ObjectUtils.fastCopy(shareRuleDto, updateShare);
                List<ShareRule> existsShareRuleList = shareRuleMapper.listByValidTime(shareRuleDto.getStartValidTime(),
                        shareRuleDto.getEndValidTime(), SystemContext.UserDomain.SHARERULESTATUS_OFF);
                if (!ObjectUtils.isNullOrEmpty(existsShareRuleList)) {
                    if (existsShareRuleList.size() > 1) {
                        throw new UserServiceException("活动时间范围内存在分享规则");
                    } else {
                        if (existsShareRuleList.get(0).getId().intValue() != shareRuleDto.getId().intValue()) {
                            throw new UserServiceException("活动时间范围内存在分享规则");
                        }
                    }
                }
                shareRuleMapper.update(updateShare);
            }
            operateImage(shareRuleDto.getImageFlag(), shareRuleDto.getDelImageUrl(), shareRuleDto.getBackgroundImageUrl());
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }

    }

    @Override
    public ShareRuleDto loadById(Integer ruleId) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(ruleId)) {
                return null;
            }
            ShareRule shareRule = shareRuleMapper.loadById(ruleId);
            if (ObjectUtils.isNullOrEmpty(shareRule)) {
                return null;
            }
            ShareRuleDto shareRuleDto = new ShareRuleDto();
            ObjectUtils.fastCopy(shareRule, shareRuleDto);
            return shareRuleDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public ShareRuleDto loadDetailById(Integer ruleId) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(ruleId)) {
                return null;
            }
            ShareRuleDto shareRuleDto = this.loadById(ruleId);
            if (ObjectUtils.isNullOrEmpty(shareRuleDto)) {
                return null;
            }
            if(!ObjectUtils.isNullOrEmpty(shareRuleDto.getInviterAwardType()) && shareRuleDto.getInviterAwardType().equals(SystemContext.UserDomain.SHARERULEAWARDTYPE_COUPON)){
            	//解析邀请人奖励
            	String inviterAward = shareRuleDto.getInviterAward();
            	String[] inviterAwardArrays =  inviterAward.split(";");
            	Map<String, Object> map = null;
            	for (String inviterAwardArray : inviterAwardArrays) {
            		map = new HashMap<String,Object>();
					String[] awardArrays = inviterAwardArray.split(",");
					CouponProxyDto couponProxyDto = couponProxyService.loadCouponById(Integer.parseInt(awardArrays[0]));
					if(!ObjectUtils.isNullOrEmpty(couponProxyDto)){
						map.put("conPackId", couponProxyDto.getConPackId());
					}
					map.put("couponId", awardArrays[0]);
					map.put("couponAmoum", awardArrays[1]);
					map.put("couponNumber", awardArrays[2]);
					shareRuleDto.getInviterCouponInfos().add(map);
				}
            }
            if(!ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedAwardType()) && shareRuleDto.getInvitedAwardType().equals(SystemContext.UserDomain.SHARERULEAWARDTYPE_COUPON)){
            	//解析被邀请人奖励
            	String invitedAward = shareRuleDto.getInvitedAward();
            	String[] invitedAwardArrays =  invitedAward.split(";");
            	Map<String, Object> map = null;
            	for (String invitedAwardArray : invitedAwardArrays) {
            		map = new HashMap<String,Object>();
					String[] awardArrays = invitedAwardArray.split(",");
					CouponProxyDto couponProxyDto = couponProxyService.loadCouponById(Integer.parseInt(awardArrays[0]));
					if(!ObjectUtils.isNullOrEmpty(couponProxyDto)){
						map.put("conPackId", couponProxyDto.getConPackId());
					}
					map.put("couponId", awardArrays[0]);
					map.put("couponAmoum", awardArrays[1]);
					map.put("couponNumber", awardArrays[2]);
					shareRuleDto.getInvitedCouponInfos().add(map);
				}
            }
            Date nowTime = new Date();
            Set<Integer> productIdSet = new HashSet<Integer>();
            if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInviterUseProduct())) {
                String[] productIdArr = shareRuleDto.getInviterUseProduct().split(",");
                for (String productIdStr : productIdArr) {
                    productIdSet.add(Integer.valueOf(productIdStr));
                }
            }
            if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedUseProduct())) {
                String[] productIdArr = shareRuleDto.getInvitedUseProduct().split(",");
                for (String productIdStr : productIdArr) {
                    productIdSet.add(Integer.valueOf(productIdStr));
                }
            }
            List<ProductProxyDto> productProxtDtos = new ArrayList<ProductProxyDto>();
            List<Integer> productIdList = new ArrayList<Integer>();
            productIdList.addAll(productIdSet);
            if (!ObjectUtils.isNullOrEmpty(productIdList)) {
                productProxtDtos = productProxyService.listProductByProductIds(productIdList);
            }
            Map<Integer, ProductProxyDto> productProxyMap = new HashMap<Integer, ProductProxyDto>();
            if (!ObjectUtils.isNullOrEmpty(productProxtDtos)) {
                for (ProductProxyDto productProxyDto : productProxtDtos) {
                    productProxyMap.put(productProxyDto.getId(), productProxyDto);
                }
            }
            if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInviterUseProduct())) {
                StringBuffer productNameSb = new StringBuffer();
                String[] productIdArr = shareRuleDto.getInviterUseProduct().split(",");
                for (String productId : productIdArr) {
                    if (productProxyMap.containsKey(Integer.parseInt(productId))) {
                        if (!ObjectUtils.isNullOrEmpty(productNameSb)) {
                            productNameSb.append(",");
                            productNameSb.append(productProxyMap.get(Integer.parseInt(productId)).getProductName());
                        }
                    }
                }
                shareRuleDto.setInviterUseProductName(productNameSb.toString());
            }
            if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedUseProduct())) {
                StringBuffer productNameSb = new StringBuffer();
                String[] productIdArr = shareRuleDto.getInvitedUseProduct().split(",");
                for (String productId : productIdArr) {
                    if (productProxyMap.containsKey(Integer.parseInt(productId))) {
                        if (!ObjectUtils.isNullOrEmpty(productNameSb)) {
                            productNameSb.append(",");
                            productNameSb.append(productProxyMap.get(Integer.parseInt(productId)).getProductName());
                        }
                    }
                }
                shareRuleDto.setInvitedUseProductName(productNameSb.toString());
            }
            shareRuleDto.setFullBackgroundImageUrl(StringUtils.toFullImageUrl(shareRuleDto.getBackgroundImageUrl()));
            if (nowTime.before(shareRuleDto.getStartValidTime())) {
                shareRuleDto.setStatus(SystemContext.UserDomain.SHARERULESTATUS_NORMAL);
            } else if (shareRuleDto.getEndValidTime().before(nowTime)) {
                shareRuleDto.setStatus(SystemContext.UserDomain.SHARERULESTATUS_OFF);
            } else {
                shareRuleDto.setStatus(SystemContext.UserDomain.SHARERULESTATUS_ON);
            }
            shareRuleDto.setStatusName(super.getSystemDictName(SystemContext.UserDomain.DictType.SHARERULESTATUS.getValue(),
                    shareRuleDto.getStatus()));
            return shareRuleDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public ShareRuleDto loadProgressing(Date nowTime) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(nowTime)) {
                nowTime = new Date();
            }
            ShareRule shareRule = shareRuleMapper.loadProgressing(nowTime, SystemContext.UserDomain.SHARERULESTATUS_OFF);
            if (ObjectUtils.isNullOrEmpty(shareRule)) {
                return null;
            }
            if (nowTime.before(shareRule.getStartValidTime())) {
                return null;
            } else if (shareRule.getEndValidTime().before(nowTime)) {
                return null;
            }
            shareRule.setStatus(SystemContext.UserDomain.SHARERULESTATUS_ON);
            ShareRuleDto shareRuleDto = new ShareRuleDto();
            ObjectUtils.fastCopy(shareRule, shareRuleDto);
            Set<Integer> productIdSet = new HashSet<Integer>();
            if (!ObjectUtils.isNullOrEmpty(shareRule.getInviterUseProduct())) {
                String[] productIdArr = shareRule.getInviterUseProduct().split(",");
                for (String productIdStr : productIdArr) {
                    productIdSet.add(Integer.valueOf(productIdStr));
                }
            }
            if (!ObjectUtils.isNullOrEmpty(shareRule.getInvitedUseProduct())) {
                String[] productIdArr = shareRule.getInvitedUseProduct().split(",");
                for (String productIdStr : productIdArr) {
                    productIdSet.add(Integer.valueOf(productIdStr));
                }
            }
            List<ProductProxyDto> productProxtDtos = new ArrayList<ProductProxyDto>();
            List<Integer> productIdList = new ArrayList<Integer>();
            productIdList.addAll(productIdSet);
            if (!ObjectUtils.isNullOrEmpty(productIdList)) {
                productProxtDtos = productProxyService.listProductByProductIds(productIdList);
            }
            Map<Integer, ProductProxyDto> productProxyMap = new HashMap<Integer, ProductProxyDto>();
            if (!ObjectUtils.isNullOrEmpty(productProxtDtos)) {
                for (ProductProxyDto productProxyDto : productProxtDtos) {
                    productProxyMap.put(productProxyDto.getId(), productProxyDto);
                }
            }
            if (!ObjectUtils.isNullOrEmpty(shareRule.getInviterUseProduct())) {
                StringBuffer productNameSb = new StringBuffer();
                String[] productIdArr = shareRule.getInviterUseProduct().split(",");
                for (String productId : productIdArr) {
                    if (productProxyMap.containsKey(Integer.parseInt(productId))) {
                        if (!ObjectUtils.isNullOrEmpty(productNameSb)) {
                            productNameSb.append(",");
                            productNameSb.append(productProxyMap.get(Integer.parseInt(productId)).getProductName());
                        }
                    }
                }
                shareRuleDto.setInviterUseProductName(productNameSb.toString());
            }
            if (!ObjectUtils.isNullOrEmpty(shareRuleDto.getInvitedUseProduct())) {
                StringBuffer productNameSb = new StringBuffer();
                String[] productIdArr = shareRuleDto.getInvitedUseProduct().split(",");
                for (String productId : productIdArr) {
                    if (productProxyMap.containsKey(Integer.parseInt(productId))) {
                        if (!ObjectUtils.isNullOrEmpty(productNameSb)) {
                            productNameSb.append(",");
                            productNameSb.append(productProxyMap.get(Integer.parseInt(productId)).getProductName());
                        }
                    }
                }
                shareRuleDto.setInvitedUseProductName(productNameSb.toString());
            }
            shareRuleDto.setFullBackgroundImageUrl(StringUtils.toFullImageUrl(shareRuleDto.getBackgroundImageUrl()));
            shareRuleDto.setStatusName(super.getSystemDictName(SystemContext.UserDomain.DictType.SHARERULESTATUS.getValue(),
                    shareRuleDto.getStatus()));
            return shareRuleDto;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public YiLiDiPage<ShareRuleDto> findShareRules(ShareRuleQueryDto shareRuleQueryDto) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(shareRuleQueryDto)) {
                throw new UserServiceException("查询条件不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleQueryDto.getStart())) {
                shareRuleQueryDto.setStart(1);
            }
            if (ObjectUtils.isNullOrEmpty(shareRuleQueryDto.getPageSize())) {
                shareRuleQueryDto.setStart(CommonConstants.PAGE_SIZE);
            }
            ShareRuleQuery shareRuleQuery = new ShareRuleQuery();
            ObjectUtils.fastCopy(shareRuleQueryDto, shareRuleQuery);
            if (!ObjectUtils.isNullOrEmpty(shareRuleQueryDto.getStrStartValidTime())) {
                Date beginStartDate = DateUtils
                        .parseDate(shareRuleQueryDto.getStrStartValidTime() + StringUtils.STARTTIMESTRING);
                shareRuleQuery.setStartValidTime(beginStartDate);
            }
            if (!ObjectUtils.isNullOrEmpty(shareRuleQueryDto.getStrEndValidTime())) {
                Date endStartTime = DateUtils.parseDate(shareRuleQueryDto.getStrEndValidTime() + StringUtils.ENDTIMESTRING);
                shareRuleQuery.setEndValidTime(endStartTime);
            }
            PageHelper.startPage(shareRuleQuery.getStart(), shareRuleQuery.getPageSize());
            Page<ShareRule> shareRulePages = shareRuleMapper.findShareRules(shareRuleQuery);
            Page<ShareRuleDto> pageDto = new Page<ShareRuleDto>(shareRuleQuery.getStart(), shareRuleQuery.getPageSize());
            ObjectUtils.fastCopy(shareRulePages, pageDto);
            List<ShareRule> shareRuleList = shareRulePages.getResult();
            if (!ObjectUtils.isNullOrEmpty(shareRuleList)) {
                for (ShareRule shareRule : shareRuleList) {
                    ShareRuleDto shareRuleDto = new ShareRuleDto();
                    ObjectUtils.fastCopy(shareRule, shareRuleDto);
                    shareRuleDto.setStatusName(super.getSystemDictName(
                            SystemContext.UserDomain.DictType.SHARERULESTATUS.getValue(), shareRuleDto.getStatus()));
                    shareRuleDto.setInviterAwardTypeName(
                            super.getSystemDictName(SystemContext.UserDomain.DictType.SHARERULEAWARDTYPE.getValue(),
                                    shareRuleDto.getInviterAwardType()));
                    shareRuleDto.setRoleTypeName(super.getSystemDictName(
                            SystemContext.UserDomain.DictType.SHARERULEROLETYPE.getValue(), shareRuleDto.getRoleType()));
                    shareRuleDto.setInviterConditionTypeName(super.getSystemDictName(
                            SystemContext.UserDomain.DictType.SHARERULEINVITERCONDITIONTYPE.getValue(),
                            shareRuleDto.getInviterConditionType()));
                    shareRuleDto.setInvitedAwardTypeName(
                            super.getSystemDictName(SystemContext.UserDomain.DictType.SHARERULEAWARDTYPE.getValue(),
                                    shareRuleDto.getInvitedAwardType()));
                    shareRuleDto.setInvitedConditionTypeName(super.getSystemDictName(
                            SystemContext.UserDomain.DictType.SHARERULEINVITEDCONDITIONTYPE.getValue(),
                            shareRuleDto.getInvitedConditionType()));
                    shareRuleDto.setFullBackgroundImageUrl(StringUtils.toFullImageUrl(shareRuleDto.getBackgroundImageUrl()));
                    pageDto.add(shareRuleDto);
                }
            }
            return YiLiDiPageUtils.encapsulatePageResult(pageDto);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public List<ShareRuleDto> listShareRules(ShareRuleQueryDto shareRuleQueryDto) throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(shareRuleQueryDto)) {
                return Collections.emptyList();
            }
            ShareRuleQuery shareRuleQuery = new ShareRuleQuery();
            ObjectUtils.fastCopy(shareRuleQueryDto, shareRuleQuery);
            List<ShareRuleDto> shareRuleDtoList = new ArrayList<ShareRuleDto>();
            List<ShareRule> shareRuleList = shareRuleMapper.listShareRules(shareRuleQuery);
            if (ObjectUtils.isNullOrEmpty(shareRuleList)) {
                return shareRuleDtoList;
            }
            for (ShareRule shareRule : shareRuleList) {
                ShareRuleDto shareRuleDto = new ShareRuleDto();
                ObjectUtils.fastCopy(shareRule, shareRuleDto);
                shareRuleDtoList.add(shareRuleDto);
            }
            return shareRuleDtoList;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public List<ShareRuleDto> listShareRulesByStatus(String status) throws UserServiceException {
        try {
            List<ShareRuleDto> shareRuleDtoList = new ArrayList<ShareRuleDto>();
            List<ShareRule> shareRuleList = shareRuleMapper.listShareRulesByStatus(status);
            if (ObjectUtils.isNullOrEmpty(shareRuleList)) {
                return shareRuleDtoList;
            }
            for (ShareRule shareRule : shareRuleList) {
                ShareRuleDto shareRuleDto = new ShareRuleDto();
                ObjectUtils.fastCopy(shareRule, shareRuleDto);
                shareRuleDtoList.add(shareRuleDto);
            }
            return shareRuleDtoList;
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }

    @Override
    public void updateStatusById(Integer shareRuleId, String updateStatus, Integer updateUserId, Date updateTime)
            throws UserServiceException {
        try {
            if (ObjectUtils.isNullOrEmpty(shareRuleId) || ObjectUtils.isNullOrEmpty(updateStatus)
                    || ObjectUtils.isNullOrEmpty(updateUserId)) {
                throw new UserServiceException("必填参数不能为空");
            }
            if (ObjectUtils.isNullOrEmpty(updateTime)) {
                updateTime = new Date();
            }
            ShareRule shareRule = shareRuleMapper.loadById(shareRuleId);
            if (ObjectUtils.isNullOrEmpty(shareRule)) {
                throw new UserServiceException("此分享规则不存在");
            }
            if (SystemContext.UserDomain.SHARERULESTATUS_ON.equals(updateStatus)) {
                if (updateTime.before(shareRule.getStartValidTime())) {
                    updateStatus = SystemContext.UserDomain.SHARERULESTATUS_NORMAL;
                }
                List<ShareRule> existsShareRuleList = shareRuleMapper.listByValidTime(shareRule.getStartValidTime(),
                        shareRule.getEndValidTime(), SystemContext.UserDomain.SHARERULESTATUS_OFF);
                if (!ObjectUtils.isNullOrEmpty(existsShareRuleList)) {
                    if (existsShareRuleList.size() > 1) {
                        throw new UserServiceException("活动时间范围内存在分享规则");
                    } else {
                        if (existsShareRuleList.get(0).getId().intValue() != shareRule.getId().intValue()) {
                            throw new UserServiceException("活动时间范围内存在分享规则");
                        }
                    }
                }
            }
            shareRuleMapper.updateStatusById(shareRuleId, updateStatus, updateUserId, updateTime);
        } catch (Exception e) {
            logger.error(e, e);
            throw new UserServiceException(e.getMessage());
        }
    }
}
