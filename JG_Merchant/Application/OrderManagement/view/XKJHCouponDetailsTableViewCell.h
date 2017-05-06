//
//  XKJHCouponDetailsTableViewCell.h
//  Merchants_JingGang
//
//  Created by thinker on 15/9/5.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XKJHCouponDetailsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void) setNameWithText:(NSString *)text;

@end
