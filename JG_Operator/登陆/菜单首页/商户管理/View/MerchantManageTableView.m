//
//  MerchantManageTableView.m
//  Operator_JingGang
//
//  Created by 张康健 on 15/9/19.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import "MerchantManageTableView.h"
#import "MerchantManageCell.h"
#import "NodataShowView.h"

@implementation MerchantManageTableView


static NSString *MerchantManageCellID = @"MerchantManageCellID";

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self _init];
        
    }
    
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        [self _init];
        
    }
    return self;
}

- (void)_init {
    self.delegate = self;
    self.dataSource = self;
    
    [self registerNib:[UINib nibWithNibName:@"MerchantManageCell" bundle:nil]  forCellReuseIdentifier:MerchantManageCellID];
    
    self.rowHeight = 183;

}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataLogicModule.currentDataModelArr.count == 0) {
        [NodataShowView showInContentView:tableView withReloadBlock:^{
            [tableView reloadData];
        } requestResultType:NoDataType];
    }
    else
    {
        [NodataShowView hideInContentView:tableView];
    }
    return self.dataLogicModule.currentDataModelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MerchantManageCell *cell = [self dequeueReusableCellWithIdentifier:MerchantManageCellID forIndexPath:indexPath];
    cell.operatorManageModel = self.dataLogicModule.currentDataModelArr[indexPath.row];
    return cell;
}



@end
