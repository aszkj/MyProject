//
//  MerchantManageCell.h
//  Operator_JingGang
//
//  Created by 张康健 on 15/9/19.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncomeStatisticsModel.h"
@interface MerchantManageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tradeTotalValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *consumeBackPromitLabel;
@property (weak, nonatomic) IBOutlet UILabel *commissionBackPromitLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalBackPromitLabel;

@property (nonatomic, strong)OperatorManagement *operatorManageModel;

@property (nonatomic, copy)  NSString *strStatus;//判断哪个controller调用了cell，根据这个做出细节布局修改


@property (nonatomic,strong) IncomeStatisticsModel *model;
@property (nonatomic,strong) NSDictionary *dicItemName;
@property (weak, nonatomic) IBOutlet UILabel *labelItemTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelOneItem;
@property (weak, nonatomic) IBOutlet UILabel *labelTwoItem;
@property (weak, nonatomic) IBOutlet UILabel *labelThreeItem;

@end
