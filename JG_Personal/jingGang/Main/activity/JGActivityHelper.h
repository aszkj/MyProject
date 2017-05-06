//
//  JGActivityHelper.h
//  jingGang
//
//  Created by dengxf on 16/1/15.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VApiManager.h"

/**
 *  静港平台活动信息管理类 */
@interface JGActivityHelper : NSObject

@property (assign, nonatomic) BOOL signViewShowed;

@property (assign, nonatomic) BOOL showed;

@property (assign, nonatomic) BOOL integralCheckInDelayShow;

/**
 *  是否小于展现的次数
 */
@property (assign, nonatomic) BOOL lessShowCount;


@property (strong,nonatomic) SalePromotionAdInfoResponse *response;

/**
 *  单例对象 */
+ (instancetype)sharedManager;

/**
 *  根据活动code 检测是否在活动时间内
 *
 *  @param activityCode 活动编码
 *  @param progressing  活动正在进行中回调
 *  @param beyond       不在活动时间内回调
 *  @param errorBlock   网络错误回调
 */
+ (void)queryActivityWithActivityCode:(NSString *)activityCode progressing:(void(^)())progressing beyondTime:(void(^)())beyond error:(void(^)(NSError *error))errorBlock notiBlock:(void(^)())noti;

/**
 *  返回活动图片
 */
+ (NSString *)downloadActivityImageWithUrlString;

/**
 *  是否展示图片
 */
+ (BOOL)showImage;

/**
 *  隐藏展示图片
 */
+ (void)dismissImage;

/**
 *  离开首页将不再显示 */
+ (void)notTargetControllerShowImage;


/**
 *  查询用户是否签到
 */
+ (void)queryUserDidCheckInPopView:(void(^)(UserSign *userSign))popViewBlock notPop:(void(^)())notPopBlock;

/**
 *  用户签到 */
+ (void)userCheckIn:(void(^)(UserSign *userSign))userSignBlock fail:(void(^)(NSError *error))errorBlock ;


/**
 *  这是一个状态 ，本应该弹出积分签到，但是避免活动页面 ，应该等到活动页面关闭后，延迟弹出
 */
+ (void)shouldPopViewButAvoidActivityView;

@end
