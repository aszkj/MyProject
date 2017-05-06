//
//  XKJHShopCategoryTableViewCell.m
//  Merchants_JingGang
//
//  Created by thinker on 15/9/7.
//  Copyright (c) 2015年 RayTao. All rights reserved.
//

#import "XKJHShopCategoryTableViewCell.h"

@interface XKJHShopCategoryTableViewCell ()



@end

@implementation XKJHShopCategoryTableViewCell

- (void)awakeFromNib {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectTap:)];
    [self.titleNameLabel addGestureRecognizer:tap];
}
- (void)selectTap:(UITapGestureRecognizer *)sender
{
    [self selectBtnAction:self.selectBtn];
}
- (IBAction)selectBtnAction:(UIButton *)sender
{
    sender.selected = ! sender.selected;
    if (self.selectBlock)
    {
        self.selectBlock(sender.selected);
    }
}



@end
