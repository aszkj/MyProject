//
//  WSJShoppingCartHeaderView.m
//  jingGang
//
//  Created by thinker on 15/8/7.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJShoppingCartHeaderView.h"

@interface WSJShoppingCartHeaderView ()

//选择按钮
@property (weak, nonatomic) IBOutlet UIButton *allBtn;
//名称
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
//logo图片
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
//编辑按钮
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@end

@implementation WSJShoppingCartHeaderView
//全选按钮
- (IBAction)selectBtn:(UIButton *)sender {
    sender.selected = ! sender.selected;
    if (self.selectBlock)
    {
        self.selectBlock(sender.selected);
    }
}
-(void)awakeFromNib
{
    self.titleNameLabel.adjustsFontSizeToFitWidth = YES;
}
- (void)noSelect
{
    self.allBtn.selected = NO;
}
- (IBAction)headerAction:(id)sender {
    if (self.selectHeaderBlock)
    {
        self.selectHeaderBlock();
    }
}
//编辑按钮
- (IBAction)editBtn:(UIButton *)sender {
    sender.selected = ! sender.selected;
    if (self.editBlock)
    {
        self.editBlock(sender.selected);
    }
}
- (void)willHearderWithModel:(WSJShoppingCartModel *)model
{
    self.allBtn.selected = model.isAll;
    if (model.name)
    {
        self.titleNameLabel.text = model.name;
    }
    else
    {
        self.titleNameLabel.text = @"自营";
    }
    if (model.goodsType)
    {
        self.logoImageView.image = [UIImage imageNamed:@"商家"];
    }
    else
    {
        self.logoImageView.image = [UIImage imageNamed:@"自营"];
    }
    self.editBtn.selected = model.edit;
}
- (IBAction)btnAction:(id)sender {
    [self selectBtn:self.allBtn];
}

@end
