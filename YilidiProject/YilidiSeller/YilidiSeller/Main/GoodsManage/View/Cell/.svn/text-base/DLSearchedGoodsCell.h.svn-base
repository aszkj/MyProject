//
//  DLSearchedGoodsCell.h
//  YilidiSeller
//
//  Created by yld on 16/6/29.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"

#define kSearchedGoodsResultCellHeight 125
typedef void(^OnOffShelfBlock)(NSNumber* onShelfNumber);
@interface DLSearchedGoodsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *salesVulomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *vipPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *stockLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgBgViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgBgViewWidthConstraint;
@property (weak, nonatomic) IBOutlet UIButton *onOffShelfMarkButton;

@property (weak, nonatomic) IBOutlet UIButton *offShelfButton;
@property (weak, nonatomic) IBOutlet UIButton *onShelfButton;

@property (nonatomic,copy)OnOffShelfBlock onOffShelfBlock;


@end

@interface DLSearchedGoodsCell (setGoodsModel)

-(void)setCellModel:(GoodsModel *)model;

-(void)configureOnOffShelfUiByGoodsModel:(GoodsModel *)model;


@end
