//
//  IntegralShopCell.h
//  jingGang
//
//  Created by 张康健 on 15/10/30.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kCellImgToBottomGap 45
#define KIntegralCellGap 10
#define KCellWith  (kScreenWidth - 3 * KIntegralCellGap) / 2
#define KCellHeight (KCellWith + kCellImgToBottomGap)

@class IntegralListBO;
@interface IntegralShopCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *integralGoodsImgView;

@property (nonatomic, copy)IntegralListBO *model;
@property (weak, nonatomic) IBOutlet UILabel *integralGoodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *integralLabel;


@end
