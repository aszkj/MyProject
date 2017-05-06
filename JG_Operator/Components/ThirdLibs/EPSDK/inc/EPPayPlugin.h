//
//  EPPayPlugin.h
//  EPPayPluginSDK
//
//  Created by 斌 on 14-10-9.
//  Copyright (c) 2014年 wxh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol EPPayPluginDelegate <NSObject>

/**
 SDK支付结果回调
 */
-(void)EPPayPluginResult:(NSString*)result;

/*************************
 交易结果说明:
 
 支付控件有三个支付状态返回值:success、fail、cancel
 
 分别代表:支付成功、支付失败、用户取消支付。
 
 ************************/

@end



@interface EPPayPlugin : NSObject

+ (void)startEPPay:(NSString*)tn mode:(int)mode viewController:(UIViewController*)viewController delegate:(id<EPPayPluginDelegate>)delegate;

@end
