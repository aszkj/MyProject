//
//  TopbarTypeTableDataLogicModule.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/5.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "TopbarTypeTableDataLogicModule.h"

@implementation TopbarTypeTableDataLogicModule

- (instancetype)init
{
    self = [super init];
    if (self) {
        _requestFromPage = 1;
        _requestPageSize = 5;
        _isAutoHeaderFresh = YES;
        _isFinishedHeaderAutoFresh = NO;
        
        _currentDataModelArr = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}


@end
