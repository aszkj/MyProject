//
//  WSJPromotionTableViewCell.m
//  jingGang
//
//  Created by thinker on 15/9/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "WSJPromotionTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "Util.h"

@interface WSJPromotionTableViewCell ()
//标题图片
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
//商铺名称
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
//商品名称
@property (weak, nonatomic) IBOutlet UILabel *ggNameLabel;
//商品价格
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
//距离
@property (weak, nonatomic) IBOutlet UILabel *distanceLable;
//已经出售个数
@property (weak, nonatomic) IBOutlet UILabel *selledCountLabel;


@end

@implementation WSJPromotionTableViewCell

- (void)awakeFromNib
{
    
}
- (void)willCustomCellWithData:(NSDictionary *)dict
{
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"groupAccPath"]]];
    self.storeNameLabel.text = dict[@"ggName"];
    self.ggNameLabel.text = dict[@"storeName"];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",dict[@"groupPrice"]];
    self.distanceLable.text = [Util transferDistanceStrWithDistance:dict[@"distance"]];
    self.selledCountLabel.text = [NSString stringWithFormat:@"【已售%@件】",dict[@"selledCount"]];
}



@end
