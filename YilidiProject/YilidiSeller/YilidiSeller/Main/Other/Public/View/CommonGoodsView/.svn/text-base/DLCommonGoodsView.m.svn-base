//
//  DLCommonGoodsView.m
//  YilidiSeller
//
//  Created by yld on 16/3/25.
//  Copyright © 2016年 Dellidc. All rights reserved.
//

#import "DLCommonGoodsView.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface DLCommonGoodsView()

@property (nonatomic,strong)UIImageView *goodsImgView;
@property (nonatomic,strong)UILabel *goodsDiscriptionLabel;
@property (nonatomic,strong)UILabel *goodsPriceLabel;
@property (nonatomic,strong)UILabel *goodsStockLabel;
@property (nonatomic,strong)UILabel *goodsBuyCountLabel;

@end

@implementation DLCommonGoodsView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _setUPView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _setUPView];
    }
    return self;
}

-(void)setCommonGoodsModel:(DLCommonGoodsModel *)commonGoodsModel {
    
    _commonGoodsModel = commonGoodsModel;
    [self _configureUI];
}

-(void)_configureUI {

    [self.goodsImgView sd_setImageWithURL:[NSURL URLWithString:self.commonGoodsModel.goodsImgUrlStr] placeholderImage:nil];
    self.goodsDiscriptionLabel.text = self.commonGoodsModel.goodsDescription;
    self.goodsPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",self.commonGoodsModel.goodsPrice.floatValue];
    self.goodsStockLabel.hidden = !self.commonGoodsModel.hasToShowStock;
    if (self.commonGoodsModel.hasToShowStock) {
        self.goodsStockLabel.text = [NSString stringWithFormat:@"库存：X%ld",self.commonGoodsModel.goodsStock.integerValue];
    }
    self.goodsBuyCountLabel.hidden = !self.commonGoodsModel.hasToShowGoodsBuyCount;
    if (self.commonGoodsModel.hasToShowGoodsBuyCount) {
        self.goodsBuyCountLabel.text = [NSString stringWithFormat:@"x%ld",self.commonGoodsModel.goodsBuyCount.integerValue];
    }
}


- (void)_setUPView {
    
    self.goodsImgView = [UIImageView new];
    self.goodsImgView.clipsToBounds = YES;
    [self addSubview:self.goodsImgView];
    
    self.goodsDiscriptionLabel = [UILabel new];
    self.goodsDiscriptionLabel.font = kSystemFontSize(14);
    self.goodsDiscriptionLabel.textColor = kGetColor(159, 159, 161);
    self.goodsDiscriptionLabel.numberOfLines = 0;
    [self addSubview:self.goodsDiscriptionLabel];
    
    self.goodsPriceLabel = [UILabel new];
    self.goodsPriceLabel.font = kSystemFontSize(14);
    self.goodsPriceLabel.textColor = kGetColor(237, 134, 133);
    [self addSubview:self.goodsPriceLabel];
    
    self.goodsStockLabel = [UILabel new];
    self.goodsStockLabel.font = kSystemFontSize(14);
    self.goodsStockLabel.textColor = kGetColor(237, 134, 133);
    [self addSubview:self.goodsStockLabel];
    
    self.goodsBuyCountLabel = [UILabel new];
    self.goodsBuyCountLabel.font = kSystemFontSize(11);
    self.goodsBuyCountLabel.textColor = [UIColor blackColor];
    [self addSubview:self.goodsBuyCountLabel];
    
    [self.goodsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13);
        make.size.mas_equalTo(CGSizeMake(67, 67));
        make.centerY.mas_equalTo(self);
    }];
    
    [self.goodsDiscriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsImgView.mas_right).with.offset(8);
        make.top.mas_equalTo(6);
        make.right.mas_equalTo(-8);
    }];
    
    [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsImgView.mas_right).with.offset(6);
        make.bottom.mas_equalTo(self.goodsImgView);
        make.height.mas_equalTo(21);
    }];
    
    [self.goodsStockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsPriceLabel.mas_right).with.offset(14);
        make.bottom.mas_equalTo(self.goodsImgView);
        make.height.mas_equalTo(21);
    }];
    
    [self.goodsBuyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-8);
        make.bottom.mas_equalTo(-4);
        make.height.mas_equalTo(21);
    }];
    
}

@end

@implementation DLCommonGoodsModel

@end

