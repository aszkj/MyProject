//
//  JGActivityHelper.m
//  jingGang
//
//  Created by dengxf on 16/1/15.
//  Copyright © 2016年 Dengxf_Dev. All rights reserved.
//

#import "JGActivityHelper.h"
#import "JGDateTools.h"
#import "UIImageView+WebCache.h"
#import "GlobeObject.h"
#import "MJExtension.h"
#import "individualSignView.h"

NSString * const kActivityImageUrlKey = @"kActivityImageUrlKey";

@implementation JGActivityHelper

+ (instancetype)sharedManager {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

+ (void)queryActivityWithActivityCode:(NSString *)activityCode progressing:(void (^)())progressing beyondTime:(void (^)())beyond error:(void (^)(NSError *))errorBlock notiBlock:(void(^)())noti{
    VApiManager *manager = [[VApiManager alloc] init];
    SalePromotionAdInfoRequest *request = [[SalePromotionAdInfoRequest alloc] init:nil];
    request.api_actCode = activityCode;
    [manager salePromotionAdInfo:request success:^(AFHTTPRequestOperation *operation, SalePromotionAdInfoResponse *response) {
        if ([response.subCode integerValue] == 0) {
            // 后台已经启用活动
            JGLog(@"活动已经开启了");
            // 1. 判断是否在活动时间内
            NSString *startTime = [[JGActivityHelper sharedManager] dateFormTranshToResponse:response timeKey:@"startTime"];
            NSString *endTime = [[JGActivityHelper sharedManager] dateFormTranshToResponse:response timeKey:@"endTime"];
            
            if ([[JGDateTools sharedInstanced] nowContainedActivityPeriodWithBeginTime:startTime endTime:endTime]) {
                // 在活动时间内
                JGLog(@"在活动范围内");
                
                [JGActivityHelper sharedManager].response = response;
                
                if ([self downloadActivityImageWithUrlString]) {
                    
                    BLOCK_EXEC(noti);
                    
                }else {
                    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:[[JGActivityHelper sharedManager] activityImageWithResponse:response]] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                            // 图片已经下载成功 将图片路径保存到本地
                        
                        JGLog(@"rece:%ld,ex:%ld",receivedSize,expectedSize);
                        
                            [[JGActivityHelper sharedManager] st_userDefaultWithImageUrlWithString:[[JGActivityHelper sharedManager] activityImageWithResponse:response]];
                            BLOCK_EXEC(noti);
                        JGLog(@"received:%ld,expected;%ld",receivedSize,expectedSize);
                    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                    }];
                }
                
            }else {
                // 不在活动时间范围内
                JGLog(@"不在活动范围内");
                JGLog(@"活动已经禁用了");
                BLOCK_EXEC(beyond);
                [[JGActivityHelper sharedManager] st_userDefaultWithImageUrlWithString:nil];
            }
        }else {
            // 后台已经禁用活动
            JGLog(@"活动已经禁用了");
            BLOCK_EXEC(beyond);
            [[JGActivityHelper sharedManager] st_userDefaultWithImageUrlWithString:nil];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        JGLog(@"网络错误");
        BLOCK_EXEC(errorBlock,error);
        [[JGActivityHelper sharedManager] st_userDefaultWithImageUrlWithString:nil];
    }];
}

+ (NSString *)downloadActivityImageWithUrlString {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kActivityImageUrlKey];
}

+ (BOOL)showImage {
    if (![JGActivityHelper sharedManager].showed && [JGActivityHelper lessShowCount ] && [JGActivityHelper sharedManager].response ) {
        [JGActivityHelper sharedManager].showed = YES;
        return YES;
    }else {
        return NO;
    }
    return NO;
}

+ (void)dismissImage {
    [JGActivityHelper sharedManager].showed = NO;
}

+ (void)notTargetControllerShowImage {
    [JGActivityHelper sharedManager].showed = YES;
}

+ (BOOL)lessShowCount
{
    NSString *today = [JGDateTools nowDateInfo];
    if ([JGDateTools checkShouldPopDateSting:today]) {
        // 在可控制范围内
        [JGDateTools addDate:today];
        return YES;
    }else {
        return NO;
    }
    return NO;
}


+ (void)queryUserDidCheckInPopView:(void(^)(UserSign *userSign))popViewBlock notPop:(void(^)())notPopBlock {
    if (!GetToken) {
        return;
    }
    
    UsersSignLoginRequest *request = [[UsersSignLoginRequest alloc ] init: GetToken];
    request.api_type = @(2);
    [[[VApiManager alloc] init] usersSignLogin:request success:^(AFHTTPRequestOperation *operation, UsersSignLoginResponse *response) {
        UserSign *userSign = [UserSign objectWithKeyValues:response.userSign];
        NSString *isSign = TNSString(userSign.isSign);
        if ([isSign isEqualToString:@"1"]) {
            // 已签到 不弹窗
            JGLog(@"\n用户已签到");
            BLOCK_EXEC(notPopBlock);
        }else {
            // 没签到，可弹窗
            BLOCK_EXEC(popViewBlock,userSign);
            [JGActivityHelper userCheckIn:^(UserSign *userSign) {
                // 用户签到成功
                JGLog(@"\n用户签到成功");
                individualSignView *signView = [[NSBundle mainBundle] loadNibNamed:@"individualSignView" owner:self options:nil][0];
                signView.integral = [userSign.integral integerValue];
                signView.day = [userSign.day integerValue];
                UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
                signView.frame = window.frame;
                
                // 2.添加自己到窗口上
                if (![JGActivityHelper sharedManager].signViewShowed) {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [window addSubview:signView];
                        [JGActivityHelper sharedManager].signViewShowed = YES;
                    });
                }
                
            } fail:^(NSError *error) {
                JGLog(@"\n用户签到失败");
            }];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BLOCK_EXEC(notPopBlock);
    }];
}

+ (void)userCheckIn:(void(^)(UserSign *userSign))userSignBlock fail:(void(^)(NSError *error))errorBlock {
    // 用户签到操作
//    UserSign *signObject = [[UserSign alloc] init];
//    BLOCK_EXEC(userSignBlock,signObject);
    UsersSignLoginRequest *request = [[UsersSignLoginRequest alloc ] init: GetToken];
    request.api_type = @(1);
    [[[VApiManager alloc] init] usersSignLogin:request success:^(AFHTTPRequestOperation *operation, UsersSignLoginResponse *response) {
        UserSign *userSign = [UserSign objectWithKeyValues:response.userSign];
        BLOCK_EXEC(userSignBlock,userSign);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BLOCK_EXEC(errorBlock,error);
    }];
}

+ (void)shouldPopViewButAvoidActivityView {
    [JGActivityHelper sharedManager].integralCheckInDelayShow = YES;
}

#pragma mark priviate method
- (void)st_userDefaultWithImageUrlWithString:(NSString *)urlString {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:urlString forKey:kActivityImageUrlKey];
    [defaults synchronize];
}

- (NSString *)activityImageWithResponse:(SalePromotionAdInfoResponse *)response {
    NSDictionary *acDic = [NSDictionary dictionaryWithDictionary:(NSDictionary *)response.activityHotSaleApiBO];
    NSString *urlString = acDic[@"firstImage"];
    return urlString;
}

- (NSString *)dateFormTranshToResponse:(SalePromotionAdInfoResponse *)response timeKey:(NSString *)timeKey {
    NSDictionary *acDict = [NSDictionary dictionaryWithDictionary:(NSDictionary *)response.activityHotSaleApiBO];
    return TNSString(acDict[timeKey]);
}

/**
 *  判断当前请求时间是否在活动时间内
 *
 *  @param startTime 活动开始时间
 *  @param endTime   活动结束时间
 */
- (BOOL)nowDatePeriodOfStartTime:(NSString *)startTime endTime:(NSString *)endTime {
    return NO;
}




@end
