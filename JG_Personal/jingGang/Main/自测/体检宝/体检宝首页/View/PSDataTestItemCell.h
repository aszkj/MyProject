//
//  PSDataTestItemCell.h
//  jingGang
//
//  Created by 张康健 on 15/7/22.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSDataTestItemCell : UITableViewCell
//标志做了测试
@property (weak, nonatomic) IBOutlet UIButton *doneTestButton;
@property (weak, nonatomic) IBOutlet UILabel *testTypeLabel;
@property (weak, nonatomic) IBOutlet UIButton *normalButton;
@property (weak, nonatomic) IBOutlet UIButton *doubtFulButton;
@property (weak, nonatomic) IBOutlet UIButton *doneTestSecondButton;
@property (weak, nonatomic) IBOutlet UIButton *editTestButton;
@property (weak, nonatomic) IBOutlet UILabel *typeValueLabel;

@end
