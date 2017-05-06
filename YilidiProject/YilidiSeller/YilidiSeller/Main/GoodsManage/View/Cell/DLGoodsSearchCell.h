//
//  DLGoodsSearchCell.h
//  YilidiSeller
//
//  Created by mm on 17/1/10.
//  Copyright © 2017年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"

#define kGoodsSearchCellHeight 145

typedef void(^OnOffShelfBlock)(NSNumber* onShelfNumber);
@interface DLGoodsSearchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *salesVulomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *vipPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *stockLabel;
@property (weak, nonatomic) IBOutlet UIButton *onOffShelfMarkButton;
@property (weak, nonatomic) IBOutlet UIButton *onOffShelfButton;
@property (nonatomic,copy)OnOffShelfBlock onOffShelfBlock;

@end

@interface DLGoodsSearchCell (setGoodsModel)

-(void)setCellModel:(GoodsModel *)model;

-(void)configureOnOffShelfUiByGoodsModel:(GoodsModel *)model;

@end
