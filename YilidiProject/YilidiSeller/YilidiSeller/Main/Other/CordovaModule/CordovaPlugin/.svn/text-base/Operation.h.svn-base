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



@end
