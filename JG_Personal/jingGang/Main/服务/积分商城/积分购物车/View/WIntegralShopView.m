//
//  WIntegralShopView.m
//  jingGang
//
//  Created by thinker on 15/11/2.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "WIntegralShopView.h"
#import "PublicInfo.h"

@interface WIntegralShopView ()

@end

@implementation WIntegralShopView

-(void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:dict[@"goodsImg"]]];
    self.titleLabel.text = dict[@"goodsName"];
    self.integralLabel.text = [NSString stringWithFormat:@"积分%@",dict[@"igoTotalIntegral"]];
    self.countLabel.text = [NSString stringWithFormat:@"x%@",dict[@"goodsCount"]];
}

- (void)setAddTimeLab:(UILabel *)addTimeLab {
    _addTimeLab.hidden = NO;
    _addTimeLab = addTimeLab;
}

- (void)awakeFromNib
{
    self.tag = 1111;
}
- (IBAction)tapAction:(id)sender
{
    if (self.shopAction)
    {
        self.shopAction(self.dict);
    }
}

@end
