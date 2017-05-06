//
//  SimilarHeartRateEditView.h
//  jingGang
//
//  Created by 张康健 on 15/8/1.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GloableEmerator.h"


typedef void(^EditEndBlock)(NSString *inputValue);
@interface SimilarHeartRateEditView : UIView
@property (weak, nonatomic) IBOutlet UILabel *editTypeLabel;
@property (weak, nonatomic) IBOutlet UITextField *editTextField;
@property (weak, nonatomic) IBOutlet UIView *bgView;

-(void)beginAnimation;
-(void)endAnimation;
//移除整个View
- (void)backButtonClickRemoveEditView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputViewToTopEdgeConstraint;

//编辑类型
@property (nonatomic, assign)TestEditType testEditType;

@property (nonatomic, copy)EditEndBlock editEndBlock;

@end
