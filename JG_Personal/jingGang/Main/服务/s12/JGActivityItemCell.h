//
//  JGActivityItemCell.h
//  jingGang
//
//  Created by dengxf on 15/12/9.
//  Copyright © 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ActHotSaleGoodsInfoApiBO;

typedef void(^SelectedItemButtonBlock)(ActHotSaleGoodsInfoApiBO *apiBo);

@interface JGActivityItemCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
@property (weak, nonatomic) IBOutlet UILabel *shopTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *shopPriceLab;
- (IBAction)shopSpreeAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *rightNowButton;

@property (weak, nonatomic) IBOutlet UILabel *surplusLab;

@property (strong,nonatomic) ActHotSaleGoodsInfoApiBO *apiBO;

@property (weak, nonatomic) IBOutlet UIView *tatolsLab;
@property (weak, nonatomic) IBOutlet UIView *sursLab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *surplusConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shopImageConstraint;

@property (copy , nonatomic) SelectedItemButtonBlock selectedItemButtonBlock;

@end
