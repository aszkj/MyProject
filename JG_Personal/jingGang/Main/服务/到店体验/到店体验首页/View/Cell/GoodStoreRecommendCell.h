//
//  GoodStoreRecommendCell.h
//  jingGang
//
//  Created by 张康健 on 15/9/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendStoreModel.h"
#import "CWStarRateView.h"
@interface GoodStoreRecommendCell : UITableViewCell

@property (weak, nonatomic) IBOutlet CWStarRateView *rateView;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *storeImgView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (nonatomic, strong)RecommendStoreModel *recommendStoreModel;

@end
