//
//  Operation.h
//  YilidiBuyer
//
//  Created by mm on 16/12/8.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <Cordova/CDVPlugin.h>

typedef void(^HtmlBackBlock)(void);

@interface Operation : CDVPlugin

- (void)backPressed:(CDVInvokedUrlCommand *)command;

@property (nonatomic,copy)HtmlBackBlock htmlBackBlock;


@end
