//
//  UIApplication+Design.m
//  weimi
//
//  Created by ray on 16/3/9.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import "UIApplication+Design.h"

@implementation UIApplication (Design)

- (BOOL)rt_openSettingURL:(NSString *)urlString
{
    NSURL*url=[NSURL URLWithString:urlString];
    if([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url];
        return YES;
    }
    return NO;
}



@end
