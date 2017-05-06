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
    NetworkRequestFaildType,//请求失败
    MerchantIsEmpty,        //不存在商家
    No_OrderType,
    No_ExpectType   //暂无收益
}NetWorkRequestResultType;

typedef void(^ReloadBlock)();
@interface NodataShowView : UIView

+(id)showInContentView:(UIView *)contentView withReloadBlock:(ReloadBlock)reloadBlock requestResultType:(NetWorkRequestResultType)requestResultType;
+(void)hideInContentView:(UIView *)contentView;

+ (void)showLoadingInView:(UIView *)contentView;


-(void)hide;


@end
