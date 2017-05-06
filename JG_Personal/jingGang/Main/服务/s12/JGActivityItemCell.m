//
//  JGActivityItemCell.m
//  jingGang
//
//  Created by dengxf on 15/12/9.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import "JGActivityItemCell.h"
#import "ActHotSaleGoodsInfoApiBO.h"
#import "UIImageView+WebCache.h"

@interface JGActivityItemCell ()

@end

@implementation JGActivityItemCell
/**
 * 热销商品的销量
@property (assign, nonatomic) CGFloat goodsSalenum;

 * 热销商品的库存 goodsInventory
 */

- (void)setApiBO:(ActHotSaleGoodsInfoApiBO *)apiBO {
    _apiBO = apiBO;
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:apiBO.adImgPath] placeholderImage:[UIImage imageNamed:@"blank_default200"]];
    [self.shopImageView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [self.shopImageView addGestureRecognizer:tapGesture];
    
    self.shopImageConstraint.constant = self.width;
    
    self.shopTitleLab.text = apiBO.adTitle;
    
    NSString *priceString = [NSString stringWithFormat:@"专享价￥%.0f/￥%.0f",[apiBO.goodsMobilePrice floatValue],[apiBO.goodsPrice floatValue]];
    self.shopPriceLab.attributedText = [self text:priceString];
    [self text:self.shopPriceLab.text];
    
    CGFloat surplus = [apiBO.goodsInventory floatValue];
    self.surplusLab.text = [NSString stringWithFormat:@"仅剩%.0f件",surplus];
    
    CGFloat rate = 0;
    if (([apiBO.goodsInventory floatValue]+ [apiBO.goodsSalenum floatValue]) == 0) {
        self.surplusConstraint.constant = 0;
    }else {
        rate = [apiBO.goodsInventory floatValue] / ([apiBO.goodsInventory floatValue] + [apiBO.goodsSalenum floatValue]);
        self.surplusConstraint.constant = (self.width - 20) * (rate);

    }
    
}


- (void)tapGesture {
    if (self.selectedItemButtonBlock) {
        self.selectedItemButtonBlock(self.apiBO);
    }
}

- (NSMutableAttributedString *)text:(NSString *)text {
    NSMutableAttributedString *attribuString;
    
    NSArray *textArray = [text componentsSeparatedByString:@"/"];
    NSRange firstRange;
    NSString *firstString = textArray[0];
    firstRange = [text rangeOfString:firstString];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setValue:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    
    attribuString = [[NSMutableAttributedString alloc] initWithString:firstString attributes:dic];
    
    NSString *lastString = textArray[1];

    NSMutableDictionary *lastDic = [NSMutableDictionary dictionary];
    [lastDic setObject:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) forKey:NSStrikethroughStyleAttributeName];
    [lastDic setObject:[UIColor grayColor] forKey:NSForegroundColorAttributeName];
    
    NSAttributedString *lastAttr = [[NSAttributedString alloc] initWithString:lastString attributes:lastDic];
    NSMutableAttributedString *last = [[NSMutableAttributedString alloc] initWithString:@"/"];
    [last appendAttributedString:lastAttr];
    
    
    [attribuString appendAttributedString:last];
    
    return attribuString;
}


- (void)awakeFromNib {
}

- (IBAction)shopSpreeAction:(id)sender {
    if (self.selectedItemButtonBlock) {
        self.selectedItemButtonBlock(self.apiBO);
    }
}
@end
