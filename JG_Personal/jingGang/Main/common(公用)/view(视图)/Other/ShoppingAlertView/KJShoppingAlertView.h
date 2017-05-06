//
//  KJShoppingAlertView.h
//  jingGang
//
//  Created by 张康健 on 15/8/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KJShoppingAlertView : UIView
@property (weak, nonatomic) IBOutlet UILabel *alertTitle;

+ (void)showAlertTitle:(NSString *)title inContentView:(UIView *)contentView;
@property (weak, nonatomic) IBOutlet UILabel *alertLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;


+ (KJShoppingAlertView *)shareAlertView;

@end
