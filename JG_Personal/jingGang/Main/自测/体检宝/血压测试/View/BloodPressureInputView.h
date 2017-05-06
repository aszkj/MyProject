//
//  BloodPressureInputView.h
//  jingGang
//
//  Created by 张康健 on 15/7/27.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

//结果回调block
typedef void(^BloodPressureInputResultBlock)(NSInteger lowPressure, NSInteger highPressure);

@interface BloodPressureInputView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint  *topViewToTopConstraint;
@property (weak, nonatomic) IBOutlet UIView              *topView;
@property (weak, nonatomic) IBOutlet UITextField         *hightPressureTextFiled;
@property (weak, nonatomic) IBOutlet UITextField         *lowPressureTextField;

@property (nonatomic, copy) BloodPressureInputResultBlock   bloodPressureInputResultBlock;

@end
