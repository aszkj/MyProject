//
//  XKJHConsumeSucceed.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/2.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHConsumeSucceed.h"

@interface XKJHConsumeSucceed ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xianHeight;
@property (weak, nonatomic) IBOutlet UIView *backVIew;

@end

@implementation XKJHConsumeSucceed

-(void)awakeFromNib
{
    self.backVIew.layer.cornerRadius = 5;
    self.backVIew.clipsToBounds = YES;
    self.xianHeight.constant = 0.3;
}
- (IBAction)certainAction:(id)sender
{
    if (self.succeedBlock)
    {
        self.hidden = YES;
        self.succeedBlock();
    }
}

@end
