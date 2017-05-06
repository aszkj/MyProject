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
    No_GoodsConsultType //没有商品咨询
}NetWorkRequestResultType;

typedef void(^ReloadBlock)();
@interface NodataShowView : UIView

@property (weak, nonatomic) IBOutlet UIButton *alertButton;
@property (weak, nonatomic) IBOutlet UIImageView *showStatusImgView;

//之前的
+(id)showInContentView:(UIView *)contentView
       withReloadBlock:(ReloadBlock)reloadBlock
     requestResultType:(NetWorkRequestResultType)requestResultType;

//title，image定制
+(void)showInContentView:(UIView *)contentView
       withReloadBlock:(ReloadBlock)reloadBlock
        alertTitle:(NSString *)alertTitle
        alertImageName:(NSString *)alertImageName;

//title定制
+(void)showInContentView:(UIView *)contentView
       withReloadBlock:(ReloadBlock)reloadBlock
            alertTitle:(NSString *)alertTitle;


+(void)hideInContentView:(UIView *)contentView;

+ (void)showLoadingInView:(UIView *)contentView;

-(void)hide;


@end
