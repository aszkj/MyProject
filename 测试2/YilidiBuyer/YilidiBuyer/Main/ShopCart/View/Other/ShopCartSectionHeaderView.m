//
//  ShopCartSectionHeaderView.m
//  YilidiBuyer
//
//  Created by yld on 16/8/1.
//  Copyright © 2016年 yld. All rights reserved.
//

#import "ShopCartSectionHeaderView.h"
#import "DisplayAdressView.h"
#import "StoreAdressView.h"
#import "AdressModel.h"
#import "StoreModel.h"
#import <Masonry/Masonry.h>
#import "UIButton+Block.h"

const CGFloat addressHeight = 80;

@interface ShopCartSectionHeaderView()

@property (nonatomic, strong)DisplayAdressView *displayAdressView;
@property (nonatomic, strong)StoreAdressView *storeAdressView;
@property (nonatomic, strong)UIView *addAdressView;
@property (weak, nonatomic) IBOutlet UIView *placeAdressView;

@end

@implementation ShopCartSectionHeaderView

- (void)awakeFromNib {
    
}


- (void)_configureUI {
    
    if (self.selectShipWay == ShipWay_DeliveryGoodsHome) {
        if (isEmpty(self.adressModel) || isEmpty(self.adressModel.consigneAdressId)) {
            self.addAdressView.hidden = NO;
            _displayAdressView.hidden = YES;
            _storeAdressView.hidden = YES;
        }else {
            self.displayAdressView.adressModel = self.adressModel;
            self.displayAdressView.hidden = NO;
            _addAdressView.hidden = YES;
            _storeAdressView.hidden = YES;
        }
    }else {
        self.storeAdressView.storeModel = self.storeModel;
        self.storeAdressView.hidden = NO;
        _addAdressView.hidden = YES;
        _displayAdressView.hidden = YES;
    }
}


- (void)setStoreModel:(StoreModel *)storeModel {
    _storeModel = storeModel;
    [self _configureUI];
}

- (void)setAdressModel:(AdressModel *)adressModel {
    
    _adressModel = adressModel;
    [self _configureUI];
}

- (DisplayAdressView *)displayAdressView {
    
    if (!_displayAdressView) {
        _displayAdressView = BoundNibView(@"DisplayAdressView", DisplayAdressView);
        [self.placeAdressView addSubview:_displayAdressView];
        [_displayAdressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_equalTo(self.placeAdressView);
        }];
        WEAK_SELF
        _displayAdressView.clickAdressBlock = ^(){
            emptyBlock(weak_self.enterAdressPageBlock);
        };
    }
    return _displayAdressView;
}


- (StoreAdressView *)storeAdressView {
    
    if (!_storeAdressView) {
        _storeAdressView = BoundNibView(@"StoreAdressView", StoreAdressView);
        [self.placeAdressView addSubview:_storeAdressView];
        [_storeAdressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_equalTo(self.placeAdressView);
        }];
    }
    return _storeAdressView;
}


- (UIView *)addAdressView {
    
    if (!_addAdressView) {
        _addAdressView = BoundNibView(@"AddAdressView", UIView);
        [self.placeAdressView addSubview:_addAdressView];
        [_addAdressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_equalTo(self.placeAdressView);
        }];
        UIButton *clickToAddAdressButton = (UIButton *)[_addAdressView viewWithTag:5];
        WEAK_SELF
        [clickToAddAdressButton addActionHandler:^(NSInteger tag) {
            emptyBlock(weak_self.enterAdressPageBlock);
        }];
    }
    return _addAdressView;
}








@end
