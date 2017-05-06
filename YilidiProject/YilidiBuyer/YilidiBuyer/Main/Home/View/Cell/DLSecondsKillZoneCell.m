//
//  DLSecondsKillZoneCell.m
//  YilidiBuyer
//
//  Created by 曾勇兵 on 16/8/19.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLSecondsKillZoneCell.h"
#import "UIImageView+sd_SetImg.h"
#import "SeckillActivityModel.h"
#import "ShopCartGoodsManager+shopCartInfo.h"
#import "ProjectRelativeMaco.h"
#import "UIButton+Design.h"
const CGFloat isAboutToStrachButtonNormalWidth = 70;
const CGFloat isAboutToStrachButtonBiggerWidth = 85;

@interface DLSecondsKillZoneCell()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goodsTitleToTopConstraint;

@end

@implementation DLSecondsKillZoneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.seckillImgWidthConstraint.constant = kSeckillImgWidth;
    [self.isAboutToScratchButton setEnlargeEdge:8];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)isAboutToScratchAction:(id)sender {
    emptyBlock(self.isAboutToStrachGoodsBlock);
}

@end


@implementation DLSecondsKillZoneCell (configureSeckillGoodsCell)

- (void)configureSeckillGoodsCellWithGoodsModel:(GoodsModel *)goodsModel seckillActivityModel:(SeckillActivityModel *)seckillActivityModel
{

    [self.zomeImageView sd_SetImgWithUrlStr:goodsModel.goodsThumbnail placeHolderImgName:nil];
    self.goodsTitleLabel.text = goodsModel.goodsName;
    self.specLable.text = goodsModel.goodsStand;
    self.seckillPriceLabel.text = kNumberToStrRemain2PointRMBWithOutPrice(goodsModel.seckillPrice);
    goodsModel.seckillActivityId = seckillActivityModel.activityId;
    [self configureActiviRelatedWithGoodsModel:goodsModel seckillActivityModel:seckillActivityModel];
}

- (void)configureActiviRelatedWithGoodsModel:(GoodsModel *)goodsModel seckillActivityModel:(SeckillActivityModel *)seckillActivityModel {
    [self _configureActiviGoodsLimitViewAndLabelWithGoodsModel:goodsModel seckillActivityModel:seckillActivityModel];
    [self _configureIsAboutToStrachButtonWithGoodsModel:goodsModel seckillActivityModel:seckillActivityModel];
}

- (void)_configureActiviGoodsLimitViewAndLabelWithGoodsModel:(GoodsModel *)goodsModel seckillActivityModel:(SeckillActivityModel *)seckillActivityModel {
    BOOL showGoodsLimitView = YES;
    SeckillActivityStatus currentGoodsInActivityStatus = seckillActivityModel.seckillActivityStatus;
    if (currentGoodsInActivityStatus == SeckillActivityStatus_hasBegan || currentGoodsInActivityStatus == SeckillActivityStatus_crazySaling) {
        showGoodsLimitView = YES;
        //赋值
        self.goodsLimitProgressView.maxValue = goodsModel.seckillTotalCount.integerValue;
        self.goodsLimitProgressView.value = goodsModel.goodsStock.integerValue;
        NSString *limitLableShowStr = @"";
        if (goodsModel.goodsStock.integerValue) {
            limitLableShowStr = jFormat(@"限量%ld件",goodsModel.seckillShowTotalCount.integerValue);
        }else {
            limitLableShowStr = @"已抢购完";
        }
        self.activityLimitCountLabel.text = limitLableShowStr;
    }else {

        showGoodsLimitView = NO;
    }
    self.activityLimitCountLabel.hidden = self.goodsLimitProgressView.hidden = !showGoodsLimitView;
}

- (void)_configureIsAboutToStrachButtonWithGoodsModel:(GoodsModel *)goodsModel seckillActivityModel:(SeckillActivityModel *)seckillActivityModel {
    SeckillActivityStatus currentGoodsInActivityStatus = seckillActivityModel.seckillActivityStatus;
    if (currentGoodsInActivityStatus == SeckillActivityStatus_hasBegan || currentGoodsInActivityStatus == SeckillActivityStatus_crazySaling) {
        self.isAboutButtonWidthConstraint.constant = isAboutToStrachButtonNormalWidth;
        if (!goodsModel.goodsStock.integerValue) {//不能买
            [self _configureGoodsHasStrachedGone:YES eableTitle:@"抢光了"];
        }else {//能，但是还得判断库存,限购数量
            [self checkAddingShopCartOfGoodsModel:goodsModel];
        }
        
    }else {
        [self _soonBeginActivityIsAboutButtonConfigure];
    }
}

- (void)checkAddingShopCartOfGoodsModel:(GoodsModel *)goodsModel {
    if ([self _canGoOnAddToShopCartOfGoodsModel:goodsModel]) {
        [self _configureGoodsHasStrachedGone:NO eableTitle:@"马上抢"];
    }else {
        [self _configureGoodsHasStrachedGone:YES eableTitle:@"马上抢"];
    }
}

- (BOOL)_canGoOnAddToShopCartOfGoodsModel:(GoodsModel *)goodsModel{
    
    NSInteger goodsNumber = [[ShopCartGoodsManager sharedManager] goodsNumberOfGoodsModel:goodsModel];
    if (goodsNumber >= goodsModel.goodsStock.integerValue) {
        return NO;
    }else  if (goodsNumber >= goodsModel.limitBuyNumber.integerValue) {
        return NO;
    }
    return YES;
}

- (void)_soonBeginActivityIsAboutButtonConfigure {
    self.isAboutToScratchButton.backgroundColor = KSelectedBgColor;
//    self.isAboutToScratchButton.userInteractionEnabled = NO;
    [self.isAboutToScratchButton setTitle:@"即将开枪" forState:UIControlStateNormal];
    self.isAboutButtonWidthConstraint.constant = isAboutToStrachButtonBiggerWidth;
}

- (void)_configureGoodsHasStrachedGone:(BOOL)hasScratcheGone eableTitle:(NSString *)eableTitle{
    UIColor *isAboutToStrachButtonBgColor = nil;
    NSString *isAboutToStrachButtonTitle = nil;
    BOOL isAboutToStrachButtonUserInteract = YES;
    if (hasScratcheGone) {//不能买
        isAboutToStrachButtonUserInteract = NO;
        isAboutToStrachButtonBgColor = UIColorFromRGB(0xcecece);
        isAboutToStrachButtonTitle = eableTitle;
    }else {//能，但是还得判断库存
        isAboutToStrachButtonUserInteract = YES;
        isAboutToStrachButtonBgColor = KCOLOR_PROJECT_RED;
        isAboutToStrachButtonTitle = eableTitle;
    }
    self.isAboutToScratchButton.backgroundColor = isAboutToStrachButtonBgColor;
    self.isAboutToScratchButton.userInteractionEnabled = isAboutToStrachButtonUserInteract;
    [self.isAboutToScratchButton setTitle:isAboutToStrachButtonTitle forState:UIControlStateNormal];

}





@end
