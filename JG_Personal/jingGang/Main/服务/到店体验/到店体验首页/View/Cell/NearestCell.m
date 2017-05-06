//
//  NearestCell.m
//  jingGang
//
//  Created by 张康健 on 15/9/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "NearestCell.h"
#import "UIImageView+WebCache.h"

#import "GlobeObject.h"

@implementation NearestCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)layoutSubviews {
    
  [super layoutSubviews];
   
  NSString *twiceImgUrl = TwiceImgUrlStr(self.awareStoreModel.goodsPath, 115, 81);
    
  [self.serviceImgView sd_setImageWithURL:[NSURL URLWithString:twiceImgUrl] placeholderImage:nil];
   self.serviceNameLabel.text = self.awareStoreModel.goodsName;
   self.storeNameLabel.text = self.awareStoreModel.storeName;
//   self.servicePriceLabel.text = [NSString stringWithFormat:@"%@",self.awareStoreModel.price];
     self.servicePriceLabel.text = kNumberToStrRemain2Point(self.awareStoreModel.price);
   self.saledNumBerLabel.text = [NSString stringWithFormat:@"【已售%@】",self.awareStoreModel.sales];
   self.distanceLabel.text =[Util transferDistanceStrWithDistance:self.awareStoreModel.distance];
}



@end
