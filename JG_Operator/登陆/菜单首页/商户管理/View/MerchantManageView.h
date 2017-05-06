//
//  MerchantManageView.h
//  Operator_JingGang
//
//  Created by 张康健 on 15/9/19.
//  Copyright (c) 2015年 XKJH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"
#import "HMSegmentedControl+setAttribute.h"
#import "MerchantManagerHelper.h"

@interface MerchantManageView : UIView

- (id)init;
- (id)initWithFrame:(CGRect)frame;

@property (nonatomic, strong)HMSegmentedControl *topBarHMSegmentedControl;

@property (nonatomic, strong)MerchantManagerHelper *merchantManagerHelper;

@property (nonatomic, assign)MerchantType merchantType;

@end
