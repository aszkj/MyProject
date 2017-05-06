//
//  WSJMerchantDetailsTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/9/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJMerchantDetailsTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface WSJMerchantDetailsTableViewCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *xianHeight;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *selledCount;

@end

@implementation WSJMerchantDetailsTableViewCell

- (void)awakeFromNib {
    self.xianHeight.constant = 0.25;
}

-(void)willCustomCellWithData:(NSDictionary *)dict
{
    [self.titleImageVIew sd_setImageWithURL:[NSURL URLWithString:dict[@"groupAccPath"]]];
    self.titleNameLabel.text = dict[@"ggName"];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",[dict[@"groupPrice"] floatValue]];
    self.selledCount.text = [NSString stringWithFormat:@"【已售%@】",dict[@"selledCount"]];
}

@end
