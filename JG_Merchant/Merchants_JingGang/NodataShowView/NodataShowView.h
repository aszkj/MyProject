//
//  NodataShowView.h
//  jingGang
//
//  Created by 张康健 on 15/8/21.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NoDataType,   //无数据
    NoNoticeDataType, //无公告数据
    NetworkRequestFaildType,//请求失败
    MerchantIsEmpty,        //不存在商家
    NoserviceType,          //暂无服务
    No_OrderType
}NetWorkRequestResultType;

typedef void(^ReloadBlock)();
@interface NodataShowView : UIView

+(id)showInContentView:(UIView *)contentView withReloadBlock:(ReloadBlock)reloadBlock requestResultType:(NetWorkRequestResultType)requestResultType;
+(void)hideInContentView:(UIView *)contentView;

+ (void)showLoadingInView:(UIView *)contentView;

//title，image定制
+(void)showInContentView:(UIView *)contentView
         withReloadBlock:(ReloadBlock)reloadBlock
              alertTitle:(NSString *)alertTitle
          alertImageName:(NSString *)alertImageName;

//title定制
+(void)showInContentView:(UIView *)contentView
         withReloadBlock:(ReloadBlock)reloadBlock
              alertTitle:(NSString *)alertTitle;



-(void)hide;


@end
