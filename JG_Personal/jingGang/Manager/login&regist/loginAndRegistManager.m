//
//  loginAndRegistManager.m
//  jingGang
//
//  Created by yi jiehuang on 15/5/8.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "loginAndRegistManager.h"

@implementation loginAndRegistManager
@synthesize Msg = _Msg;
@synthesize delegate = m_delegate;

- (id)init
{
    self = [super init];
    if (self) {
        m_delegate = nil;
    }
    return self;
}


@end