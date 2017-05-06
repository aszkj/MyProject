//
//  XKJHOnlineOrderIncomeDetailTableView.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/5.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHOnlineOrderIncomeDetailTableView.h"
#import "XKJHOnlineOrderIncomeDetailCell.h"
#import "XHJHOnlineOrderManageCell.h"
#import "NodataShowView.h"

@implementation XKJHOnlineOrderIncomeDetailTableView

static NSString *XHJHOnlineOrderManageCellID = @"XHJHOnlineOrderManageCellID";

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style dataLogicModule:(TopbarTypeTableDataLogicModule *)dataLogicModule {
    
    self = [super initWithFrame:frame style:style dataLogicModule:dataLogicModule];
    if (self) {

        [self _init];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _init];
    }
    return self;
}


-(void)_init{
    
    self.delegate = self;
    self.dataSource = self;
    [self registerNib:[UINib nibWithNibName:@"XHJHOnlineOrderManageCell" bundle:nil]  forCellReuseIdentifier:XHJHOnlineOrderManageCellID];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = self.dataLogicModule.currentDataModelArr.count;
    if (count == 0) {
        [NodataShowView showInContentView:self withReloadBlock:^{
        } requestResultType:No_OrderType];
    }
    else
    {
        [NodataShowView hideInContentView:self];
    }
    return self.dataLogicModule.currentDataModelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XHJHOnlineOrderManageCell *cell = [self dequeueReusableCellWithIdentifier:XHJHOnlineOrderManageCellID forIndexPath:indexPath];
    cell.groupOrderModel = (GroupOrderModel *)self.dataLogicModule.currentDataModelArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 205;
    
}




@end
