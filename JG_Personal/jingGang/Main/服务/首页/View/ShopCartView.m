//
//  ShopCartView.m
//  jingGang
//
//  Created by 张康健 on 15/8/27.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "ShopCartView.h"
#import "Masonry.h"
#import "GlobeObject.h"
#import "VApiManager.h"

@interface ShopCartView(){

    VApiManager *_vapManager;
}

@property (weak, nonatomic) IBOutlet UILabel *shopNumberLabel;


@end

@implementation ShopCartView

-(void)awakeFromNib {
    
    self.shopNumberLabel.layer.cornerRadius = 7;
    self.shopNumberLabel.layer.masksToBounds = YES;
//    self.shopNumberLabel.hidden = YES;
    _vapManager = [[VApiManager alloc] init];
    
}

-(void)layoutSubviews {

    [super layoutSubviews];
    self.shopNumberLabel.hidden = YES;

}

+ (id)showOnNavgationView:(UIView *)navigationView {
    
    ShopCartView *shopCartView = [self shopCartView];
    [navigationView addSubview:shopCartView];
    WEAK_SELF
    [shopCartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(35, 33));
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(25);
    }];
    
    //第一次初始化的时候，自动请求购物车数量
    [shopCartView requestAndSetShopCartNumber];
    
    return shopCartView;
}

-(void)setShopCartNumber:(NSInteger)shopCartNumber {
    _shopCartNumber = shopCartNumber;
    [self setShopCartNumberLabel];
}

-(void)requestAndSetShopCartNumber {
    if (isEmpty(GetToken)) {
        return;
    }
    //请求购物车数量
    ShopCartSizeRequest *request = [[ShopCartSizeRequest alloc] init:GetToken];
    
    [_vapManager shopCartSize:request success:^(AFHTTPRequestOperation *operation, ShopCartSizeResponse *response) {

        self.shopCartNumber = response.shopCartSize.integerValue;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


-(void)setShopCartNumberLabel{
    
    _shopNumberLabel.hidden = (_shopCartNumber ? NO : YES);
    self.shopNumberLabel.text = [NSString stringWithFormat:@"%ld",_shopCartNumber];
}


+ (ShopCartView *)shopCartView {

    return BoundNibView(@"ShopCartView", ShopCartView);
}



- (IBAction)cominToShopCartAction:(id)sender {
    
    if (self.cominToShopCartBlock) {
        self.cominToShopCartBlock();
    }
}

@end
