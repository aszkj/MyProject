//
//  JGShare.m
//  jingGang
//
//  Created by 张康健 on 15/6/19.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "JGShare.h"
#import "Util.h"
#import "VApiManager.h"

#define KShareContent @"云e生分享"

@implementation JGShare

+ (void)shareWithTitle:(NSString *)title
               content:(NSString *)content
          headerImgUrl:(NSString *)headImgUrl
              shareUrl:(NSString *)shareUrl
             shareType:(ShareType)shareType
{

    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:@"云e生"
                                                image:headImgUrl ? [ShareSDK imageWithUrl:headImgUrl] : nil
                                                title:title
                                                  url:shareUrl
                                          description:content
                                            mediaType:SSPublishContentMediaTypeNews];
    
    //定制微信分享
    [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInteger:SSPublishContentMediaTypeNews]
                                          content:content
                                            title:title
                                              url:shareUrl
                                       thumbImage:headImgUrl ? [ShareSDK imageWithUrl:headImgUrl] : nil
                                            image:headImgUrl ? [ShareSDK imageWithUrl:headImgUrl] : nil
                                     musicFileUrl:nil
                                          extInfo:nil
                                         fileData:nil
                                     emoticonData:nil];
    
    
    [ShareSDK shareContent:publishContent
                      type:shareType
               authOptions:nil
              shareOptions:nil
             statusBarTips:YES
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        if (state == SSPublishContentStateSuccess)
                        {
                            if (type == ShareTypeWeixiTimeline) {
                                
                                [Util ShowAlertWithOutCancelWithTitle:@"提示" message:@"朋友圈分享成功!"];
                            }else if (type == ShareTypeSinaWeibo){
                                [Util ShowAlertWithOutCancelWithTitle:@"提示" message:@"微博分享成功"];
                            
                            }
                            
                            //调用增加积分接口
                            VApiManager *vapManager = [[VApiManager alloc] init];
                            SnsHealthTaskSaveRequest *request = [[SnsHealthTaskSaveRequest alloc] init:GetToken];
                            request.api_integralType = @2;
                            [vapManager snsHealthTaskSave:request success:^(AFHTTPRequestOperation *operation, SnsHealthTaskSaveResponse *response) {
                                
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                
                            }];
                            
                        }
                        else if (state == SSPublishContentStateFail)
                        {
                            NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
                            
                            NSLog(@"error discription:%@",[error errorDescription]);
                            
                            [Util ShowAlertWithOutCancelWithTitle:@"提示" message:[error errorDescription]];
                        }
                        
                    }];//这个方法，在自己的事件里调用这个就好
    
}

+ (void)shareWithImage:(NSString *)imagePath shareWithTitle:(NSString *)title content:(NSString *)shareContent headerImgUrl:(NSString *)shareHeadImgUrl shareUrl:(NSString *)shareUrl shareType:(ShareType)shareType
{
    id<ISSContent> publishContent = [ShareSDK content:shareContent
                                       defaultContent:shareContent
                                                image:[ShareSDK imageWithPath:imagePath]
                                     //                                                image:shareImage
                                                title:title
                                                  url:shareUrl
                                          description:shareContent
                                            mediaType:SSPublishContentMediaTypeImage];
    
    
    [ShareSDK shareContent:publishContent
                      type:shareType
               authOptions:nil
              shareOptions:nil
             statusBarTips:YES
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        
                        NSLog(@"分享状态 %u",state);
                        
                        if (state == SSResponseStateSuccess)
                        {
                            if (type == ShareTypeWeixiTimeline) {
                                
                                [Util ShowAlertWithOutCancelWithTitle:@"提示" message:@"朋友圈分享成功!"];
                            }else if (type == ShareTypeSinaWeibo){
                                [Util ShowAlertWithOutCancelWithTitle:@"提示" message:@"微博分享成功"];
                            }
                            
                            //调用增加积分接口
                            VApiManager *vapManager = [[VApiManager alloc] init];
                            SnsHealthTaskSaveRequest *request = [[SnsHealthTaskSaveRequest alloc] init:GetToken];
                            request.api_integralType = @2;
                            [vapManager snsHealthTaskSave:request success:^(AFHTTPRequestOperation *operation, SnsHealthTaskSaveResponse *response) {
                                
                                NSLog(@"送积分 response %@",response);
                                
                                
                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                
                            }];
                            
                        }
                        else if (state == SSResponseStateFail)
                        {
                            NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
                            
                            NSLog(@"error discription:%@",[error errorDescription]);
                            
                            [Util ShowAlertWithOutCancelWithTitle:@"提示" message:[error errorDescription]];
                        }
                        
                        
                        
                    }];//这个方法，在自己的事件里调用这个就好
    
}



@end






