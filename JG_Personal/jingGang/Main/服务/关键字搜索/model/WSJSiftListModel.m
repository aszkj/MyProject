//
//  WSJSiftListModel.m
//  jingGang
//
//  Created by thinker on 15/8/6.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJSiftListModel.h"

@implementation WSJSiftListModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.data = [NSMutableArray array];
        self.selectRow = -1;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"id = %@  title = %@",self.ID,self.titleName];
}
@end
