//
//  DLClassfitionGoodsCell.h
//  YilidiSeller
//
//  Created by mm on 17/1/9.
//  Copyright © 2017年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"

#define kDLClassfitionGoodsCellHeight 96

typedef void(^SelectGoodsBlock)(UIButton *);

@interface DLClassfitionGoodsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *salesVulomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *vipPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UILabel *stockLabel;

@property (nonatomic,copy)SelectGoodsBlock selectGoodsBlock;

@end

@interface DLClassfitionGoodsCell (setCellModel)

-(void)setGoodsCellModel:(GoodsModel *)model;

@end
