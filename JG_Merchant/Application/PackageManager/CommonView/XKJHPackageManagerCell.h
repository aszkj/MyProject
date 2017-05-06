//
//  XKJHPackageManagerCell.h
//  Merchants_JingGang
//
//  Created by 鹏 朱 on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PressBlk)(void);

@interface XKJHPackageManagerCell : UITableViewCell

@property (strong, nonatomic) UIImageView *thumbnail;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *price;
@property (strong, nonatomic) UILabel *saledNumber;
@property (strong, nonatomic) UIButton *offShelfBtn;
@property (strong, nonatomic) UILabel *addShelfState;

@property (copy, nonatomic) PressBlk pressBlock;


- (id)initWithStyle:(UITableViewCellStyle)style type:(NSInteger)typeNum reuseIdentifier:(NSString *)reuseIdentifier;

@end
