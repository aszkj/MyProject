//
//  BaseTabbarTypeTableView.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/5.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "BaseTabbarTypeTableView.h"

@interface BaseTabbarTypeTableView() {

    NSString *reuseCellID;//重用cellID
}

@end


@implementation BaseTabbarTypeTableView

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _initDataLogicModule];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initDataLogicModule];

    }
    return self;
}

-(void)_initDataLogicModule {
    TopbarTypeTableDataLogicModule *module = [[TopbarTypeTableDataLogicModule alloc] init];
    _dataLogicModule = module;

}

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style dataLogicModule:(TopbarTypeTableDataLogicModule *)dataLogicModule
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        _dataLogicModule = dataLogicModule;

    }
    return self;
}


-(void)_init{
    
    self.delegate = self;
    self.dataSource = self;
}






@end
