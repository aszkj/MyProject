//
//  JGPayCloudView.h
//  jingGang
//
//  Created by dengxf on 16/1/6.
//  Copyright © 2016年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGPayCloudView : UIView

/** 微信支付按钮 */
@property (weak, nonatomic) IBOutlet UIButton *wxPayButton;

/** 支付宝支付按钮 */
@property (weak, nonatomic) IBOutlet UIButton *alPayButton;

/**
 *  初始化充值页面，并返回充值结果
 *
 */
- (instancetype)initWithPaySuccess:(void(^)(BOOL payResult,id response))succ superController:(UINavigationController *)superController;

- (IBAction)selectedWXPayAction:(UIButton *)sender;

- (IBAction)selectedALiPayAction:(UIButton *)sender;

// 下一步
- (IBAction)payNextAction:(UIButton *)sender;

@end
