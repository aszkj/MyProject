//
//  PromoteSaleRecommendCell.h
//  jingGang
//
//  Created by 张康健 on 15/9/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceModel.h"
@interface PromoteSaleRecommendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *serviceImgView;
@property (weak, nonatomic) IBOutlet UILabel *serviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *servicePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *hasSaledLabel;

@property (nonatomic, strong)ServiceModel *serviceModel;

@end
