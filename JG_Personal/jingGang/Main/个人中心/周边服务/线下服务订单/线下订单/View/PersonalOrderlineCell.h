//
//  PersonalOrderlineCell.h
//  jingGang
//
//  Created by dengxf on 15/11/11.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PersonalOrderlineModel;

@interface PersonalOrderlineCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *storeNameLab;
@property (strong, nonatomic) IBOutlet UILabel *orderIdLab;
@property (strong, nonatomic) IBOutlet UILabel *localGroupNameLab;
@property (strong, nonatomic) IBOutlet UILabel *addTimeLab;
@property (strong, nonatomic) IBOutlet UILabel *totalPriceLab;
@property (strong, nonatomic) IBOutlet UILabel *orderStatusLab;
@property (strong, nonatomic) IBOutlet UILabel *userNicknameLab;
@property (strong, nonatomic) IBOutlet UILabel *mobileLab;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *storeNameWidthConstrain;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *orderIdConstraint;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *addTimeConstraint;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *orderStutasConstraint;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *mobileConstraint;

@property (strong,nonatomic) PersonalOrderlineModel *orderlineModel;


+ (instancetype)personalOrderCellWithTableView:(UITableView *)tableView;

@end
