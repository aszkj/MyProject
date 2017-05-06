//
//  Operation.h
//  YilidiBuyer
//
//  Created by mm on 16/12/8.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "CDV.h"

typedef void(^HtmlBackBlock)(void);
typedef void(^HtmlRedirectBlock)(NSString *redirectUrl);
typedef void(^HtmlToCartPageBlock)();
typedef void(^HtmlToLoginPageBlock)();
typedef void(^HtmlToOrderlistPageBlock)();
typedef void(^HtmlToOrderDetailPageBlock)(NSString *orderNo);
typedef void(^HtmlToClassPageBlock)();
typedef void(^HtmlToBrandPageBlock)();

@interface Operation : CDVPlugin

- (void)backPressed:(CDVInvokedUrlCommand *)command;

- (void)redirectPage:(CDVInvokedUrlCommand *)command;

- (void)toCartPage:(CDVInvokedUrlCommand *)command;

- (void)toLoginPage:(CDVInvokedUrlCommand *)command;

- (void)toOrderListPage:(CDVInvokedUrlCommand *)command;

- (void)toOrderDetailPage:(CDVInvokedUrlCommand *)command;

- (void)toClassPage:(CDVInvokedUrlCommand *)command;

- (void)toBrandPage:(CDVInvokedUrlCommand *)command;

@property (nonatomic,copy)HtmlBackBlock htmlBackBlock;
@property (nonatomic,copy)HtmlRedirectBlock htmlRedirectBlock;

#pragma mark - 页面跳转
@property (nonatomic,copy)HtmlToCartPageBlock htmlToCartPageBlock;
@property (nonatomic,copy)HtmlToLoginPageBlock htmlToLoginPageBlock;
@property (nonatomic,copy)HtmlToOrderlistPageBlock htmlToOrderlistPageBlock;
@property (nonatomic,copy)HtmlToOrderDetailPageBlock htmlToOrderDetailPageBlock;
@property (nonatomic,copy)HtmlToClassPageBlock htmlToClassPageBlock;
@property (nonatomic,copy)HtmlToBrandPageBlock htmlToBrandPageBlock;



@end
