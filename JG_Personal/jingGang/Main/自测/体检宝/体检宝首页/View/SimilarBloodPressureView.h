//
//  SimilarBloodPressureView.h
//  jingGang
//
//  Created by 张康健 on 15/8/1.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GloableEmerator.h"

typedef void(^LowAndHighBlock)(NSString *lowValue,NSString *highValue);

@interface SimilarBloodPressureView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputViewToTopEdgeConstraint;

@property (weak, nonatomic) IBOutlet UILabel *lowLabel;
@property (weak, nonatomic) IBOutlet UITextField *lowTextField;
@property (weak, nonatomic) IBOutlet UILabel *highLabel;
@property (weak, nonatomic) IBOutlet UITextField *highTextField;

@property (nonatomic,copy)LowAndHighBlock lowAndHighBlock;
//编辑类型
@property (nonatomic, assign)TestEditType testEditType;


@end
