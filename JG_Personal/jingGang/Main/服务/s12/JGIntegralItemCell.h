//
//  JGIntegralItemCell.h
//  jingGang
//
//  Created by dengxf on 15/12/18.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IntegralListBO;

@interface JGIntegralItemCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *integralShopImageView;
@property (weak, nonatomic) IBOutlet UILabel *integralShopPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *integralNameLab;

@property (strong,nonatomic) IntegralListBO *listBO;

@end
