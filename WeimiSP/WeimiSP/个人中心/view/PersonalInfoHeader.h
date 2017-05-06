//
//  PersonalInfoHeader.h
//  WeimiSP
//
//  Created by thinker on 16/2/19.
//  Copyright © 2016年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^EditInfoActionBlock)(void);


@interface PersonalInfoHeader : UIView


@property (nonatomic, strong) UIImageView *userImageView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *userTelLabel;

@property (nonatomic, strong) UILabel *orderNumberLabel;
@property (nonatomic, strong) UILabel *profitLabel;

/**
 *  点击编辑返回
 */
@property (nonatomic, copy) EditInfoActionBlock editInfoActionBlock;

@end
