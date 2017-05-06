//
//  XKJHShopEnterHeaderView.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHShopEnterHeaderView.h"

@interface XKJHShopEnterHeaderView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xianWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xianHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleWidth;
@property (weak, nonatomic) IBOutlet UIButton           *rightBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation XKJHShopEnterHeaderView
- (IBAction)photoAction:(UIButton *)sender
{
    if ([self.model.title containsString:@"其他证明"])
    {
        if (self.model.imageArray.count > 4)
        {
            [Util ShowAlertWithOnlyMessage:@"其他证明不能操作5张"];
            return;
        }
    }
    else
    {
        if (self.model.imageArray.count > 0)
        {
            NSArray *message = [self.model.title componentsSeparatedByString:@"*"];
            [Util ShowAlertWithOnlyMessage:[NSString stringWithFormat:@"%@限制一张",message[0]]];
            return;
        }
    }
    
    if (self.photoBlock)
    {
        self.photoBlock();
    }
}
- (IBAction)tapActon:(id)sender {
    [self photoAction:nil];
}

- (void)awakeFromNib
{
    self.xianHeight.constant = 0.3;
    self.xianWidth.constant = 0.0;
    self.titleWidth.constant = 280;
}
- (void)setModel:(XKJHShopEnterInfoModel *)model
{
    _model = model;
    self.titleLabel.attributedText = [Util getShopEnterAttributeString:model.title];;
}

-(void)setIsXian:(BOOL)isXian
{
//    _isXian = isXian;
    if (isXian)
    {
        self.xianWidth.constant = 0.25;
    }
    else
    {
        self.xianWidth.constant = 0.0;
    }
}

@end
