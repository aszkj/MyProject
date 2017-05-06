//
//  HasyouLikeCollecionCell.h
//  jingGang
//
//  Created by 张康健 on 15/8/21.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define KRecommendImgWith (kScreenWidth/2 - 2*10)
#define KRecommendGoodsCellHeight (KRecommendImgWith + 2*10+5)
@interface HasyouLikeCollecionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *hasYouLikeImgView;
@property (weak, nonatomic) IBOutlet UILabel *labelPrice;
@property (weak, nonatomic) IBOutlet UILabel *labelGoodsName;

@end
