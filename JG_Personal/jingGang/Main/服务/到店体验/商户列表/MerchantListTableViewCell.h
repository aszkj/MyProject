//
//  MerchantListTableViewCell.h
//  JingGangIB
//
//  Created by thinker on 15/9/10.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSJStarView.h"

@interface MerchantListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *merchanImage;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UILabel *shopAddress;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet WSJStarView *starView;

- (void)configWithObject:(id)object;

@end
