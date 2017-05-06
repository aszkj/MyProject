//
//  PromoteSaleRecommendCell.m
//  jingGang
//
//  Created by 张康健 on 15/9/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "PromoteSaleRecommendCell.h"
#import "UIImageView+WebCache.h"
#import "GlobeObject.h"
@implementation PromoteSaleRecommendCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)setServiceModel:(ServiceModel *)serviceModel {

    _serviceModel = serviceModel;
     NSString *twiceImgUrl = TwiceImgUrlStr(_serviceModel.groupAccPath, 115, 81);
    [self.serviceImgView sd_setImageWithURL:[NSURL URLWithString:twiceImgUrl] placeholderImage:nil];
    self.serviceNameLabel.text = _serviceModel.ggName;
    self.storeLabel.text = _serviceModel.storeName;
//    self.servicePriceLabel.text = [NSString stringWithFormat:@"%@",_serviceModel.groupPrice];
    self.servicePriceLabel.text = kNumberToStrRemain2Point(self.serviceModel.groupPrice);
    self.distanceLabel.text =  [Util transferDistanceStrWithDistance:self.serviceModel.distance];
    
    self.hasSaledLabel.text = [NSString stringWithFormat:@"【已售%@】",_serviceModel.selledCount];
}


@end
