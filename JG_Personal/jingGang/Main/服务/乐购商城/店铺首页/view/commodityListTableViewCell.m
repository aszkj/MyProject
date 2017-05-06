//
//  commodityListTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/8/3.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "commodityListTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "GlobeObject.h"

@interface commodityListTableViewCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleNameHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *jifenConstranint;
@property (weak, nonatomic) IBOutlet UILabel *mobilePriceLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xianGao;
@end

@implementation commodityListTableViewCell

- (void)willSearchCellWithModel:(NSDictionary *)dict
{
    NSLog(@"dict1 ---- %@",dict);
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",dict[@"storePrice"]];
    [self setTitleNameLabelText:dict[@"title"]];
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:TwiceImgUrlStr(dict[@"mainPhotoUrl"], self.titleImageView.frame.size.width, self.titleImageView.frame.size.height) ]];
    self.mobilePriceLabel.hidden = YES;
//    if ([dict[@"hasExchangeIntegral"] boolValue])//是否有积分兑换价格 goodsIntegralPrice
//    {
//        self.jifenLabel.hidden = YES;
////        [self setJifenLabelText:[NSString stringWithFormat:@"￥%@+%@积分兑换",dict[@"goodsIntegralPrice"],dict[@"exchangeIntegral"]]];
//    }
//    else
//    {
//        self.jifenLabel.hidden = YES;
//    }
    if ([dict[@"hasMobilePrice"] boolValue] && [dict[@"mobilePrice"] floatValue] > 0) //是否有手机专享价 mobilePrice
    {
        self.mobilePriceLabel.hidden = NO;
        self.mobilePriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[dict[@"mobilePrice"] floatValue] ];
        self.iphoneView.hidden = NO;
    }
    else
    {
        self.iphoneView.hidden = YES;
    }
}

- (void)willCellWithModel:(NSDictionary *)dict
{
    NSLog(@"dict ---- %@",dict);
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",dict[@"goodsShowPrice"]];
    [self setTitleNameLabelText:dict[@"goodsName"]];
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:TwiceImgUrlStr(dict[@"goodsMainPhotoPath"], self.titleImageView.frame.size.width, self.titleImageView.frame.size.height) ]];
//    if ([dict[@"hasExchangeIntegral"] boolValue])//是否有积分兑换价格 goodsIntegralPrice
//    {
//        self.jifenLabel.hidden = NO;
//        [self setJifenLabelText:[NSString stringWithFormat:@"￥%@+%@积分兑换",dict[@"goodsIntegralPrice"],dict[@"exchangeIntegral"]]];
//    }
//    else
//    {
//        self.jifenLabel.hidden = YES;
//    }
    if ([dict[@"hasMobilePrice"] boolValue]) //是否有手机专享价 mobilePrice
    {
        self.mobilePriceLabel.hidden = NO;
        self.mobilePriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[dict[@"mobilePrice"]floatValue]];
        self.iphoneView.hidden = NO;
    }
    else
    {
        self.mobilePriceLabel.hidden = YES;
        self.iphoneView.hidden = YES;
    }
}
- (void)awakeFromNib {
    self.titleNameLabel.adjustsFontSizeToFitWidth = YES;
    self.xianGao.constant = 0.3;
    self.priceLabel.adjustsFontSizeToFitWidth = YES;
    self.jifenLabel.adjustsFontSizeToFitWidth = YES;
    self.mobilePriceLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)setJifenLabelText:(NSString *)text
{
    self.jifenLabel.text = text;
    CGRect frame = [text boundingRectWithSize:CGSizeMake(1200, CGRectGetHeight(self.jifenLabel.frame)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    self.jifenConstranint.constant = frame.size.width;
}
- (void) setTitleNameLabelText:(NSString *)text
{
    self.titleNameLabel.text = text;
    CGRect frame = [text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.titleNameLabel.frame), 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];
    self.titleNameHeight.constant = frame.size.height;
    if (frame.size.height > 55)
    {
        self.titleNameHeight.constant = 55;
    }
}


@end
