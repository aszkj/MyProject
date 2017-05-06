//
//  XKJHOfflineOrderManageTableView.m
//  Merchants_JingGang
//
//  Created by 张康健 on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHOfflineOrderManageTableView.h"
#import "XKJHOfflineOrderManageCell.h"
#import "NodataShowView.h"

@implementation XKJHOfflineOrderManageTableView

static NSString *XKJHOfflineOrderManageCellID = @"XKJHOfflineOrderManageCellID";

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
    [self registerNib:[UINib nibWithNibName:@"XKJHOfflineOrderManageCell" bundle:nil]  forCellReuseIdentifier:XKJHOfflineOrderManageCellID];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = self.dataLogicModule.currentDataModelArr.count;
    if (count == 0) {
        [NodataShowView showInContentView:self withReloadBlock:^{
        } requestResultType:NoDataType];
    }
    else
    {
        [NodataShowView hideInContentView:self];
    }
    return self.dataLogicModule.currentDataModelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XKJHOfflineOrderManageCell *cell = [self dequeueReusableCellWithIdentifier:XKJHOfflineOrderManageCellID forIndexPath:indexPath];
    cell.groupOffOrderModel = self.dataLogicModule.currentDataModelArr[indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 202;

}



@end
