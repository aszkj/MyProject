//
//  NearestCell.h
//  jingGang
//
//  Created by 张康健 on 15/9/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AwareStoreModel.h"
@interface NearestCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *serviceImgView;
@property (weak, nonatomic) IBOutlet UILabel *serviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *servicePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *saledNumBerLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (nonatomic, strong)AwareStoreModel *awareStoreModel;

@end
