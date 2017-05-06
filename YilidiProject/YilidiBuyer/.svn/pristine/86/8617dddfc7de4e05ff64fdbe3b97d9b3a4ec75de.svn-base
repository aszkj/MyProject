//
//  DLSecondsKillZoneCell.h
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/8/19.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLProgressView.h"
#import "GoodsModel.h"

typedef void(^IsAboutToStrachGoodsBlock)(void);
#define kSeckillOtherPartHeightBesidesImg 34
#define kSeckillImgWidth ADAPT_SCREEN_WIDTH(115)
#define kSeckillImgHeight kSeckillImgWidth
#define kSeckillCellHeight (kSeckillImgHeight + kSeckillOtherPartHeightBesidesImg)
@class SeckillActivityModel;
@interface DLSecondsKillZoneCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *zomeImageView;
@property (strong, nonatomic) IBOutlet UILabel *goodsTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *specLable;
@property (strong, nonatomic) IBOutlet UILabel *activityLimitCountLabel;
@property (strong, nonatomic) IBOutlet DLProgressView *goodsLimitProgressView;
@property (strong, nonatomic) IBOutlet UILabel *seckillPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *isAboutToScratchButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *isAboutButtonWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seckillImgWidthConstraint;
@property (nonatomic,copy)IsAboutToStrachGoodsBlock isAboutToStrachGoodsBlock;

@end


@interface DLSecondsKillZoneCell (configureSeckillGoodsCell)

- (void)configureSeckillGoodsCellWithGoodsModel:(GoodsModel *)goodsModel seckillActivityModel:(SeckillActivityModel *)seckillActivityModel;
- (void)checkAddingShopCartOfGoodsModel:(GoodsModel *)goodsModel;
@end