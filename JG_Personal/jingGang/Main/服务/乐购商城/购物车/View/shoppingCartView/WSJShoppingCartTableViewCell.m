//
//  WSJShoppingCartTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/8/7.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJShoppingCartTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "GlobeObject.h"

@interface WSJShoppingCartTableViewCell ()
{
    WSJShoppingCartInfoModel *_model;
}

//选中按钮
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
//标题图片
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
//标题名称
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//商品规格
@property (weak, nonatomic) IBOutlet UILabel *specInfo;
//物件价格
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
//商品个数
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iphoneImage;

@end

@implementation WSJShoppingCartTableViewCell
- (void)willCellWith:(WSJShoppingCartInfoModel *)model
{
    _model = model;
    self.selectBtn.selected = model.isSelect;
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:TwiceImgUrlStr(model.imageURL, self.titleImageView.frame.size.width, self.titleImageView.frame.size.height)]];
    self.titleLabel.text = model.name;
    self.specInfo.text = model.specInfo;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.goodsCurrentPrice];
    self.countLabel.text = [NSString stringWithFormat:@"x%@",model.count];
    if ([model.hasMobilePrice boolValue])
    {
        self.iphoneImage.hidden = NO;
    }
    else
    {
        self.iphoneImage.hidden = YES;
    }
}
- (IBAction)selectAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    _model.isSelect = sender.selected;
    if (self.selectShopping)
    {
        self.selectShopping([_model.ID stringValue],sender.selected);
    }
}

- (void)awakeFromNib {
    self.specInfo.adjustsFontSizeToFitWidth = YES;
    self.priceLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.countLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)btnAction:(id)sender {
    [self selectAction:self.selectBtn];
}

@end
