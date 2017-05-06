//
//  KJSelectGoodsCountCell.m
//  jingGang
//
//  Created by 张康健 on 15/8/9.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "KJSelectGoodsCountCell.h"
#import "GlobeObject.h"


@implementation KJSelectGoodsCountCell

- (void)awakeFromNib {
    
    self.buyGoodsCount = 1;
    //如果开始没有库存
    
    self.subCountButton.enabled = NO;
    
    [kNotification addObserver:self selector:@selector(observeGoodsStock:) name:goodsStockChangeNotification object:nil];
}

- (IBAction)addCountAction:(id)sender {
    
    self.buyGoodsCount ++;
    [self _setCountButton];
}


- (IBAction)subCountAction:(id)sender {
    self.buyGoodsCount --;
    [self _setCountButton];
}


-(void)_setCountButton{
    
    [self.countButton setTitle:[NSString stringWithFormat:@"%ld",_buyGoodsCount] forState:UIControlStateNormal];
    self.subCountButton.enabled = (self.buyGoodsCount > 1) ? YES : NO;
//     NSLog(@"库存 %ld",self.goodsStockCount);
    self.addButton.userInteractionEnabled = (self.buyGoodsCount < self.goodsStockCount) ? YES : NO;
    [kNotification postNotificationName:changeGoodsCountNotification object:@(_buyGoodsCount)];
}


- (void)observeGoodsStock:(NSNotification *)notiInfo {
    
    self.goodsStockCount = [notiInfo.object integerValue];
//    NSLog(@"库存有 %ld",self.goodsStockCount);
    //比较当前选择数量与squ库存，如果数量大于等于库存，取库存为当前购买数量，若小于则取当前值
    if (_buyGoodsCount >= _goodsStockCount) {//大于等于库存
        _buyGoodsCount = _goodsStockCount;
    }else{//小于库存，
        //如果当前数量为0，说明上一个库存为0,置1
        if (!_buyGoodsCount) {
            _buyGoodsCount = 1;
        }
    }
    
    if (!_goodsStockCount) {//若选择的规格库存为0,加减都不让
        self.addButton.enabled = NO;
    }else{
        self.addButton.enabled = YES;
    }
    [self _setCountButton];
}


- (void)dealloc
{
    [kNotification removeObserver:self];
}


@end
