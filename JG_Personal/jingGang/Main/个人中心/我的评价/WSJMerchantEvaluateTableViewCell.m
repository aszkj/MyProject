//
//  WSJMerchantEvaluateTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/9/11.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJMerchantEvaluateTableViewCell.h"
#import "WSJEvaluateView.h"

@interface WSJMerchantEvaluateTableViewCell ()

@property (weak, nonatomic) IBOutlet WSJEvaluateView *evaluate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *evaluateHeight;

@end

@implementation WSJMerchantEvaluateTableViewCell

- (void)awakeFromNib {
    
}
- (void)setModel:(WSJEvaluateModel *)model
{
    self.evaluateHeight.constant = model.O2OHeight;
    self.evaluate.model = model;
}

@end
