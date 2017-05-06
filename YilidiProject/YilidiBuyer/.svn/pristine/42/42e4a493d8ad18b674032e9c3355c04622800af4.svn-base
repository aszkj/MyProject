//
//  DLShopCartCell.m
//  YilidiBuyer
//
//  Created by yld on 16/5/4.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "DLShopCartCell.h"
#import "UIImageView+sd_SetImg.h"
#import "ProjectRelativeMaco.h"
#import "ProjectRelativeDefineNotification.h"
#import <Masonry/Masonry.h>
#import "GlobleConst.h"

@interface DLShopCartCell()

@property (nonatomic, strong)UIImageView *enableImgView;
@property (weak, nonatomic) IBOutlet UIView *goodsBgView;
@property (nonatomic,strong) GoodsModel *goodsModel;

@end

@implementation DLShopCartCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [kNotification addObserver:self selector:@selector(observeShopCartGoodsEditState:) name:KNotificationShopCartGoodsEditStateChange object:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setShopCartCellModel:(GoodsModel *)model {
    
    self.goodsModel = model;
    [self.goodsImgView sd_SetImgWithUrlStr:model.goodsThumbnail placeHolderImgName:nil];
    self.goodsNameLabel.text = model.goodsName;
    self.goodsNowPriceLabel.text = kPriceFloatValueToRMB(model.goodsOrderPrice.floatValue);
    self.goodsStandLabel.text = model.goodsStand;
    self.allSelectedButton.selected = model.selected;
    [self _dealGoodsStatusWithGoodsModel:model];
    [self _configureGoodsActivityUI];
    WEAK_SELF
    self.goodsCountChangeView.countChangedBlk = ^(NSInteger nowCount,BOOL isAdd){
        if (weak_self.changeShopCartGoodsCountBlock) {
            weak_self.changeShopCartGoodsCountBlock(nowCount,isAdd);
        }
    };
    self.goodsCountChangeView.deleteShopCartGoodsBlock = ^{
        emptyBlock(weak_self.deleteShopCartGoodsFromSubBlock);
    };
    self.goodsCountChangeView.goodsModel = model;
    [self.goodsCountChangeView initUiFromShopCartGoodsId:model.goodsId];
}

- (void)_configureGoodsActivityUI {
    if (self.goodsModel.goodsActivityDescription) {
        self.goodsActivityDescriptionLabel.text = self.goodsModel.goodsActivityDescription;
    }
    BOOL hasGoodsActivityDescription = self.goodsModel.goodsActivityDescriptionHeight > YLDSMALLVALUE;
    self.goodsActivityDescriptionLabel.hidden = self.separateGoodsActivityToGoodsInfoLineView.hidden = !hasGoodsActivityDescription;
}

- (void)_dealGoodsStatusWithGoodsModel:(GoodsModel *)goodsModel {
    
    ShopCartGoodsStatus goodsStatus = [goodsModel shopCartGoodsStatus];
    CGFloat uiAlPha;
    if (goodsStatus != ShopCartGoodsStatus_canBuy) {
        NSString *uableGoodsImgName = nil;
        switch (goodsStatus) {
            case ShopCartGoodsStatus_isOffShelf:
                uableGoodsImgName = @"已下架";
                break;
            case ShopCartGoodsStatus_hasGot:
                uableGoodsImgName = @"已领取";
                break;
            case ShopCartGoodsStatus_NoStock:
                uableGoodsImgName = @"缺货";
                break;
            case ShopCartGoodsStatus_hasGrabedOver:
                uableGoodsImgName = @"抢光了";
                break;
            default:
                break;
        }
        self.enableImgView.hidden = NO;
        self.enableImgView.image = IMAGE(uableGoodsImgName);
        self.goodsCountChangeView.hidden = YES;
        if (goodsModel.isShopCartGoodsEditing) {
            self.allSelectedButton.enabled = YES;
            self.allSelectedButton.selected = goodsModel.selected;
        }else {
            self.allSelectedButton.enabled = NO;
            self.allSelectedButton.selected = NO;
        }
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
    self.goodsNameLabel.alpha = self.goodsNowPriceLabel.alpha = self.goodsStandLabel.alpha = uiAlPha;
}


- (IBAction)deleteAction:(id)sender {
    if (self.deleteShopCartGoodsBlock) {
        self.deleteShopCartGoodsBlock();
    }
}

- (IBAction)setSelectedAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    if (self.selectShopCartGoodsBlock) {
        self.selectShopCartGoodsBlock(button);
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

- (void)observeShopCartGoodsEditState:(NSNotification *)notification{
    BOOL isShopCartEditing = [(NSNumber *)notification.object integerValue];
    if ([self.goodsModel shopCartGoodsStatus] == ShopCartGoodsStatus_canBuy) {
        return;
    }
    self.goodsModel.isShopCartGoodsEditing = isShopCartEditing;
    if (isShopCartEditing) {
        self.allSelectedButton.enabled = YES;
        self.allSelectedButton.selected = NO;
    }else {
        self.allSelectedButton.enabled = NO;
        self.allSelectedButton.selected = NO;
        self.goodsModel.selected = NO;
    }
}

- (void)dealloc {
    [kNotification removeObserver:self];
}

@end

@implementation DLShopCartCell (setShopCartCellModel)


@end

