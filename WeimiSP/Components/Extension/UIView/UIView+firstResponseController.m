//
//  UIView+firstResponseController.m
//  jingGang
//
//  Created by 张康健 on 15/7/31.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "UIView+firstResponseController.h"

@implementation UIView (firstResponseController)

-(UIViewController *)firstResponseController {
    
    id responser = [self nextResponder];
    
    while (responser) {
        if ([responser isKindOfClass:[UIViewController class]]) {
            responser = (UIViewController *)responser;
            return responser;
            break;
        }
        responser = [responser nextResponder];
    }
    
    return nil;
}

@end
