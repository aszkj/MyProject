//
//  DLShopCartCell.m
//  YilidiBuyer
//
//  Created by yld on 16/5/4.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLFavoriteCell.h"
#import "UIImageView+sd_SetImg.h"
#import "ProjectRelativeMaco.h"
#import "ProjectRelativeKey.h"
#import "ProjectRelativeDefineNotification.h"
#import <Masonry/Masonry.h>

const CGFloat ScanConditioGoodsImgViewToLeftConstraint = 15;
const CGFloat EditConditioGoodsImgViewToLeftConstraint = 45;

@interface DLFavoriteCell()

@property (nonatomic, strong)UIImageView *enableImgView;
@property (weak, nonatomic) IBOutlet UIView *goodsBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *goodsImgViewToLeftConstraint;

@end

@implementation DLFavoriteCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)setSelectedAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    if (self.selectFavoriteGoodsBlock) {
        self.selectFavoriteGoodsBlock(button);
    }
}

- (UIImageView *)enableImgView {
    if (!_enableImgView) {
        _enableImgView = [UIImageView new];
        [self.goodsImgView addSubview:_enableImgView];
        [_enableImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.goodsBgView);
        }];
    }
    return _enableImgView;
}

@end

@implementation DLFavoriteCell (setShopCartCellModel)

-(void)setFavoriteCellModel:(GoodsModel *)model {

    [self.goodsImgView sd_SetImgWithUrlStr:model.goodsThumbnail placeHolderImgName:nil];
    self.goodsNameLabel.text = model.goodsName;
    self.goodsNowPriceLabel.text = kPriceFloatValueToRMB(model.goodsOrderPrice.floatValue);
    self.allSelectedButton.selected = model.selected;
    WEAK_SELF
    self.goodsCountChangeView.goodsModel = model;
    [self.goodsCountChangeView initUiFromShopCartGoodsId:model.goodsId];
    self.goodsCountChangeView.countChangedBlk = ^(NSInteger nowCount,BOOL isAdd){
        NSDictionary *postDic = @{kaddShopCartGoodsModelKey:model,
                                  kwillAnimateGoodsViewKey:self.goodsImgView,
                                  KGoodsChangeIsAddKey:@(isAdd)};
        [kNotification postNotificationName:KNotificationShopCartGoodsChange object:nil userInfo:postDic];
    };
    [self _dealGoodsStatusWithGoodsModel:model];
}

- (void)_dealGoodsStatusWithGoodsModel:(GoodsModel *)goodsModel {
    
    GoodsStatus goodsStatus = [goodsModel goodsStatus];
    CGFloat uiAlPha;
    if (goodsStatus != GoodsStatus_Normal) {
        NSString *uableGoodsImgName = nil;
        switch (goodsStatus) {
            case GoodsStatus_OffShelf:
                uableGoodsImgName = @"已下架";
                break;
            case GoodsStatus_NoStock:
                uableGoodsImgName = @"补货中";
                break;
            case GoodsStatus_OutOfDate:
                uableGoodsImgName = @"已过期";
                break;
            default:
                break;
        }
        self.enableImgView.hidden = NO;
        self.enableImgView.image = IMAGE(uableGoodsImgName);
        self.goodsCountChangeView.hidden = YES;
//        self.allSelectedButton.enabled = NO;
//        self.allSelectedButton.selected = NO;
        uiAlPha = 0.5;
    }else {
        if (_enableImgView) {
            _enableImgView.hidden = YES;
        }
        self.enableImgView.hidden = YES;
        self.allSelectedButton.enabled = YES;
        self.allSelectedButton.selected = goodsModel.selected;
        self.goodsCountChangeView.hidden = NO;
        uiAlPha = 1.0f;
    }
    self.goodsNameLabel.alpha = self.goodsNowPriceLabel.alpha  = uiAlPha;

}

- (void)favoriteCellIsEdit:(BOOL)isEdit cellModel:(GoodsModel *)model{

    self.goodsImgViewToLeftConstraint.constant = isEdit ? EditConditioGoodsImgViewToLeftConstraint :  ScanConditioGoodsImgViewToLeftConstraint;
    if ([model goodsStatus] == GoodsStatus_Normal) {
        self.goodsCountChangeView.hidden = isEdit;
    }else {
        self.goodsCountChangeView.hidden = YES;
    }

}


@end

