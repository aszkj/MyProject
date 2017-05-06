//
//  SubRunDetailTableViewCell.h
//  Merchants_JingGang
//
//  Created by thinker on 15/9/7.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubRunDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *usrMessage;
@property (weak, nonatomic) IBOutlet UILabel *recommendMoney;
@property (weak, nonatomic) IBOutlet UILabel *upTime;
@property (weak, nonatomic) IBOutlet UILabel *serverCode;

- (void)setServerNameWithString:(NSString *)name;
- (void)configData:(id)object;


@end
