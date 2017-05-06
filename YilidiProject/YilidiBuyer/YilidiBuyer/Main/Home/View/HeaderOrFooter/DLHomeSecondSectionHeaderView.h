//
//  DLTopQualityFruitSectionHeaderView.h
//  YilidiBuyer
//
//  Created by yld on 16/4/18.
//  Copyright © 2016年 yld. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kCommunityWellSelectImgToSideEdges 5
#define kOtherPartHeightBesidesImg 40
#define kCommunityWellSelectImgWidth (kScreenWidth - 2 * kCommunityWellSelectImgToSideEdges)
#define kCommunityWellSelectImgHeight kCommunityWellSelectImgWidth / 3.4
#define kCommunityWellSelectSectionHeaderHeight ( kCommunityWellSelectImgHeight + kOtherPartHeightBesidesImg)

@class DLHomeFloorModel;
@interface DLHomeSecondSectionHeaderView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreGoodsButton;
@property (weak, nonatomic) IBOutlet UIImageView *sectionGoodsAdImgView;
@property (strong, nonatomic) IBOutlet UIImageView *titleImageView;

@property (nonatomic,strong)DLHomeFloorModel *floorModel;


@end
