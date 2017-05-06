//
//  PersonalCenterTableViewCell.h
//  weimi
//
//  Created by thinker on 16/1/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UpdateHeadImageBlock)(void);

@interface PersonalCenterTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UIImageView *rightImageView;

@property (nonatomic, strong) UILabel     *rightLabel;

@property (nonatomic, strong) UIButton    *rightButton;

/**
 *  修改头像
 */
@property (nonatomic, copy) UpdateHeadImageBlock updateHeadImageBlock;

@end
