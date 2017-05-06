//
//  KJDarlingCommentCell.h
//  jingGang
//
//  Created by 张康健 on 15/8/17.
//  Copyright (c) 2015年 yi jiehuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define cellOriginalHeight 515
#define addHeight 26
#import "DarlingCommentModel.h"
#import "GoodsInfoModel.h"

//编辑图片导致cell高度变化回调block,可能增加高度，可能删除高度
typedef void(^PhotoEditCauseHeightChangeBlock)(BOOL isAddHeight);
@class RateView;
@interface KJDarlingCommentCell : UITableViewCell
//三个评级view
@property (nonatomic, strong)RateView *descRateView;
@property (nonatomic, strong)RateView *serviceRateView;
@property (nonatomic, strong)RateView *deleverRateView;
@property (weak, nonatomic) IBOutlet UIView *commentImgBgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentImgBgViewHeightConstraint;
@property (nonatomic, copy)PhotoEditCauseHeightChangeBlock photoEditCauseHeightChangeBlock;

@property (nonatomic, strong)GoodsInfoModel *goodsInfoModel;
@property (nonatomic, strong)DarlingCommentModel *model;
@property (weak, nonatomic) IBOutlet UITextView *commentContentTextView;


@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;

//解决复用问题
//@property BOOL isAddedHeight;

@end
