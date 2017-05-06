//
//  AddSubCountView.m
//  jingGang
//
//  Created by 张康健 on 15/9/10.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import "AddSubCountView.h"
#import "Masonry.h"

@interface AddSubCountView() {

}

@property (weak, nonatomic) IBOutlet UIButton *subCountButton;
@property (weak, nonatomic) IBOutlet UIButton *countButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
//库存
@property (nonatomic, assign)NSInteger goodsStockCount;

@end

@implementation AddSubCountView

- (void)awakeFromNib {
    
    self.buyGoodsCount = 1;
    //如果开始没有库存
    self.subCountButton.enabled = NO;
}

+ (id)showInContentView:(UIView *)contentView goodStockCount:(NSInteger)goodsStockCount size:(CGSize)size{
    AddSubCountView *addSubCountView = [self addSubCountView];
    addSubCountView.goodsStockCount = goodsStockCount;
    [contentView addSubview:addSubCountView];
    [addSubCountView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(contentView);
        make.right.equalTo(contentView.mas_right).with.offset(-10);
        make.centerY.equalTo(contentView.mas_centerY);
        if (size.width > 0 && size.height > 0) {
            make.size.mas_equalTo(size);
        }
    }];
    
    return addSubCountView;
}

- (IBAction)addCountAction:(id)sender {
    
    self.buyGoodsCount ++;
    [self _setCountButton];
    
    if (_countChangedBlk) {
        _countChangedBlk(self.buyGoodsCount);
    }
}

- (IBAction)subCountAction:(id)sender {
    self.buyGoodsCount --;
    [self _setCountButton];
    
    if (_countChangedBlk) {
        _countChangedBlk(self.buyGoodsCount);
    }
}


-(void)_setCountButton{
    
    [self.countButton setTitle:[NSString stringWithFormat:@"%ld",_buyGoodsCount] forState:UIControlStateNormal];
    self.subCountButton.enabled = (self.buyGoodsCount > 1) ? YES : NO;
    self.addButton.userInteractionEnabled = (self.buyGoodsCount < self.goodsStockCount) ? YES : NO;
}

+(id)addSubCountView {

    return BoundNibView(@"AddSubCountView", AddSubCountView);

}


@end
