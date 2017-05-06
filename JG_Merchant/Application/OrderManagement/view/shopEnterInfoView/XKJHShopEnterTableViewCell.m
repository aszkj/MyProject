//
//  XKJHShopEnterTableViewCell.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/6.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHShopEnterTableViewCell.h"

@interface XKJHShopEnterTableViewCell ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xianHeight;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation XKJHShopEnterTableViewCell

- (void)awakeFromNib {
    self.xianHeight.constant = 0.4;
    self.contentTextView.delegate = self;
}

- (void)setModel:(XKJHShopEnterInfoModel *)model
{
    _model = model;
    self.titleLabel.attributedText = [Util getShopEnterAttributeString:model.title];
    self.contentTextView.text = model.content;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.model.content = textView.text;
}

@end
